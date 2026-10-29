import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob_config.dart';

/// Small boundary around the platform SDK so races can be tested without ads.
abstract interface class AdMobBannerHandle {
  Widget get view;
  Future<void> load();
  Future<void> dispose();
}

abstract interface class AdMobBannerBackend {
  Future<void> initialize();
  Future<AdSize?> adaptiveSize(int width);
  AdMobBannerHandle create({
    required String adUnitId,
    required AdSize size,
    required VoidCallback onLoaded,
    required void Function(String message) onFailed,
    required VoidCallback onImpression,
    required void Function(String message) onPaid,
  });
}

class GoogleAdMobBannerBackend implements AdMobBannerBackend {
  static Future<void>? _initialization;

  @override
  Future<void> initialize() {
    return _initialization ??= MobileAds.instance
        .initialize()
        .then<void>((_) {}, onError: (Object error, StackTrace stack) {
      _initialization = null;
      Error.throwWithStackTrace(error, stack);
    });
  }

  @override
  Future<AdSize?> adaptiveSize(int width) =>
      AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(width);

  @override
  AdMobBannerHandle create({
    required String adUnitId,
    required AdSize size,
    required VoidCallback onLoaded,
    required void Function(String message) onFailed,
    required VoidCallback onImpression,
    required void Function(String message) onPaid,
  }) {
    final ad = BannerAd(
      adUnitId: adUnitId,
      size: size,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) => onLoaded(),
        onAdFailedToLoad: (_, error) =>
            onFailed('${error.domain} / ${error.code}: ${error.message}'),
        onAdImpression: (_) => onImpression(),
        onPaidEvent: (_, valueMicros, precision, currencyCode) =>
            onPaid('$valueMicros micros $currencyCode ($precision)'),
      ),
    );
    return _GoogleBannerHandle(ad);
  }
}

class _GoogleBannerHandle implements AdMobBannerHandle {
  _GoogleBannerHandle(this.ad);
  final BannerAd ad;

  @override
  Widget get view => AdWidget(key: ValueKey(ad), ad: ad);
  @override
  Future<void> load() => ad.load();
  @override
  Future<void> dispose() => ad.dispose();
}

/// Mounted only on the active analysis tab. Never overlays the WebView.
class AdMobBanner extends StatefulWidget {
  const AdMobBanner({
    super.key,
    required this.canRequestAds,
    this.config,
    this.backend,
  });

  /// Must come from the current consent decision, never a stored assumption.
  final bool canRequestAds;
  final AdMobConfig? config;
  final AdMobBannerBackend? backend;

  @override
  State<AdMobBanner> createState() => _AdMobBannerState();
}

class _AdMobBannerState extends State<AdMobBanner> with WidgetsBindingObserver {
  late AdMobBannerBackend _backend;
  AdMobBannerHandle? _handle;
  AdSize? _size;
  int _generation = 0;
  int? _width;
  int? _scheduledWidth;
  Timer? _retryTimer;
  int _automaticRetryCount = 0;
  static const _retryDelays = [
    Duration(seconds: 30),
    Duration(seconds: 60),
    Duration(seconds: 120),
  ];
  bool _loaded = false;
  bool _paused = false;
  String _status = '테스트 광고 대기';

  AdMobConfig get _config => widget.config ?? AdMobConfig.current;
  bool get _allowed => _config.enabled && widget.canRequestAds;

