import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Languages the web app ships (`i18n.config.ts` in the web repo), in the
/// same order. The app follows this list so the WebView and the native
/// screens always agree.
const supportedLanguageCodes = <String>[
  'ko', 'en', 'ja', 'es', 'fr', 'de', 'pt', 'hi', //
  'ru', 'ar', 'tr', 'vi', 'th', 'id', 'ms',
];

final supportedAppLocales = List<Locale>.unmodifiable(
  supportedLanguageCodes.map(Locale.new),
);

/// Used when none of the device languages is supported.
const fallbackLocale = Locale('en');

/// The web serves Korean without a path prefix.
const _unprefixedLocale = 'ko';

bool _isSupported(String? code) =>
    code != null && supportedLanguageCodes.contains(code);

/// Picks the app language: the saved choice first, then the first device
/// language whose language code (`pt` for `pt-BR`) is supported, else English.
Locale resolveAppLocale(String? saved, List<Locale> deviceLocales) {
  if (_isSupported(saved)) return Locale(saved!);
  for (final device in deviceLocales) {
    final code = device.languageCode.toLowerCase();
    if (_isSupported(code)) return Locale(code);
  }
  return fallbackLocale;
}

/// Web address for [locale]: `https://trackfollows.com` for Korean,
/// `https://trackfollows.com/en` for the rest. [path] starts with `/`.
String webUrlFor(String origin, Locale locale, [String path = '']) {
  final base =
      origin.endsWith('/') ? origin.substring(0, origin.length - 1) : origin;
  final code = locale.languageCode;
  final prefix = code == _unprefixedLocale ? '' : '/$code';
  return '$base$prefix$path';
}

/// Language of a web page address: its first path segment when that is a
/// supported language, otherwise Korean (the unprefixed default).
Locale localeFromWebUrl(String url) {
  final segments = Uri.tryParse(url)?.pathSegments ?? const <String>[];
  final first = segments.isEmpty ? null : segments.first.toLowerCase();
  return Locale(_isSupported(first) ? first! : _unprefixedLocale);
}

/// The single language value the whole app reads (WebView, native screens,
/// notifications), persisted under [prefsKey].
class AppLocaleStore extends ValueNotifier<Locale> {
  AppLocaleStore._(this._prefs, this._deviceLocales, Locale initial)
      : super(initial);

  static const prefsKey = 'app_locale';
  static const onboardingCompletedKey = 'onboarding_completed';

  final SharedPreferences _prefs;
  List<Locale> _deviceLocales;

  /// Loads the saved language. A device that finished onboarding before this
  /// version is pinned to Korean, so an update never switches an existing
  /// user's app to English just because the phone is set to English.
  static Future<AppLocaleStore> load(
    SharedPreferences prefs,
    List<Locale> deviceLocales,
  ) async {
    if (!prefs.containsKey(prefsKey) &&
        (prefs.getBool(onboardingCompletedKey) ?? false)) {
      await prefs.setString(prefsKey, _unprefixedLocale);
    }
    final initial = resolveAppLocale(prefs.getString(prefsKey), deviceLocales);
    return AppLocaleStore._(prefs, deviceLocales, initial);
  }

  /// The language the user picked, or null when following the device.
  String? get savedCode {
    final saved = _prefs.getString(prefsKey);
    return _isSupported(saved) ? saved : null;
  }

  /// Saves [locale] as the user's choice; null goes back to the device
  /// languages.
  Future<void> select(Locale? locale) async {
    if (locale == null) {
      await _prefs.remove(prefsKey);
    } else {
      await _prefs.setString(prefsKey, locale.languageCode);
    }
    value = resolveAppLocale(savedCode, _deviceLocales);
  }

  /// Called when the device languages change while the app runs.
  void updateDeviceLocales(List<Locale> deviceLocales) {
    _deviceLocales = deviceLocales;
    value = resolveAppLocale(savedCode, deviceLocales);
  }
}

/// Privacy policy / terms page. The web has these documents only in Korean
/// and English, so every other language opens the English one.
String legalUrlFor(String origin, Locale locale, String path) {
  final docLocale = locale.languageCode == _unprefixedLocale
      ? const Locale(_unprefixedLocale)
      : fallbackLocale;
  return webUrlFor(origin, docLocale, path);
}
