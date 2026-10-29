import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:trackfollows/ads/admob_test_banner.dart';
import 'package:trackfollows/ads/admob_test_config.dart';
import 'package:trackfollows/ads/admob_banner.dart';
import 'package:trackfollows/ads/admob_config.dart';

const _enabled = AdMobTestConfig(
    requested: true, release: false, platform: TargetPlatform.android);
const _release = AdMobTestConfig(
    requested: true, release: true, platform: TargetPlatform.android);
const _production =
    AdMobConfig(release: true, platform: TargetPlatform.android);

class _FakeHandle implements TestBannerHandle {
  _FakeHandle(this.onLoaded, this.onFailed, this.onImpression);
  final VoidCallback onLoaded;
  final void Function(String) onFailed;
  final VoidCallback onImpression;
  int loads = 0;
  int disposals = 0;
  Object? disposeError;
  @override
  Widget get view => const Text('fake test creative');
  @override
  Future<void> load() async => loads++;
  @override
  Future<void> dispose() async {
    disposals++;
    if (disposeError != null) throw disposeError!;
  }
}

class _FakeBackend implements TestBannerBackend {
  final handles = <_FakeHandle>[];
  final widths = <int>[];
  final ids = <String>[];
  Completer<AdSize?>? sizeCompleter;
  Completer<void>? initializationCompleter;
  int initializations = 0;

  @override
  Future<void> initialize() async {
    initializations++;
    await initializationCompleter?.future;
  }

  @override
  Future<AdSize?> adaptiveSize(int width) {
    widths.add(width);
    return sizeCompleter?.future ??
        Future.value(AdSize(width: width, height: 50));
  }

  @override
  TestBannerHandle create({
    required String adUnitId,
    required AdSize size,
    required VoidCallback onLoaded,
    required void Function(String message) onFailed,
    required VoidCallback onImpression,
    required void Function(String message) onPaid,
  }) {
    ids.add(adUnitId);
    final handle = _FakeHandle(onLoaded, onFailed, onImpression);
    handles.add(handle);
    return handle;
  }
}

Widget _host(_FakeBackend backend,
        {double width = 320, AdMobTestConfig config = _enabled}) =>
    MaterialApp(
      home: Scaffold(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: width,
            child: AdMobTestBanner(config: config, backend: backend),
          ),
        ),
      ),
    );

Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump();
}

Widget _productionHost(_FakeBackend backend,
        {bool canRequestAds = true, double width = 320}) =>
    MaterialApp(
      home: Scaffold(
        body: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: width,
            child: AdMobBanner(
              key: const Key('production-banner'),
              config: _production,
              backend: backend,
              canRequestAds: canRequestAds,
            ),
          ),
        ),
      ),
    );