  @override
  void initState() {
    super.initState();
    _backend = widget.backend ?? GoogleAdMobBannerBackend();
    final lifecycle = WidgetsBinding.instance.lifecycleState;
    _paused = lifecycle == AppLifecycleState.paused ||
        lifecycle == AppLifecycleState.hidden ||
        lifecycle == AppLifecycleState.detached;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(covariant AdMobBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.backend != widget.backend ||
        oldWidget.config != widget.config ||
        oldWidget.canRequestAds != widget.canRequestAds) {
      _invalidate();
      _backend = widget.backend ?? GoogleAdMobBannerBackend();
      _width = null;
      _automaticRetryCount = 0;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_paused && mounted) {
        setState(() {
          _paused = false;
          _width = null;
        });
      }
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.hidden) {
      _paused = true;
      _invalidate();
      if (mounted) setState(() => _status = '백그라운드: 광고 일시 중지');
    }
  }

  void _disposeHandle(AdMobBannerHandle? handle, {required bool logErrors}) {
    if (handle == null) return;
    // This may run after State.dispose; capture config before scheduling it.
    unawaited(Future<void>.sync(handle.dispose).catchError((Object error) {
      if (logErrors) debugPrint('[AdMob TEST] dispose failed: $error');
    }));
  }

  void _invalidate() {
    _generation++;
    _scheduledWidth = null;
    _retryTimer?.cancel();
    _retryTimer = null;
    final previous = _handle;
    final wasRendered = _loaded;
    final logErrors = _config.isTest;
    _handle = null;
    _loaded = false;
    _size = null;
    if (previous != null && wasRendered) {
      // AdWidget.dispose needs the SDK's ad-id mapping to unregister its view.
      // Remove that widget this frame, then release the native ad resources.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _disposeHandle(previous, logErrors: logErrors);
      });
      WidgetsBinding.instance.ensureVisualUpdate();
    } else {
      _disposeHandle(previous, logErrors: logErrors);
    }
  }

  bool _isCurrent(int generation) =>
      mounted && !_paused && _allowed && generation == _generation;

  void _report(String status) {
    if (_config.isTest) debugPrint('[AdMob TEST] $status');
    if (mounted) setState(() => _status = status);
  }

  void _failed(int generation, int width, String message) {
    if (!_isCurrent(generation)) return;
    _invalidate();
    _report('로드 실패 · $message');

    // The SDK refreshes loaded banners itself; this only recovers a failed
    // initial request. Keep the failed placement collapsed while backing off.
    if (_config.isTest || _automaticRetryCount >= _retryDelays.length) return;
    final delay = _retryDelays[_automaticRetryCount++];
    final retryGeneration = _generation;
    _retryTimer = Timer(delay, () {
      _retryTimer = null;
      if (!_isCurrent(retryGeneration) || _width != width) return;
      unawaited(_load(width, automaticRetry: true));
    });
  }

  Future<void> _load(int width, {bool automaticRetry = false}) async {
    _invalidate();
    _width = width;
    if (!automaticRetry) _automaticRetryCount = 0;
    if (!_allowed || _paused) return;
    final generation = _generation;
    _report('SDK 초기화 · 테스트 광고 요청 준비');

    try {
      await _backend.initialize();
      if (!_isCurrent(generation)) return;
      final size = await _backend.adaptiveSize(width);
      if (!_isCurrent(generation)) return;
      if (size == null) throw StateError('적응형 배너 크기를 계산하지 못했습니다.');

      final handle = _backend.create(
        adUnitId: _config.bannerAdUnitId!,
        size: size,
        onLoaded: () {
          if (!_isCurrent(generation)) return;
          _automaticRetryCount = 0;
          setState(() => _loaded = true);
          _report('로드 성공 · ${size.width}×${size.height} · Google 테스트 광고');
        },
        onFailed: (message) {
          _failed(generation, width, message);
        },
        onImpression: () {
          if (_isCurrent(generation)) _report('노출 확인 · Google 테스트 광고');
        },
        onPaid: (message) {
          if (_isCurrent(generation) && _config.isTest) {
            debugPrint('[AdMob TEST] paid event (test, not revenue): $message');
          }
        },
      );
      _handle = handle;
      _size = size;
      _report('요청 중 · ${_config.bannerAdUnitId}');
      await handle.load();
    } catch (error) {
      _failed(generation, width, '$error');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _invalidate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_allowed) return const SizedBox.shrink();

    return LayoutBuilder(builder: (context, constraints) {
      if (!constraints.hasBoundedWidth) return const SizedBox.shrink();
      final safePadding = MediaQuery.paddingOf(context);
      final width = (constraints.maxWidth - safePadding.horizontal).floor();
      if (!_paused &&
          width > 0 &&
          _width != width &&
          _scheduledWidth != width) {
        _scheduledWidth = width;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted || !_allowed || _scheduledWidth != width || _paused) {
            return;
          }
          unawaited(_load(width));
        });
      }
      final creative = _loaded && _handle != null && _size != null
          ? SizedBox(
              width: _size!.width.toDouble(),
              height: _size!.height.toDouble(),
              child: _handle!.view,
            )
          : null;

      // A failed/pending production banner consumes no layout space.
      // Keep SDK diagnostics and retry controls confined to test mode.
      if (!_config.isTest) {
        if (creative == null) return const SizedBox.shrink();
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              heightFactor: 1,
              child: creative,
            ),
          ),
        );
      }
      return SafeArea(
        top: false,
        child: _testPanel(creative, width),
      );
    });
  }

  Widget _testPanel(Widget? creative, int width) {
    return ColoredBox(
      color: const Color(0xFFF1F5F9),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (creative != null) creative,
          Padding(
            // Keep controls visually separate from the ad itself.
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(_status,
                      key: const Key('admob-test-status'),
                      style: const TextStyle(fontSize: 11)),
                ),
                const SizedBox(width: 12),
                TextButton(
                  key: const Key('admob-test-retry'),
                  onPressed: !_paused && width > 0
                      ? () => unawaited(_load(width))
                      : null,
                  child: const Text('다시 요청'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
