import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'supported_languages.dart';

export 'supported_languages.dart';

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

  /// Set on the first launch of a version that has [AppLocaleStore], so the
  /// existing-user check below runs exactly once per device.
  static const migratedKey = 'app_locale_migrated';

  final SharedPreferences _prefs;
  List<Locale> _deviceLocales;

  /// Loads the saved language. A device that finished onboarding before this
  /// version is pinned to Korean, so an update never switches an existing
  /// user's app to English just because the phone is set to English.
  static Future<AppLocaleStore> load(
    SharedPreferences prefs,
    List<Locale> deviceLocales,
  ) async {
    if (!(prefs.getBool(migratedKey) ?? false)) {
      if (!prefs.containsKey(prefsKey) &&
          (prefs.getBool(onboardingCompletedKey) ?? false)) {
        await prefs.setString(prefsKey, _unprefixedLocale);
      }
      await prefs.setBool(migratedKey, true);
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

/// Keeps [AppLocaleStore] in sync when the device languages change while the
/// app is running (only matters when the user has not picked a language).
class DeviceLocaleObserver with WidgetsBindingObserver {
  DeviceLocaleObserver(this.store);

  final AppLocaleStore store;

  @override
  void didChangeLocales(List<Locale>? locales) {
    if (locales != null) store.updateDeviceLocales(locales);
  }
}

/// Medium date (`Nov 21, 2026`) in [locale]. Digits stay 0-9 in every
/// language so dates match the counts next to them (Arabic would otherwise
/// mix ٢١ with 35).
DateFormat appDateFormat(String locale) =>
    DateFormat.yMMMd(locale)..useNativeDigits = false;
