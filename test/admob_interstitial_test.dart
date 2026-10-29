import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackfollows/ads/admob_config.dart';
import 'package:trackfollows/ads/admob_interstitial.dart';

class _FakeHandle implements InterstitialHandle {
  int shows = 0;
  bool disposed = false;
  VoidCallback? onClosed;

  @override
  Future<void> show({required VoidCallback onClosed}) async {
    shows++;
    this.onClosed = onClosed;
  }

  @override
  Future<void> dispose() async => disposed = true;
}

class _FakeBackend implements InterstitialBackend {
  int loads = 0;
  final handles = <_FakeHandle>[];

  @override
  Future<void> initialize() async {}

  @override
  void load({
    required String adUnitId,
    required void Function(InterstitialHandle ad) onLoaded,
    required void Function(String message) onFailed,
  }) {
    loads++;
    final handle = _FakeHandle();
    handles.add(handle);
    onLoaded(handle);
  }
}

void main() {
  late DateTime now;
  late _FakeBackend backend;

  AdMobInterstitialController controller({String? id = 'unit'}) =>
      AdMobInterstitialController(
        adUnitId: id,
        backend: backend,
        policy: InterstitialPolicy(now: () => now),
      );

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    now = DateTime(2026, 10, 29, 10);
    backend = _FakeBackend();
  });

  test('first analysis never shows, second shows, then once per day',
      () async {
    final ads = controller()..updateConsent(true);
    await pumpEventQueue();

    expect(await ads.onAnalysisCompleted(), isFalse);
    expect(await ads.onAnalysisCompleted(), isTrue);
    backend.handles.first.onClosed!();
    await pumpEventQueue();
    expect(ads.hasReadyAd, isTrue);

    expect(await ads.onAnalysisCompleted(), isFalse);
    now = DateTime(2026, 10, 30, 9);
    expect(await ads.onAnalysisCompleted(), isTrue);
  });

  test('skips without consent or without a ready ad', () async {
    final ads = controller();
    await ads.onAnalysisCompleted();
    expect(await ads.onAnalysisCompleted(), isFalse);
    expect(backend.loads, 0);
  });

  test('no unit id means nothing loads or shows', () async {
    final ads = controller(id: null)..updateConsent(true);
    await pumpEventQueue();
    await ads.onAnalysisCompleted();
    expect(await ads.onAnalysisCompleted(), isFalse);
    expect(backend.loads, 0);
  });

  test('release builds skip interstitials until production ids exist', () {
    for (final platform in [TargetPlatform.android, TargetPlatform.iOS]) {
      final release = AdMobConfig(release: true, platform: platform);
      expect(release.interstitialAdUnitId, isNull);
      final debugTest =
          AdMobConfig(release: false, platform: platform, testMode: true);
      expect(debugTest.interstitialAdUnitId, startsWith('ca-app-pub-3940'));
    }
  });
}
