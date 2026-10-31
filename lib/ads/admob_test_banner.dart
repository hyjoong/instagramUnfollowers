import 'package:flutter/material.dart';

import 'admob_banner.dart';
import 'admob_test_config.dart';

/// Backwards-compatible test doubles used by the isolated smoke target.
typedef TestBannerHandle = AdMobBannerHandle;
typedef TestBannerBackend = AdMobBannerBackend;
typedef GoogleTestBannerBackend = GoogleAdMobBannerBackend;

/// The smoke app can only use Google's sample ad units. Production apps must
/// use AdMobBanner and pass the current consent decision explicitly.
class AdMobTestBanner extends StatelessWidget {
  const AdMobTestBanner({super.key, this.config, this.backend});

  final AdMobTestConfig? config;
  final TestBannerBackend? backend;

  @override
  Widget build(BuildContext context) => AdMobBanner(
        config: config ?? AdMobTestConfig.current,
        backend: backend,
        canRequestAds: true,
      );
}
