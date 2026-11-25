import 'dart:ui' show Locale;

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackfollows/reminders/recheck_reminder.dart';

class _FakeBackend implements ReminderBackend {
  bool grant = true;
  bool failSchedule = false;
  final scheduled = <DateTime>[];
  final titles = <String>[];
  int cancels = 0;

  @override
  Future<bool> requestPermission() async => grant;

  @override
  Future<void> schedule(DateTime when, ReminderText text) async {
    if (failSchedule) throw StateError('schedule failed');
    scheduled.add(when);
    titles.add(text.title);
  }

  @override
  Future<void> cancel() async => cancels++;
}

void main() {
  late DateTime now;
  late _FakeBackend backend;
  var locale = const Locale('ko');

  RecheckReminderController controller() => RecheckReminderController(
        backend: backend,
        now: () => now,
        locale: () => locale,
      );

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    now = DateTime(2026, 11, 21, 10);
    backend = _FakeBackend();
    locale = const Locale('ko');
  });

  test('the reminder is written in the app language', () async {
    locale = const Locale('en');
    await controller().enable();
    expect(backend.titles.single, isNot(contains('언팔')));
    expect(backend.titles.single, isNotEmpty);
  });

  test('a language change re-schedules the pending reminder at the same time',
      () async {
    final c = controller();
    await c.enable();
    final due = backend.scheduled.single;

    now = now.add(const Duration(days: 3));
    locale = const Locale('ja');
    await c.onLocaleChanged();

    expect(backend.scheduled, [due, due]);
    expect(backend.titles.first, isNot(backend.titles.last));
  });

  test('a language change does nothing when the reminder is off or past',
      () async {
    final c = controller();
    await c.onLocaleChanged();
    expect(backend.scheduled, isEmpty);

    await c.enable();
    now = now.add(const Duration(days: 15));
    await c.onLocaleChanged();
    expect(backend.scheduled, hasLength(1));
  });

  test('enabling schedules a reminder two weeks out', () async {
    final reminder = controller();

    expect(await reminder.enable(), isTrue);

    expect(await reminder.isEnabled(), isTrue);
    expect(backend.scheduled, [DateTime(2026, 12, 5, 10)]);
  });

  test('a refused permission saves nothing and can be offered again',
      () async {
    backend.grant = false;
    final reminder = controller();

    expect(await reminder.enable(), isFalse);

    expect(await reminder.isEnabled(), isFalse);
    expect(backend.scheduled, isEmpty);
    expect(await reminder.shouldPrompt(), isTrue);
  });

  test('a failed schedule does not turn the reminder on', () async {
    backend.failSchedule = true;
    final reminder = controller();

    expect(await reminder.enable(), isFalse);
    expect(await reminder.isEnabled(), isFalse);
  });

  test('each analysis pushes the reminder out again while enabled', () async {
    final reminder = controller();
    await reminder.enable();

    now = DateTime(2026, 11, 30, 9);
    await reminder.onAnalysisCompleted();

    expect(backend.scheduled.last, DateTime(2026, 12, 14, 9));
  });

  test('an analysis schedules nothing unless the reminder is on', () async {
    final reminder = controller();

    await reminder.onAnalysisCompleted();

    expect(backend.scheduled, isEmpty);
  });

  test('disabling cancels the reminder and stops the offer', () async {
    final reminder = controller();
    await reminder.enable();

    await reminder.disable();
    await reminder.onAnalysisCompleted();

    expect(await reminder.isEnabled(), isFalse);
    expect(backend.cancels, 1);
    expect(backend.scheduled, hasLength(1));
    expect(await reminder.shouldPrompt(), isFalse);
  });

  test('the offer stops after it has been shown twice', () async {
    final reminder = controller();

    expect(await reminder.shouldPrompt(), isTrue);
    await reminder.markPrompted();
    expect(await reminder.shouldPrompt(), isTrue);
    await reminder.markPrompted();
    expect(await reminder.shouldPrompt(), isFalse);
  });

  test('the offer is not shown once the reminder is on', () async {
    final reminder = controller();
    await reminder.enable();

    expect(await reminder.shouldPrompt(), isFalse);
  });
}
