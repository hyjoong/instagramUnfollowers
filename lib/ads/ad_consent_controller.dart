import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// SDK boundary so consent ordering and failure paths can be tested without ads.
abstract class AdConsentBackend {
  Future<void> requestConsentInfoUpdate();
  Future<void> loadAndShowConsentFormIfRequired();
  Future<bool> canRequestAds();
  Future<PrivacyOptionsRequirementStatus> getPrivacyOptionsRequirementStatus();
  Future<void> showPrivacyOptionsForm();
}

class _GoogleAdConsentBackend implements AdConsentBackend {
  @override
  Future<void> requestConsentInfoUpdate() {
    final completion = Completer<void>();
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () {
        if (!completion.isCompleted) completion.complete();
      },
      (error) {
        if (!completion.isCompleted) completion.completeError(error);
      },
    );
    return completion.future;
  }

  @override
  Future<void> loadAndShowConsentFormIfRequired() async {
    FormError? failure;
    await ConsentForm.loadAndShowConsentFormIfRequired((error) {
      failure = error;
    });
    if (failure != null) throw failure!;
  }

  @override
  Future<bool> canRequestAds() => ConsentInformation.instance.canRequestAds();

  @override
  Future<PrivacyOptionsRequirementStatus>
      getPrivacyOptionsRequirementStatus() =>
          ConsentInformation.instance.getPrivacyOptionsRequirementStatus();

  @override
  Future<void> showPrivacyOptionsForm() async {
    FormError? failure;
    await ConsentForm.showPrivacyOptionsForm((error) {
      failure = error;
    });
    if (failure != null) throw failure!;
  }
}

/// Session-scoped consent state. The UMP SDK owns all persisted consent choices.
/// Start [initialize] without delaying the app's first usable screen.
class AdConsentController extends ChangeNotifier {
  AdConsentController({AdConsentBackend? backend})
      : _backend = backend ?? _GoogleAdConsentBackend();

  final AdConsentBackend _backend;
  Future<void>? _initialization;
  Future<String?>? _privacyOperation;
  bool _canRequestAds = false;
  bool _privacyOptionsRequired = false;
  bool _isBusy = false;
  bool _disposed = false;

  bool get canRequestAds => _canRequestAds;
  bool get privacyOptionsRequired => _privacyOptionsRequired;
  bool get isBusy => _isBusy;

  /// Runs once per controller/app session, including when consent gathering fails.
  Future<void> initialize() {
    if (_disposed) return Future<void>.value();
    if (_initialization != null) return _initialization!;

    final completion = Completer<void>();
    // Store before notifying: a listener may call initialize again synchronously.
    _initialization = completion.future;
    _isBusy = true;
    notifyListeners();
    unawaited(_initialize(completion));
    return completion.future;
  }

  Future<void> _initialize(Completer<void> completion) async {
    try {
      if (_disposed) return;
      try {
        await _backend.requestConsentInfoUpdate();
        if (_disposed) return;
        await _backend.loadAndShowConsentFormIfRequired();
      } catch (_) {
        // UMP may still permit ads using valid consent from an earlier session.
        // Never infer eligibility from a failed update or from a local cache.
      }
      if (!_disposed) await _refreshSdkState();
    } finally {
      if (!_disposed) {
        _isBusy = false;
        notifyListeners();
      }
      completion.complete();
    }
  }

  /// Temporarily removes ad eligibility while the user changes privacy choices.
  /// Repeated taps share the same operation; failures become user-facing text.
  Future<String?> showPrivacyOptions() {
    if (_disposed) return Future.value('화면을 다시 연 뒤 시도해 주세요.');
    if (_privacyOperation != null) return _privacyOperation!;
    if (_isBusy || _initialization == null) {
      return Future.value('광고 개인정보 설정을 준비하고 있어요. 잠시 후 다시 시도해 주세요.');
    }
    if (!_privacyOptionsRequired) {
      return Future.value('현재 변경할 광고 개인정보 설정이 없어요.');
    }

    final completion = Completer<String?>();
    _privacyOperation = completion.future;
    _canRequestAds = false;
    _isBusy = true;
    notifyListeners();
    unawaited(_showPrivacyOptions(completion));
    return completion.future;
  }

  Future<void> _showPrivacyOptions(Completer<String?> completion) async {
    String? message;
    try {
      if (_disposed) return;
      try {
        await _backend.showPrivacyOptionsForm();
      } catch (_) {
        message = '개인정보 설정을 열지 못했어요. 잠시 후 다시 시도해 주세요.';
      }
      if (!_disposed) {
        final refreshed = await _refreshSdkState();
        if (!refreshed) {
          message ??= '개인정보 설정 상태를 확인하지 못했어요. 잠시 후 다시 시도해 주세요.';
        }
      }
    } finally {
      _privacyOperation = null;
      if (!_disposed) {
        _isBusy = false;
        notifyListeners();
      }
      completion.complete(message);
    }
  }

  Future<bool> _refreshSdkState() async {
    var eligible = false;
    var complete = true;
    try {
      eligible = await _backend.canRequestAds();
    } catch (_) {
      complete = false;
    }
    if (_disposed) return false;

    // Preserve an existing privacy entry point if a transient query fails.
    var privacyRequired = _privacyOptionsRequired;
    try {
      final status = await _backend.getPrivacyOptionsRequirementStatus();
      if (status == PrivacyOptionsRequirementStatus.unknown) {
        complete = false;
      } else {
        privacyRequired = status == PrivacyOptionsRequirementStatus.required;
      }
    } catch (_) {
      complete = false;
    }
    if (_disposed) return false;

    _canRequestAds = complete && eligible;
    _privacyOptionsRequired = privacyRequired;
    return complete;
  }

  @override
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _canRequestAds = false;
    _privacyOptionsRequired = false;
    _isBusy = false;
    super.dispose();
  }
}
