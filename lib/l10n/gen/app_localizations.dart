import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('ja'),
    Locale('ko'),
    Locale('ms'),
    Locale('pt'),
    Locale('ru'),
    Locale('th'),
    Locale('tr'),
    Locale('vi')
  ];

  /// No description provided for @commonCancel.
  ///
  /// In ko, this message translates to:
  /// **'취소'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In ko, this message translates to:
  /// **'삭제'**
  String get commonDelete;

  /// No description provided for @commonRetry.
  ///
  /// In ko, this message translates to:
  /// **'다시 시도'**
  String get commonRetry;

  /// No description provided for @commonUnfollowers.
  ///
  /// In ko, this message translates to:
  /// **'언팔로워'**
  String get commonUnfollowers;

  /// No description provided for @commonFans.
  ///
  /// In ko, this message translates to:
  /// **'팬'**
  String get commonFans;

  /// No description provided for @commonMutual.
  ///
  /// In ko, this message translates to:
  /// **'맞팔'**
  String get commonMutual;

  /// No description provided for @commonFollowers.
  ///
  /// In ko, this message translates to:
  /// **'팔로워'**
  String get commonFollowers;

  /// No description provided for @commonTotalFollowers.
  ///
  /// In ko, this message translates to:
  /// **'총 팔로워'**
  String get commonTotalFollowers;

  /// No description provided for @commonTotalFollowing.
  ///
  /// In ko, this message translates to:
  /// **'총 팔로잉'**
  String get commonTotalFollowing;

  /// No description provided for @commonNewFollowers.
  ///
  /// In ko, this message translates to:
  /// **'새 팔로워'**
  String get commonNewFollowers;

  /// No description provided for @commonNotificationPermissionOff.
  ///
  /// In ko, this message translates to:
  /// **'알림 권한이 꺼져 있어요. 기기 설정에서 알림을 허용해 주세요.'**
  String get commonNotificationPermissionOff;

  /// No description provided for @navAnalyze.
  ///
  /// In ko, this message translates to:
  /// **'분석'**
  String get navAnalyze;

  /// No description provided for @navHistory.
  ///
  /// In ko, this message translates to:
  /// **'히스토리'**
  String get navHistory;

  /// No description provided for @navSettings.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get navSettings;

  /// No description provided for @mainFilePickFailed.
  ///
  /// In ko, this message translates to:
  /// **'파일 선택에 실패했습니다'**
  String get mainFilePickFailed;

  /// No description provided for @mainPreparingResults.
  ///
  /// In ko, this message translates to:
  /// **'분석 결과를 준비하고 있어요'**
  String get mainPreparingResults;

  /// No description provided for @mainReminderPrompt.
  ///
  /// In ko, this message translates to:
  /// **'누가 나를 언팔했는지는 다음 분석 때 알 수 있어요. 2주 뒤에 알려 드릴까요?'**
  String get mainReminderPrompt;

  /// No description provided for @mainReminderAction.
  ///
  /// In ko, this message translates to:
  /// **'알림 받기'**
  String get mainReminderAction;

  /// No description provided for @mainReminderEnabled.
  ///
  /// In ko, this message translates to:
  /// **'2주 뒤에 알려 드릴게요. 설정에서 끌 수 있어요.'**
  String get mainReminderEnabled;

  /// No description provided for @mainExitTitle.
  ///
  /// In ko, this message translates to:
  /// **'앱 종료'**
  String get mainExitTitle;

  /// No description provided for @mainExitMessage.
  ///
  /// In ko, this message translates to:
  /// **'앱을 종료하시겠습니까?'**
  String get mainExitMessage;

  /// No description provided for @mainExitConfirm.
  ///
  /// In ko, this message translates to:
  /// **'종료'**
  String get mainExitConfirm;

  /// No description provided for @loadingTitle.
  ///
  /// In ko, this message translates to:
  /// **'인스타그램 언팔로워 분석'**
  String get loadingTitle;

  /// No description provided for @loadingMessage.
  ///
  /// In ko, this message translates to:
  /// **'로딩 중...'**
  String get loadingMessage;

  /// No description provided for @errorTitle.
  ///
  /// In ko, this message translates to:
  /// **'연결 오류'**
  String get errorTitle;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In ko, this message translates to:
  /// **'TrackFollows에 오신 것을 환영합니다'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeBody.
  ///
  /// In ko, this message translates to:
  /// **'인스타그램 팔로워 데이터를 분석하여 언팔로워, 맞팔 상태, 팔로우 날짜를 확인해보세요.'**
  String get onboardingWelcomeBody;

  /// No description provided for @onboardingSafeTitle.
  ///
  /// In ko, this message translates to:
  /// **'100% 안전하고 개인정보 보호'**
  String get onboardingSafeTitle;

  /// No description provided for @onboardingSafeBody.
  ///
  /// In ko, this message translates to:
  /// **'모든 데이터 처리는 기기에서 이루어집니다. 개인정보를 수집하거나 저장하지 않습니다.'**
  String get onboardingSafeBody;

  /// No description provided for @onboardingEasyTitle.
  ///
  /// In ko, this message translates to:
  /// **'사용하기 쉬움'**
  String get onboardingEasyTitle;

  /// No description provided for @onboardingEasyBody.
  ///
  /// In ko, this message translates to:
  /// **'인스타그램 데이터 파일을 업로드하기만 하면 즉시 분석 결과를 확인할 수 있습니다.'**
  String get onboardingEasyBody;

  /// No description provided for @onboardingReadyTitle.
  ///
  /// In ko, this message translates to:
  /// **'시작할 준비가 되었습니다'**
  String get onboardingReadyTitle;

  /// No description provided for @onboardingReadyBody.
  ///
  /// In ko, this message translates to:
  /// **'인스타그램 팔로워 분석을 시작해보세요!'**
  String get onboardingReadyBody;

  /// No description provided for @onboardingSkip.
  ///
  /// In ko, this message translates to:
  /// **'건너뛰기'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In ko, this message translates to:
  /// **'다음'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In ko, this message translates to:
  /// **'시작하기'**
  String get onboardingStart;

  /// No description provided for @historyTitle.
  ///
  /// In ko, this message translates to:
  /// **'분석 히스토리'**
  String get historyTitle;

  /// No description provided for @historyLowOverlap.
  ///
  /// In ko, this message translates to:
  /// **'두 기록의 팔로워가 거의 겹치지 않아요. 같은 계정의 기록인지 확인해 주세요.'**
  String get historyLowOverlap;

  /// No description provided for @historyDeleteTitle.
  ///
  /// In ko, this message translates to:
  /// **'분석 기록 삭제'**
  String get historyDeleteTitle;

  /// No description provided for @historyDeleteMessage.
  ///
  /// In ko, this message translates to:
  /// **'이 분석 기록을 삭제하시겠습니까?'**
  String get historyDeleteMessage;

  /// No description provided for @historyDeleted.
  ///
  /// In ko, this message translates to:
  /// **'분석 기록이 삭제되었습니다'**
  String get historyDeleted;

  /// No description provided for @historyDeleteFailed.
  ///
  /// In ko, this message translates to:
  /// **'삭제에 실패했습니다'**
  String get historyDeleteFailed;

  /// No description provided for @historyShareSubject.
  ///
  /// In ko, this message translates to:
  /// **'인스타그램 분석 결과'**
  String get historyShareSubject;

  /// No description provided for @historyShareFooter.
  ///
  /// In ko, this message translates to:
  /// **'TrackFollows 앱으로 생성됨'**
  String get historyShareFooter;

  /// No description provided for @historyCompare.
  ///
  /// In ko, this message translates to:
  /// **'두 기록 비교'**
  String get historyCompare;

  /// No description provided for @historyCompareSelected.
  ///
  /// In ko, this message translates to:
  /// **'고른 두 기록 비교하기'**
  String get historyCompareSelected;

  /// No description provided for @historyCompareHint.
  ///
  /// In ko, this message translates to:
  /// **'비교할 기록 두 개를 골라 주세요 ({count}/2)'**
  String historyCompareHint(String count);

  /// No description provided for @historyEmptyTitle.
  ///
  /// In ko, this message translates to:
  /// **'분석 히스토리가 없습니다'**
  String get historyEmptyTitle;

  /// No description provided for @historyEmptyBody.
  ///
  /// In ko, this message translates to:
  /// **'분석 결과가 여기에 표시됩니다'**
  String get historyEmptyBody;

  /// No description provided for @historyExportedOn.
  ///
  /// In ko, this message translates to:
  /// **'{date} 내보내기'**
  String historyExportedOn(String date);

  /// No description provided for @historyCounts.
  ///
  /// In ko, this message translates to:
  /// **'팔로워 {followers} · 팔로잉 {following} · 언팔로워 {unfollowers}'**
  String historyCounts(String followers, String following, String unfollowers);

  /// No description provided for @historyAnalyzedOn.
  ///
  /// In ko, this message translates to:
  /// **'분석: {date}'**
  String historyAnalyzedOn(String date);

  /// No description provided for @historyViewStats.
  ///
  /// In ko, this message translates to:
  /// **'통계 보기'**
  String get historyViewStats;

  /// No description provided for @historyShare.
  ///
  /// In ko, this message translates to:
  /// **'공유'**
  String get historyShare;

  /// No description provided for @historyFirstRecord.
  ///
  /// In ko, this message translates to:
  /// **'첫 기록 · 다음 분석부터 변화를 비교해요'**
  String get historyFirstRecord;

  /// No description provided for @historyNoChange.
  ///
  /// In ko, this message translates to:
  /// **'직전 기록과 팔로워 변화 없음'**
  String get historyNoChange;

  /// No description provided for @historyVsPrevious.
  ///
  /// In ko, this message translates to:
  /// **'직전 기록 대비'**
  String get historyVsPrevious;

  /// No description provided for @historyLostCount.
  ///
  /// In ko, this message translates to:
  /// **'언팔 {count}'**
  String historyLostCount(String count);

  /// No description provided for @historyGainedCount.
  ///
  /// In ko, this message translates to:
  /// **'새 팔로워 {count}'**
  String historyGainedCount(String count);

  /// No description provided for @statsTitle.
  ///
  /// In ko, this message translates to:
  /// **'분석 결과'**
  String get statsTitle;

  /// No description provided for @statsNotFoundTitle.
  ///
  /// In ko, this message translates to:
  /// **'분석 데이터를 찾을 수 없습니다'**
  String get statsNotFoundTitle;

  /// No description provided for @statsNotFoundBody.
  ///
  /// In ko, this message translates to:
  /// **'삭제되었거나 존재하지 않는 데이터입니다'**
  String get statsNotFoundBody;

  /// No description provided for @statsBack.
  ///
  /// In ko, this message translates to:
  /// **'돌아가기'**
  String get statsBack;

  /// No description provided for @statsSummary.
  ///
  /// In ko, this message translates to:
  /// **'분석 요약'**
  String get statsSummary;

  /// No description provided for @statsNoData.
  ///
  /// In ko, this message translates to:
  /// **'분석 데이터가 없습니다'**
  String get statsNoData;

  /// No description provided for @statsDistribution.
  ///
  /// In ko, this message translates to:
  /// **'팔로워 분포'**
  String get statsDistribution;

  /// No description provided for @statsDetailedStats.
  ///
  /// In ko, this message translates to:
  /// **'상세 통계'**
  String get statsDetailedStats;

  /// No description provided for @statsDetails.
  ///
  /// In ko, this message translates to:
  /// **'상세 정보'**
  String get statsDetails;

  /// No description provided for @statsAnalysisDate.
  ///
  /// In ko, this message translates to:
  /// **'분석 날짜'**
  String get statsAnalysisDate;

  /// No description provided for @statsMutualRate.
  ///
  /// In ko, this message translates to:
  /// **'맞팔 비율: {rate}%'**
  String statsMutualRate(String rate);

  /// No description provided for @compareTitle.
  ///
  /// In ko, this message translates to:
  /// **'기록 비교'**
  String get compareTitle;

  /// No description provided for @compareRecentStats.
  ///
  /// In ko, this message translates to:
  /// **'최근 기록 통계'**
  String get compareRecentStats;

  /// No description provided for @compareAnalysisDay.
  ///
  /// In ko, this message translates to:
  /// **'{date} (분석일)'**
  String compareAnalysisDay(String date);

  /// No description provided for @compareAnalysisDayNote.
  ///
  /// In ko, this message translates to:
  /// **'(분석일)은 파일 이름에 내보낸 날짜가 없는 예전 기록이라 분석한 날로 표시했어요.'**
  String get compareAnalysisDayNote;

  /// No description provided for @compareLostTitle.
  ///
  /// In ko, this message translates to:
  /// **'나를 언팔한 사람'**
  String get compareLostTitle;

  /// No description provided for @compareLostEmpty.
  ///
  /// In ko, this message translates to:
  /// **'이 기간에 나를 언팔한 사람이 없어요.'**
  String get compareLostEmpty;

  /// No description provided for @compareNewEmpty.
  ///
  /// In ko, this message translates to:
  /// **'이 기간에 새로 생긴 팔로워가 없어요.'**
  String get compareNewEmpty;

  /// No description provided for @compareRenamedTitle.
  ///
  /// In ko, this message translates to:
  /// **'아이디를 바꾼 계정'**
  String get compareRenamedTitle;

  /// No description provided for @compareDisappearedNote.
  ///
  /// In ko, this message translates to:
  /// **'목록에서 사라진 계정 중에는 언팔 대신 계정을 비활성화·삭제한 경우도 있어요. 프로필을 눌러 확인해 보세요.'**
  String get compareDisappearedNote;

  /// No description provided for @compareNoChange.
  ///
  /// In ko, this message translates to:
  /// **'변화 없음'**
  String get compareNoChange;

  /// No description provided for @compareExportDateNote.
  ///
  /// In ko, this message translates to:
  /// **'날짜는 인스타그램에서 파일을 내보낸 날이에요.'**
  String get compareExportDateNote;

  /// No description provided for @compareChange.
  ///
  /// In ko, this message translates to:
  /// **'증감'**
  String get compareChange;

  /// No description provided for @compareLost.
  ///
  /// In ko, this message translates to:
  /// **'언팔'**
  String get compareLost;

  /// No description provided for @appSettingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'앱 설정'**
  String get appSettingsTitle;

  /// No description provided for @appSettingsAnalysisSection.
  ///
  /// In ko, this message translates to:
  /// **'분석 설정'**
  String get appSettingsAnalysisSection;

  /// No description provided for @appSettingsDataSection.
  ///
  /// In ko, this message translates to:
  /// **'데이터 관리'**
  String get appSettingsDataSection;

  /// No description provided for @appSettingsAnalysisNotify.
  ///
  /// In ko, this message translates to:
  /// **'분석 알림'**
  String get appSettingsAnalysisNotify;

  /// No description provided for @appSettingsAnalysisNotifyBody.
  ///
  /// In ko, this message translates to:
  /// **'분석이 완료되면 알림을 받습니다'**
  String get appSettingsAnalysisNotifyBody;

  /// No description provided for @appSettingsAutoRefresh.
  ///
  /// In ko, this message translates to:
  /// **'히스토리 자동 새로고침'**
  String get appSettingsAutoRefresh;

  /// No description provided for @appSettingsAutoRefreshBody.
  ///
  /// In ko, this message translates to:
  /// **'히스토리 데이터를 자동으로 업데이트합니다'**
  String get appSettingsAutoRefreshBody;

  /// No description provided for @appSettingsClearHistory.
  ///
  /// In ko, this message translates to:
  /// **'분석 히스토리 삭제'**
  String get appSettingsClearHistory;

  /// No description provided for @appSettingsClearHistoryBody.
  ///
  /// In ko, this message translates to:
  /// **'저장된 모든 분석 데이터를 삭제합니다'**
  String get appSettingsClearHistoryBody;

  /// No description provided for @appSettingsExportAll.
  ///
  /// In ko, this message translates to:
  /// **'모든 데이터 내보내기'**
  String get appSettingsExportAll;

  /// No description provided for @appSettingsExportAllBody.
  ///
  /// In ko, this message translates to:
  /// **'모든 분석 데이터를 텍스트로 내보냅니다'**
  String get appSettingsExportAllBody;

  /// No description provided for @appSettingsClearTitle.
  ///
  /// In ko, this message translates to:
  /// **'히스토리 삭제'**
  String get appSettingsClearTitle;

  /// No description provided for @appSettingsClearMessage.
  ///
  /// In ko, this message translates to:
  /// **'모든 분석 히스토리를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.'**
  String get appSettingsClearMessage;

  /// No description provided for @appSettingsCleared.
  ///
  /// In ko, this message translates to:
  /// **'분석 히스토리가 성공적으로 삭제되었습니다'**
  String get appSettingsCleared;

  /// No description provided for @appSettingsClearFailed.
  ///
  /// In ko, this message translates to:
  /// **'히스토리 삭제에 실패했습니다'**
  String get appSettingsClearFailed;

  /// No description provided for @appSettingsNothingToExport.
  ///
  /// In ko, this message translates to:
  /// **'내보낼 분석 데이터가 없습니다'**
  String get appSettingsNothingToExport;

  /// No description provided for @appSettingsExportTitle.
  ///
  /// In ko, this message translates to:
  /// **'TrackFollows 분석 데이터 내보내기'**
  String get appSettingsExportTitle;

  /// No description provided for @appSettingsExportCreated.
  ///
  /// In ko, this message translates to:
  /// **'생성일: {date}'**
  String appSettingsExportCreated(String date);

  /// No description provided for @appSettingsExportItem.
  ///
  /// In ko, this message translates to:
  /// **'분석 {index}'**
  String appSettingsExportItem(String index);

  /// No description provided for @appSettingsExportDate.
  ///
  /// In ko, this message translates to:
  /// **'날짜'**
  String get appSettingsExportDate;

  /// No description provided for @appSettingsExportFailed.
  ///
  /// In ko, this message translates to:
  /// **'데이터 내보내기에 실패했습니다'**
  String get appSettingsExportFailed;

  /// No description provided for @settingsTitle.
  ///
  /// In ko, this message translates to:
  /// **'설정'**
  String get settingsTitle;

  /// No description provided for @settingsNotificationsSection.
  ///
  /// In ko, this message translates to:
  /// **'알림'**
  String get settingsNotificationsSection;

  /// No description provided for @settingsRecheckTitle.
  ///
  /// In ko, this message translates to:
  /// **'다시 확인 알림'**
  String get settingsRecheckTitle;

  /// No description provided for @settingsRecheckBody.
  ///
  /// In ko, this message translates to:
  /// **'분석하고 2주 뒤에 새 파일로 확인하라고 알려 드려요'**
  String get settingsRecheckBody;

  /// No description provided for @settingsSupportSection.
  ///
  /// In ko, this message translates to:
  /// **'지원 및 법적 고지'**
  String get settingsSupportSection;

  /// No description provided for @settingsFaq.
  ///
  /// In ko, this message translates to:
  /// **'자주 묻는 질문'**
  String get settingsFaq;

  /// No description provided for @settingsTerms.
  ///
  /// In ko, this message translates to:
  /// **'이용약관'**
  String get settingsTerms;

  /// No description provided for @settingsPrivacy.
  ///
  /// In ko, this message translates to:
  /// **'개인정보 처리방침'**
  String get settingsPrivacy;

  /// No description provided for @settingsAdPrivacy.
  ///
  /// In ko, this message translates to:
  /// **'광고 개인정보 설정'**
  String get settingsAdPrivacy;

  /// No description provided for @settingsAppInfoSection.
  ///
  /// In ko, this message translates to:
  /// **'앱 정보'**
  String get settingsAppInfoSection;

  /// No description provided for @settingsAboutTitle.
  ///
  /// In ko, this message translates to:
  /// **'TrackFollows 소개'**
  String get settingsAboutTitle;

  /// No description provided for @settingsAboutBody.
  ///
  /// In ko, this message translates to:
  /// **'TrackFollows는 인스타그램 데이터를 기기에서 분석하는 도구입니다. 광고 서비스의 정보 처리에 관한 내용은 개인정보 처리방침에서 확인할 수 있습니다.'**
  String get settingsAboutBody;

  /// No description provided for @settingsVersion.
  ///
  /// In ko, this message translates to:
  /// **'버전 {version} ({build})'**
  String settingsVersion(String version, String build);

  /// No description provided for @settingsCopyright.
  ///
  /// In ko, this message translates to:
  /// **'© 2025-2026 TrackFollows. 모든 권리 보유.'**
  String get settingsCopyright;

  /// No description provided for @settingsLanguage.
  ///
  /// In ko, this message translates to:
  /// **'언어'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In ko, this message translates to:
  /// **'기기 언어 따르기'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsOpenLinkFailed.
  ///
  /// In ko, this message translates to:
  /// **'링크를 열지 못했어요.'**
  String get settingsOpenLinkFailed;

  /// No description provided for @adConsentNotReady.
  ///
  /// In ko, this message translates to:
  /// **'화면을 다시 연 뒤 시도해 주세요.'**
  String get adConsentNotReady;

  /// No description provided for @adConsentPreparing.
  ///
  /// In ko, this message translates to:
  /// **'광고 개인정보 설정을 준비하고 있어요. 잠시 후 다시 시도해 주세요.'**
  String get adConsentPreparing;

  /// No description provided for @adConsentNothingToChange.
  ///
  /// In ko, this message translates to:
  /// **'현재 변경할 광고 개인정보 설정이 없어요.'**
  String get adConsentNothingToChange;

  /// No description provided for @adConsentOpenFailed.
  ///
  /// In ko, this message translates to:
  /// **'개인정보 설정을 열지 못했어요. 잠시 후 다시 시도해 주세요.'**
  String get adConsentOpenFailed;

  /// No description provided for @adConsentStatusFailed.
  ///
  /// In ko, this message translates to:
  /// **'개인정보 설정 상태를 확인하지 못했어요. 잠시 후 다시 시도해 주세요.'**
  String get adConsentStatusFailed;

  /// No description provided for @reminderTitle.
  ///
  /// In ko, this message translates to:
  /// **'언팔 다시 확인할 때예요'**
  String get reminderTitle;

  /// No description provided for @reminderBody.
  ///
  /// In ko, this message translates to:
  /// **'지난 분석 후 2주가 지났어요. 새 파일로 분석하면 그사이 나를 언팔한 사람을 알 수 있어요.'**
  String get reminderBody;

  /// No description provided for @reminderChannelName.
  ///
  /// In ko, this message translates to:
  /// **'다시 확인 알림'**
  String get reminderChannelName;

  /// No description provided for @reminderChannelDescription.
  ///
  /// In ko, this message translates to:
  /// **'분석 후 2주 뒤에 새 파일로 다시 확인하라고 알려 드려요'**
  String get reminderChannelDescription;

  /// No description provided for @faqTitle.
  ///
  /// In ko, this message translates to:
  /// **'자주 묻는 질문'**
  String get faqTitle;

  /// No description provided for @faqIsSafeQuestion.
  ///
  /// In ko, this message translates to:
  /// **'이 서비스는 안전한가요?'**
  String get faqIsSafeQuestion;

  /// No description provided for @faqIsSafeAnswer.
  ///
  /// In ko, this message translates to:
  /// **'TrackFollows는 인스타그램 비밀번호를 요구하거나 계정에 로그인하지 않습니다. 선택한 파일은 기기에서 분석합니다. 이용·오류 진단과 광고 서비스의 데이터 처리 방식은 개인정보 처리방침에서 확인할 수 있습니다.'**
  String get faqIsSafeAnswer;

  /// No description provided for @faqDownloadTimeQuestion.
  ///
  /// In ko, this message translates to:
  /// **'데이터 다운로드에 얼마나 시간이 걸리나요?'**
  String get faqDownloadTimeQuestion;

  /// No description provided for @faqDownloadTimeAnswer.
  ///
  /// In ko, this message translates to:
  /// **'내보내기 파일은 인스타그램에서 준비합니다. 준비 시간은 일정하지 않으므로 알림이나 내보내기 화면을 확인하고, 준비가 끝나면 ZIP 파일을 내려받으세요.'**
  String get faqDownloadTimeAnswer;

  /// No description provided for @faqWhatIsUnfollowerQuestion.
  ///
  /// In ko, this message translates to:
  /// **'언팔로워란 정확히 무엇인가요?'**
  String get faqWhatIsUnfollowerQuestion;

  /// No description provided for @faqWhatIsUnfollowerAnswer.
  ///
  /// In ko, this message translates to:
  /// **'제공한 파일에서 내가 팔로우하는 목록에는 있지만 나를 팔로우하는 목록에는 없는 계정입니다. 처음부터 나를 팔로우하지 않은 계정도 포함될 수 있습니다. 한 번의 내보내기 파일만으로 과거에 나를 팔로우했는지, 언제 언팔했는지는 확인할 수 없습니다.'**
  String get faqWhatIsUnfollowerAnswer;

  /// No description provided for @faqThreadsQuestion.
  ///
  /// In ko, this message translates to:
  /// **'스레드(Threads) 언팔로워도 확인할 수 있나요?'**
  String get faqThreadsQuestion;

  /// No description provided for @faqThreadsAnswer.
  ///
  /// In ko, this message translates to:
  /// **'네. 인스타그램에서 받은 ZIP에 스레드 팔로워·팔로잉 목록이 들어 있으면 인스타그램과 별도로 스레드 결과를 보여 드립니다. 결과 화면 위쪽에서 인스타그램과 스레드를 전환해 볼 수 있습니다. 스레드 팔로워는 인스타그램 팔로워와 따로 집계되는 목록입니다.'**
  String get faqThreadsAnswer;

  /// No description provided for @faqIsFreeQuestion.
  ///
  /// In ko, this message translates to:
  /// **'이 서비스를 사용하는데 비용이 드나요?'**
  String get faqIsFreeQuestion;

  /// No description provided for @faqIsFreeAnswer.
  ///
  /// In ko, this message translates to:
  /// **'아니요, 이 서비스는 완전 무료입니다. 모든 기능을 무료로 이용하실 수 있습니다.'**
  String get faqIsFreeAnswer;

  /// No description provided for @faqIncorrectListQuestion.
  ///
  /// In ko, this message translates to:
  /// **'언팔로워 목록이 예상과 다르게 표시됩니다. 왜 그런가요?'**
  String get faqIncorrectListQuestion;

  /// No description provided for @faqIncorrectListAnswer.
  ///
  /// In ko, this message translates to:
  /// **'분석 결과는 내보내기 파일에 담긴 목록을 기준으로 하며 현재 인스타그램 화면과 다를 수 있습니다. 내보내기 시점, 선택한 기간, 계정의 삭제·비활성화 등이 목록과 집계에 영향을 줄 수 있습니다.\n\n내보내기 기간을 전체 기간으로 선택하고 팔로워·팔로잉 파일이 모두 포함되어 있는지 확인하세요. 새 파일을 받아도 현재 계정 상태와 일치한다고 보장할 수는 없습니다.'**
  String get faqIncorrectListAnswer;

  /// No description provided for @faqFileSelectErrorQuestion.
  ///
  /// In ko, this message translates to:
  /// **'ZIP 파일을 선택할 수 없어요'**
  String get faqFileSelectErrorQuestion;

  /// No description provided for @faqFileSelectErrorAnswer.
  ///
  /// In ko, this message translates to:
  /// **'카카오톡 등의 메시징 앱에서 링크를 열었을 때 파일 선택 기능이 정상적으로 작동하지 않을 수 있습니다. 이 경우 Chrome이나 Samsung Internet 등의 브라우저에서 직접 사이트에 접속하여 파일을 선택해보세요. 브라우저에서 직접 접속하면 일반적으로 파일을 정상적으로 선택할 수 있습니다'**
  String get faqFileSelectErrorAnswer;

  /// No description provided for @faqDataSecurityQuestion.
  ///
  /// In ko, this message translates to:
  /// **'데이터 보안 및 개인정보 보호'**
  String get faqDataSecurityQuestion;

  /// No description provided for @faqDataSecurityAnswer.
  ///
  /// In ko, this message translates to:
  /// **'분석을 위해 인스타그램 원본 파일, 계정명, 팔로워 목록을 서버로 전송하지 않습니다. 지난번 분석과 비교할 수 있도록 팔로워·팔로잉 아이디 목록을 이 기기(브라우저 또는 앱)에만 저장하며, 결과 화면의 \'기록 지우기\'로 언제든 지울 수 있습니다. 이용·오류 진단과 광고 서비스의 데이터 처리는 개인정보 처리방침을 확인해 주세요.'**
  String get faqDataSecurityAnswer;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'ar',
        'de',
        'en',
        'es',
        'fr',
        'hi',
        'id',
        'ja',
        'ko',
        'ms',
        'pt',
        'ru',
        'th',
        'tr',
        'vi'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'ms':
      return AppLocalizationsMs();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
