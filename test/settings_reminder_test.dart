import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackfollows/l10n/gen/app_localizations.dart';
import 'package:trackfollows/reminders/recheck_reminder.dart';
import 'package:trackfollows/screens/settings_screen.dart';

class _GrantingBackend implements ReminderBackend {
  bool grant = true;

  @override
  Future<bool> requestPermission() async => grant;

  @override
  Future<void> schedule(DateTime when, ReminderText text) async {}

  @override
  Future<void> cancel() async {}
}

void main() {
  late RecheckReminderController reminder;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    PackageInfo.setMockInitialValues(
      appName: 'TrackFollows',
      packageName: 'com.hyjoong.trackfollows',
      version: '1.3.0',
      buildNumber: '45',
      buildSignature: '',
    );
    reminder = RecheckReminderController(backend: _GrantingBackend());
  });

  Future<void> pumpSettings(WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SettingsScreen(reminder: reminder),
    ));
    await tester.pumpAndSettle();
  }

  bool switchValue(WidgetTester tester) =>
      tester.widget<SwitchListTile>(find.byType(SwitchListTile)).value;

  // 설정 탭은 앱을 켤 때 만들어져 계속 살아 있다. 분석 후 권유에서 켠 것이
  // 이미 떠 있는 설정 화면의 스위치에도 보여야 한다.
  testWidgets('turning the reminder on elsewhere updates the open settings',
      (tester) async {
    await pumpSettings(tester);
    expect(switchValue(tester), isFalse);

    await tester.runAsync(reminder.enable);
    await tester.pumpAndSettle();
    expect(switchValue(tester), isTrue);

    await tester.runAsync(reminder.disable);
    await tester.pumpAndSettle();
    expect(switchValue(tester), isFalse);
  });

  testWidgets('the switch turns the reminder on and off', (tester) async {
    await pumpSettings(tester);

    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    expect(switchValue(tester), isTrue);
    expect(await tester.runAsync(reminder.isEnabled), isTrue);

    await tester.tap(find.byType(SwitchListTile));
    await tester.pumpAndSettle();
    expect(switchValue(tester), isFalse);
    expect(await tester.runAsync(reminder.isEnabled), isFalse);
  });
}
