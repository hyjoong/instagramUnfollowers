import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:trackfollows/ads/ad_consent_controller.dart';

class _FakeConsentBackend implements AdConsentBackend {
  final calls = <String>[];
  Completer<void>? updateBarrier;
  Completer<void>? formBarrier;
  Completer<void>? privacyBarrier;
  Object? updateError;
  Object? formError;
  Object? eligibilityError;
  Object? privacyStatusError;
  Object? privacyFormError;
  bool eligible = false;
  PrivacyOptionsRequirementStatus privacyStatus =
      PrivacyOptionsRequirementStatus.required;

  @override
  Future<void> requestConsentInfoUpdate() async {
    calls.add('update');
    if (updateBarrier != null) await updateBarrier!.future;
    if (updateError != null) throw updateError!;
  }

  @override
  Future<void> loadAndShowConsentFormIfRequired() async {
    calls.add('required form');
    if (formBarrier != null) await formBarrier!.future;
    if (formError != null) throw formError!;
  }

  @override
  Future<bool> canRequestAds() async {
    calls.add('eligibility');
    if (eligibilityError != null) throw eligibilityError!;
    return eligible;
  }

  @override
  Future<PrivacyOptionsRequirementStatus>
      getPrivacyOptionsRequirementStatus() async {
    calls.add('privacy status');
    if (privacyStatusError != null) throw privacyStatusError!;
    return privacyStatus;
  }

  @override
  Future<void> showPrivacyOptionsForm() async {
    calls.add('privacy form');
    if (privacyBarrier != null) await privacyBarrier!.future;
    if (privacyFormError != null) throw privacyFormError!;
  }
}

Future<void> _flush() => Future<void>.delayed(Duration.zero);

