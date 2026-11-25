import 'dart:io' show Platform;
import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

import '../l10n/app_locale.dart';
import '../l10n/gen/app_localizations.dart';

/// Notification copy, fixed at scheduling time in the app language.
class ReminderText {
  const ReminderText({
    required this.title,
    required this.body,
    required this.channelName,
    required this.channelDescription,
  });

  factory ReminderText.of(AppLocalizations l10n) => ReminderText(
        title: l10n.reminderTitle,
        body: l10n.reminderBody,
        channelName: l10n.reminderChannelName,
        channelDescription: l10n.reminderChannelDescription,
      );

  final String title;
  final String body;
  final String channelName;
  final String channelDescription;
}

/// OS boundary so the reminder flow can be tested without notifications.
abstract interface class ReminderBackend {
  /// Asks the OS for notification permission; true when it is granted.
  Future<bool> requestPermission();
  Future<void> schedule(DateTime when, ReminderText text);
  Future<void> cancel();
}

class LocalNotificationReminderBackend implements ReminderBackend {
  LocalNotificationReminderBackend([FlutterLocalNotificationsPlugin? plugin])
      : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  /// Separate from the "analysis complete" notification, which uses id 0.
  static const notificationId = 1001;

  final FlutterLocalNotificationsPlugin _plugin;

  @override
  Future<bool> requestPermission() async {
    if (Platform.isAndroid) {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      return await android?.requestNotificationsPermission() ?? false;
    }
    if (Platform.isIOS) {
      final ios = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      return await ios?.requestPermissions(
              alert: true, badge: true, sound: true) ??
          false;
    }
    return false;
  }

  @override
  Future<void> schedule(DateTime when, ReminderText text) =>
      _plugin.zonedSchedule(
        notificationId,
        text.title,
        text.body,
        // An absolute instant, so the device's time zone database isn't needed.
        tz.TZDateTime.from(when.toUtc(), tz.UTC),
        NotificationDetails(
          android: AndroidNotificationDetails(
            'recheck_reminder',
            text.channelName,
            channelDescription: text.channelDescription,
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        // Inexact is enough for a two-week reminder and needs no alarm permission.
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );

  @override
  Future<void> cancel() => _plugin.cancel(notificationId);
}

/// Opt-in reminder to analyze a fresh export two weeks after the last analysis.
///
/// One export only shows who doesn't follow back; who unfollowed appears on the
/// next analysis. The reminder brings people back for that second one.
class RecheckReminderController {
  RecheckReminderController({
    ReminderBackend? backend,
    Future<SharedPreferences> Function()? prefs,
    DateTime Function()? now,
    Locale Function()? locale,
  })  : _backend = backend ?? LocalNotificationReminderBackend(),
        _prefs = prefs ?? SharedPreferences.getInstance,
        _now = now ?? DateTime.now,
        _locale = locale ?? (() => fallbackLocale);

  static const enabledKey = 'recheck_reminder_enabled';
  static const promptCountKey = 'recheck_reminder_prompt_count';

  /// When the pending reminder fires (ms since epoch), so a language change
  /// can re-schedule it at the same time.
  static const dueKey = 'recheck_reminder_due';
  static const delay = Duration(days: 14);

  /// How many times the opt-in may be offered before we stop asking.
  static const maxPrompts = 2;

  final ReminderBackend _backend;
  final Future<SharedPreferences> Function() _prefs;
  final DateTime Function() _now;
  final Locale Function() _locale;

  ReminderText get _text => ReminderText.of(lookupAppLocalizations(_locale()));

  final _changes = ValueNotifier<int>(0);

  /// Fires after the reminder is turned on or off, wherever that happened
  /// (the prompt after an analysis or the settings switch), so screens that
  /// show the setting can read [isEnabled] again.
  Listenable get changes => _changes;

  Future<void> _schedule(DateTime when) async {
    await _backend.schedule(when, _text);
    await (await _prefs()).setInt(dueKey, when.millisecondsSinceEpoch);
  }

  Future<bool> isEnabled() async =>
      (await _prefs()).getBool(enabledKey) ?? false;

  /// True while the person has neither answered nor been asked [maxPrompts] times.
  Future<bool> shouldPrompt() async {
    final prefs = await _prefs();
    if (prefs.getBool(enabledKey) != null) return false;
    return (prefs.getInt(promptCountKey) ?? 0) < maxPrompts;
  }

  Future<void> markPrompted() async {
    final prefs = await _prefs();
    await prefs.setInt(promptCountKey, (prefs.getInt(promptCountKey) ?? 0) + 1);
  }

  /// Returns false when the OS permission was refused; nothing is saved then.
  Future<bool> enable() async {
    try {
      if (!await _backend.requestPermission()) return false;
      await _schedule(_now().add(delay));
    } catch (error) {
      debugPrint('Recheck reminder enable failed: $error');
      return false;
    }
    await (await _prefs()).setBool(enabledKey, true);
    _changes.value++;
    return true;
  }

  Future<void> disable() async {
    await (await _prefs()).setBool(enabledKey, false);
    _changes.value++;
    try {
      await _backend.cancel();
    } catch (error) {
      debugPrint('Recheck reminder cancel failed: $error');
    }
  }

  /// Pushes the reminder out to two weeks after this analysis.
  Future<void> onAnalysisCompleted() async {
    if (!await isEnabled()) return;
    try {
      await _schedule(_now().add(delay));
    } catch (error) {
      debugPrint('Recheck reminder schedule failed: $error');
    }
  }

  /// The copy is fixed when scheduled, so after a language change the pending
  /// reminder is scheduled again at the same time with the new language.
  Future<void> onLocaleChanged() async {
    if (!await isEnabled()) return;
    final due = (await _prefs()).getInt(dueKey);
    if (due == null) return;
    final when = DateTime.fromMillisecondsSinceEpoch(due);
    if (!when.isAfter(_now())) return;
    try {
      await _schedule(when);
    } catch (error) {
      debugPrint('Recheck reminder reschedule failed: $error');
    }
  }
}
