// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get commonCancel => 'ยกเลิก';

  @override
  String get commonDelete => 'ลบ';

  @override
  String get commonRetry => 'ลองอีกครั้ง';

  @override
  String get commonUnfollowers => 'ผู้ที่เลิกติดตาม';

  @override
  String get commonFans => 'แฟน';

  @override
  String get commonMutual => 'ติดตามกัน';

  @override
  String get commonFollowers => 'ผู้ติดตาม';

  @override
  String get commonTotalFollowers => 'ผู้ติดตามทั้งหมด';

  @override
  String get commonTotalFollowing => 'กำลังติดตามทั้งหมด';

  @override
  String get commonNewFollowers => 'ผู้ติดตามใหม่';

  @override
  String get commonNotificationPermissionOff =>
      'การแจ้งเตือนถูกปิดอยู่ โปรดอนุญาตการแจ้งเตือนในการตั้งค่าอุปกรณ์';

  @override
  String get navAnalyze => 'วิเคราะห์';

  @override
  String get navHistory => 'ประวัติ';

  @override
  String get navSettings => 'ตั้งค่า';

  @override
  String get mainFilePickFailed => 'เลือกไฟล์ไม่สำเร็จ';

  @override
  String get mainPreparingResults => 'กำลังเตรียมผลการวิเคราะห์';

  @override
  String get mainReminderPrompt =>
      'จะรู้ว่าใครเลิกติดตามคุณในการวิเคราะห์ครั้งถัดไป ให้แจ้งเตือนในอีก 2 สัปดาห์ไหม?';

  @override
  String get mainReminderAction => 'รับการแจ้งเตือน';

  @override
  String get mainReminderEnabled =>
      'จะแจ้งเตือนในอีก 2 สัปดาห์ ปิดได้ในการตั้งค่า';

  @override
  String get mainExitTitle => 'ออกจากแอป';

  @override
  String get mainExitMessage => 'ต้องการออกจากแอปหรือไม่?';

  @override
  String get mainExitConfirm => 'ออก';

  @override
  String get loadingTitle => 'วิเคราะห์ผู้ที่เลิกติดตามบน Instagram';

  @override
  String get loadingMessage => 'กำลังโหลด...';

  @override
  String get errorTitle => 'เชื่อมต่อผิดพลาด';

  @override
  String get onboardingWelcomeTitle => 'ยินดีต้อนรับสู่ TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'วิเคราะห์ข้อมูลผู้ติดตามบน Instagram เพื่อดูผู้ที่เลิกติดตาม สถานะการติดตามกัน และวันที่เริ่มติดตาม';

  @override
  String get onboardingSafeTitle => 'ปลอดภัย 100% และเป็นส่วนตัว';

  @override
  String get onboardingSafeBody =>
      'การประมวลผลข้อมูลทั้งหมดเกิดขึ้นบนอุปกรณ์ของคุณ เราไม่เก็บหรือบันทึกข้อมูลส่วนตัวใดๆ';

  @override
  String get onboardingEasyTitle => 'ใช้งานง่าย';

  @override
  String get onboardingEasyBody =>
      'เพียงอัปโหลดไฟล์ข้อมูล Instagram ก็ดูผลการวิเคราะห์ได้ทันที';

  @override
  String get onboardingReadyTitle => 'พร้อมเริ่มแล้ว';

  @override
  String get onboardingReadyBody =>
      'เริ่มวิเคราะห์ผู้ติดตามบน Instagram กันเลย!';

  @override
  String get onboardingSkip => 'ข้าม';

  @override
  String get onboardingNext => 'ถัดไป';

  @override
  String get onboardingStart => 'เริ่มเลย';

  @override
  String get historyTitle => 'ประวัติการวิเคราะห์';

  @override
  String get historyLowOverlap =>
      'ผู้ติดตามของทั้งสองรายการแทบไม่ซ้ำกัน โปรดตรวจสอบว่าเป็นบัญชีเดียวกันหรือไม่';

  @override
  String get historyDeleteTitle => 'ลบประวัติการวิเคราะห์';

  @override
  String get historyDeleteMessage => 'ต้องการลบประวัติการวิเคราะห์นี้หรือไม่?';

  @override
  String get historyDeleted => 'ลบประวัติการวิเคราะห์แล้ว';

  @override
  String get historyDeleteFailed => 'ลบไม่สำเร็จ';

  @override
  String get historyShareSubject => 'ผลการวิเคราะห์ Instagram';

  @override
  String get historyShareFooter => 'สร้างด้วยแอป TrackFollows';

  @override
  String get historyCompare => 'เปรียบเทียบสองรายการ';

  @override
  String get historyCompareSelected => 'เปรียบเทียบสองรายการที่เลือก';

  @override
  String historyCompareHint(String count) {
    return 'เลือกรายการที่จะเปรียบเทียบสองรายการ ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'ยังไม่มีประวัติการวิเคราะห์';

  @override
  String get historyEmptyBody => 'ผลการวิเคราะห์จะแสดงที่นี่';

  @override
  String historyExportedOn(String date) {
    return 'ส่งออกเมื่อ $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'ผู้ติดตาม $followers · กำลังติดตาม $following · ผู้ที่เลิกติดตาม $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'วิเคราะห์เมื่อ $date';
  }

  @override
  String get historyViewStats => 'ดูสถิติ';

  @override
  String get historyShare => 'แชร์';

  @override
  String get historyFirstRecord =>
      'รายการแรก · จะเปรียบเทียบการเปลี่ยนแปลงตั้งแต่การวิเคราะห์ครั้งถัดไป';

  @override
  String get historyNoChange => 'ผู้ติดตามไม่เปลี่ยนแปลงจากรายการก่อนหน้า';

  @override
  String get historyVsPrevious => 'เทียบกับรายการก่อนหน้า';

  @override
  String historyLostCount(String count) {
    return 'เลิกติดตาม $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'ผู้ติดตามใหม่ $count';
  }

  @override
  String get statsTitle => 'ผลการวิเคราะห์';

  @override
  String get statsNotFoundTitle => 'ไม่พบข้อมูลการวิเคราะห์';

  @override
  String get statsNotFoundBody => 'ข้อมูลถูกลบไปแล้วหรือไม่มีอยู่';

  @override
  String get statsBack => 'กลับ';

  @override
  String get statsSummary => 'สรุปการวิเคราะห์';

  @override
  String get statsNoData => 'ไม่มีข้อมูลการวิเคราะห์';

  @override
  String get statsDistribution => 'การกระจายของผู้ติดตาม';

  @override
  String get statsDetailedStats => 'สถิติโดยละเอียด';

  @override
  String get statsDetails => 'รายละเอียด';

  @override
  String get statsAnalysisDate => 'วันที่วิเคราะห์';

  @override
  String statsMutualRate(String rate) {
    return 'สัดส่วนการติดตามกัน: $rate%';
  }

  @override
  String get compareTitle => 'เปรียบเทียบรายการ';

  @override
  String get compareRecentStats => 'สถิติล่าสุด';

  @override
  String compareAnalysisDay(String date) {
    return '$date (วันวิเคราะห์)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(วันวิเคราะห์) คือรายการเก่าที่ชื่อไฟล์ไม่มีวันที่ส่งออก จึงแสดงเป็นวันที่วิเคราะห์';

  @override
  String get compareLostTitle => 'คนที่เลิกติดตามคุณ';

  @override
  String get compareLostEmpty => 'ไม่มีใครเลิกติดตามคุณในช่วงนี้';

  @override
  String get compareNewEmpty => 'ไม่มีผู้ติดตามใหม่ในช่วงนี้';

  @override
  String get compareRenamedTitle => 'บัญชีที่เปลี่ยนชื่อผู้ใช้';

  @override
  String get compareDisappearedNote =>
      'บัญชีที่หายไปจากรายชื่อบางส่วนอาจไม่ได้เลิกติดตาม แต่ปิดใช้งานหรือลบบัญชีไปแล้ว ลองแตะโปรไฟล์เพื่อตรวจสอบ';

  @override
  String get compareNoChange => 'ไม่มีการเปลี่ยนแปลง';

  @override
  String get compareExportDateNote => 'วันที่คือวันที่ส่งออกไฟล์จาก Instagram';

  @override
  String get compareChange => 'การเปลี่ยนแปลง';

  @override
  String get compareLost => 'เลิกติดตาม';

  @override
  String get appSettingsTitle => 'การตั้งค่าแอป';

  @override
  String get appSettingsAnalysisSection => 'การตั้งค่าการวิเคราะห์';

  @override
  String get appSettingsDataSection => 'การจัดการข้อมูล';

  @override
  String get appSettingsAnalysisNotify => 'การแจ้งเตือนการวิเคราะห์';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'รับการแจ้งเตือนเมื่อการวิเคราะห์เสร็จสิ้น';

  @override
  String get appSettingsAutoRefresh => 'รีเฟรชประวัติอัตโนมัติ';

  @override
  String get appSettingsAutoRefreshBody => 'อัปเดตข้อมูลประวัติโดยอัตโนมัติ';

  @override
  String get appSettingsClearHistory => 'ลบประวัติการวิเคราะห์';

  @override
  String get appSettingsClearHistoryBody =>
      'ลบข้อมูลการวิเคราะห์ที่บันทึกไว้ทั้งหมด';

  @override
  String get appSettingsExportAll => 'ส่งออกข้อมูลทั้งหมด';

  @override
  String get appSettingsExportAllBody =>
      'ส่งออกข้อมูลการวิเคราะห์ทั้งหมดเป็นข้อความ';

  @override
  String get appSettingsClearTitle => 'ลบประวัติ';

  @override
  String get appSettingsClearMessage =>
      'ต้องการลบประวัติการวิเคราะห์ทั้งหมดหรือไม่? ไม่สามารถย้อนกลับได้';

  @override
  String get appSettingsCleared => 'ลบประวัติการวิเคราะห์สำเร็จแล้ว';

  @override
  String get appSettingsClearFailed => 'ลบประวัติไม่สำเร็จ';

  @override
  String get appSettingsNothingToExport => 'ไม่มีข้อมูลการวิเคราะห์ที่จะส่งออก';

  @override
  String get appSettingsExportTitle => 'ส่งออกข้อมูลการวิเคราะห์ TrackFollows';

  @override
  String appSettingsExportCreated(String date) {
    return 'สร้างเมื่อ: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'การวิเคราะห์ $index';
  }

  @override
  String get appSettingsExportDate => 'วันที่';

  @override
  String get appSettingsExportFailed => 'ส่งออกข้อมูลไม่สำเร็จ';

  @override
  String get settingsTitle => 'ตั้งค่า';

  @override
  String get settingsNotificationsSection => 'การแจ้งเตือน';

  @override
  String get settingsRecheckTitle => 'แจ้งเตือนให้ตรวจสอบอีกครั้ง';

  @override
  String get settingsRecheckBody =>
      'เตือนให้ตรวจสอบด้วยไฟล์ใหม่ในอีก 2 สัปดาห์หลังการวิเคราะห์';

  @override
  String get settingsSupportSection => 'การสนับสนุนและข้อมูลทางกฎหมาย';

  @override
  String get settingsFaq => 'คำถามที่พบบ่อย';

  @override
  String get settingsTerms => 'ข้อกำหนดการใช้งาน';

  @override
  String get settingsPrivacy => 'นโยบายความเป็นส่วนตัว';

  @override
  String get settingsAdPrivacy => 'ความเป็นส่วนตัวของโฆษณา';

  @override
  String get settingsAppInfoSection => 'ข้อมูลแอป';

  @override
  String get settingsAboutTitle => 'เกี่ยวกับ TrackFollows';

  @override
  String get settingsAboutBody =>
      'TrackFollows เป็นเครื่องมือที่วิเคราะห์ข้อมูล Instagram บนอุปกรณ์ของคุณ ดูรายละเอียดการจัดการข้อมูลของบริการโฆษณาได้ในนโยบายความเป็นส่วนตัว';

  @override
  String settingsVersion(String version, String build) {
    return 'เวอร์ชัน $version ($build)';
  }

  @override
  String get settingsCopyright => '© 2025-2026 TrackFollows สงวนลิขสิทธิ์';

  @override
  String get settingsLanguage => 'ภาษา';

  @override
  String get settingsLanguageSystem => 'ตามภาษาของอุปกรณ์';

  @override
  String get settingsOpenLinkFailed => 'เปิดลิงก์ไม่สำเร็จ';

  @override
  String get adConsentNotReady => 'โปรดเปิดหน้าจอนี้ใหม่แล้วลองอีกครั้ง';

  @override
  String get adConsentPreparing =>
      'กำลังเตรียมการตั้งค่าความเป็นส่วนตัวของโฆษณา โปรดลองอีกครั้งในอีกสักครู่';

  @override
  String get adConsentNothingToChange =>
      'ขณะนี้ไม่มีการตั้งค่าความเป็นส่วนตัวของโฆษณาที่ต้องเปลี่ยน';

  @override
  String get adConsentOpenFailed =>
      'เปิดการตั้งค่าความเป็นส่วนตัวไม่สำเร็จ โปรดลองอีกครั้งในอีกสักครู่';

  @override
  String get adConsentStatusFailed =>
      'ตรวจสอบสถานะการตั้งค่าความเป็นส่วนตัวไม่สำเร็จ โปรดลองอีกครั้งในอีกสักครู่';

  @override
  String get reminderTitle => 'ถึงเวลาตรวจสอบผู้ที่เลิกติดตามอีกครั้ง';

  @override
  String get reminderBody =>
      'ผ่านไป 2 สัปดาห์แล้วหลังการวิเคราะห์ครั้งก่อน วิเคราะห์ด้วยไฟล์ใหม่เพื่อดูว่าใครเลิกติดตามคุณในช่วงนี้';

  @override
  String get reminderChannelName => 'แจ้งเตือนให้ตรวจสอบอีกครั้ง';

  @override
  String get reminderChannelDescription =>
      'เตือนให้ตรวจสอบอีกครั้งด้วยไฟล์ใหม่ในอีก 2 สัปดาห์หลังการวิเคราะห์';

  @override
  String get faqTitle => 'คำถามที่พบบ่อย';

  @override
  String get faqIsSafeQuestion => 'บริการนี้ปลอดภัยหรือไม่?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows ไม่ขอรหัสผ่าน Instagram หรือเข้าสู่บัญชีของคุณ ไฟล์ที่เลือกจะถูกวิเคราะห์บนอุปกรณ์ของคุณ การประมวลผลข้อมูลวินิจฉัยการใช้งานและบริการโฆษณามีอธิบายแยกไว้ในนโยบายความเป็นส่วนตัว';

  @override
  String get faqDownloadTimeQuestion => 'การดาวน์โหลดข้อมูลใช้เวลานานแค่ไหน?';

  @override
  String get faqDownloadTimeAnswer =>
      'Instagram เป็นผู้เตรียมไฟล์ส่งออก ระยะเวลาอาจแตกต่างกัน โปรดตรวจสอบการแจ้งเตือนหรือหน้าส่งออก แล้วดาวน์โหลด ZIP เมื่อพร้อม';

  @override
  String get faqWhatIsUnfollowerQuestion => 'ผู้ที่ไม่ได้ติดตามกลับคืออะไร?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'คือบัญชีที่อยู่ในรายชื่อที่คุณติดตาม แต่ไม่อยู่ในรายชื่อผู้ติดตามคุณในไฟล์ที่ให้มา ซึ่งอาจรวมถึงบัญชีที่ไม่เคยติดตามคุณ ไฟล์ส่งออกเพียงครั้งเดียวไม่สามารถยืนยันได้ว่าใครเคยติดตามคุณหรือเลิกติดตามเมื่อใด';

  @override
  String get faqThreadsQuestion => 'ตรวจสอบผู้เลิกติดตามใน Threads ได้ด้วยไหม';

  @override
  String get faqThreadsAnswer =>
      'ได้ หากไฟล์ ZIP ที่ดาวน์โหลดจาก Instagram มีรายชื่อผู้ติดตามและกำลังติดตามของ Threads ระบบจะแสดงผลของ Threads แยกจากผลของ Instagram คุณสลับดู Instagram และ Threads ได้ที่ด้านบนของหน้าผลลัพธ์ ผู้ติดตามใน Threads เป็นรายชื่อแยกจากผู้ติดตามใน Instagram';

  @override
  String get faqIsFreeQuestion => 'มีค่าใช้จ่ายในการใช้บริการนี้หรือไม่?';

  @override
  String get faqIsFreeAnswer =>
      'ไม่ บริการนี้ฟรีทั้งหมด คุณสามารถใช้ฟีเจอร์ทั้งหมดได้โดยไม่มีค่าใช้จ่าย';

  @override
  String get faqIncorrectListQuestion =>
      'รายชื่อผู้ที่ไม่ได้ติดตามกลับแตกต่างจากที่คาดไว้ ทำไม?';

  @override
  String get faqIncorrectListAnswer =>
      'ผลลัพธ์อ้างอิงรายชื่อในไฟล์ส่งออกและอาจต่างจาก Instagram ในปัจจุบัน เวลาที่ส่งออก ช่วงเวลาที่เลือก และบัญชีที่ถูกลบหรือปิดใช้งานอาจส่งผลต่อรายชื่อและจำนวน\n\nเลือกช่วงเวลาทั้งหมดเมื่อส่งออก และตรวจสอบว่ามีไฟล์ผู้ติดตามและบัญชีที่คุณติดตามครบทุกไฟล์ แม้ไฟล์ส่งออกใหม่ก็ไม่รับประกันว่าจะตรงกับสถานะบัญชีปัจจุบัน';

  @override
  String get faqFileSelectErrorQuestion => 'ฉันไม่สามารถเลือกไฟล์ ZIP ได้';

  @override
  String get faqFileSelectErrorAnswer =>
      'เมื่อเปิดลิงก์จากแอปส่งข้อความเช่น KakaoTalk ฟังก์ชันการเลือกไฟล์อาจไม่ทำงานอย่างถูกต้อง ในกรณีนี้ให้ลองเข้าถึงเว็บไซต์โดยตรงผ่านเบราว์เซอร์เช่น Chrome หรือ Samsung Internet เพื่อเลือกไฟล์ โดยปกติคุณสามารถเลือกไฟล์ได้ตามปกติเมื่อเข้าถึงโดยตรงผ่านเบราว์เซอร์';

  @override
  String get faqDataSecurityQuestion =>
      'ความปลอดภัยของข้อมูลและความเป็นส่วนตัว';

  @override
  String get faqDataSecurityAnswer =>
      'ไฟล์ Instagram ต้นฉบับ ชื่อบัญชี และรายชื่อผู้ติดตามของคุณจะไม่ถูกส่งไปยังเซิร์ฟเวอร์เพื่อวิเคราะห์ เพื่อให้เปรียบเทียบกับการวิเคราะห์ครั้งก่อนได้ ชื่อผู้ใช้ของผู้ติดตามและที่กำลังติดตามจะถูกบันทึกไว้เฉพาะในอุปกรณ์นี้ (เบราว์เซอร์หรือแอป) และคุณลบได้ทุกเมื่อด้วย \'ลบประวัติ\' ในหน้าผลลัพธ์ ดูนโยบายความเป็นส่วนตัวสำหรับการจัดการข้อมูลการวินิจฉัยและบริการโฆษณา';
}
