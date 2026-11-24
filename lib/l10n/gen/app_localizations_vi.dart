// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get commonCancel => 'Hủy';

  @override
  String get commonDelete => 'Xóa';

  @override
  String get commonRetry => 'Thử lại';

  @override
  String get commonUnfollowers => 'Không theo dõi lại';

  @override
  String get commonFans => 'Người hâm mộ';

  @override
  String get commonMutual => 'Theo dõi lẫn nhau';

  @override
  String get commonFollowers => 'Người theo dõi';

  @override
  String get commonTotalFollowers => 'Tổng người theo dõi';

  @override
  String get commonTotalFollowing => 'Tổng đang theo dõi';

  @override
  String get commonNewFollowers => 'Người theo dõi mới';

  @override
  String get commonNotificationPermissionOff =>
      'Quyền thông báo đang tắt. Hãy cho phép thông báo trong cài đặt thiết bị.';

  @override
  String get navAnalyze => 'Phân tích';

  @override
  String get navHistory => 'Lịch sử';

  @override
  String get navSettings => 'Cài đặt';

  @override
  String get mainFilePickFailed => 'Không thể chọn tệp';

  @override
  String get mainPreparingResults => 'Đang chuẩn bị kết quả phân tích';

  @override
  String get mainReminderPrompt =>
      'Bạn sẽ biết ai đã bỏ theo dõi mình ở lần phân tích tiếp theo. Nhắc bạn sau 2 tuần nhé?';

  @override
  String get mainReminderAction => 'Nhận nhắc nhở';

  @override
  String get mainReminderEnabled =>
      'Chúng tôi sẽ nhắc bạn sau 2 tuần. Bạn có thể tắt trong cài đặt.';

  @override
  String get mainExitTitle => 'Thoát ứng dụng';

  @override
  String get mainExitMessage => 'Bạn có muốn thoát ứng dụng không?';

  @override
  String get mainExitConfirm => 'Thoát';

  @override
  String get loadingTitle => 'Phân tích người theo dõi Instagram';

  @override
  String get loadingMessage => 'Đang tải...';

  @override
  String get errorTitle => 'Lỗi kết nối';

  @override
  String get onboardingWelcomeTitle => 'Chào mừng đến với TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'Phân tích dữ liệu người theo dõi Instagram để xem ai không theo dõi lại bạn, trạng thái theo dõi lẫn nhau và ngày theo dõi.';

  @override
  String get onboardingSafeTitle => 'An toàn 100% và bảo vệ quyền riêng tư';

  @override
  String get onboardingSafeBody =>
      'Mọi dữ liệu đều được xử lý ngay trên thiết bị của bạn. Chúng tôi không thu thập hay lưu trữ thông tin cá nhân.';

  @override
  String get onboardingEasyTitle => 'Dễ sử dụng';

  @override
  String get onboardingEasyBody =>
      'Chỉ cần tải lên tệp dữ liệu Instagram là bạn có thể xem ngay kết quả phân tích.';

  @override
  String get onboardingReadyTitle => 'Sẵn sàng bắt đầu';

  @override
  String get onboardingReadyBody =>
      'Hãy bắt đầu phân tích người theo dõi Instagram của bạn!';

  @override
  String get onboardingSkip => 'Bỏ qua';

  @override
  String get onboardingNext => 'Tiếp theo';

  @override
  String get onboardingStart => 'Bắt đầu';

  @override
  String get historyTitle => 'Lịch sử phân tích';

  @override
  String get historyLowOverlap =>
      'Người theo dõi của hai bản ghi gần như không trùng nhau. Hãy kiểm tra xem có phải cùng một tài khoản không.';

  @override
  String get historyDeleteTitle => 'Xóa bản ghi phân tích';

  @override
  String get historyDeleteMessage =>
      'Bạn có muốn xóa bản ghi phân tích này không?';

  @override
  String get historyDeleted => 'Đã xóa bản ghi phân tích';

  @override
  String get historyDeleteFailed => 'Không thể xóa';

  @override
  String get historyShareSubject => 'Kết quả phân tích Instagram';

  @override
  String get historyShareFooter => 'Được tạo bởi ứng dụng TrackFollows';

  @override
  String get historyCompare => 'So sánh hai bản ghi';

  @override
  String get historyCompareSelected => 'So sánh hai bản ghi đã chọn';

  @override
  String historyCompareHint(String count) {
    return 'Chọn hai bản ghi để so sánh ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'Chưa có lịch sử phân tích';

  @override
  String get historyEmptyBody => 'Kết quả phân tích sẽ hiển thị ở đây';

  @override
  String historyExportedOn(String date) {
    return 'Xuất ngày $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'Người theo dõi $followers · Đang theo dõi $following · Không theo dõi lại $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'Phân tích: $date';
  }

  @override
  String get historyViewStats => 'Xem thống kê';

  @override
  String get historyShare => 'Chia sẻ';

  @override
  String get historyFirstRecord =>
      'Bản ghi đầu tiên · Từ lần phân tích sau sẽ so sánh thay đổi';

  @override
  String get historyNoChange =>
      'Không có thay đổi người theo dõi so với bản ghi trước';

  @override
  String get historyVsPrevious => 'So với bản ghi trước';

  @override
  String historyLostCount(String count) {
    return 'Bỏ theo dõi $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'Người theo dõi mới $count';
  }

  @override
  String get statsTitle => 'Kết quả phân tích';

  @override
  String get statsNotFoundTitle => 'Không tìm thấy dữ liệu phân tích';

  @override
  String get statsNotFoundBody => 'Dữ liệu đã bị xóa hoặc không tồn tại';

  @override
  String get statsBack => 'Quay lại';

  @override
  String get statsSummary => 'Tóm tắt phân tích';

  @override
  String get statsNoData => 'Không có dữ liệu phân tích';

  @override
  String get statsDistribution => 'Phân bố người theo dõi';

  @override
  String get statsDetailedStats => 'Thống kê chi tiết';

  @override
  String get statsDetails => 'Chi tiết';

  @override
  String get statsAnalysisDate => 'Ngày phân tích';

  @override
  String statsMutualRate(String rate) {
    return 'Tỷ lệ theo dõi lẫn nhau: $rate%';
  }

  @override
  String get compareTitle => 'So sánh bản ghi';

  @override
  String get compareRecentStats => 'Thống kê bản ghi gần nhất';

  @override
  String compareAnalysisDay(String date) {
    return '$date (ngày phân tích)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(ngày phân tích) là bản ghi cũ có tên tệp không ghi ngày xuất, nên chúng tôi hiển thị ngày bạn phân tích.';

  @override
  String get compareLostTitle => 'Người đã bỏ theo dõi bạn';

  @override
  String get compareLostEmpty =>
      'Không có ai bỏ theo dõi bạn trong khoảng thời gian này.';

  @override
  String get compareNewEmpty =>
      'Không có người theo dõi mới trong khoảng thời gian này.';

  @override
  String get compareRenamedTitle => 'Tài khoản đã đổi tên người dùng';

  @override
  String get compareDisappearedNote =>
      'Một số tài khoản biến mất khỏi danh sách có thể đã vô hiệu hóa hoặc xóa tài khoản thay vì bỏ theo dõi. Hãy nhấn vào hồ sơ để kiểm tra.';

  @override
  String get compareNoChange => 'Không thay đổi';

  @override
  String get compareExportDateNote =>
      'Ngày là ngày tệp được xuất từ Instagram.';

  @override
  String get compareChange => 'Thay đổi';

  @override
  String get compareLost => 'Bỏ theo dõi';

  @override
  String get appSettingsTitle => 'Cài đặt ứng dụng';

  @override
  String get appSettingsAnalysisSection => 'Cài đặt phân tích';

  @override
  String get appSettingsDataSection => 'Quản lý dữ liệu';

  @override
  String get appSettingsAnalysisNotify => 'Thông báo phân tích';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'Nhận thông báo khi phân tích hoàn tất';

  @override
  String get appSettingsAutoRefresh => 'Tự động làm mới lịch sử';

  @override
  String get appSettingsAutoRefreshBody => 'Tự động cập nhật dữ liệu lịch sử';

  @override
  String get appSettingsClearHistory => 'Xóa lịch sử phân tích';

  @override
  String get appSettingsClearHistoryBody =>
      'Xóa tất cả dữ liệu phân tích đã lưu';

  @override
  String get appSettingsExportAll => 'Xuất tất cả dữ liệu';

  @override
  String get appSettingsExportAllBody =>
      'Xuất toàn bộ dữ liệu phân tích dưới dạng văn bản';

  @override
  String get appSettingsClearTitle => 'Xóa lịch sử';

  @override
  String get appSettingsClearMessage =>
      'Bạn có muốn xóa toàn bộ lịch sử phân tích không? Không thể hoàn tác thao tác này.';

  @override
  String get appSettingsCleared => 'Đã xóa lịch sử phân tích thành công';

  @override
  String get appSettingsClearFailed => 'Không thể xóa lịch sử';

  @override
  String get appSettingsNothingToExport => 'Không có dữ liệu phân tích để xuất';

  @override
  String get appSettingsExportTitle => 'Xuất dữ liệu phân tích TrackFollows';

  @override
  String appSettingsExportCreated(String date) {
    return 'Ngày tạo: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'Phân tích $index';
  }

  @override
  String get appSettingsExportDate => 'Ngày';

  @override
  String get appSettingsExportFailed => 'Không thể xuất dữ liệu';

  @override
  String get settingsTitle => 'Cài đặt';

  @override
  String get settingsNotificationsSection => 'Thông báo';

  @override
  String get settingsRecheckTitle => 'Nhắc kiểm tra lại';

  @override
  String get settingsRecheckBody =>
      'Nhắc bạn kiểm tra bằng tệp mới sau 2 tuần kể từ lần phân tích';

  @override
  String get settingsSupportSection => 'Hỗ trợ và pháp lý';

  @override
  String get settingsFaq => 'Câu hỏi thường gặp';

  @override
  String get settingsTerms => 'Điều khoản dịch vụ';

  @override
  String get settingsPrivacy => 'Chính sách quyền riêng tư';

  @override
  String get settingsAdPrivacy => 'Cài đặt quyền riêng tư quảng cáo';

  @override
  String get settingsAppInfoSection => 'Thông tin ứng dụng';

  @override
  String get settingsAboutTitle => 'Giới thiệu TrackFollows';

  @override
  String get settingsAboutBody =>
      'TrackFollows là công cụ phân tích dữ liệu Instagram ngay trên thiết bị của bạn. Bạn có thể xem cách các dịch vụ quảng cáo xử lý thông tin trong Chính sách quyền riêng tư.';

  @override
  String settingsVersion(String version, String build) {
    return 'Phiên bản $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. Bảo lưu mọi quyền.';

  @override
  String get settingsLanguage => 'Ngôn ngữ';

  @override
  String get settingsLanguageSystem => 'Theo ngôn ngữ thiết bị';

  @override
  String get settingsOpenLinkFailed => 'Không thể mở liên kết.';

  @override
  String get adConsentNotReady => 'Hãy mở lại màn hình rồi thử lại.';

  @override
  String get adConsentPreparing =>
      'Đang chuẩn bị cài đặt quyền riêng tư quảng cáo. Hãy thử lại sau ít phút.';

  @override
  String get adConsentNothingToChange =>
      'Hiện không có cài đặt quyền riêng tư quảng cáo nào để thay đổi.';

  @override
  String get adConsentOpenFailed =>
      'Không thể mở cài đặt quyền riêng tư. Hãy thử lại sau ít phút.';

  @override
  String get adConsentStatusFailed =>
      'Không thể kiểm tra trạng thái cài đặt quyền riêng tư. Hãy thử lại sau ít phút.';

  @override
  String get reminderTitle => 'Đến lúc kiểm tra lại người bỏ theo dõi';

  @override
  String get reminderBody =>
      'Đã 2 tuần kể từ lần phân tích trước. Phân tích bằng tệp mới để biết ai đã bỏ theo dõi bạn trong thời gian đó.';

  @override
  String get reminderChannelName => 'Nhắc kiểm tra lại';

  @override
  String get reminderChannelDescription =>
      'Nhắc bạn kiểm tra lại bằng tệp mới sau 2 tuần kể từ lần phân tích';

  @override
  String get faqTitle => 'Câu Hỏi Thường Gặp';

  @override
  String get faqIsSafeQuestion => 'Dịch vụ này có an toàn không?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows không yêu cầu mật khẩu Instagram hay đăng nhập vào tài khoản của bạn. Tệp đã chọn được phân tích trên thiết bị. Cách xử lý dữ liệu chẩn đoán sử dụng và của dịch vụ quảng cáo được trình bày riêng trong Chính sách quyền riêng tư.';

  @override
  String get faqDownloadTimeQuestion =>
      'Mất bao lâu để tải xuống dữ liệu của tôi?';

  @override
  String get faqDownloadTimeAnswer =>
      'Instagram chuẩn bị bản xuất. Thời gian chuẩn bị có thể khác nhau; hãy xem thông báo hoặc màn hình xuất và tải ZIP khi đã sẵn sàng.';

  @override
  String get faqWhatIsUnfollowerQuestion => 'Người không theo dõi là gì?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'Đó là các tài khoản có trong danh sách bạn đang theo dõi nhưng không có trong danh sách người theo dõi bạn ở các tệp được cung cấp. Có thể bao gồm tài khoản chưa từng theo dõi bạn. Một bản xuất không xác định được ai từng theo dõi bạn hoặc đã bỏ theo dõi vào lúc nào.';

  @override
  String get faqThreadsQuestion =>
      'Tôi có thể xem ai bỏ theo dõi mình trên Threads không?';

  @override
  String get faqThreadsAnswer =>
      'Có. Nếu tệp ZIP tải từ Instagram có danh sách người theo dõi và đang theo dõi trên Threads, bạn sẽ thấy kết quả Threads riêng bên cạnh kết quả Instagram. Chuyển đổi giữa Instagram và Threads ở đầu trang kết quả. Người theo dõi Threads là một danh sách riêng, khác với người theo dõi Instagram.';

  @override
  String get faqIsFreeQuestion =>
      'Có phải trả phí để sử dụng dịch vụ này không?';

  @override
  String get faqIsFreeAnswer =>
      'Không, dịch vụ này hoàn toàn miễn phí. Bạn có thể sử dụng tất cả các tính năng mà không phải trả bất kỳ khoản phí nào';

  @override
  String get faqIncorrectListQuestion =>
      'Danh sách người bỏ theo dõi hiển thị khác với những gì tôi mong đợi. Tại sao?';

  @override
  String get faqIncorrectListAnswer =>
      'Kết quả phản ánh danh sách trong tệp xuất và có thể khác với Instagram hiện tại. Thời điểm xuất, khoảng thời gian đã chọn và tài khoản bị xóa hoặc vô hiệu hóa có thể ảnh hưởng đến danh sách và số lượng.\n\nChọn Toàn bộ thời gian khi xuất và kiểm tra xem đã có đủ các tệp người theo dõi và đang theo dõi chưa. Ngay cả bản xuất mới cũng không đảm bảo khớp với trạng thái hiện tại của tài khoản.';

  @override
  String get faqFileSelectErrorQuestion => 'Tôi không thể chọn tệp ZIP';

  @override
  String get faqFileSelectErrorAnswer =>
      'Khi mở liên kết từ các ứng dụng nhắn tin như KakaoTalk, chức năng chọn tệp có thể không hoạt động đúng. Trong trường hợp này, hãy thử truy cập trực tiếp vào trang web thông qua các trình duyệt như Chrome hoặc Samsung Internet để chọn tệp. Thông thường, bạn có thể chọn tệp bình thường khi truy cập trực tiếp thông qua trình duyệt.';

  @override
  String get faqDataSecurityQuestion => 'Bảo mật dữ liệu và quyền riêng tư';

  @override
  String get faqDataSecurityAnswer =>
      'Tệp Instagram gốc, tên tài khoản và danh sách người theo dõi của bạn không được gửi lên máy chủ để phân tích. Để so sánh với lần phân tích trước, tên người dùng của người theo dõi và đang theo dõi chỉ được lưu trên thiết bị này (trình duyệt hoặc ứng dụng), và bạn có thể xóa bất cứ lúc nào bằng \'Xóa lịch sử\' trên màn hình kết quả. Xem Chính sách quyền riêng tư về cách xử lý dữ liệu chẩn đoán và dịch vụ quảng cáo.';
}
