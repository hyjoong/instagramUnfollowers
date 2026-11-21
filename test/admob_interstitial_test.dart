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

  test('announces the ad only when one is about to show, before showing it',
      () async {
    final ads = controller()..updateConsent(true);
    await pumpEventQueue();
    var announced = 0;
    var showsWhenAnnounced = -1;
    Future<void> beforeShow() async {
      announced++;
      showsWhenAnnounced = backend.handles.first.shows;
    }

    expect(await ads.onAnalysisCompleted(beforeShow: beforeShow), isFalse);
    expect(announced, 0);

    expect(await ads.onAnalysisCompleted(beforeShow: beforeShow), isTrue);
    expect(announced, 1);
    expect(showsWhenAnnounced, 0);
    expect(backend.handles.first.shows, 1);
  });

  test('an ad is not shown if the app is torn down during the announcement',
      () async {
    final ads = controller()..updateConsent(true);
    await pumpEventQueue();
    await ads.onAnalysisCompleted();

    final shown = await ads.onAnalysisCompleted(
      beforeShow: () async => ads.dispose(),
    );

    expect(shown, isFalse);
    expect(backend.handles.first.shows, 0);
    expect(backend.handles.first.disposed, isTrue);
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

  test('release uses publisher interstitial ids, debug test mode uses samples',
      () {
    expect(
        const AdMobConfig(release: true, platform: TargetPlatform.android)
            .interstitialAdUnitId,
        'ca-app-pub-2951563150255051/5705291157');
    expect(
        const AdMobConfig(release: true, platform: TargetPlatform.iOS)
            .interstitialAdUnitId,
        'ca-app-pub-2951563150255051/8563835896');
    for (final platform in [TargetPlatform.android, TargetPlatform.iOS]) {
      final debugTest =
          AdMobConfig(release: false, platform: platform, testMode: true);
      expect(debugTest.interstitialAdUnitId, startsWith('ca-app-pub-3940'));
    }
  });

  test('the history card stays off in release until its units exist', () {
    for (final platform in [TargetPlatform.android, TargetPlatform.iOS]) {
      expect(
          AdMobConfig(release: true, platform: platform).historyNativeAdUnitId,
          isNull);
      expect(
          AdMobConfig(release: false, platform: platform, testMode: true)
              .historyNativeAdUnitId,
          startsWith('ca-app-pub-3940'));
      expect(
          AdMobConfig(release: false, platform: platform)
              .historyNativeAdUnitId,
          isNull);
    }
  });
}
