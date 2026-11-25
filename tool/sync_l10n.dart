// Builds lib/l10n/arb/app_{locale}.arb from the web repo's translations.
//
// The web repo (hyjoong/trackerfollows) is the single source of truth:
// i18n/messages/{locale}.json holds an `App` bundle for the native screens and
// the `FAQ` bundle the web already translates. Run after either changes:
//
//   dart run tool/sync_l10n.dart --web ../trackerfollows
//   flutter gen-l10n
//
// The generated ARB files are committed so the app builds without the web repo.
import 'dart:convert';
import 'dart:io';

import 'package:trackfollows/l10n/supported_languages.dart';

const _template = 'ko';
const _bundles = ['App', 'FAQ'];
final _placeholder = RegExp(r'\{(\w+)\}');

void main(List<String> args) {
  final webIndex = args.indexOf('--web');
  final webRoot = webIndex >= 0 && webIndex + 1 < args.length
      ? args[webIndex + 1]
      : '../trackerfollows';
  final outDir = Directory('lib/l10n/arb')..createSync(recursive: true);

  final template = _flatten(_read(webRoot, _template));
  final english = _flatten(_read(webRoot, 'en'));
  for (final locale in supportedLanguageCodes) {
    final messages = locale == _template
        ? template
        : _flatten(_read(webRoot, locale));
    // A FAQ entry the web has not translated yet falls back to English;
    // App messages must be complete.
    for (final key in template.keys) {
      if (messages.containsKey(key) || !key.startsWith('faq')) continue;
      stderr.writeln('$locale: $key not translated on the web, using en');
      messages[key] = english[key] ?? template[key]!;
    }
    _check(locale, template, messages);

    final arb = <String, Object>{'@@locale': locale};
    for (final key in template.keys) {
      final value = messages[key]!;
      arb[key] = value;
      if (locale != _template) continue;
      final names = _placeholder.allMatches(value).map((m) => m[1]!).toSet();
      if (names.isEmpty) continue;
      arb['@$key'] = {
        'placeholders': {
          for (final name in names) name: {'type': 'String'},
        },
      };
    }
    final file = File('${outDir.path}/app_$locale.arb');
    file.writeAsStringSync(
      '${const JsonEncoder.withIndent('  ').convert(arb)}\n',
    );
    stdout.writeln('${file.path}: ${template.length} messages');
  }
}

Map<String, dynamic> _read(String webRoot, String locale) {
  final file = File('$webRoot/i18n/messages/$locale.json');
  if (!file.existsSync()) {
    stderr.writeln('Missing ${file.path}. Pass the web repo with --web <path>.');
    exit(1);
  }
  return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
}

/// `App.history.title` -> `historyTitle`, `FAQ.isSafe.question` ->
/// `faqIsSafeQuestion`.
Map<String, String> _flatten(Map<String, dynamic> messages) {
  final out = <String, String>{};
  void walk(Object? node, List<String> path) {
    if (node is String) {
      out[_camel(path)] = node;
    } else if (node is Map<String, dynamic>) {
      node.forEach((key, value) => walk(value, [...path, key]));
    }
  }

  for (final bundle in _bundles) {
    final node = messages[bundle];
    if (node == null) {
      stderr.writeln('The web messages have no "$bundle" bundle.');
      exit(1);
    }
    if (bundle == 'App') {
      walk(node, const []);
    } else {
      // The app shows the FAQ title and its question/answer pairs only.
      final faq = node as Map<String, dynamic>;
      walk(faq['title'], const ['faq', 'title']);
      faq.forEach((key, value) {
        if (value is Map && value.containsKey('question')) {
          walk(value, ['faq', key]);
        }
      });
    }
  }
  return out;
}

String _camel(List<String> parts) => [
      parts.first,
      for (final part in parts.skip(1))
        part.isEmpty ? '' : part[0].toUpperCase() + part.substring(1),
    ].join();

void _check(
  String locale,
  Map<String, String> template,
  Map<String, String> messages,
) {
  Set<String> names(String text) =>
      _placeholder.allMatches(text).map((m) => m[1]!).toSet();
  final problems = <String>[];
  for (final entry in template.entries) {
    final value = messages[entry.key];
    if (value == null) {
      problems.add('missing ${entry.key}');
    } else if (!_sameSet(names(entry.value), names(value))) {
      problems.add('placeholders differ in ${entry.key}');
    }
  }
  if (problems.isNotEmpty) {
    stderr.writeln('$locale: ${problems.join(', ')}');
    exit(1);
  }
}

bool _sameSet(Set<String> a, Set<String> b) =>
    a.length == b.length && a.containsAll(b);
