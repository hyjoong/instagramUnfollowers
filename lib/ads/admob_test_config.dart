import 'package:flutter/foundation.dart';
import 'admob_config.dart';

/// Sample-only configuration for the dedicated smoke target.
class AdMobTestConfig extends AdMobConfig {
  const AdMobTestConfig({
    required this.requested,
    required super.release,
    required super.platform,
    super.web = false,
  }) : super(testMode: requested, adsEnabled: !release);

  static const nativeAdsUserAgent = AdMobConfig.nativeAdsUserAgent;
  static const androidBannerId = AdMobConfig.androidTestBannerId;
  static const iosBannerId = AdMobConfig.iosTestBannerId;

  static final AdMobTestConfig current = AdMobTestConfig(
    requested: const bool.fromEnvironment('ADMOB_TEST_MODE'),
    release: kReleaseMode,
    platform: defaultTargetPlatform,
    web: kIsWeb,
  );

  final bool requested;

  void requireEnabled() {
    if (!enabled) {
      throw StateError(
        'AdMob test target requires Android/iOS, a non-release build, '
        'and --dart-define=ADMOB_TEST_MODE=true. This target only runs test ads.',
      );
    }
  }
}
