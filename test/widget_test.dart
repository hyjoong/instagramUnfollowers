import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trackfollows/l10n/gen/app_localizations.dart';
import 'package:trackfollows/screens/error_screen.dart';

void main() {
  testWidgets('error screen shows the message and calls retry', (tester) async {
    var retried = 0;
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ErrorScreen(errorMessage: 'offline', onRetry: () => retried++),
    ));

    expect(find.text('offline'), findsOneWidget);
    expect(find.text('Connection error'), findsOneWidget);
    await tester.tap(find.byType(ElevatedButton));
    expect(retried, 1);
  });
}
