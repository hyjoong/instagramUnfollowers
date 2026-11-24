// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonUnfollowers => 'Non-abonnés';

  @override
  String get commonFans => 'Fans';

  @override
  String get commonMutual => 'Mutuels';

  @override
  String get commonFollowers => 'Abonnés';

  @override
  String get commonTotalFollowers => 'Total des abonnés';

  @override
  String get commonTotalFollowing => 'Total des abonnements';

  @override
  String get commonNewFollowers => 'Nouveaux abonnés';

  @override
  String get commonNotificationPermissionOff =>
      'Les notifications sont désactivées. Autorisez-les dans les réglages de votre appareil.';

  @override
  String get navAnalyze => 'Analyse';

  @override
  String get navHistory => 'Historique';

  @override
  String get navSettings => 'Réglages';

  @override
  String get mainFilePickFailed => 'Échec de la sélection du fichier';

  @override
  String get mainPreparingResults => 'Préparation de vos résultats';

  @override
  String get mainReminderPrompt =>
      'Vous saurez qui s\'est désabonné lors de votre prochaine analyse. Voulez-vous un rappel dans 2 semaines ?';

  @override
  String get mainReminderAction => 'Me rappeler';

  @override
  String get mainReminderEnabled =>
      'Nous vous le rappellerons dans 2 semaines. Vous pouvez désactiver cela dans les Réglages.';

  @override
  String get mainExitTitle => 'Quitter l\'app';

  @override
  String get mainExitMessage => 'Voulez-vous quitter l\'app ?';

  @override
  String get mainExitConfirm => 'Quitter';

  @override
  String get loadingTitle => 'Analyse des désabonnements Instagram';

  @override
  String get loadingMessage => 'Chargement...';

  @override
  String get errorTitle => 'Erreur de connexion';

  @override
  String get onboardingWelcomeTitle => 'Bienvenue sur TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'Analysez vos données d\'abonnés Instagram pour voir les non-abonnés, les abonnements mutuels et les dates d\'abonnement.';

  @override
  String get onboardingSafeTitle => '100 % sûr et confidentiel';

  @override
  String get onboardingSafeBody =>
      'Toutes les données sont traitées sur votre appareil. Nous ne collectons ni ne stockons aucune information personnelle.';

  @override
  String get onboardingEasyTitle => 'Simple à utiliser';

  @override
  String get onboardingEasyBody =>
      'Importez simplement votre fichier de données Instagram et consultez vos résultats immédiatement.';

  @override
  String get onboardingReadyTitle => 'Vous êtes prêt à commencer';

  @override
  String get onboardingReadyBody =>
      'Commencez à analyser vos abonnés Instagram !';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingNext => 'Suivant';

  @override
  String get onboardingStart => 'Commencer';

  @override
  String get historyTitle => 'Historique des analyses';

  @override
  String get historyLowOverlap =>
      'Les abonnés de ces deux enregistrements se recoupent à peine. Vérifiez qu\'ils proviennent du même compte.';

  @override
  String get historyDeleteTitle => 'Supprimer l\'analyse';

  @override
  String get historyDeleteMessage => 'Voulez-vous supprimer cette analyse ?';

  @override
  String get historyDeleted => 'L\'analyse a été supprimée';

  @override
  String get historyDeleteFailed => 'Échec de la suppression';

  @override
  String get historyShareSubject => 'Résultats de l\'analyse Instagram';

  @override
  String get historyShareFooter => 'Créé avec l\'app TrackFollows';

  @override
  String get historyCompare => 'Comparer deux enregistrements';

  @override
  String get historyCompareSelected => 'Comparer les enregistrements choisis';

  @override
  String historyCompareHint(String count) {
    return 'Choisissez deux enregistrements à comparer ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'Aucun historique d\'analyse';

  @override
  String get historyEmptyBody => 'Vos résultats d\'analyse s\'afficheront ici';

  @override
  String historyExportedOn(String date) {
    return 'Exporté le $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'Abonnés $followers · Abonnements $following · Non-abonnés $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'Analyse : $date';
  }

  @override
  String get historyViewStats => 'Voir les statistiques';

  @override
  String get historyShare => 'Partager';

  @override
  String get historyFirstRecord =>
      'Premier enregistrement · Les changements seront comparés dès votre prochaine analyse';

  @override
  String get historyNoChange =>
      'Aucun changement d\'abonnés depuis l\'enregistrement précédent';

  @override
  String get historyVsPrevious => 'Par rapport à l\'enregistrement précédent';

  @override
  String historyLostCount(String count) {
    return 'Désabonnés $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'Nouveaux abonnés $count';
  }

  @override
  String get statsTitle => 'Résultats de l\'analyse';

  @override
  String get statsNotFoundTitle => 'Données d\'analyse introuvables';

  @override
  String get statsNotFoundBody =>
      'Ces données ont été supprimées ou n\'existent pas';

  @override
  String get statsBack => 'Retour';

  @override
  String get statsSummary => 'Résumé de l\'analyse';

  @override
  String get statsNoData => 'Aucune donnée d\'analyse';

  @override
  String get statsDistribution => 'Répartition des abonnés';

  @override
  String get statsDetailedStats => 'Statistiques détaillées';

  @override
  String get statsDetails => 'Détails';

  @override
  String get statsAnalysisDate => 'Date de l\'analyse';

  @override
  String statsMutualRate(String rate) {
    return 'Taux d\'abonnements mutuels : $rate%';
  }

  @override
  String get compareTitle => 'Comparer les enregistrements';

  @override
  String get compareRecentStats => 'Statistiques du dernier enregistrement';

  @override
  String compareAnalysisDay(String date) {
    return '$date (jour d\'analyse)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(jour d\'analyse) indique un ancien enregistrement dont le nom de fichier ne contient pas la date d\'export ; c\'est donc le jour de l\'analyse qui est affiché.';

  @override
  String get compareLostTitle => 'Personnes qui se sont désabonnées';

  @override
  String get compareLostEmpty =>
      'Personne ne s\'est désabonné pendant cette période.';

  @override
  String get compareNewEmpty => 'Aucun nouvel abonné pendant cette période.';

  @override
  String get compareRenamedTitle =>
      'Comptes qui ont changé de nom d\'utilisateur';

  @override
  String get compareDisappearedNote =>
      'Certains comptes disparus de la liste ont peut-être été désactivés ou supprimés au lieu de se désabonner. Touchez le profil pour vérifier.';

  @override
  String get compareNoChange => 'Aucun changement';

  @override
  String get compareExportDateNote =>
      'Les dates correspondent au jour où le fichier a été exporté depuis Instagram.';

  @override
  String get compareChange => 'Évolution';

  @override
  String get compareLost => 'Désabonnés';

  @override
  String get appSettingsTitle => 'Réglages de l\'app';

  @override
  String get appSettingsAnalysisSection => 'Réglages d\'analyse';

  @override
  String get appSettingsDataSection => 'Gestion des données';

  @override
  String get appSettingsAnalysisNotify => 'Notifications d\'analyse';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'Recevez une notification lorsqu\'une analyse est terminée';

  @override
  String get appSettingsAutoRefresh =>
      'Actualisation automatique de l\'historique';

  @override
  String get appSettingsAutoRefreshBody =>
      'Met à jour automatiquement les données de l\'historique';

  @override
  String get appSettingsClearHistory => 'Supprimer l\'historique des analyses';

  @override
  String get appSettingsClearHistoryBody =>
      'Supprime toutes les données d\'analyse enregistrées';

  @override
  String get appSettingsExportAll => 'Exporter toutes les données';

  @override
  String get appSettingsExportAllBody =>
      'Exporte toutes les données d\'analyse au format texte';

  @override
  String get appSettingsClearTitle => 'Supprimer l\'historique';

  @override
  String get appSettingsClearMessage =>
      'Voulez-vous supprimer tout l\'historique des analyses ? Cette action est irréversible.';

  @override
  String get appSettingsCleared =>
      'L\'historique des analyses a bien été supprimé';

  @override
  String get appSettingsClearFailed =>
      'Échec de la suppression de l\'historique';

  @override
  String get appSettingsNothingToExport =>
      'Aucune donnée d\'analyse à exporter';

  @override
  String get appSettingsExportTitle =>
      'Export des données d\'analyse TrackFollows';

  @override
  String appSettingsExportCreated(String date) {
    return 'Créé le : $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'Analyse $index';
  }

  @override
  String get appSettingsExportDate => 'Date';

  @override
  String get appSettingsExportFailed => 'Échec de l\'export des données';

  @override
  String get settingsTitle => 'Réglages';

  @override
  String get settingsNotificationsSection => 'Notifications';

  @override
  String get settingsRecheckTitle => 'Rappel de vérification';

  @override
  String get settingsRecheckBody =>
      'Nous vous rappelons 2 semaines après l\'analyse de vérifier avec un nouveau fichier';

  @override
  String get settingsSupportSection => 'Assistance et mentions légales';

  @override
  String get settingsFaq => 'Questions fréquentes';

  @override
  String get settingsTerms => 'Conditions d\'utilisation';

  @override
  String get settingsPrivacy => 'Politique de confidentialité';

  @override
  String get settingsAdPrivacy => 'Confidentialité des publicités';

  @override
  String get settingsAppInfoSection => 'Infos sur l\'app';

  @override
  String get settingsAboutTitle => 'À propos de TrackFollows';

  @override
  String get settingsAboutBody =>
      'TrackFollows est un outil qui analyse vos données Instagram sur votre appareil. Vous trouverez dans la Politique de confidentialité des détails sur le traitement des informations par les services publicitaires.';

  @override
  String settingsVersion(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. Tous droits réservés.';

  @override
  String get settingsLanguage => 'Langue';

  @override
  String get settingsLanguageSystem => 'Suivre la langue de l\'appareil';

  @override
  String get settingsOpenLinkFailed => 'Impossible d\'ouvrir le lien.';

  @override
  String get adConsentNotReady => 'Rouvrez cet écran, puis réessayez.';

  @override
  String get adConsentPreparing =>
      'Les réglages de confidentialité des publicités sont en cours de préparation. Réessayez dans un instant.';

  @override
  String get adConsentNothingToChange =>
      'Aucun réglage de confidentialité des publicités à modifier pour le moment.';

  @override
  String get adConsentOpenFailed =>
      'Impossible d\'ouvrir les réglages de confidentialité. Réessayez dans un instant.';

  @override
  String get adConsentStatusFailed =>
      'Impossible de vérifier l\'état des réglages de confidentialité. Réessayez dans un instant.';

  @override
  String get reminderTitle => 'Il est temps de revérifier vos désabonnements';

  @override
  String get reminderBody =>
      'Deux semaines se sont écoulées depuis votre dernière analyse. Analysez un nouveau fichier pour savoir qui s\'est désabonné entre-temps.';

  @override
  String get reminderChannelName => 'Rappel de vérification';

  @override
  String get reminderChannelDescription =>
      'Vous rappelle 2 semaines après l\'analyse de revérifier avec un nouveau fichier';

  @override
  String get faqTitle => 'Questions Fréquentes';

  @override
  String get faqIsSafeQuestion => 'Ce service est-il sûr ?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows ne demande pas votre mot de passe Instagram et ne se connecte pas à votre compte. Les fichiers sélectionnés sont analysés sur votre appareil. Les traitements liés aux diagnostics d’utilisation et aux services publicitaires sont décrits séparément dans la politique de confidentialité.';

  @override
  String get faqDownloadTimeQuestion =>
      'Combien de temps faut-il pour télécharger mes données ?';

  @override
  String get faqDownloadTimeAnswer =>
      'Instagram prépare l’export. Le délai varie : consultez la notification ou l’écran d’export, puis téléchargez le ZIP lorsqu’il est prêt.';

  @override
  String get faqWhatIsUnfollowerQuestion =>
      'Qu\'est-ce qu\'un non-abonné exactement ?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'Ces comptes figurent dans votre liste d’abonnements, mais pas dans celle de vos abonnés, dans les fichiers fournis. Certains ne vous ont peut-être jamais suivi. Un seul export ne permet pas de déterminer si une personne vous suivait auparavant ni quand elle s’est désabonnée.';

  @override
  String get faqThreadsQuestion =>
      'Puis-je aussi voir mes désabonnements sur Threads ?';

  @override
  String get faqThreadsAnswer =>
      'Oui. Si le ZIP téléchargé depuis Instagram contient vos listes d\'abonnés et d\'abonnements Threads, vous obtenez un résultat Threads distinct de celui d\'Instagram. Passez de Instagram à Threads en haut des résultats. Les abonnés Threads forment une liste distincte de vos abonnés Instagram.';

  @override
  String get faqIsFreeQuestion =>
      'Est-ce que l\'utilisation de ce service coûte quelque chose ?';

  @override
  String get faqIsFreeAnswer =>
      'Non, ce service est totalement gratuit. Vous pouvez utiliser toutes les fonctionnalités sans frais.';

  @override
  String get faqIncorrectListQuestion =>
      'La liste des unfollowers apparaît différente de ce que j\'attendais. Pourquoi ?';

  @override
  String get faqIncorrectListAnswer =>
      'Les résultats reflètent les listes de votre export et peuvent différer de l’état actuel sur Instagram. La date de l’export, la période choisie et les comptes supprimés ou désactivés peuvent affecter les listes et les totaux.\n\nChoisissez Toute la période lors de l’export et vérifiez que tous les fichiers d’abonnés et d’abonnements sont inclus. Même un nouvel export ne garantit pas une correspondance avec l’état actuel des comptes.';

  @override
  String get faqFileSelectErrorQuestion =>
      'Je ne peux pas sélectionner le fichier ZIP';

  @override
  String get faqFileSelectErrorAnswer =>
      'Lorsque vous ouvrez le lien via KakaoTalk ou d\'autres applications de messagerie, la sélection de fichiers peut ne pas fonctionner. Dans ce cas, essayez d\'accéder au site web directement via le navigateur Chrome ou Samsung Internet, puis sélectionnez le fichier. La sélection de fichiers fonctionne normalement lorsque vous accédez via un navigateur directement.';

  @override
  String get faqDataSecurityQuestion =>
      'Sécurité des données et confidentialité';

  @override
  String get faqDataSecurityAnswer =>
      'Vos fichiers Instagram d\'origine, noms de compte et listes d\'abonnés ne sont pas envoyés à un serveur pour l\'analyse. Pour comparer avec votre dernière analyse, les noms d\'utilisateur de vos abonnés et abonnements sont enregistrés uniquement sur cet appareil (navigateur ou application) et vous pouvez les supprimer à tout moment avec « Effacer l\'historique » sur l\'écran des résultats. Consultez la Politique de confidentialité pour le traitement des données de diagnostic et des services publicitaires.';
}
