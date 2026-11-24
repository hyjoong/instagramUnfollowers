// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonRetry => 'Try again';

  @override
  String get commonUnfollowers => 'Unfollowers';

  @override
  String get commonFans => 'Fans';

  @override
  String get commonMutual => 'Mutual';

  @override
  String get commonFollowers => 'Followers';

  @override
  String get commonTotalFollowers => 'Total followers';

  @override
  String get commonTotalFollowing => 'Total following';

  @override
  String get commonNewFollowers => 'New followers';

  @override
  String get commonNotificationPermissionOff =>
      'Notifications are turned off. Please allow them in your device settings.';

  @override
  String get navAnalyze => 'Analyze';

  @override
  String get navHistory => 'History';

  @override
  String get navSettings => 'Settings';

  @override
  String get mainFilePickFailed => 'Failed to select the file';

  @override
  String get mainPreparingResults => 'Preparing your results';

  @override
  String get mainReminderPrompt =>
      'You\'ll see who unfollowed you after your next analysis. Want a reminder in 2 weeks?';

  @override
  String get mainReminderAction => 'Remind me';

  @override
  String get mainReminderEnabled =>
      'We\'ll remind you in 2 weeks. You can turn this off in Settings.';

  @override
  String get mainExitTitle => 'Exit app';

  @override
  String get mainExitMessage => 'Do you want to exit the app?';

  @override
  String get mainExitConfirm => 'Exit';

  @override
  String get loadingTitle => 'Instagram Unfollowers Analyzer';

  @override
  String get loadingMessage => 'Loading...';

  @override
  String get errorTitle => 'Connection error';

  @override
  String get onboardingWelcomeTitle => 'Welcome to TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'Analyze your Instagram follower data to see unfollowers, mutual follows, and follow dates.';

  @override
  String get onboardingSafeTitle => '100% safe and private';

  @override
  String get onboardingSafeBody =>
      'All data is processed on your device. We don\'t collect or store any personal information.';

  @override
  String get onboardingEasyTitle => 'Easy to use';

  @override
  String get onboardingEasyBody =>
      'Just upload your Instagram data file and see your results instantly.';

  @override
  String get onboardingReadyTitle => 'You\'re ready to start';

  @override
  String get onboardingReadyBody => 'Start analyzing your Instagram followers!';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Get started';

  @override
  String get historyTitle => 'Analysis history';

  @override
  String get historyLowOverlap =>
      'The followers in these two records barely overlap. Please check that they are from the same account.';

  @override
  String get historyDeleteTitle => 'Delete analysis';

  @override
  String get historyDeleteMessage => 'Do you want to delete this analysis?';

  @override
  String get historyDeleted => 'The analysis was deleted';

  @override
  String get historyDeleteFailed => 'Failed to delete';

  @override
  String get historyShareSubject => 'Instagram analysis results';

  @override
  String get historyShareFooter => 'Created with the TrackFollows app';

  @override
  String get historyCompare => 'Compare two records';

  @override
  String get historyCompareSelected => 'Compare selected records';

  @override
  String historyCompareHint(String count) {
    return 'Select two records to compare ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'No analysis history';

  @override
  String get historyEmptyBody => 'Your analysis results will appear here';

  @override
  String historyExportedOn(String date) {
    return 'Exported $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'Followers $followers · Following $following · Unfollowers $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'Analyzed: $date';
  }

  @override
  String get historyViewStats => 'View stats';

  @override
  String get historyShare => 'Share';

  @override
  String get historyFirstRecord =>
      'First record · Changes will be compared from your next analysis';

  @override
  String get historyNoChange => 'No follower changes since the previous record';

  @override
  String get historyVsPrevious => 'Compared to previous record';

  @override
  String historyLostCount(String count) {
    return 'Unfollowed $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'New followers $count';
  }

  @override
  String get statsTitle => 'Analysis results';

  @override
  String get statsNotFoundTitle => 'Analysis data not found';

  @override
  String get statsNotFoundBody => 'This data was deleted or doesn\'t exist';

  @override
  String get statsBack => 'Go back';

  @override
  String get statsSummary => 'Analysis summary';

  @override
  String get statsNoData => 'No analysis data';

  @override
  String get statsDistribution => 'Follower distribution';

  @override
  String get statsDetailedStats => 'Detailed stats';

  @override
  String get statsDetails => 'Details';

  @override
  String get statsAnalysisDate => 'Analysis date';

  @override
  String statsMutualRate(String rate) {
    return 'Mutual follow rate: $rate%';
  }

  @override
  String get compareTitle => 'Compare records';

  @override
  String get compareRecentStats => 'Latest record stats';

  @override
  String compareAnalysisDay(String date) {
    return '$date (analysis day)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(analysis day) marks an older record whose file name has no export date, so the day it was analyzed is shown instead.';

  @override
  String get compareLostTitle => 'People who unfollowed you';

  @override
  String get compareLostEmpty => 'No one unfollowed you during this period.';

  @override
  String get compareNewEmpty =>
      'You didn\'t get any new followers during this period.';

  @override
  String get compareRenamedTitle => 'Accounts that changed their username';

  @override
  String get compareDisappearedNote =>
      'Some accounts that disappeared from the list may have been deactivated or deleted instead of unfollowing. Tap a profile to check.';

  @override
  String get compareNoChange => 'No change';

  @override
  String get compareExportDateNote =>
      'Dates show the day the file was exported from Instagram.';

  @override
  String get compareChange => 'Change';

  @override
  String get compareLost => 'Unfollowed';

  @override
  String get appSettingsTitle => 'App settings';

  @override
  String get appSettingsAnalysisSection => 'Analysis settings';

  @override
  String get appSettingsDataSection => 'Data management';

  @override
  String get appSettingsAnalysisNotify => 'Analysis notifications';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'Get notified when an analysis is complete';

  @override
  String get appSettingsAutoRefresh => 'Auto-refresh history';

  @override
  String get appSettingsAutoRefreshBody =>
      'Automatically update your history data';

  @override
  String get appSettingsClearHistory => 'Delete analysis history';

  @override
  String get appSettingsClearHistoryBody => 'Delete all saved analysis data';

  @override
  String get appSettingsExportAll => 'Export all data';

  @override
  String get appSettingsExportAllBody => 'Export all analysis data as text';

  @override
  String get appSettingsClearTitle => 'Delete history';

  @override
  String get appSettingsClearMessage =>
      'Do you want to delete all analysis history? This can\'t be undone.';

  @override
  String get appSettingsCleared => 'Analysis history was deleted successfully';

  @override
  String get appSettingsClearFailed => 'Failed to delete history';

  @override
  String get appSettingsNothingToExport =>
      'There is no analysis data to export';

  @override
  String get appSettingsExportTitle => 'TrackFollows analysis data export';

  @override
  String appSettingsExportCreated(String date) {
    return 'Created: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'Analysis $index';
  }

  @override
  String get appSettingsExportDate => 'Date';

  @override
  String get appSettingsExportFailed => 'Failed to export data';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsNotificationsSection => 'Notifications';

  @override
  String get settingsRecheckTitle => 'Recheck reminder';

  @override
  String get settingsRecheckBody =>
      'We\'ll remind you to check with a new file 2 weeks after you analyze';

  @override
  String get settingsSupportSection => 'Support and legal';

  @override
  String get settingsFaq => 'FAQ';

  @override
  String get settingsTerms => 'Terms of Service';

  @override
  String get settingsPrivacy => 'Privacy Policy';

  @override
  String get settingsAdPrivacy => 'Ad privacy settings';

  @override
  String get settingsAppInfoSection => 'App info';

  @override
  String get settingsAboutTitle => 'About TrackFollows';

  @override
  String get settingsAboutBody =>
      'TrackFollows is a tool that analyzes your Instagram data on your device. You can find details about how ad services handle information in the Privacy Policy.';

  @override
  String settingsVersion(String version, String build) {
    return 'Version $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. All rights reserved.';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'Follow device language';

  @override
  String get settingsOpenLinkFailed => 'Couldn\'t open the link.';

  @override
  String get adConsentNotReady => 'Please reopen this screen and try again.';

  @override
  String get adConsentPreparing =>
      'Ad privacy settings are getting ready. Please try again in a moment.';

  @override
  String get adConsentNothingToChange =>
      'There are no ad privacy settings to change right now.';

  @override
  String get adConsentOpenFailed =>
      'Couldn\'t open privacy settings. Please try again in a moment.';

  @override
  String get adConsentStatusFailed =>
      'Couldn\'t check the privacy settings status. Please try again in a moment.';

  @override
  String get reminderTitle => 'Time to recheck your unfollowers';

  @override
  String get reminderBody =>
      'It\'s been 2 weeks since your last analysis. Analyze a new file to see who unfollowed you since then.';

  @override
  String get reminderChannelName => 'Recheck reminder';

  @override
  String get reminderChannelDescription =>
      'Reminds you to recheck with a new file 2 weeks after you analyze';

  @override
  String get faqTitle => 'Frequently Asked Questions';

  @override
  String get faqIsSafeQuestion => 'Is this service safe?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows does not ask for your Instagram password or sign in to your account. Selected files are analyzed on your device. Usage diagnostics and advertising services have separate data practices, described in the Privacy Policy.';

  @override
  String get faqDownloadTimeQuestion =>
      'How long does it take to download my data?';

  @override
  String get faqDownloadTimeAnswer =>
      'Instagram prepares the export. Preparation time varies; check its notification or export screen and download the ZIP when it is ready.';

  @override
  String get faqWhatIsUnfollowerQuestion => 'What exactly is an unfollower?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'These accounts appear in your following list but not your follower list in the files you provide. They may include accounts that never followed you. A single export cannot establish whether someone previously followed you or when they unfollowed.';

  @override
  String get faqThreadsQuestion => 'Can I check my Threads unfollowers too?';

  @override
  String get faqThreadsAnswer =>
      'Yes. If the ZIP you downloaded from Instagram includes your Threads followers and following lists, you get a separate Threads result alongside your Instagram result. Switch between Instagram and Threads at the top of the results. Threads followers are a separate list from your Instagram followers.';

  @override
  String get faqIsFreeQuestion => 'Does it cost anything to use this service?';

  @override
  String get faqIsFreeAnswer =>
      'No, this service is completely free. You can use all features at no cost.';

  @override
  String get faqIncorrectListQuestion =>
      'The unfollower list appears different from what I expected. Why?';

  @override
  String get faqIncorrectListAnswer =>
      'Results reflect the lists in your export and may differ from Instagram today. Export timing, the selected date range, and deleted or deactivated accounts may affect the lists and counts.\n\nSelect All time when exporting and check that all follower and following files are included. A new export still cannot guarantee a match with current account status.';

  @override
  String get faqFileSelectErrorQuestion => 'I can\'t select the ZIP file';

  @override
  String get faqFileSelectErrorAnswer =>
      'When opening links from messaging apps like KakaoTalk, the file selection feature may not work properly. In this case, try accessing the site directly through browsers like Chrome or Samsung Internet to select the file. Usually, you can select files normally when accessing directly through a browser';

  @override
  String get faqDataSecurityQuestion => 'Data Security & Privacy';

  @override
  String get faqDataSecurityAnswer =>
      'Your original Instagram files, account names and follower lists are not sent to a server for analysis. To compare with your last analysis, the follower and following usernames are saved only on this device (browser or app), and you can delete them anytime with \'Delete history\' on the results screen. See the Privacy Policy for information about usage diagnostics and advertising services.';
}
