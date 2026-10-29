import 'package:flutter/foundation.dart';

/// Build-time mode selection. Production IDs are never used by debug/profile.
class AdMobConfig {
  const AdMobConfig({
    required this.release,
    required this.platform,
    this.web = false,
    this.testMode = false,
    this.adsEnabled = true,
  });

  static const nativeAdsUserAgent = 'TrackFollows-NativeAds/1';
  static const androidProductionBannerId =
      'ca-app-pub-2951563150255051/5185165995';
  static const iosProductionBannerId = 'ca-app-pub-2951563150255051/4486413560';
  static const androidTestBannerId = 'ca-app-pub-3940256099942544/9214589741';
  static const iosTestBannerId = 'ca-app-pub-3940256099942544/2435281174';

  // Interstitial units are created image/text only in the AdMob console.
  // Empty means the unit does not exist yet, so release builds skip it.
  static const androidProductionInterstitialId = '';
  static const iosProductionInterstitialId = '';
  static const androidTestInterstitialId =
      'ca-app-pub-3940256099942544/1033173712';
  static const iosTestInterstitialId = 'ca-app-pub-3940256099942544/4411468910';

  static final AdMobConfig current = AdMobConfig(
    release: kReleaseMode,
    platform: defaultTargetPlatform,
    web: kIsWeb,
    testMode: const bool.fromEnvironment('ADMOB_TEST_MODE'),
    adsEnabled: const bool.fromEnvironment('ADMOB_ENABLED', defaultValue: true),
  );

  final bool release;
  final TargetPlatform platform;
  final bool web;
  final bool testMode;
  final bool adsEnabled;

  bool get enabled =>
      adsEnabled &&
      !web &&
      (platform == TargetPlatform.android || platform == TargetPlatform.iOS) &&
      ((release && !testMode) || (!release && testMode));

  bool get isTest => enabled && !release && testMode;

  String? get bannerAdUnitId {
    if (!enabled) return null;
    if (platform == TargetPlatform.android) {
      return isTest ? androidTestBannerId : androidProductionBannerId;
    }
    return isTest ? iosTestBannerId : iosProductionBannerId;
  }

  String? get interstitialAdUnitId {
    if (!enabled) return null;
    final id = platform == TargetPlatform.android
        ? (isTest ? androidTestInterstitialId : androidProductionInterstitialId)
        : (isTest ? iosTestInterstitialId : iosProductionInterstitialId);
    return id.isEmpty ? null : id;
  }
}
