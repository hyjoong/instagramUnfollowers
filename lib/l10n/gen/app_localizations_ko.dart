// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get commonCancel => '취소';

  @override
  String get commonDelete => '삭제';

  @override
  String get commonRetry => '다시 시도';

  @override
  String get commonUnfollowers => '언팔로워';

  @override
  String get commonFans => '팬';

  @override
  String get commonMutual => '맞팔';

  @override
  String get commonFollowers => '팔로워';

  @override
  String get commonTotalFollowers => '총 팔로워';

  @override
  String get commonTotalFollowing => '총 팔로잉';

  @override
  String get commonNewFollowers => '새 팔로워';

  @override
  String get commonNotificationPermissionOff =>
      '알림 권한이 꺼져 있어요. 기기 설정에서 알림을 허용해 주세요.';

  @override
  String get navAnalyze => '분석';

  @override
  String get navHistory => '히스토리';

  @override
  String get navSettings => '설정';

  @override
  String get mainFilePickFailed => '파일 선택에 실패했습니다';

  @override
  String get mainPreparingResults => '분석 결과를 준비하고 있어요';

  @override
  String get mainReminderPrompt =>
      '누가 나를 언팔했는지는 다음 분석 때 알 수 있어요. 2주 뒤에 알려 드릴까요?';

  @override
  String get mainReminderAction => '알림 받기';

  @override
  String get mainReminderEnabled => '2주 뒤에 알려 드릴게요. 설정에서 끌 수 있어요.';

  @override
  String get mainExitTitle => '앱 종료';

  @override
  String get mainExitMessage => '앱을 종료하시겠습니까?';

  @override
  String get mainExitConfirm => '종료';

  @override
  String get loadingTitle => '인스타그램 언팔로워 분석';

  @override
  String get loadingMessage => '로딩 중...';

  @override
  String get errorTitle => '연결 오류';

  @override
  String get onboardingWelcomeTitle => 'TrackFollows에 오신 것을 환영합니다';

  @override
  String get onboardingWelcomeBody =>
      '인스타그램 팔로워 데이터를 분석하여 언팔로워, 맞팔 상태, 팔로우 날짜를 확인해보세요.';

  @override
  String get onboardingSafeTitle => '100% 안전하고 개인정보 보호';

  @override
  String get onboardingSafeBody =>
      '모든 데이터 처리는 기기에서 이루어집니다. 개인정보를 수집하거나 저장하지 않습니다.';

  @override
  String get onboardingEasyTitle => '사용하기 쉬움';

  @override
  String get onboardingEasyBody =>
      '인스타그램 데이터 파일을 업로드하기만 하면 즉시 분석 결과를 확인할 수 있습니다.';

  @override
  String get onboardingReadyTitle => '시작할 준비가 되었습니다';

  @override
  String get onboardingReadyBody => '인스타그램 팔로워 분석을 시작해보세요!';

  @override
  String get onboardingSkip => '건너뛰기';

  @override
  String get onboardingNext => '다음';

  @override
  String get onboardingStart => '시작하기';

  @override
  String get historyTitle => '분석 히스토리';

  @override
  String get historyLowOverlap => '두 기록의 팔로워가 거의 겹치지 않아요. 같은 계정의 기록인지 확인해 주세요.';

  @override
  String get historyDeleteTitle => '분석 기록 삭제';

  @override
  String get historyDeleteMessage => '이 분석 기록을 삭제하시겠습니까?';

  @override
  String get historyDeleted => '분석 기록이 삭제되었습니다';

  @override
  String get historyDeleteFailed => '삭제에 실패했습니다';

  @override
  String get historyShareSubject => '인스타그램 분석 결과';

  @override
  String get historyShareFooter => 'TrackFollows 앱으로 생성됨';

  @override
  String get historyCompare => '두 기록 비교';

  @override
  String get historyCompareSelected => '고른 두 기록 비교하기';

  @override
  String historyCompareHint(String count) {
    return '비교할 기록 두 개를 골라 주세요 ($count/2)';
  }

  @override
  String get historyEmptyTitle => '분석 히스토리가 없습니다';

  @override
  String get historyEmptyBody => '분석 결과가 여기에 표시됩니다';

  @override
  String historyExportedOn(String date) {
    return '$date 내보내기';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return '팔로워 $followers · 팔로잉 $following · 언팔로워 $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return '분석: $date';
  }

  @override
  String get historyViewStats => '통계 보기';

  @override
  String get historyShare => '공유';

  @override
  String get historyFirstRecord => '첫 기록 · 다음 분석부터 변화를 비교해요';

  @override
  String get historyNoChange => '직전 기록과 팔로워 변화 없음';

  @override
  String get historyVsPrevious => '직전 기록 대비';

  @override
  String historyLostCount(String count) {
    return '언팔 $count';
  }

  @override
  String historyGainedCount(String count) {
    return '새 팔로워 $count';
  }

  @override
  String get statsTitle => '분석 결과';

  @override
  String get statsNotFoundTitle => '분석 데이터를 찾을 수 없습니다';

  @override
  String get statsNotFoundBody => '삭제되었거나 존재하지 않는 데이터입니다';

  @override
  String get statsBack => '돌아가기';

  @override
  String get statsSummary => '분석 요약';

  @override
  String get statsNoData => '분석 데이터가 없습니다';

  @override
  String get statsDistribution => '팔로워 분포';

  @override
  String get statsDetailedStats => '상세 통계';

  @override
  String get statsDetails => '상세 정보';

  @override
  String get statsAnalysisDate => '분석 날짜';

  @override
  String statsMutualRate(String rate) {
    return '맞팔 비율: $rate%';
  }

  @override
  String get compareTitle => '기록 비교';

  @override
  String get compareRecentStats => '최근 기록 통계';

  @override
  String compareAnalysisDay(String date) {
    return '$date (분석일)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(분석일)은 파일 이름에 내보낸 날짜가 없는 예전 기록이라 분석한 날로 표시했어요.';

  @override
  String get compareLostTitle => '나를 언팔한 사람';

  @override
  String get compareLostEmpty => '이 기간에 나를 언팔한 사람이 없어요.';

  @override
  String get compareNewEmpty => '이 기간에 새로 생긴 팔로워가 없어요.';

  @override
  String get compareRenamedTitle => '아이디를 바꾼 계정';

  @override
  String get compareDisappearedNote =>
      '목록에서 사라진 계정 중에는 언팔 대신 계정을 비활성화·삭제한 경우도 있어요. 프로필을 눌러 확인해 보세요.';

  @override
  String get compareNoChange => '변화 없음';

  @override
  String get compareExportDateNote => '날짜는 인스타그램에서 파일을 내보낸 날이에요.';

  @override
  String get compareChange => '증감';

  @override
  String get compareLost => '언팔';

  @override
  String get appSettingsTitle => '앱 설정';

  @override
  String get appSettingsAnalysisSection => '분석 설정';

  @override
  String get appSettingsDataSection => '데이터 관리';

  @override
  String get appSettingsAnalysisNotify => '분석 알림';

  @override
  String get appSettingsAnalysisNotifyBody => '분석이 완료되면 알림을 받습니다';

  @override
  String get appSettingsAutoRefresh => '히스토리 자동 새로고침';

  @override
  String get appSettingsAutoRefreshBody => '히스토리 데이터를 자동으로 업데이트합니다';

  @override
  String get appSettingsClearHistory => '분석 히스토리 삭제';

  @override
  String get appSettingsClearHistoryBody => '저장된 모든 분석 데이터를 삭제합니다';

  @override
  String get appSettingsExportAll => '모든 데이터 내보내기';

  @override
  String get appSettingsExportAllBody => '모든 분석 데이터를 텍스트로 내보냅니다';

  @override
  String get appSettingsClearTitle => '히스토리 삭제';

  @override
  String get appSettingsClearMessage =>
      '모든 분석 히스토리를 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get appSettingsCleared => '분석 히스토리가 성공적으로 삭제되었습니다';

  @override
  String get appSettingsClearFailed => '히스토리 삭제에 실패했습니다';

  @override
  String get appSettingsNothingToExport => '내보낼 분석 데이터가 없습니다';

  @override
  String get appSettingsExportTitle => 'TrackFollows 분석 데이터 내보내기';

  @override
  String appSettingsExportCreated(String date) {
    return '생성일: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return '분석 $index';
  }

  @override
  String get appSettingsExportDate => '날짜';

  @override
  String get appSettingsExportFailed => '데이터 내보내기에 실패했습니다';

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsNotificationsSection => '알림';

  @override
  String get settingsRecheckTitle => '다시 확인 알림';

  @override
  String get settingsRecheckBody => '분석하고 2주 뒤에 새 파일로 확인하라고 알려 드려요';

  @override
  String get settingsSupportSection => '지원 및 법적 고지';

  @override
  String get settingsFaq => '자주 묻는 질문';

  @override
  String get settingsTerms => '이용약관';

  @override
  String get settingsPrivacy => '개인정보 처리방침';

  @override
  String get settingsAdPrivacy => '광고 개인정보 설정';

  @override
  String get settingsAppInfoSection => '앱 정보';

  @override
  String get settingsAboutTitle => 'TrackFollows 소개';

  @override
  String get settingsAboutBody =>
      'TrackFollows는 인스타그램 데이터를 기기에서 분석하는 도구입니다. 광고 서비스의 정보 처리에 관한 내용은 개인정보 처리방침에서 확인할 수 있습니다.';

  @override
  String settingsVersion(String version, String build) {
    return '버전 $version ($build)';
  }

  @override
  String get settingsCopyright => '© 2025-2026 TrackFollows. 모든 권리 보유.';

  @override
  String get settingsLanguage => '언어';

  @override
  String get settingsLanguageSystem => '기기 언어 따르기';

  @override
  String get settingsOpenLinkFailed => '링크를 열지 못했어요.';

  @override
  String get adConsentNotReady => '화면을 다시 연 뒤 시도해 주세요.';

  @override
  String get adConsentPreparing => '광고 개인정보 설정을 준비하고 있어요. 잠시 후 다시 시도해 주세요.';

  @override
  String get adConsentNothingToChange => '현재 변경할 광고 개인정보 설정이 없어요.';

  @override
  String get adConsentOpenFailed => '개인정보 설정을 열지 못했어요. 잠시 후 다시 시도해 주세요.';

  @override
  String get adConsentStatusFailed => '개인정보 설정 상태를 확인하지 못했어요. 잠시 후 다시 시도해 주세요.';

  @override
  String get reminderTitle => '언팔 다시 확인할 때예요';

  @override
  String get reminderBody =>
      '지난 분석 후 2주가 지났어요. 새 파일로 분석하면 그사이 나를 언팔한 사람을 알 수 있어요.';

  @override
  String get reminderChannelName => '다시 확인 알림';

  @override
  String get reminderChannelDescription => '분석 후 2주 뒤에 새 파일로 다시 확인하라고 알려 드려요';

  @override
  String get faqTitle => '자주 묻는 질문';

  @override
  String get faqIsSafeQuestion => '이 서비스는 안전한가요?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows는 인스타그램 비밀번호를 요구하거나 계정에 로그인하지 않습니다. 선택한 파일은 기기에서 분석합니다. 이용·오류 진단과 광고 서비스의 데이터 처리 방식은 개인정보 처리방침에서 확인할 수 있습니다.';

  @override
  String get faqDownloadTimeQuestion => '데이터 다운로드에 얼마나 시간이 걸리나요?';

  @override
  String get faqDownloadTimeAnswer =>
      '내보내기 파일은 인스타그램에서 준비합니다. 준비 시간은 일정하지 않으므로 알림이나 내보내기 화면을 확인하고, 준비가 끝나면 ZIP 파일을 내려받으세요.';

  @override
  String get faqWhatIsUnfollowerQuestion => '언팔로워란 정확히 무엇인가요?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      '제공한 파일에서 내가 팔로우하는 목록에는 있지만 나를 팔로우하는 목록에는 없는 계정입니다. 처음부터 나를 팔로우하지 않은 계정도 포함될 수 있습니다. 한 번의 내보내기 파일만으로 과거에 나를 팔로우했는지, 언제 언팔했는지는 확인할 수 없습니다.';

  @override
  String get faqThreadsQuestion => '스레드(Threads) 언팔로워도 확인할 수 있나요?';

  @override
  String get faqThreadsAnswer =>
      '네. 인스타그램에서 받은 ZIP에 스레드 팔로워·팔로잉 목록이 들어 있으면 인스타그램과 별도로 스레드 결과를 보여 드립니다. 결과 화면 위쪽에서 인스타그램과 스레드를 전환해 볼 수 있습니다. 스레드 팔로워는 인스타그램 팔로워와 따로 집계되는 목록입니다.';

  @override
  String get faqIsFreeQuestion => '이 서비스를 사용하는데 비용이 드나요?';

  @override
  String get faqIsFreeAnswer => '아니요, 이 서비스는 완전 무료입니다. 모든 기능을 무료로 이용하실 수 있습니다.';

  @override
  String get faqIncorrectListQuestion => '언팔로워 목록이 예상과 다르게 표시됩니다. 왜 그런가요?';

  @override
  String get faqIncorrectListAnswer =>
      '분석 결과는 내보내기 파일에 담긴 목록을 기준으로 하며 현재 인스타그램 화면과 다를 수 있습니다. 내보내기 시점, 선택한 기간, 계정의 삭제·비활성화 등이 목록과 집계에 영향을 줄 수 있습니다.\n\n내보내기 기간을 전체 기간으로 선택하고 팔로워·팔로잉 파일이 모두 포함되어 있는지 확인하세요. 새 파일을 받아도 현재 계정 상태와 일치한다고 보장할 수는 없습니다.';

  @override
  String get faqFileSelectErrorQuestion => 'ZIP 파일을 선택할 수 없어요';

  @override
  String get faqFileSelectErrorAnswer =>
      '카카오톡 등의 메시징 앱에서 링크를 열었을 때 파일 선택 기능이 정상적으로 작동하지 않을 수 있습니다. 이 경우 Chrome이나 Samsung Internet 등의 브라우저에서 직접 사이트에 접속하여 파일을 선택해보세요. 브라우저에서 직접 접속하면 일반적으로 파일을 정상적으로 선택할 수 있습니다';

  @override
  String get faqDataSecurityQuestion => '데이터 보안 및 개인정보 보호';

  @override
  String get faqDataSecurityAnswer =>
      '분석을 위해 인스타그램 원본 파일, 계정명, 팔로워 목록을 서버로 전송하지 않습니다. 지난번 분석과 비교할 수 있도록 팔로워·팔로잉 아이디 목록을 이 기기(브라우저 또는 앱)에만 저장하며, 결과 화면의 \'기록 지우기\'로 언제든 지울 수 있습니다. 이용·오류 진단과 광고 서비스의 데이터 처리는 개인정보 처리방침을 확인해 주세요.';
}
