// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get commonCancel => 'Batal';

  @override
  String get commonDelete => 'Padam';

  @override
  String get commonRetry => 'Cuba lagi';

  @override
  String get commonUnfollowers => 'Unfollower';

  @override
  String get commonFans => 'Peminat';

  @override
  String get commonMutual => 'Follow Mutual';

  @override
  String get commonFollowers => 'Pengikut';

  @override
  String get commonTotalFollowers => 'Jumlah pengikut';

  @override
  String get commonTotalFollowing => 'Jumlah diikuti';

  @override
  String get commonNewFollowers => 'Pengikut baharu';

  @override
  String get commonNotificationPermissionOff =>
      'Kebenaran pemberitahuan dimatikan. Sila benarkan pemberitahuan dalam tetapan peranti.';

  @override
  String get navAnalyze => 'Analisis';

  @override
  String get navHistory => 'Sejarah';

  @override
  String get navSettings => 'Tetapan';

  @override
  String get mainFilePickFailed => 'Gagal memilih fail';

  @override
  String get mainPreparingResults => 'Sedang menyediakan keputusan analisis';

  @override
  String get mainReminderPrompt =>
      'Anda hanya akan tahu siapa yang unfollow anda pada analisis seterusnya. Ingatkan 2 minggu lagi?';

  @override
  String get mainReminderAction => 'Ingatkan saya';

  @override
  String get mainReminderEnabled =>
      'Kami akan mengingatkan anda 2 minggu lagi. Boleh dimatikan dalam tetapan.';

  @override
  String get mainExitTitle => 'Keluar aplikasi';

  @override
  String get mainExitMessage => 'Adakah anda pasti mahu keluar dari aplikasi?';

  @override
  String get mainExitConfirm => 'Keluar';

  @override
  String get loadingTitle => 'Analisis Unfollower Instagram';

  @override
  String get loadingMessage => 'Memuatkan...';

  @override
  String get errorTitle => 'Ralat sambungan';

  @override
  String get onboardingWelcomeTitle => 'Selamat datang ke TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'Analisis data pengikut Instagram untuk melihat unfollower, status follow mutual dan tarikh mula mengikuti.';

  @override
  String get onboardingSafeTitle => '100% selamat dan peribadi';

  @override
  String get onboardingSafeBody =>
      'Semua data diproses pada peranti anda. Kami tidak mengumpul atau menyimpan maklumat peribadi.';

  @override
  String get onboardingEasyTitle => 'Mudah digunakan';

  @override
  String get onboardingEasyBody =>
      'Muat naik sahaja fail data Instagram dan keputusan analisis terus dipaparkan.';

  @override
  String get onboardingReadyTitle => 'Sedia untuk bermula';

  @override
  String get onboardingReadyBody => 'Jom mulakan analisis pengikut Instagram!';

  @override
  String get onboardingSkip => 'Langkau';

  @override
  String get onboardingNext => 'Seterusnya';

  @override
  String get onboardingStart => 'Mulakan';

  @override
  String get historyTitle => 'Sejarah analisis';

  @override
  String get historyLowOverlap =>
      'Pengikut kedua-dua rekod hampir tidak bertindih. Sila pastikan ia daripada akaun yang sama.';

  @override
  String get historyDeleteTitle => 'Padam sejarah analisis';

  @override
  String get historyDeleteMessage =>
      'Adakah anda pasti mahu memadam sejarah analisis ini?';

  @override
  String get historyDeleted => 'Sejarah analisis telah dipadam';

  @override
  String get historyDeleteFailed => 'Gagal memadam';

  @override
  String get historyShareSubject => 'Keputusan analisis Instagram';

  @override
  String get historyShareFooter => 'Dijana oleh aplikasi TrackFollows';

  @override
  String get historyCompare => 'Banding dua rekod';

  @override
  String get historyCompareSelected => 'Banding dua rekod yang dipilih';

  @override
  String historyCompareHint(String count) {
    return 'Pilih dua rekod untuk dibandingkan ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'Tiada sejarah analisis';

  @override
  String get historyEmptyBody => 'Keputusan analisis akan dipaparkan di sini';

  @override
  String historyExportedOn(String date) {
    return 'Dieksport pada $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'Pengikut $followers · Diikuti $following · Unfollower $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'Dianalisis: $date';
  }

  @override
  String get historyViewStats => 'Lihat statistik';

  @override
  String get historyShare => 'Kongsi';

  @override
  String get historyFirstRecord =>
      'Rekod pertama · perubahan dibandingkan bermula analisis seterusnya';

  @override
  String get historyNoChange =>
      'Tiada perubahan pengikut daripada rekod sebelumnya';

  @override
  String get historyVsPrevious => 'Berbanding rekod sebelumnya';

  @override
  String historyLostCount(String count) {
    return 'Unfollow $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'Pengikut baharu $count';
  }

  @override
  String get statsTitle => 'Keputusan analisis';

  @override
  String get statsNotFoundTitle => 'Data analisis tidak ditemui';

  @override
  String get statsNotFoundBody => 'Data telah dipadam atau tidak wujud';

  @override
  String get statsBack => 'Kembali';

  @override
  String get statsSummary => 'Ringkasan analisis';

  @override
  String get statsNoData => 'Tiada data analisis';

  @override
  String get statsDistribution => 'Taburan pengikut';

  @override
  String get statsDetailedStats => 'Statistik terperinci';

  @override
  String get statsDetails => 'Butiran';

  @override
  String get statsAnalysisDate => 'Tarikh analisis';

  @override
  String statsMutualRate(String rate) {
    return 'Nisbah follow mutual: $rate%';
  }

  @override
  String get compareTitle => 'Banding rekod';

  @override
  String get compareRecentStats => 'Statistik terkini';

  @override
  String compareAnalysisDay(String date) {
    return '$date (hari analisis)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(hari analisis) menandakan rekod lama yang nama failnya tiada tarikh eksport, jadi dipaparkan sebagai tarikh analisis.';

  @override
  String get compareLostTitle => 'Yang unfollow anda';

  @override
  String get compareLostEmpty => 'Tiada orang unfollow anda dalam tempoh ini.';

  @override
  String get compareNewEmpty => 'Tiada pengikut baharu dalam tempoh ini.';

  @override
  String get compareRenamedTitle => 'Akaun yang menukar nama pengguna';

  @override
  String get compareDisappearedNote =>
      'Sesetengah akaun yang hilang daripada senarai mungkin menyahaktifkan atau memadam akaun, bukan unfollow. Ketik profil untuk menyemak.';

  @override
  String get compareNoChange => 'Tiada perubahan';

  @override
  String get compareExportDateNote =>
      'Tarikh ialah hari fail dieksport daripada Instagram.';

  @override
  String get compareChange => 'Perubahan';

  @override
  String get compareLost => 'Unfollow';

  @override
  String get appSettingsTitle => 'Tetapan aplikasi';

  @override
  String get appSettingsAnalysisSection => 'Tetapan analisis';

  @override
  String get appSettingsDataSection => 'Pengurusan data';

  @override
  String get appSettingsAnalysisNotify => 'Pemberitahuan analisis';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'Terima pemberitahuan apabila analisis selesai';

  @override
  String get appSettingsAutoRefresh => 'Segar semula sejarah secara automatik';

  @override
  String get appSettingsAutoRefreshBody =>
      'Kemas kini data sejarah secara automatik';

  @override
  String get appSettingsClearHistory => 'Padam sejarah analisis';

  @override
  String get appSettingsClearHistoryBody =>
      'Padam semua data analisis yang disimpan';

  @override
  String get appSettingsExportAll => 'Eksport semua data';

  @override
  String get appSettingsExportAllBody =>
      'Eksport semua data analisis sebagai teks';

  @override
  String get appSettingsClearTitle => 'Padam sejarah';

  @override
  String get appSettingsClearMessage =>
      'Adakah anda pasti mahu memadam semua sejarah analisis? Tindakan ini tidak boleh dibuat asal.';

  @override
  String get appSettingsCleared => 'Sejarah analisis berjaya dipadam';

  @override
  String get appSettingsClearFailed => 'Gagal memadam sejarah';

  @override
  String get appSettingsNothingToExport =>
      'Tiada data analisis untuk dieksport';

  @override
  String get appSettingsExportTitle => 'Eksport data analisis TrackFollows';

  @override
  String appSettingsExportCreated(String date) {
    return 'Dijana pada: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'Analisis $index';
  }

  @override
  String get appSettingsExportDate => 'Tarikh';

  @override
  String get appSettingsExportFailed => 'Gagal mengeksport data';

  @override
  String get settingsTitle => 'Tetapan';

  @override
  String get settingsNotificationsSection => 'Pemberitahuan';

  @override
  String get settingsRecheckTitle => 'Peringatan semak semula';

  @override
  String get settingsRecheckBody =>
      'Ingatkan untuk menyemak dengan fail baharu 2 minggu selepas analisis';

  @override
  String get settingsSupportSection => 'Sokongan dan maklumat undang-undang';

  @override
  String get settingsFaq => 'Soalan Lazim';

  @override
  String get settingsTerms => 'Syarat Perkhidmatan';

  @override
  String get settingsPrivacy => 'Dasar Privasi';

  @override
  String get settingsAdPrivacy => 'Privasi iklan';

  @override
  String get settingsAppInfoSection => 'Maklumat aplikasi';

  @override
  String get settingsAboutTitle => 'Tentang TrackFollows';

  @override
  String get settingsAboutBody =>
      'TrackFollows ialah alat untuk menganalisis data Instagram pada peranti anda. Maklumat tentang pemprosesan data perkhidmatan iklan boleh dilihat dalam Dasar Privasi.';

  @override
  String settingsVersion(String version, String build) {
    return 'Versi $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. Hak cipta terpelihara.';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLanguageSystem => 'Ikut bahasa peranti';

  @override
  String get settingsOpenLinkFailed => 'Gagal membuka pautan.';

  @override
  String get adConsentNotReady =>
      'Sila buka semula skrin ini, kemudian cuba lagi.';

  @override
  String get adConsentPreparing =>
      'Sedang menyediakan tetapan privasi iklan. Sila cuba lagi sebentar nanti.';

  @override
  String get adConsentNothingToChange =>
      'Tiada tetapan privasi iklan yang perlu diubah sekarang.';

  @override
  String get adConsentOpenFailed =>
      'Gagal membuka tetapan privasi. Sila cuba lagi sebentar nanti.';

  @override
  String get adConsentStatusFailed =>
      'Gagal menyemak status tetapan privasi. Sila cuba lagi sebentar nanti.';

  @override
  String get reminderTitle => 'Masanya semak unfollow semula';

  @override
  String get reminderBody =>
      'Sudah 2 minggu sejak analisis lepas. Analisis dengan fail baharu untuk tahu siapa yang unfollow anda sejak itu.';

  @override
  String get reminderChannelName => 'Peringatan semak semula';

  @override
  String get reminderChannelDescription =>
      'Mengingatkan untuk menyemak semula dengan fail baharu 2 minggu selepas analisis';

  @override
  String get faqTitle => 'Soalan Lazim';

  @override
  String get faqIsSafeQuestion => 'Adakah perkhidmatan ini selamat?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows tidak meminta kata laluan Instagram atau log masuk ke akaun anda. Fail yang dipilih dianalisis pada peranti anda. Pengendalian data diagnostik penggunaan dan perkhidmatan iklan diterangkan secara berasingan dalam Dasar Privasi.';

  @override
  String get faqDownloadTimeQuestion =>
      'Berapa lama masa yang diperlukan untuk memuat turun data saya?';

  @override
  String get faqDownloadTimeAnswer =>
      'Instagram menyediakan eksport. Tempoh penyediaan berbeza-beza; semak pemberitahuan atau skrin eksport dan muat turun ZIP apabila sudah sedia.';

  @override
  String get faqWhatIsUnfollowerQuestion => 'Apakah sebenarnya unfollower itu?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'Akaun ini terdapat dalam senarai yang anda ikuti tetapi tiada dalam senarai pengikut dalam fail yang diberikan. Ini mungkin termasuk akaun yang tidak pernah mengikuti anda. Satu eksport tidak membuktikan sama ada seseorang pernah mengikuti anda atau bila mereka berhenti.';

  @override
  String get faqThreadsQuestion =>
      'Bolehkah saya juga melihat unfollower Threads?';

  @override
  String get faqThreadsAnswer =>
      'Ya. Jika ZIP yang anda muat turun daripada Instagram mengandungi senarai pengikut dan diikuti Threads, anda akan melihat hasil Threads yang berasingan daripada hasil Instagram. Tukar antara Instagram dan Threads di bahagian atas hasil. Pengikut Threads ialah senarai yang berasingan daripada pengikut Instagram anda.';

  @override
  String get faqIsFreeQuestion =>
      'Adakah menggunakan perkhidmatan ini berbayar?';

  @override
  String get faqIsFreeAnswer =>
      'Tidak, perkhidmatan ini sepenuhnya percuma. Anda boleh menggunakan semua ciri tanpa kos.';

  @override
  String get faqIncorrectListQuestion =>
      'Senarai unfollower kelihatan berbeza daripada yang saya jangkakan. Mengapa?';

  @override
  String get faqIncorrectListAnswer =>
      'Hasil mencerminkan senarai dalam fail eksport dan mungkin berbeza daripada Instagram sekarang. Masa eksport, julat tarikh yang dipilih, serta akaun yang dipadam atau dinyahaktifkan boleh mempengaruhi senarai dan bilangannya.\n\nPilih Sepanjang masa semasa mengeksport dan pastikan semua fail pengikut serta akaun yang anda ikuti disertakan. Eksport baharu juga tidak menjamin padanan dengan status akaun semasa.';

  @override
  String get faqFileSelectErrorQuestion => 'Saya tidak dapat memilih fail ZIP';

  @override
  String get faqFileSelectErrorAnswer =>
      'Apabila membuka pautan dari aplikasi pesanan seperti KakaoTalk, ciri pemilihan fail mungkin tidak berfungsi dengan betul. Dalam kes ini, cuba akses laman web secara langsung melalui penyemak imbas seperti Chrome atau Samsung Internet untuk memilih fail. Biasanya, anda boleh memilih fail secara normal apabila mengakses secara langsung melalui penyemak imbas.';

  @override
  String get faqDataSecurityQuestion => 'Keselamatan Data & Privasi';

  @override
  String get faqDataSecurityAnswer =>
      'Fail asal Instagram, nama akaun dan senarai pengikut anda tidak dihantar ke pelayan untuk analisis. Untuk perbandingan dengan analisis terakhir, nama pengguna pengikut dan yang diikuti disimpan hanya pada peranti ini (pelayar atau aplikasi), dan anda boleh memadamnya bila-bila masa melalui \'Padam sejarah\' di skrin keputusan. Rujuk Dasar Privasi untuk pengendalian data diagnostik dan perkhidmatan iklan.';
}