void main() {
  test('update precedes form, and eligibility is read only after dismissal',
      () async {
    final backend = _FakeConsentBackend()
      ..eligible = true
      ..updateBarrier = Completer<void>()
      ..formBarrier = Completer<void>();
    final controller = AdConsentController(backend: backend);
    addTearDown(controller.dispose);

    final initialized = controller.initialize();
    expect(controller.isBusy, isTrue);
    expect(controller.canRequestAds, isFalse);
    expect(backend.calls, ['update']);

    backend.updateBarrier!.complete();
    await _flush();
    expect(backend.calls, ['update', 'required form']);
    expect(controller.canRequestAds, isFalse);

    backend.formBarrier!.complete();
    await initialized;
    expect(backend.calls,
        ['update', 'required form', 'eligibility', 'privacy status']);
    expect(controller.canRequestAds, isTrue);
    expect(controller.privacyOptionsRequired, isTrue);
    expect(controller.isBusy, isFalse);
  });

  test('SDK denial does not become ad eligibility after a successful form',
      () async {
    final controller = AdConsentController(backend: _FakeConsentBackend());
    addTearDown(controller.dispose);
    await controller.initialize();
    expect(controller.canRequestAds, isFalse);
    expect(controller.privacyOptionsRequired, isTrue);
    expect(controller.isBusy, isFalse);
  });

  for (final cachedEligibility in [false, true]) {
    test('update failure uses SDK eligibility ($cachedEligibility), skips form',
        () async {
      final backend = _FakeConsentBackend()
        ..eligible = cachedEligibility
        ..updateError = StateError('offline');
      final controller = AdConsentController(backend: backend);
      addTearDown(controller.dispose);
      await controller.initialize();
      expect(backend.calls, ['update', 'eligibility', 'privacy status']);
      expect(controller.canRequestAds, cachedEligibility);
      expect(controller.isBusy, isFalse);
    });

    test('form failure uses SDK eligibility ($cachedEligibility)', () async {
      final backend = _FakeConsentBackend()
        ..eligible = cachedEligibility
        ..formError = FormError(errorCode: 2, message: 'network error');
      final controller = AdConsentController(backend: backend);
      addTearDown(controller.dispose);
      await controller.initialize();
      expect(controller.canRequestAds, cachedEligibility);
      expect(controller.isBusy, isFalse);
    });
  }

  test('eligibility query failure fails closed without blocking initialization',
      () async {
    final backend = _FakeConsentBackend()
      ..eligible = true
      ..eligibilityError = StateError('channel unavailable');
    final controller = AdConsentController(backend: backend);
    addTearDown(controller.dispose);
    await controller.initialize();
    expect(controller.canRequestAds, isFalse);
    expect(controller.privacyOptionsRequired, isTrue);
    expect(controller.isBusy, isFalse);
  });

  test('unknown privacy requirement fails closed', () async {
    final backend = _FakeConsentBackend()
      ..eligible = true
      ..privacyStatus = PrivacyOptionsRequirementStatus.unknown;
    final controller = AdConsentController(backend: backend);
    addTearDown(controller.dispose);
    await controller.initialize();
    expect(controller.canRequestAds, isFalse);
    expect(controller.privacyOptionsRequired, isFalse);
  });

  test('not-required privacy entry point permits ads when SDK permits them',
      () async {
    final backend = _FakeConsentBackend()
      ..eligible = true
      ..privacyStatus = PrivacyOptionsRequirementStatus.notRequired;
    final controller = AdConsentController(backend: backend);
    addTearDown(controller.dispose);
    await controller.initialize();
    expect(controller.canRequestAds, isTrue);
    expect(controller.privacyOptionsRequired, isFalse);
    expect(await controller.showPrivacyOptions(), isNotNull);
    expect(backend.calls, isNot(contains('privacy form')));
  });

  test(
      'privacy form pauses ads, deduplicates taps, and honors revoked eligibility',
      () async {
    final backend = _FakeConsentBackend()..eligible = true;
    final controller = AdConsentController(backend: backend);
    addTearDown(controller.dispose);
    await controller.initialize();
    final states = <bool>[];
    controller.addListener(() => states.add(controller.canRequestAds));
    backend.privacyBarrier = Completer<void>();

    final privacy = controller.showPrivacyOptions();
    final repeated = controller.showPrivacyOptions();
    expect(identical(privacy, repeated), isTrue);
    expect(controller.canRequestAds, isFalse);
    expect(controller.isBusy, isTrue);
    expect(states, [false]);
    expect(backend.calls.where((call) => call == 'privacy form'), hasLength(1));

    backend.eligible = false;
    backend.privacyBarrier!.complete();
    expect(await privacy, isNull);
    expect(controller.canRequestAds, isFalse);
    expect(controller.isBusy, isFalse);
    expect(states, [false, false]);
    expect(backend.calls.skip(4),
        ['privacy form', 'eligibility', 'privacy status']);
  });

  test('privacy form error is friendly and refreshes SDK prior consent',
      () async {
    final backend = _FakeConsentBackend()..eligible = true;
    final controller = AdConsentController(backend: backend);
    addTearDown(controller.dispose);
    await controller.initialize();
    backend.privacyFormError = StateError('private SDK diagnostics');

    final message = await controller.showPrivacyOptions();
    expect(message, contains('잠시 후 다시 시도'));
    expect(message, isNot(contains('private SDK diagnostics')));
    expect(controller.canRequestAds, isTrue);
    expect(controller.isBusy, isFalse);
  });

  test(
      'privacy refresh error disables ads but preserves the existing entry point',
      () async {
    final backend = _FakeConsentBackend()..eligible = true;
    final controller = AdConsentController(backend: backend);
    addTearDown(controller.dispose);
    await controller.initialize();
    backend.privacyStatusError = StateError('status unavailable');

    expect(await controller.showPrivacyOptions(), isNotNull);
    expect(controller.canRequestAds, isFalse);
    expect(controller.privacyOptionsRequired, isTrue);
    expect(controller.isBusy, isFalse);
  });

  test('initialize is idempotent during and after synchronous listener reentry',
      () async {
    final backend = _FakeConsentBackend()..updateBarrier = Completer<void>();
    final controller = AdConsentController(backend: backend);
    addTearDown(controller.dispose);
    Future<void>? reentered;
    controller.addListener(() {
      reentered ??= controller.initialize();
    });

    final first = controller.initialize();
    final repeated = controller.initialize();
    expect(identical(first, reentered), isTrue);
    expect(identical(first, repeated), isTrue);
    expect(backend.calls, ['update']);
    backend.updateBarrier!.complete();
    await first;
    await controller.initialize();
    expect(backend.calls.where((call) => call == 'update'), hasLength(1));
  });

  test('privacy calls before or during initialization do not present a form',
      () async {
    final backend = _FakeConsentBackend()..updateBarrier = Completer<void>();
    final controller = AdConsentController(backend: backend);
    addTearDown(controller.dispose);
    expect(await controller.showPrivacyOptions(), isNotNull);
    final initialized = controller.initialize();
    expect(await controller.showPrivacyOptions(), isNotNull);
    expect(backend.calls, ['update']);
    backend.updateBarrier!.complete();
    await initialized;
  });

  test('disposal during update prevents later SDK steps and notifications',
      () async {
    final backend = _FakeConsentBackend()..updateBarrier = Completer<void>();
    final controller = AdConsentController(backend: backend);
    var notifications = 0;
    controller.addListener(() => notifications++);
    final initialized = controller.initialize();
    controller.dispose();
    backend.updateBarrier!.complete();
    await initialized;
    await controller.initialize();
    expect(await controller.showPrivacyOptions(), isNotNull);
    expect(backend.calls, ['update']);
    expect(notifications, 1);
    expect(controller.canRequestAds, isFalse);
    expect(controller.isBusy, isFalse);
  });

  test('disposal while privacy form is open prevents consent refresh',
      () async {
    final backend = _FakeConsentBackend()..eligible = true;
    final controller = AdConsentController(backend: backend);
    await controller.initialize();
    backend.privacyBarrier = Completer<void>();
    final privacy = controller.showPrivacyOptions();
    controller.dispose();
    backend.privacyBarrier!.complete();
    await privacy;
    expect(backend.calls.last, 'privacy form');
    expect(controller.canRequestAds, isFalse);
    expect(controller.isBusy, isFalse);
  });
}
