// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get commonCancel => 'Abbrechen';

  @override
  String get commonDelete => 'Löschen';

  @override
  String get commonRetry => 'Erneut versuchen';

  @override
  String get commonUnfollowers => 'Unfollower';

  @override
  String get commonFans => 'Fans';

  @override
  String get commonMutual => 'Gegenseitige Follower';

  @override
  String get commonFollowers => 'Follower';

  @override
  String get commonTotalFollowers => 'Follower gesamt';

  @override
  String get commonTotalFollowing => 'Gefolgt gesamt';

  @override
  String get commonNewFollowers => 'Neue Follower';

  @override
  String get commonNotificationPermissionOff =>
      'Benachrichtigungen sind deaktiviert. Bitte erlauben Sie sie in den Geräteeinstellungen.';

  @override
  String get navAnalyze => 'Analyse';

  @override
  String get navHistory => 'Verlauf';

  @override
  String get navSettings => 'Einstellungen';

  @override
  String get mainFilePickFailed => 'Die Datei konnte nicht ausgewählt werden';

  @override
  String get mainPreparingResults =>
      'Ihre Analyseergebnisse werden vorbereitet';

  @override
  String get mainReminderPrompt =>
      'Wer Ihnen entfolgt ist, sehen Sie bei der nächsten Analyse. Sollen wir Sie in 2 Wochen erinnern?';

  @override
  String get mainReminderAction => 'Erinnern';

  @override
  String get mainReminderEnabled =>
      'Wir erinnern Sie in 2 Wochen. In den Einstellungen können Sie das ausschalten.';

  @override
  String get mainExitTitle => 'App beenden';

  @override
  String get mainExitMessage => 'Möchten Sie die App beenden?';

  @override
  String get mainExitConfirm => 'Beenden';

  @override
  String get loadingTitle => 'Instagram-Unfollower-Analyse';

  @override
  String get loadingMessage => 'Wird geladen...';

  @override
  String get errorTitle => 'Verbindungsfehler';

  @override
  String get onboardingWelcomeTitle => 'Willkommen bei TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'Analysieren Sie Ihre Instagram-Follower-Daten und sehen Sie Unfollower, gegenseitiges Folgen und Follow-Daten.';

  @override
  String get onboardingSafeTitle => '100 % sicher und privat';

  @override
  String get onboardingSafeBody =>
      'Alle Daten werden auf Ihrem Gerät verarbeitet. Es werden keine persönlichen Daten gesammelt oder gespeichert.';

  @override
  String get onboardingEasyTitle => 'Einfach zu bedienen';

  @override
  String get onboardingEasyBody =>
      'Laden Sie einfach Ihre Instagram-Datendatei hoch und sehen Sie sofort die Analyseergebnisse.';

  @override
  String get onboardingReadyTitle => 'Alles bereit';

  @override
  String get onboardingReadyBody =>
      'Starten Sie jetzt Ihre Instagram-Follower-Analyse!';

  @override
  String get onboardingSkip => 'Überspringen';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get onboardingStart => 'Los geht\'s';

  @override
  String get historyTitle => 'Analyseverlauf';

  @override
  String get historyLowOverlap =>
      'Die Follower beider Einträge überschneiden sich kaum. Bitte prüfen Sie, ob sie zum selben Konto gehören.';

  @override
  String get historyDeleteTitle => 'Analyseeintrag löschen';

  @override
  String get historyDeleteMessage =>
      'Möchten Sie diesen Analyseeintrag löschen?';

  @override
  String get historyDeleted => 'Analyseeintrag wurde gelöscht';

  @override
  String get historyDeleteFailed => 'Löschen fehlgeschlagen';

  @override
  String get historyShareSubject => 'Instagram-Analyseergebnis';

  @override
  String get historyShareFooter => 'Erstellt mit der TrackFollows-App';

  @override
  String get historyCompare => 'Zwei Einträge vergleichen';

  @override
  String get historyCompareSelected => 'Ausgewählte Einträge vergleichen';

  @override
  String historyCompareHint(String count) {
    return 'Wählen Sie zwei Einträge zum Vergleichen aus ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'Noch kein Analyseverlauf';

  @override
  String get historyEmptyBody => 'Ihre Analyseergebnisse erscheinen hier';

  @override
  String historyExportedOn(String date) {
    return 'Exportiert am $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'Follower $followers · Gefolgt $following · Unfollower $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'Analysiert: $date';
  }

  @override
  String get historyViewStats => 'Statistik ansehen';

  @override
  String get historyShare => 'Teilen';

  @override
  String get historyFirstRecord =>
      'Erster Eintrag · Ab der nächsten Analyse sehen Sie Veränderungen';

  @override
  String get historyNoChange =>
      'Keine Follower-Änderung seit dem letzten Eintrag';

  @override
  String get historyVsPrevious => 'Im Vergleich zum letzten Eintrag';

  @override
  String historyLostCount(String count) {
    return 'Entfolgt: $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'Neue Follower: $count';
  }

  @override
  String get statsTitle => 'Analyseergebnis';

  @override
  String get statsNotFoundTitle => 'Analysedaten nicht gefunden';

  @override
  String get statsNotFoundBody =>
      'Die Daten wurden gelöscht oder existieren nicht';

  @override
  String get statsBack => 'Zurück';

  @override
  String get statsSummary => 'Analyse-Zusammenfassung';

  @override
  String get statsNoData => 'Keine Analysedaten vorhanden';

  @override
  String get statsDistribution => 'Follower-Verteilung';

  @override
  String get statsDetailedStats => 'Detaillierte Statistik';

  @override
  String get statsDetails => 'Details';

  @override
  String get statsAnalysisDate => 'Analysedatum';

  @override
  String statsMutualRate(String rate) {
    return 'Anteil gegenseitiger Follower: $rate %';
  }

  @override
  String get compareTitle => 'Einträge vergleichen';

  @override
  String get compareRecentStats => 'Statistik des neuesten Eintrags';

  @override
  String compareAnalysisDay(String date) {
    return '$date (Analysetag)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(Analysetag) kennzeichnet ältere Einträge, deren Dateiname kein Exportdatum enthält. Hier wird der Tag der Analyse angezeigt.';

  @override
  String get compareLostTitle => 'Wer Ihnen entfolgt ist';

  @override
  String get compareLostEmpty =>
      'In diesem Zeitraum ist Ihnen niemand entfolgt.';

  @override
  String get compareNewEmpty =>
      'In diesem Zeitraum gibt es keine neuen Follower.';

  @override
  String get compareRenamedTitle => 'Konten mit geändertem Benutzernamen';

  @override
  String get compareDisappearedNote =>
      'Unter den aus der Liste verschwundenen Konten können auch deaktivierte oder gelöschte Konten sein, die Ihnen nicht entfolgt sind. Tippen Sie auf das Profil, um das zu prüfen.';

  @override
  String get compareNoChange => 'Keine Änderung';

  @override
  String get compareExportDateNote =>
      'Das Datum ist der Tag, an dem die Datei aus Instagram exportiert wurde.';

  @override
  String get compareChange => 'Änderung';

  @override
  String get compareLost => 'Entfolgt';

  @override
  String get appSettingsTitle => 'App-Einstellungen';

  @override
  String get appSettingsAnalysisSection => 'Analyseeinstellungen';

  @override
  String get appSettingsDataSection => 'Datenverwaltung';

  @override
  String get appSettingsAnalysisNotify => 'Analyse-Benachrichtigung';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'Sie werden benachrichtigt, sobald die Analyse abgeschlossen ist';

  @override
  String get appSettingsAutoRefresh => 'Verlauf automatisch aktualisieren';

  @override
  String get appSettingsAutoRefreshBody =>
      'Die Verlaufsdaten werden automatisch aktualisiert';

  @override
  String get appSettingsClearHistory => 'Analyseverlauf löschen';

  @override
  String get appSettingsClearHistoryBody =>
      'Alle gespeicherten Analysedaten werden gelöscht';

  @override
  String get appSettingsExportAll => 'Alle Daten exportieren';

  @override
  String get appSettingsExportAllBody =>
      'Alle Analysedaten werden als Text exportiert';

  @override
  String get appSettingsClearTitle => 'Verlauf löschen';

  @override
  String get appSettingsClearMessage =>
      'Möchten Sie den gesamten Analyseverlauf löschen? Dies kann nicht rückgängig gemacht werden.';

  @override
  String get appSettingsCleared =>
      'Der Analyseverlauf wurde erfolgreich gelöscht';

  @override
  String get appSettingsClearFailed =>
      'Der Verlauf konnte nicht gelöscht werden';

  @override
  String get appSettingsNothingToExport => 'Keine Analysedaten zum Exportieren';

  @override
  String get appSettingsExportTitle => 'TrackFollows-Analysedaten-Export';

  @override
  String appSettingsExportCreated(String date) {
    return 'Erstellt am: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'Analyse $index';
  }

  @override
  String get appSettingsExportDate => 'Datum';

  @override
  String get appSettingsExportFailed => 'Datenexport fehlgeschlagen';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get settingsNotificationsSection => 'Benachrichtigungen';

  @override
  String get settingsRecheckTitle => 'Erinnerung zur erneuten Prüfung';

  @override
  String get settingsRecheckBody =>
      'Wir erinnern Sie 2 Wochen nach der Analyse daran, mit einer neuen Datei erneut zu prüfen';

  @override
  String get settingsSupportSection => 'Support und Rechtliches';

  @override
  String get settingsFaq => 'Häufig gestellte Fragen';

  @override
  String get settingsTerms => 'Nutzungsbedingungen';

  @override
  String get settingsPrivacy => 'Datenschutzerklärung';

  @override
  String get settingsAdPrivacy => 'Datenschutz bei Werbung';

  @override
  String get settingsAppInfoSection => 'App-Info';

  @override
  String get settingsAboutTitle => 'Über TrackFollows';

  @override
  String get settingsAboutBody =>
      'TrackFollows ist ein Tool, das Ihre Instagram-Daten auf Ihrem Gerät analysiert. Informationen zur Datenverarbeitung durch Werbedienste finden Sie in der Datenschutzerklärung.';

  @override
  String settingsVersion(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. Alle Rechte vorbehalten.';

  @override
  String get settingsLanguage => 'Sprache';

  @override
  String get settingsLanguageSystem => 'Gerätesprache verwenden';

  @override
  String get settingsOpenLinkFailed => 'Der Link konnte nicht geöffnet werden.';

  @override
  String get adConsentNotReady =>
      'Bitte öffnen Sie den Bildschirm erneut und versuchen Sie es noch einmal.';

  @override
  String get adConsentPreparing =>
      'Die Datenschutzeinstellungen für Werbung werden vorbereitet. Bitte versuchen Sie es gleich noch einmal.';

  @override
  String get adConsentNothingToChange =>
      'Aktuell gibt es keine Datenschutzeinstellungen für Werbung zu ändern.';

  @override
  String get adConsentOpenFailed =>
      'Die Datenschutzeinstellungen konnten nicht geöffnet werden. Bitte versuchen Sie es gleich noch einmal.';

  @override
  String get adConsentStatusFailed =>
      'Der Status der Datenschutzeinstellungen konnte nicht geprüft werden. Bitte versuchen Sie es gleich noch einmal.';

  @override
  String get reminderTitle => 'Zeit zu prüfen, wer Ihnen entfolgt ist';

  @override
  String get reminderBody =>
      'Seit Ihrer letzten Analyse sind 2 Wochen vergangen. Analysieren Sie eine neue Datei, um zu sehen, wer Ihnen seitdem entfolgt ist.';

  @override
  String get reminderChannelName => 'Erinnerung zur erneuten Prüfung';

  @override
  String get reminderChannelDescription =>
      'Erinnert Sie 2 Wochen nach der Analyse daran, mit einer neuen Datei erneut zu prüfen';

  @override
  String get faqTitle => 'Häufig gestellte Fragen';

  @override
  String get faqIsSafeQuestion => 'Ist dieser Dienst sicher?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows fragt nicht nach Ihrem Instagram-Passwort und meldet sich nicht bei Ihrem Konto an. Die ausgewählten Dateien werden auf Ihrem Gerät analysiert. Die Verarbeitung von Nutzungsdiagnosen und Daten durch Werbedienste wird gesondert in der Datenschutzerklärung beschrieben.';

  @override
  String get faqDownloadTimeQuestion =>
      'Wie lange dauert es, meine Daten herunterzuladen?';

  @override
  String get faqDownloadTimeAnswer =>
      'Instagram bereitet den Export vor. Die Dauer variiert. Prüfen Sie die Benachrichtigung oder die Exportansicht und laden Sie die ZIP-Datei herunter, sobald sie bereitsteht.';

  @override
  String get faqWhatIsUnfollowerQuestion => 'Was genau ist ein Unfollower?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'Diese Konten stehen in den bereitgestellten Dateien auf Ihrer Gefolgt-Liste, aber nicht auf Ihrer Follower-Liste. Darunter können Konten sein, die Ihnen nie gefolgt sind. Ein einzelner Export belegt nicht, ob Ihnen jemand früher gefolgt ist oder wann diese Person entfolgt ist.';

  @override
  String get faqThreadsQuestion =>
      'Kann ich auch meine Threads-Unfollower sehen?';

  @override
  String get faqThreadsAnswer =>
      'Ja. Enthält die von Instagram heruntergeladene ZIP-Datei Ihre Threads-Follower- und Gefolgt-Listen, erhalten Sie neben dem Instagram-Ergebnis ein eigenes Threads-Ergebnis. Oben in den Ergebnissen wechseln Sie zwischen Instagram und Threads. Threads-Follower sind eine eigene Liste, getrennt von Ihren Instagram-Followern.';

  @override
  String get faqIsFreeQuestion => 'Kostet die Nutzung dieses Dienstes etwas?';

  @override
  String get faqIsFreeAnswer =>
      'Nein, dieser Dienst ist völlig kostenlos. Sie können alle Funktionen kostenlos nutzen.';

  @override
  String get faqIncorrectListQuestion =>
      'Die Unfollower-Liste sieht anders aus als erwartet. Warum?';

  @override
  String get faqIncorrectListAnswer =>
      'Die Ergebnisse entsprechen den Listen im Export und können vom aktuellen Stand auf Instagram abweichen. Exportzeitpunkt, gewählter Zeitraum sowie gelöschte oder deaktivierte Konten können Listen und Anzahlen beeinflussen.\n\nWählen Sie beim Export den gesamten Zeitraum und prüfen Sie, ob alle Follower- und Gefolgt-Dateien enthalten sind. Auch ein neuer Export garantiert keine Übereinstimmung mit dem aktuellen Kontostatus.';

  @override
  String get faqFileSelectErrorQuestion =>
      'Ich kann die ZIP-Datei nicht auswählen';

  @override
  String get faqFileSelectErrorAnswer =>
      'Wenn Sie Links von Messaging-Apps wie KakaoTalk öffnen, funktioniert die Dateiauswahlfunktion möglicherweise nicht richtig. Versuchen Sie in diesem Fall, direkt über Browser wie Chrome oder Samsung Internet auf die Website zuzugreifen, um die Datei auszuwählen. Normalerweise können Sie Dateien normal auswählen, wenn Sie direkt über einen Browser zugreifen.';

  @override
  String get faqDataSecurityQuestion => 'Datensicherheit und Datenschutz';

  @override
  String get faqDataSecurityAnswer =>
      'Deine Instagram-Originaldateien, Kontonamen und Followerlisten werden für die Analyse nicht an einen Server gesendet. Für den Vergleich mit deiner letzten Analyse werden die Benutzernamen von Followern und Gefolgten nur auf diesem Gerät (Browser oder App) gespeichert; du kannst sie jederzeit über „Verlauf löschen“ im Ergebnis löschen. Informationen zur Nutzungs- und Fehlerdiagnose sowie zu Werbediensten findest du in der Datenschutzerklärung.';
}
