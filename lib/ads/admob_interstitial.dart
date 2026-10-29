import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Decides whether a completed analysis may be followed by an interstitial.
///
/// - The first successful analysis on a device never shows one.
/// - At most one interstitial per local calendar day.
class InterstitialPolicy {
  InterstitialPolicy({DateTime Function()? now}) : _now = now ?? DateTime.now;

  static const completedAnalysesKey = 'ad_interstitial_completed_analyses';
  static const lastShownDayKey = 'ad_interstitial_last_shown_day';

  final DateTime Function() _now;

  String _today() {
    final now = _now();
    return '${now.year}-${now.month}-${now.day}';
  }

  /// Records a successful analysis and returns whether an ad may follow it.
  Future<bool> recordAnalysisAndCheck(SharedPreferences prefs) async {
    final completed = (prefs.getInt(completedAnalysesKey) ?? 0) + 1;
    await prefs.setInt(completedAnalysesKey, completed);
    if (completed < 2) return false;
    return prefs.getString(lastShownDayKey) != _today();
  }

  Future<void> markShown(SharedPreferences prefs) =>
      prefs.setString(lastShownDayKey, _today());
}

/// SDK boundary so the show/skip flow can be tested without ads.
abstract interface class InterstitialBackend {
  Future<void> initialize();
  void load({
    required String adUnitId,
    required void Function(InterstitialHandle ad) onLoaded,
    required void Function(String message) onFailed,
  });
}

abstract interface class InterstitialHandle {
  /// Shows the ad; [onClosed] runs once it is dismissed or fails to show.
  Future<void> show({required VoidCallback onClosed});
  Future<void> dispose();
}

class GoogleInterstitialBackend implements InterstitialBackend {
  @override
  Future<void> initialize() => MobileAds.instance.initialize().then((_) {});

  @override
  void load({
    required String adUnitId,
    required void Function(InterstitialHandle ad) onLoaded,
    required void Function(String message) onFailed,
  }) {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => onLoaded(_GoogleInterstitialHandle(ad)),
        onAdFailedToLoad: (error) =>
            onFailed('${error.domain} / ${error.code}: ${error.message}'),
      ),
    );
  }
}

class _GoogleInterstitialHandle implements InterstitialHandle {
  _GoogleInterstitialHandle(this.ad);
  final InterstitialAd ad;

  @override
  Future<void> show({required VoidCallback onClosed}) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (_) => onClosed(),
      onAdFailedToShowFullScreenContent: (_, __) => onClosed(),
    );
    return ad.show();
  }

  @override
  Future<void> dispose() => ad.dispose();
}

/// Preloads one interstitial and shows it after a successful analysis when
/// [InterstitialPolicy] allows. Never waits on the network: if no ad is ready,
/// the analysis result is simply shown without one.
class AdMobInterstitialController {
  AdMobInterstitialController({
    required this.adUnitId,
    InterstitialBackend? backend,
    InterstitialPolicy? policy,
    Future<SharedPreferences> Function()? prefs,
  })  : _backend = backend ?? GoogleInterstitialBackend(),
        _policy = policy ?? InterstitialPolicy(),
        _prefs = prefs ?? SharedPreferences.getInstance;

  final String? adUnitId;
  final InterstitialBackend _backend;
  final InterstitialPolicy _policy;
  final Future<SharedPreferences> Function() _prefs;

  InterstitialHandle? _ready;
  bool _loading = false;
  bool _showing = false;
  bool _canRequestAds = false;
  bool _disposed = false;

  bool get hasReadyAd => _ready != null;

  /// Call whenever the consent decision changes.
  void updateConsent(bool canRequestAds) {
    _canRequestAds = canRequestAds;
    if (canRequestAds) unawaited(preload());
  }

  Future<void> preload() async {
    final id = adUnitId;
    if (id == null || !_canRequestAds || _disposed) return;
    if (_ready != null || _loading) return;
    _loading = true;
    try {
      await _backend.initialize();
    } catch (error) {
      _loading = false;
      debugPrint('Interstitial init failed: $error');
      return;
    }
    if (_disposed) return;
    _backend.load(
      adUnitId: id,
      onLoaded: (ad) {
        _loading = false;
        if (_disposed) {
          unawaited(ad.dispose());
          return;
        }
        _ready = ad;
      },
      onFailed: (message) {
        _loading = false;
        debugPrint('Interstitial load failed: $message');
      },
    );
  }

  /// Returns true when an ad was shown.
  Future<bool> onAnalysisCompleted() async {
    if (adUnitId == null || _disposed || _showing) return false;
    final prefs = await _prefs();
    final allowed = await _policy.recordAnalysisAndCheck(prefs);
    final ad = _ready;
    if (!allowed || ad == null || !_canRequestAds || _disposed) {
      unawaited(preload());
      return false;
    }
    _ready = null;
    _showing = true;
    await _policy.markShown(prefs);
    await ad.show(onClosed: () {
      _showing = false;
      unawaited(ad.dispose());
      unawaited(preload());
    });
    return true;
  }

  void dispose() {
    _disposed = true;
    final ad = _ready;
    _ready = null;
    if (ad != null) unawaited(ad.dispose());
  }
}
