import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackfollows/l10n/app_locale.dart';
import 'package:trackfollows/l10n/gen/app_localizations.dart';
import 'package:trackfollows/screens/settings_screen.dart';

void main() {
  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'TrackFollows',
      packageName: 'com.hyjoong.trackfollows',
      version: '1.3.0',
      buildNumber: '45',
      buildSignature: '',
    );
  });

  testWidgets('picking a language saves it and reloads in that language',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final store = await AppLocaleStore.load(prefs, const [Locale('en')]);
    final reloaded = <Locale>[];

    await tester.pumpWidget(ValueListenableBuilder<Locale>(
      valueListenable: store,
      builder: (context, locale, _) => MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: SettingsScreen(
          localeStore: store,
          onLocaleSelected: reloaded.add,
        ),
      ),
    ));
    await tester.pumpAndSettle();

    final en = lookupAppLocalizations(const Locale('en'));
    await tester.tap(find.text(en.settingsLanguageSystem));
    await tester.pumpAndSettle();
    await tester.tap(find.text('日本語'));
    await tester.pumpAndSettle();

    expect(prefs.getString(AppLocaleStore.prefsKey), 'ja');
    expect(reloaded, const [Locale('ja')]);
    final ja = lookupAppLocalizations(const Locale('ja'));
    expect(find.text(ja.settingsTitle), findsOneWidget);
    expect(find.text('日本語'), findsOneWidget);
  });
}
