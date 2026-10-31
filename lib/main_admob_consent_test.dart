import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ads/ad_consent_controller.dart';
import 'ads/admob_banner.dart';
import 'ads/admob_test_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // This target must never start in release or request publisher ad units.
  AdMobTestConfig.current.requireEnabled();
  runApp(const _ConsentTestApp());
}

/// Debug geography and resets are deliberately confined to this entry point.
/// The production AdConsentController and backend remain unchanged.
class _EeaTestBackend implements AdConsentBackend {
  _EeaTestBackend(this.log);
  final ValueChanged<String> log;

  @override
  Future<void> requestConsentInfoUpdate() {
    AdMobTestConfig.current.requireEnabled();
    const configuredId = String.fromEnvironment('UMP_TEST_DEVICE_ID');
    final deviceId = configuredId.trim();
    final params = ConsentRequestParameters(
      consentDebugSettings: ConsentDebugSettings(
        debugGeography: DebugGeography.debugGeographyEea,
        testIdentifiers: deviceId.isEmpty ? null : [deviceId],
      ),
    );
    log('UMP update: EEA debug; device hash supplied=${deviceId.isNotEmpty}');
    final completion = Completer<void>();
    ConsentInformation.instance.requestConsentInfoUpdate(params, () {
      log('UMP update succeeded');
      // Read-only diagnostics must not change completion or ad eligibility.
      unawaited(_logUpdatedConsentDiagnostics());
      if (!completion.isCompleted) completion.complete();
    }, (error) {
      log('UMP update error ${error.errorCode}: ${error.message}');
      if (!completion.isCompleted) completion.completeError(error);
    });
    return completion.future;
  }

  Future<void> _logUpdatedConsentDiagnostics() async {
    try {
      final ConsentStatus status =
          await ConsentInformation.instance.getConsentStatus();
      log('UMP consentStatus after update=$status');
    } catch (error) {
      log('UMP diagnostic getConsentStatus error: $error');
    }
    try {
      final bool available =
          await ConsentInformation.instance.isConsentFormAvailable();
      log('UMP consentFormAvailable after update=$available');
    } catch (error) {
      log('UMP diagnostic isConsentFormAvailable error: $error');
    }
  }

  @override
  Future<void> loadAndShowConsentFormIfRequired() async {
    log('UMP load/show if required: started');
    FormError? failure;
    await ConsentForm.loadAndShowConsentFormIfRequired((error) {
      failure = error;
      if (error != null) {
        log('UMP form error ${error.errorCode}: ${error.message}');
      } else {
        // This callback alone does not prove a form was displayed.
        log('UMP form flow completed (or no form required)');
      }
    });
    if (failure != null) throw failure!;
  }

  @override
  Future<bool> canRequestAds() async {
    final allowed = await ConsentInformation.instance.canRequestAds();
    log('UMP canRequestAds=$allowed');
    return allowed;
  }

  @override
  Future<PrivacyOptionsRequirementStatus>
      getPrivacyOptionsRequirementStatus() async {
    final status =
        await ConsentInformation.instance.getPrivacyOptionsRequirementStatus();
    log('UMP privacyOptionsRequired=$status');
    return status;
  }

  @override
  Future<void> showPrivacyOptionsForm() async {
    log('UMP privacy options: opening');
    FormError? failure;
    await ConsentForm.showPrivacyOptionsForm((error) {
      failure = error;
      if (error != null) {
        log('UMP privacy options error ${error.errorCode}: ${error.message}');
      } else {
        log('UMP privacy options: closed');
      }
    });
    if (failure != null) throw failure!;
  }
}

class _ConsentTestApp extends StatelessWidget {
  const _ConsentTestApp();

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'TrackFollows UMP Test',
        theme: ThemeData(colorSchemeSeed: const Color(0xFFEC4899)),
        home: const _ConsentTestScreen(),
      );
}

class _ConsentTestScreen extends StatefulWidget {
  const _ConsentTestScreen();

  @override
  State<_ConsentTestScreen> createState() => _ConsentTestScreenState();
}

class _ConsentTestScreenState extends State<_ConsentTestScreen> {
  late AdConsentController _consent;
  final _messages = <String>[];
  bool _working = false;
  int _session = 0;

  @override
  void initState() {
    super.initState();
    AdMobTestConfig.current.requireEnabled();
    _consent = _newController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) unawaited(_start(reset: false));
    });
  }

  AdConsentController _newController() =>
      AdConsentController(backend: _EeaTestBackend(_log))
        ..addListener(_onConsentChanged);

  void _onConsentChanged() {
    if (mounted) setState(() {});
  }

  void _log(String message) {
    debugPrint('[UMP TEST] $message');
    if (!mounted) return;
    setState(() {
      _messages.insert(0, message);
      if (_messages.length > 24) _messages.removeLast();
    });
  }

  Future<void> _start({required bool reset}) async {
    if (_working || _consent.isBusy) return;
    AdMobTestConfig.current.requireEnabled();
    setState(() => _working = true);
    _consent.removeListener(_onConsentChanged);
    _consent.dispose();
    _consent = _newController();
    _session++;
    try {
      if (reset) {
        // Remove a currently displayed banner before clearing SDK test state.
        await WidgetsBinding.instance.endOfFrame;
        if (!mounted) return;
        await ConsentInformation.instance.reset();
        _log('UMP test consent reset; requesting a fresh EEA form');
      }
      if (mounted) await _consent.initialize();
    } catch (error) {
      _log('Test session error: $error');
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _showPrivacyOptions() async {
    final message = await _consent.showPrivacyOptions();
    if (message != null) _log(message);
  }

  @override
  void dispose() {
    _consent.removeListener(_onConsentChanged);
    _consent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final busy = _working || _consent.isBusy;
    return Scaffold(
      appBar: AppBar(title: const Text('EEA 동의창 테스트')),
      body: Column(children: [
        Expanded(
          child: ListView(padding: const EdgeInsets.all(16), children: [
            const Text(
              '실제 UMP 동의창 + Google 샘플 배너\n'
              '웹 화면·Firebase 없이 동의 결과로만 배너 요청을 제어합니다. '
              'EEA 지역 강제 설정은 테스트 기기에서만 적용됩니다.',
            ),
            const SizedBox(height: 12),
            Text('광고 요청 가능: ${_consent.canRequestAds}\n'
                '개인정보 옵션 필요: ${_consent.privacyOptionsRequired}\n'
                '진행 중: $busy'),
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 8, children: [
              OutlinedButton(
                onPressed: busy ? null : () => _start(reset: false),
                child: const Text('동의 상태 다시 확인'),
              ),
              OutlinedButton(
                onPressed: busy ? null : () => _start(reset: true),
                child: const Text('테스트 동의 초기화'),
              ),
              if (_consent.privacyOptionsRequired)
                FilledButton(
                  onPressed: busy ? null : _showPrivacyOptions,
                  child: const Text('광고 개인정보 설정'),
                ),
            ]),
            const SizedBox(height: 16),
            const Text('진단 기록', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (final message in _messages)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(message, style: const TextStyle(fontSize: 12)),
              ),
          ]),
        ),
        AdMobBanner(
          key: ValueKey(_session),
          config: AdMobTestConfig.current,
          canRequestAds: !_working && _consent.canRequestAds,
        ),
      ]),
    );
  }
}
