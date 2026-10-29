import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trackfollows/ads/admob_test_config.dart';
import 'package:trackfollows/ads/admob_config.dart';

void main() {
  test('production and test mode matrix never mixes publisher and sample IDs',
      () {
    for (final platform in TargetPlatform.values) {
      for (final release in [false, true]) {
        for (final testMode in [false, true]) {
          for (final adsEnabled in [false, true]) {
            for (final web in [false, true]) {
              final config = AdMobConfig(
                release: release,
                platform: platform,
                testMode: testMode,
                adsEnabled: adsEnabled,
                web: web,
              );
              final expected = adsEnabled &&
                  !web &&
                  [TargetPlatform.android, TargetPlatform.iOS]
                      .contains(platform) &&
                  (release != testMode);
              expect(config.enabled, expected);
              expect(config.isTest, expected && !release);
              if (!expected) {
                expect(config.bannerAdUnitId, isNull);
              } else if (!release) {
                expect(
                    config.bannerAdUnitId,
                    platform == TargetPlatform.android
                        ? AdMobConfig.androidTestBannerId
                        : AdMobConfig.iosTestBannerId);
              } else {
                expect(
                    config.bannerAdUnitId,
                    platform == TargetPlatform.android
                        ? 'ca-app-pub-2951563150255051/5185165995'
                        : 'ca-app-pub-2951563150255051/4486413560');
              }
            }
          }
        }
      }
    }
  });

  test('current config identity remains stable between reads', () {
    expect(identical(AdMobConfig.current, AdMobConfig.current), isTrue);
    expect(identical(AdMobTestConfig.current, AdMobTestConfig.current), isTrue);
  });

  test('only explicitly enabled mobile non-release builds get sample IDs', () {
    for (final platform in TargetPlatform.values) {
      for (final release in [false, true]) {
        for (final requested in [false, true]) {
          for (final web in [false, true]) {
            final config = AdMobTestConfig(
                requested: requested,
                release: release,
                platform: platform,
                web: web);
            final eligible = requested &&
                !release &&
                !web &&
                [TargetPlatform.android, TargetPlatform.iOS].contains(platform);
            expect(config.enabled, eligible);
            if (eligible) {
              expect(config.bannerAdUnitId,
                  startsWith('ca-app-pub-3940256099942544/'));
              expect(config.requireEnabled, returnsNormally);
            } else {
              expect(config.bannerAdUnitId, isNull);
              expect(config.requireEnabled, throwsStateError);
            }
          }
        }
      }
    }
  });
}
