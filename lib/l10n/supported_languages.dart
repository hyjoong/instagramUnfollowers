/// Languages the web app ships (`i18n.config.ts` in the web repo), in the
/// same order. The app follows this list so the WebView and the native
/// screens always agree. Pure Dart so tool/sync_l10n.dart can import it.
const supportedLanguageCodes = <String>[
  'ko', 'en', 'ja', 'es', 'fr', 'de', 'pt', 'hi', //
  'ru', 'ar', 'tr', 'vi', 'th', 'id', 'ms',
];