void main() {
  testWidgets(
      'async SDK disposal error after unmount does not access dead state',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_host(backend));
    await _settle(tester);
    final first = backend.handles.single;
    first.disposeError = StateError('simulated native disposal error');
    first.onLoaded();
    await tester.pump();
    await tester.pumpWidget(const SizedBox());
    await _settle(tester);
    expect(first.disposals, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('no consent means no SDK initialization or ad requests',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_productionHost(backend, canRequestAds: false));
    await _settle(tester);
    expect(backend.initializations, 0);
    expect(backend.handles, isEmpty);
    expect(
        tester.getSize(find.byKey(const Key('production-banner'))).height, 0);
  });

  testWidgets('consent revoked during initialization prevents ad creation',
      (tester) async {
    final backend = _FakeBackend()..initializationCompleter = Completer<void>();
    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    expect(backend.initializations, 1);
    await tester.pumpWidget(_productionHost(backend, canRequestAds: false));
    backend.initializationCompleter!.complete();
    await _settle(tester);
    expect(backend.widths, isEmpty);
    expect(backend.handles, isEmpty);
  });

  testWidgets('consent revoked during load disposes and ignores late callbacks',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    final first = backend.handles.single;
    expect(first.loads, 1);
    await tester.pumpWidget(_productionHost(backend, canRequestAds: false));
    expect(first.disposals, 1);
    first.onLoaded();
    first.onImpression();
    first.onFailed('late error');
    await _settle(tester);
    expect(find.text('fake test creative'), findsNothing);
    expect(backend.handles.length, 1);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    expect(backend.handles.length, 2);
    expect(backend.ids, everyElement(AdMobConfig.androidProductionBannerId));
  });

  testWidgets(
      'production creative has no debug controls and disappears on revoke',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    final first = backend.handles.single;
    expect(
        tester.getSize(find.byKey(const Key('production-banner'))).height, 0);
    first.onLoaded();
    await tester.pump();
    expect(find.text('fake test creative'), findsOneWidget);
    expect(find.byKey(const Key('admob-test-status')), findsNothing);
    expect(find.byKey(const Key('admob-test-retry')), findsNothing);
    expect(
        tester.getSize(find.byKey(const Key('production-banner'))).height, 66);
    await tester.pumpWidget(_productionHost(backend, canRequestAds: false));
    expect(first.disposals, 1);
    expect(
        tester.getSize(find.byKey(const Key('production-banner'))).height, 0);
  });

  testWidgets('production load failure reserves no space or debug UI',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    backend.handles.single.onFailed('no fill');
    await tester.pump();
    expect(backend.handles.single.disposals, 1);
    expect(find.textContaining('no fill'), findsNothing);
    expect(find.byType(TextButton), findsNothing);
    expect(
        tester.getSize(find.byKey(const Key('production-banner'))).height, 0);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('production retries at 30, 60, 120 seconds then stops',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    for (final delay in [30, 60, 120]) {
      final attempts = backend.handles.length;
      backend.handles.last.onFailed('no fill');
      await _settle(tester);
      expect(backend.handles.length, attempts);
      expect(
          tester.getSize(find.byKey(const Key('production-banner'))).height, 0);
      await tester.pump(Duration(seconds: delay - 1));
      expect(backend.handles.length, attempts);
      await tester.pump(const Duration(seconds: 1));
      await _settle(tester);
      expect(backend.handles.length, attempts + 1);
    }
    backend.handles.last.onFailed('still no fill');
    await tester.pump(const Duration(minutes: 10));
    await _settle(tester);
    expect(backend.handles.length, 4);
  });

  testWidgets('consent revocation cancels scheduled production retry',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    backend.handles.single.onFailed('no fill');
    await tester.pumpWidget(_productionHost(backend, canRequestAds: false));
    await tester.pump(const Duration(minutes: 5));
    await _settle(tester);
    expect(backend.handles.length, 1);
    expect(backend.initializations, 1);
  });

  testWidgets('background cancels retry and resume starts a fresh budget',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    backend.handles.single.onFailed('no fill');
    await tester.pump(const Duration(seconds: 10));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump(const Duration(minutes: 5));
    expect(backend.handles.length, 1);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await _settle(tester);
    expect(backend.handles.length, 2);
    backend.handles.last.onFailed('no fill after resume');
    await tester.pump(const Duration(seconds: 30));
    await _settle(tester);
    expect(backend.handles.length, 3);
  });

  testWidgets('unmount cancels scheduled production retry', (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    backend.handles.single.onFailed('no fill');
    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(minutes: 5));
    expect(backend.handles.length, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('new width cancels old retry and resets its delay',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    backend.handles.single.onFailed('no fill');
    await tester.pump(const Duration(seconds: 10));
    await tester.pumpWidget(_productionHost(backend, width: 480));
    await _settle(tester);
    expect(backend.handles.length, 2);
    backend.handles.last.onFailed('no fill after resize');
    await tester.pump(const Duration(seconds: 20));
    await _settle(tester);
    expect(backend.handles.length, 2);
    await tester.pump(const Duration(seconds: 10));
    await _settle(tester);
    expect(backend.handles.length, 3);
    expect(backend.widths, [320, 480, 480]);
  });

  testWidgets('success resets automatic retry budget', (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_productionHost(backend));
    await _settle(tester);
    backend.handles.single.onFailed('no fill');
    await tester.pump(const Duration(seconds: 30));
    await _settle(tester);
    backend.handles.last.onLoaded();
    await tester.pump();
    backend.handles.last.onFailed('later failure');
    await tester.pump(const Duration(seconds: 30));
    await _settle(tester);
    expect(backend.handles.length, 3);
  });

  testWidgets('test mode waits for manual retry after failure', (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_host(backend));
    await _settle(tester);
    backend.handles.single.onFailed('test no fill');
    await tester.pump(const Duration(minutes: 10));
    expect(backend.handles.length, 1);
    await tester.tap(find.byKey(const Key('admob-test-retry')));
    await _settle(tester);
    expect(backend.handles.length, 2);
  });

  testWidgets('release build never initializes or requests an ad',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_host(backend, config: _release));
    await _settle(tester);
    expect(backend.initializations, 0);
    expect(backend.handles, isEmpty);
  });

  testWidgets('unmount during size calculation cannot create or render an ad',
      (tester) async {
    final backend = _FakeBackend()..sizeCompleter = Completer<AdSize?>();
    await tester.pumpWidget(_host(backend));
    await _settle(tester);
    expect(backend.widths, [320]);
    await tester.pumpWidget(const SizedBox());
    backend.sizeCompleter!.complete(const AdSize(width: 320, height: 50));
    await _settle(tester);
    expect(backend.handles, isEmpty);
    expect(tester.takeException(), isNull);
  });

  testWidgets('retry disposes old ad and ignores late failure callbacks',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_host(backend));
    await _settle(tester);
    final first = backend.handles.single;
    first.onLoaded();
    await tester.pump();
    expect(find.text('fake test creative'), findsOneWidget);

    await tester.tap(find.byKey(const Key('admob-test-retry')));
    await _settle(tester);
    expect(first.disposals, 1);
    final second = backend.handles.last;
    second.onLoaded();
    first.onFailed('stale error');
    await tester.pump();
    expect(find.text('fake test creative'), findsOneWidget);
    expect(find.textContaining('stale error'), findsNothing);
    expect(second.disposals, 0);
    expect(backend.ids, everyElement(AdMobTestConfig.androidBannerId));

    second.onImpression();
    await tester.pump();
    expect(find.textContaining('노출 확인'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
    expect(second.disposals, 1);
    second.onLoaded();
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('resize replaces and disposes the old banner', (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_host(backend));
    await _settle(tester);
    final first = backend.handles.single;
    first.onLoaded();
    await tester.pumpWidget(_host(backend, width: 480));
    await _settle(tester);
    expect(backend.widths, [320, 480]);
    expect(first.disposals, 1);
    expect(backend.handles.last.loads, 1);
  });

  testWidgets('background disposes ad and resume requests a fresh ad',
      (tester) async {
    final backend = _FakeBackend();
    await tester.pumpWidget(_host(backend));
    await _settle(tester);
    final first = backend.handles.single;
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    expect(first.disposals, 1);
    first.onLoaded();
    expect(find.text('fake test creative'), findsNothing);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await _settle(tester);
    expect(backend.handles.length, 2);
    expect(tester.takeException(), isNull);
  });
}
