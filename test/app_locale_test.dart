import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackfollows/l10n/app_locale.dart';
import 'package:trackfollows/l10n/gen/app_localizations.dart';

void main() {
  group('resolveAppLocale', () {
    Locale resolve(List<Locale> device, [String? saved]) =>
        resolveAppLocale(saved, device);

    test('matches device languages by language code', () {
      expect(resolve(const [Locale('ko', 'KR')]), const Locale('ko'));
      expect(resolve(const [Locale('en', 'US')]), const Locale('en'));
      expect(resolve(const [Locale('ja')]), const Locale('ja'));
      expect(resolve(const [Locale('pt', 'BR')]), const Locale('pt'));
      expect(resolve(const [Locale('pt', 'PT')]), const Locale('pt'));
      expect(resolve(const [Locale('es', 'MX')]), const Locale('es'));
    });

    test('falls back to English for unsupported or empty lists', () {
      expect(
        resolve(
            const [Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans')]),
        const Locale('en'),
      );
      expect(resolve(const []), const Locale('en'));
    });

    test('takes the first supported language in device order', () {
      expect(
        resolve(const [Locale('zh'), Locale('it'), Locale('de'), Locale('ko')]),
        const Locale('de'),
      );
    });

    test('saved choice wins over device languages', () {
      expect(resolve(const [Locale('en')], 'ja'), const Locale('ja'));
      expect(resolve(const [Locale('en')], 'xx'), const Locale('en'));
    });
  });

  group('web urls', () {
    const origin = 'https://trackfollows.com';

    test('Korean has no prefix, others use /{locale}', () {
      expect(webUrlFor(origin, const Locale('ko')), origin);
      expect(webUrlFor(origin, const Locale('en')), '$origin/en');
      expect(webUrlFor('$origin/', const Locale('pt')), '$origin/pt');
      expect(
          webUrlFor(origin, const Locale('ko'), '/privacy'), '$origin/privacy');
      expect(
          webUrlFor(origin, const Locale('en'), '/terms'), '$origin/en/terms');
    });

    test('legal pages exist only in ko and en', () {
      expect(legalUrlFor(origin, const Locale('ko'), '/privacy'),
          '$origin/privacy');
      expect(legalUrlFor(origin, const Locale('en'), '/terms'),
          '$origin/en/terms');
      expect(legalUrlFor(origin, const Locale('ja'), '/privacy'),
          '$origin/en/privacy');
    });

    test('reads the language back from a page address', () {
      expect(localeFromWebUrl('$origin/ja/file'), const Locale('ja'));
      expect(localeFromWebUrl('$origin/'), const Locale('ko'));
      expect(localeFromWebUrl(origin), const Locale('ko'));
      expect(localeFromWebUrl('$origin/privacy'), const Locale('ko'));
      expect(localeFromWebUrl('$origin/EN'), const Locale('en'));
    });
  });

  group('AppLocaleStore', () {
    Future<(AppLocaleStore, SharedPreferences)> load(
      Map<String, Object> values,
      List<Locale> device,
    ) async {
      SharedPreferences.setMockInitialValues(values);
      final prefs = await SharedPreferences.getInstance();
      return (await AppLocaleStore.load(prefs, device), prefs);
    }

    test('new install follows the device', () async {
      final (store, prefs) = await load({}, const [Locale('ja')]);
      expect(store.value, const Locale('ja'));
      expect(prefs.containsKey(AppLocaleStore.prefsKey), isFalse);
    });

    test('existing user is pinned to Korean on first run', () async {
      final (store, prefs) = await load(
        {AppLocaleStore.onboardingCompletedKey: true},
        const [Locale('en')],
      );
      expect(store.value, const Locale('ko'));
      expect(prefs.getString(AppLocaleStore.prefsKey), 'ko');
    });

    test('saved choice is kept for existing users', () async {
      final (store, _) = await load({
        AppLocaleStore.onboardingCompletedKey: true,
        AppLocaleStore.prefsKey: 'es',
      }, const [
        Locale('ko')
      ]);
      expect(store.value, const Locale('es'));
    });

    test('select saves and notifies; null follows the device again', () async {
      final (store, prefs) = await load({}, const [Locale('de')]);
      final seen = <Locale>[];
      store.addListener(() => seen.add(store.value));

      await store.select(const Locale('ar'));
      expect(prefs.getString(AppLocaleStore.prefsKey), 'ar');
      expect(store.savedCode, 'ar');

      await store.select(null);
      expect(store.savedCode, isNull);
      expect(seen, const [Locale('ar'), Locale('de')]);
    });

    test('device language change applies only without a saved choice',
        () async {
      final (store, _) = await load({}, const [Locale('de')]);
      store.updateDeviceLocales(const [Locale('fr')]);
      expect(store.value, const Locale('fr'));

      await store.select(const Locale('ko'));
      store.updateDeviceLocales(const [Locale('ru')]);
      expect(store.value, const Locale('ko'));
    });
  });

  test('generated translations cover exactly the supported languages', () {
    expect(
      AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet(),
      supportedLanguageCodes.toSet(),
    );
    for (final locale in supportedAppLocales) {
      final l10n = lookupAppLocalizations(locale);
      expect(l10n.navSettings, isNotEmpty, reason: locale.languageCode);
      expect(l10n.faqIsSafeQuestion, isNotEmpty, reason: locale.languageCode);
    }
  });
}
