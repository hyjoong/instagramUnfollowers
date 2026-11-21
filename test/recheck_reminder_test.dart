import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackfollows/reminders/recheck_reminder.dart';

class _FakeBackend implements ReminderBackend {
  bool grant = true;
  bool failSchedule = false;
  final scheduled = <DateTime>[];
  int cancels = 0;

  @override
  Future<bool> requestPermission() async => grant;

  @override
  Future<void> schedule(DateTime when) async {
    if (failSchedule) throw StateError('schedule failed');
    scheduled.add(when);
  }

  @override
  Future<void> cancel() async => cancels++;
}

void main() {
  late DateTime now;
  late _FakeBackend backend;

  RecheckReminderController controller() =>
      RecheckReminderController(backend: backend, now: () => now);

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    now = DateTime(2026, 11, 21, 10);
    backend = _FakeBackend();
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
