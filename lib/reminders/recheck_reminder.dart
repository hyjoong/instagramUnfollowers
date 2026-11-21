import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;

/// OS boundary so the reminder flow can be tested without notifications.
abstract interface class ReminderBackend {
  /// Asks the OS for notification permission; true when it is granted.
  Future<bool> requestPermission();
  Future<void> schedule(DateTime when);
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
  Future<void> schedule(DateTime when) => _plugin.zonedSchedule(
        notificationId,
        '언팔 다시 확인할 때예요',
        '지난 분석 후 2주가 지났어요. 새 파일로 분석하면 그사이 나를 언팔한 사람을 알 수 있어요.',
        // An absolute instant, so the device's time zone database isn't needed.
        tz.TZDateTime.from(when.toUtc(), tz.UTC),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'recheck_reminder',
            '다시 확인 알림',
            channelDescription: '분석 후 2주 뒤에 새 파일로 다시 확인하라고 알려 드려요',
          ),
          iOS: DarwinNotificationDetails(),
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
  })  : _backend = backend ?? LocalNotificationReminderBackend(),
        _prefs = prefs ?? SharedPreferences.getInstance,
        _now = now ?? DateTime.now;

  static const enabledKey = 'recheck_reminder_enabled';
  static const promptCountKey = 'recheck_reminder_prompt_count';
  static const delay = Duration(days: 14);

  /// How many times the opt-in may be offered before we stop asking.
  static const maxPrompts = 2;

  final ReminderBackend _backend;
  final Future<SharedPreferences> Function() _prefs;
  final DateTime Function() _now;

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
      await _backend.schedule(_now().add(delay));
    } catch (error) {
      debugPrint('Recheck reminder enable failed: $error');
      return false;
    }
    await (await _prefs()).setBool(enabledKey, true);
    return true;
  }

  Future<void> disable() async {
    await (await _prefs()).setBool(enabledKey, false);
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
      await _backend.schedule(_now().add(delay));
    } catch (error) {
      debugPrint('Recheck reminder schedule failed: $error');
    }
  }
}
