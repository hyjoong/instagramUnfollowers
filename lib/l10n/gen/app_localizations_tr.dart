// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get commonCancel => 'İptal';

  @override
  String get commonDelete => 'Sil';

  @override
  String get commonRetry => 'Tekrar dene';

  @override
  String get commonUnfollowers => 'Geri takip etmeyenler';

  @override
  String get commonFans => 'Hayranlar';

  @override
  String get commonMutual => 'Karşılıklı takip';

  @override
  String get commonFollowers => 'Takipçiler';

  @override
  String get commonTotalFollowers => 'Toplam takipçi';

  @override
  String get commonTotalFollowing => 'Toplam takip edilen';

  @override
  String get commonNewFollowers => 'Yeni takipçiler';

  @override
  String get commonNotificationPermissionOff =>
      'Bildirim izni kapalı. Lütfen cihaz ayarlarından bildirimlere izin verin.';

  @override
  String get navAnalyze => 'Analiz';

  @override
  String get navHistory => 'Geçmiş';

  @override
  String get navSettings => 'Ayarlar';

  @override
  String get mainFilePickFailed => 'Dosya seçilemedi';

  @override
  String get mainPreparingResults => 'Analiz sonuçları hazırlanıyor';

  @override
  String get mainReminderPrompt =>
      'Seni kimlerin takipten çıktığını bir sonraki analizde görürsün. 2 hafta sonra hatırlatalım mı?';

  @override
  String get mainReminderAction => 'Hatırlat';

  @override
  String get mainReminderEnabled =>
      '2 hafta sonra hatırlatacağız. Ayarlardan kapatabilirsin.';

  @override
  String get mainExitTitle => 'Uygulamadan çık';

  @override
  String get mainExitMessage => 'Uygulamadan çıkmak istiyor musun?';

  @override
  String get mainExitConfirm => 'Çık';

  @override
  String get loadingTitle => 'Instagram Takipçi Analizi';

  @override
  String get loadingMessage => 'Yükleniyor...';

  @override
  String get errorTitle => 'Bağlantı hatası';

  @override
  String get onboardingWelcomeTitle => 'TrackFollows\'a hoş geldin';

  @override
  String get onboardingWelcomeBody =>
      'Instagram takipçi verilerini analiz ederek seni geri takip etmeyenleri, karşılıklı takip durumunu ve takip tarihlerini gör.';

  @override
  String get onboardingSafeTitle => '%100 güvenli ve gizliliğini korur';

  @override
  String get onboardingSafeBody =>
      'Tüm veriler cihazında işlenir. Kişisel bilgilerini toplamaz veya saklamayız.';

  @override
  String get onboardingEasyTitle => 'Kullanımı kolay';

  @override
  String get onboardingEasyBody =>
      'Instagram veri dosyanı yüklemen yeterli, analiz sonuçlarını hemen görürsün.';

  @override
  String get onboardingReadyTitle => 'Başlamaya hazırsın';

  @override
  String get onboardingReadyBody => 'Instagram takipçi analizine başla!';

  @override
  String get onboardingSkip => 'Atla';

  @override
  String get onboardingNext => 'İleri';

  @override
  String get onboardingStart => 'Başla';

  @override
  String get historyTitle => 'Analiz geçmişi';

  @override
  String get historyLowOverlap =>
      'İki kaydın takipçileri neredeyse hiç örtüşmüyor. Aynı hesaba ait kayıtlar olduğundan emin ol.';

  @override
  String get historyDeleteTitle => 'Analiz kaydını sil';

  @override
  String get historyDeleteMessage => 'Bu analiz kaydını silmek istiyor musun?';

  @override
  String get historyDeleted => 'Analiz kaydı silindi';

  @override
  String get historyDeleteFailed => 'Silinemedi';

  @override
  String get historyShareSubject => 'Instagram analiz sonucu';

  @override
  String get historyShareFooter => 'TrackFollows uygulamasıyla oluşturuldu';

  @override
  String get historyCompare => 'İki kaydı karşılaştır';

  @override
  String get historyCompareSelected => 'Seçilen iki kaydı karşılaştır';

  @override
  String historyCompareHint(String count) {
    return 'Karşılaştırmak için iki kayıt seç ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'Analiz geçmişi yok';

  @override
  String get historyEmptyBody => 'Analiz sonuçları burada görünecek';

  @override
  String historyExportedOn(String date) {
    return 'Dışa aktarma: $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'Takipçi $followers · Takip edilen $following · Geri takip etmeyen $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'Analiz: $date';
  }

  @override
  String get historyViewStats => 'İstatistikleri gör';

  @override
  String get historyShare => 'Paylaş';

  @override
  String get historyFirstRecord =>
      'İlk kayıt · Değişimleri bir sonraki analizden itibaren karşılaştırırız';

  @override
  String get historyNoChange => 'Önceki kayda göre takipçi değişimi yok';

  @override
  String get historyVsPrevious => 'Önceki kayda göre';

  @override
  String historyLostCount(String count) {
    return 'Takipten çıkan $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'Yeni takipçi $count';
  }

  @override
  String get statsTitle => 'Analiz sonucu';

  @override
  String get statsNotFoundTitle => 'Analiz verisi bulunamadı';

  @override
  String get statsNotFoundBody => 'Veri silinmiş veya hiç var olmamış';

  @override
  String get statsBack => 'Geri dön';

  @override
  String get statsSummary => 'Analiz özeti';

  @override
  String get statsNoData => 'Analiz verisi yok';

  @override
  String get statsDistribution => 'Takipçi dağılımı';

  @override
  String get statsDetailedStats => 'Ayrıntılı istatistikler';

  @override
  String get statsDetails => 'Ayrıntılar';

  @override
  String get statsAnalysisDate => 'Analiz tarihi';

  @override
  String statsMutualRate(String rate) {
    return 'Karşılıklı takip oranı: %$rate';
  }

  @override
  String get compareTitle => 'Kayıt karşılaştırma';

  @override
  String get compareRecentStats => 'Son kayıt istatistikleri';

  @override
  String compareAnalysisDay(String date) {
    return '$date (analiz günü)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(analiz günü), dosya adında dışa aktarma tarihi olmayan eski kayıtlar için analizin yapıldığı günü gösterir.';

  @override
  String get compareLostTitle => 'Seni takipten çıkanlar';

  @override
  String get compareLostEmpty => 'Bu dönemde seni takipten çıkan olmadı.';

  @override
  String get compareNewEmpty => 'Bu dönemde yeni takipçin olmadı.';

  @override
  String get compareRenamedTitle => 'Kullanıcı adını değiştirenler';

  @override
  String get compareDisappearedNote =>
      'Listeden kaybolan hesaplardan bazıları takipten çıkmak yerine hesabını devre dışı bırakmış veya silmiş olabilir. Profile dokunarak kontrol et.';

  @override
  String get compareNoChange => 'Değişim yok';

  @override
  String get compareExportDateNote =>
      'Tarih, dosyanın Instagram\'dan dışa aktarıldığı gündür.';

  @override
  String get compareChange => 'Değişim';

  @override
  String get compareLost => 'Takipten çıkan';

  @override
  String get appSettingsTitle => 'Uygulama ayarları';

  @override
  String get appSettingsAnalysisSection => 'Analiz ayarları';

  @override
  String get appSettingsDataSection => 'Veri yönetimi';

  @override
  String get appSettingsAnalysisNotify => 'Analiz bildirimi';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'Analiz tamamlandığında bildirim al';

  @override
  String get appSettingsAutoRefresh => 'Geçmişi otomatik yenile';

  @override
  String get appSettingsAutoRefreshBody =>
      'Geçmiş verilerini otomatik günceller';

  @override
  String get appSettingsClearHistory => 'Analiz geçmişini sil';

  @override
  String get appSettingsClearHistoryBody =>
      'Kayıtlı tüm analiz verilerini siler';

  @override
  String get appSettingsExportAll => 'Tüm verileri dışa aktar';

  @override
  String get appSettingsExportAllBody =>
      'Tüm analiz verilerini metin olarak dışa aktarır';

  @override
  String get appSettingsClearTitle => 'Geçmişi sil';

  @override
  String get appSettingsClearMessage =>
      'Tüm analiz geçmişini silmek istiyor musun? Bu işlem geri alınamaz.';

  @override
  String get appSettingsCleared => 'Analiz geçmişi başarıyla silindi';

  @override
  String get appSettingsClearFailed => 'Geçmiş silinemedi';

  @override
  String get appSettingsNothingToExport => 'Dışa aktarılacak analiz verisi yok';

  @override
  String get appSettingsExportTitle =>
      'TrackFollows analiz verilerini dışa aktarma';

  @override
  String appSettingsExportCreated(String date) {
    return 'Oluşturulma: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'Analiz $index';
  }

  @override
  String get appSettingsExportDate => 'Tarih';

  @override
  String get appSettingsExportFailed => 'Veriler dışa aktarılamadı';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get settingsNotificationsSection => 'Bildirimler';

  @override
  String get settingsRecheckTitle => 'Tekrar kontrol hatırlatması';

  @override
  String get settingsRecheckBody =>
      'Analizden 2 hafta sonra yeni dosyayla kontrol etmeni hatırlatırız';

  @override
  String get settingsSupportSection => 'Destek ve yasal bilgiler';

  @override
  String get settingsFaq => 'Sık Sorulan Sorular';

  @override
  String get settingsTerms => 'Kullanım Şartları';

  @override
  String get settingsPrivacy => 'Gizlilik Politikası';

  @override
  String get settingsAdPrivacy => 'Reklam gizlilik ayarları';

  @override
  String get settingsAppInfoSection => 'Uygulama bilgisi';

  @override
  String get settingsAboutTitle => 'TrackFollows hakkında';

  @override
  String get settingsAboutBody =>
      'TrackFollows, Instagram verilerini cihazında analiz eden bir araçtır. Reklam hizmetlerinin bilgileri nasıl işlediğini Gizlilik Politikası\'nda bulabilirsin.';

  @override
  String settingsVersion(String version, String build) {
    return 'Sürüm $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. Tüm hakları saklıdır.';

  @override
  String get settingsLanguage => 'Dil';

  @override
  String get settingsLanguageSystem => 'Cihaz dilini kullan';

  @override
  String get settingsOpenLinkFailed => 'Bağlantı açılamadı.';

  @override
  String get adConsentNotReady => 'Ekranı yeniden açıp tekrar dene.';

  @override
  String get adConsentPreparing =>
      'Reklam gizlilik ayarları hazırlanıyor. Biraz sonra tekrar dene.';

  @override
  String get adConsentNothingToChange =>
      'Şu anda değiştirilecek reklam gizlilik ayarı yok.';

  @override
  String get adConsentOpenFailed =>
      'Gizlilik ayarları açılamadı. Biraz sonra tekrar dene.';

  @override
  String get adConsentStatusFailed =>
      'Gizlilik ayarlarının durumu kontrol edilemedi. Biraz sonra tekrar dene.';

  @override
  String get reminderTitle => 'Takipten çıkanları tekrar kontrol etme zamanı';

  @override
  String get reminderBody =>
      'Son analizden bu yana 2 hafta geçti. Yeni dosyayla analiz edersen bu sürede seni kimlerin takipten çıktığını görebilirsin.';

  @override
  String get reminderChannelName => 'Tekrar kontrol hatırlatması';

  @override
  String get reminderChannelDescription =>
      'Analizden 2 hafta sonra yeni dosyayla tekrar kontrol etmeni hatırlatırız';

  @override
  String get faqTitle => 'Sık Sorulan Sorular';

  @override
  String get faqIsSafeQuestion => 'Bu servis güvenli mi?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows Instagram şifrenizi istemez ve hesabınıza giriş yapmaz. Seçilen dosyalar cihazınızda analiz edilir. Kullanım tanılama verilerinin ve reklam hizmetlerinin veri işlemesi Gizlilik Politikası’nda ayrıca açıklanmıştır.';

  @override
  String get faqDownloadTimeQuestion => 'Verilerimi indirmek ne kadar sürer?';

  @override
  String get faqDownloadTimeAnswer =>
      'Dışa aktarımı Instagram hazırlar. Hazırlık süresi değişir; bildirimi veya dışa aktarma ekranını kontrol edin ve hazır olduğunda ZIP dosyasını indirin.';

  @override
  String get faqWhatIsUnfollowerQuestion => 'Geri takip etmeyen nedir?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'Bunlar, sağladığınız dosyalarda takip edilen listenizde bulunan ancak takipçi listenizde bulunmayan hesaplardır. Sizi hiç takip etmemiş hesaplar da dahil olabilir. Tek bir dışa aktarım, birinin daha önce sizi takip edip etmediğini veya ne zaman takipten çıktığını kanıtlamaz.';

  @override
  String get faqThreadsQuestion =>
      'Threads\'te takipten çıkanları da görebilir miyim?';

  @override
  String get faqThreadsAnswer =>
      'Evet. Instagram\'dan indirdiğiniz ZIP dosyası Threads takipçi ve takip edilen listelerinizi içeriyorsa, Instagram sonucundan ayrı bir Threads sonucu görürsünüz. Sonuçların üst kısmından Instagram ve Threads arasında geçiş yapabilirsiniz. Threads takipçileri, Instagram takipçilerinizden ayrı bir listedir.';

  @override
  String get faqIsFreeQuestion => 'Bu hizmeti kullanmanın bir maliyeti var mı?';

  @override
  String get faqIsFreeAnswer =>
      'Hayır, bu hizmet tamamen ücretsizdir. Tüm özellikleri herhangi bir ücret ödemeden kullanabilirsiniz';

  @override
  String get faqIncorrectListQuestion =>
      'Takipçi listesi beklediğimden farklı görünüyor. Neden?';

  @override
  String get faqIncorrectListAnswer =>
      'Sonuçlar dışa aktarılan dosyalardaki listeleri yansıtır ve Instagram’daki güncel durumdan farklı olabilir. Dışa aktarım zamanı, seçilen tarih aralığı ve silinmiş veya devre dışı hesaplar listeleri ve sayıları etkileyebilir.\n\nDışa aktarırken Tüm zamanlar seçeneğini seçin ve tüm takipçi ve takip edilen dosyalarının dahil olduğunu kontrol edin. Yeni bir dışa aktarım bile güncel hesap durumuyla eşleşmeyi garanti etmez.';

  @override
  String get faqFileSelectErrorQuestion => 'ZIP dosyasını seçemiyorum';

  @override
  String get faqFileSelectErrorAnswer =>
      'KakaoTalk gibi mesajlaşma uygulamalarından bağlantıyı açtığınızda, dosya seçme özelliği düzgün çalışmayabilir. Bu durumda, dosyayı seçmek için Chrome veya Samsung Internet gibi tarayıcılar aracılığıyla siteye doğrudan erişmeyi deneyin. Genellikle, bir tarayıcı aracılığıyla doğrudan eriştiğinizde dosyaları normal olarak seçebilirsiniz.';

  @override
  String get faqDataSecurityQuestion => 'Veri Güvenliği ve Gizlilik';

  @override
  String get faqDataSecurityAnswer =>
      'Orijinal Instagram dosyalarınız, hesap adlarınız ve takipçi listeleriniz analiz için bir sunucuya gönderilmez. Son analizinizle karşılaştırabilmek için takipçi ve takip edilen kullanıcı adları yalnızca bu cihazda (tarayıcı veya uygulama) saklanır ve sonuç ekranındaki \'Geçmişi sil\' ile istediğiniz zaman silebilirsiniz. Kullanım ve hata teşhisi ile reklam hizmetlerine ait veri işleme için Gizlilik Politikası\'na bakın.';
}
