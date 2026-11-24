import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../l10n/gen/app_localizations.dart';

/// Why the ad privacy options could not be shown. The settings screen turns
/// it into text in the app language.
enum PrivacyOptionsError {
  notReady,
  preparing,
  nothingToChange,
  openFailed,
  statusFailed;

  String message(AppLocalizations l10n) => switch (this) {
        notReady => l10n.adConsentNotReady,
        preparing => l10n.adConsentPreparing,
        nothingToChange => l10n.adConsentNothingToChange,
        openFailed => l10n.adConsentOpenFailed,
        statusFailed => l10n.adConsentStatusFailed,
      };
}

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
  Future<PrivacyOptionsError?>? _privacyOperation;
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
  /// Repeated taps share the same operation; failures are reported as a
  /// [PrivacyOptionsError] the UI can show.
  Future<PrivacyOptionsError?> showPrivacyOptions() {
    if (_disposed) return Future.value(PrivacyOptionsError.notReady);
    if (_privacyOperation != null) return _privacyOperation!;
    if (_isBusy || _initialization == null) {
      return Future.value(PrivacyOptionsError.preparing);
    }
    if (!_privacyOptionsRequired) {
      return Future.value(PrivacyOptionsError.nothingToChange);
    }

    final completion = Completer<PrivacyOptionsError?>();
    _privacyOperation = completion.future;
    _canRequestAds = false;
    _isBusy = true;
    notifyListeners();
    unawaited(_showPrivacyOptions(completion));
    return completion.future;
  }

  Future<void> _showPrivacyOptions(
    Completer<PrivacyOptionsError?> completion,
  ) async {
    PrivacyOptionsError? message;
    try {
      if (_disposed) return;
      try {
        await _backend.showPrivacyOptionsForm();
      } catch (_) {
        message = PrivacyOptionsError.openFailed;
      }
      if (!_disposed) {
        final refreshed = await _refreshSdkState();
        if (!refreshed) {
          message ??= PrivacyOptionsError.statusFailed;
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
