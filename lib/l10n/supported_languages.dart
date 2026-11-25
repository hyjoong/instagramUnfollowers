/// Languages the web app ships (`i18n.config.ts` in the web repo), in the
/// same order. The app follows this list so the WebView and the native
/// screens always agree. Pure Dart so tool/sync_l10n.dart can import it.
const supportedLanguageCodes = <String>[
  'ko', 'en', 'ja', 'es', 'fr', 'de', 'pt', 'hi', //
  'ru', 'ar', 'tr', 'vi', 'th', 'id', 'ms',
];

/// Each language in its own name, as the web shows it (`localName` in
/// i18n.config.ts). Not translated: people look for their own language.
const languageNativeNames = <String, String>{
  'ko': '한국어',
  'en': 'English',
  'ja': '日本語',
  'es': 'Español',
  'fr': 'Français',
  'de': 'Deutsch',
  'pt': 'Português',
  'hi': 'हिंदी',
  'ru': 'Русский',
  'ar': 'العربية',
  'tr': 'Türkçe',
  'vi': 'Tiếng Việt',
  'th': 'ไทย',
  'id': 'Bahasa Indonesia',
  'ms': 'Bahasa Melayu',
};
