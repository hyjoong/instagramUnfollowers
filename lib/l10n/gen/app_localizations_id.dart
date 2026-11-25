// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get commonCancel => 'Batal';

  @override
  String get commonDelete => 'Hapus';

  @override
  String get commonRetry => 'Coba lagi';

  @override
  String get commonUnfollowers => 'Unfollower';

  @override
  String get commonFans => 'Penggemar';

  @override
  String get commonMutual => 'Follow Timbal Balik';

  @override
  String get commonFollowers => 'Pengikut';

  @override
  String get commonTotalFollowers => 'Total pengikut';

  @override
  String get commonTotalFollowing => 'Total mengikuti';

  @override
  String get commonNewFollowers => 'Pengikut baru';

  @override
  String get commonNotificationPermissionOff =>
      'Izin notifikasi nonaktif. Aktifkan notifikasi di pengaturan perangkat.';

  @override
  String get navAnalyze => 'Analisis';

  @override
  String get navHistory => 'Riwayat';

  @override
  String get navSettings => 'Setelan';

  @override
  String get mainFilePickFailed => 'Gagal memilih file';

  @override
  String get mainPreparingResults => 'Sedang menyiapkan hasil analisis';

  @override
  String get mainReminderPrompt =>
      'Siapa yang unfollow kamu baru terlihat di analisis berikutnya. Ingatkan 2 minggu lagi?';

  @override
  String get mainReminderAction => 'Ingatkan saya';

  @override
  String get mainReminderEnabled =>
      'Kami akan mengingatkanmu 2 minggu lagi. Bisa dimatikan di setelan.';

  @override
  String get mainExitTitle => 'Keluar dari aplikasi';

  @override
  String get mainExitMessage => 'Yakin ingin keluar dari aplikasi?';

  @override
  String get mainExitConfirm => 'Keluar';

  @override
  String get loadingTitle => 'Analisis Unfollower Instagram';

  @override
  String get loadingMessage => 'Memuat...';

  @override
  String get errorTitle => 'Kesalahan koneksi';

  @override
  String get onboardingWelcomeTitle => 'Selamat datang di TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'Analisis data pengikut Instagram untuk melihat unfollower, status follow timbal balik, dan tanggal mulai mengikuti.';

  @override
  String get onboardingSafeTitle => '100% aman dan privat';

  @override
  String get onboardingSafeBody =>
      'Semua data diproses di perangkatmu. Kami tidak mengumpulkan atau menyimpan informasi pribadi apa pun.';

  @override
  String get onboardingEasyTitle => 'Mudah digunakan';

  @override
  String get onboardingEasyBody =>
      'Cukup unggah file data Instagram dan hasil analisis langsung muncul.';

  @override
  String get onboardingReadyTitle => 'Siap dimulai';

  @override
  String get onboardingReadyBody => 'Yuk mulai analisis pengikut Instagram!';

  @override
  String get onboardingSkip => 'Lewati';

  @override
  String get onboardingNext => 'Lanjut';

  @override
  String get onboardingStart => 'Mulai';

  @override
  String get historyTitle => 'Riwayat analisis';

  @override
  String get historyLowOverlap =>
      'Pengikut dari kedua catatan hampir tidak ada yang sama. Pastikan keduanya dari akun yang sama.';

  @override
  String get historyDeleteTitle => 'Hapus riwayat analisis';

  @override
  String get historyDeleteMessage =>
      'Yakin ingin menghapus riwayat analisis ini?';

  @override
  String get historyDeleted => 'Riwayat analisis dihapus';

  @override
  String get historyDeleteFailed => 'Gagal menghapus';

  @override
  String get historyShareSubject => 'Hasil analisis Instagram';

  @override
  String get historyShareFooter => 'Dibuat dengan aplikasi TrackFollows';

  @override
  String get historyCompare => 'Bandingkan dua catatan';

  @override
  String get historyCompareSelected => 'Bandingkan dua catatan terpilih';

  @override
  String historyCompareHint(String count) {
    return 'Pilih dua catatan untuk dibandingkan ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'Belum ada riwayat analisis';

  @override
  String get historyEmptyBody => 'Hasil analisis akan tampil di sini';

  @override
  String historyExportedOn(String date) {
    return 'Diekspor $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'Pengikut $followers · Mengikuti $following · Unfollower $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'Dianalisis: $date';
  }

  @override
  String get historyViewStats => 'Lihat statistik';

  @override
  String get historyShare => 'Bagikan';

  @override
  String get historyFirstRecord =>
      'Catatan pertama · perubahan dibandingkan mulai analisis berikutnya';

  @override
  String get historyNoChange =>
      'Tidak ada perubahan pengikut dari catatan sebelumnya';

  @override
  String get historyVsPrevious => 'Dibanding catatan sebelumnya';

  @override
  String historyLostCount(String count) {
    return 'Unfollow $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'Pengikut baru $count';
  }

  @override
  String get statsTitle => 'Hasil analisis';

  @override
  String get statsNotFoundTitle => 'Data analisis tidak ditemukan';

  @override
  String get statsNotFoundBody => 'Data sudah dihapus atau tidak ada';

  @override
  String get statsBack => 'Kembali';

  @override
  String get statsSummary => 'Ringkasan analisis';

  @override
  String get statsNoData => 'Tidak ada data analisis';

  @override
  String get statsDistribution => 'Distribusi pengikut';

  @override
  String get statsDetailedStats => 'Statistik rinci';

  @override
  String get statsDetails => 'Detail';

  @override
  String get statsAnalysisDate => 'Tanggal analisis';

  @override
  String statsMutualRate(String rate) {
    return 'Rasio follow timbal balik: $rate%';
  }

  @override
  String get compareTitle => 'Bandingkan catatan';

  @override
  String get compareRecentStats => 'Statistik terbaru';

  @override
  String compareAnalysisDay(String date) {
    return '$date (hari analisis)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(hari analisis) menandai catatan lama yang nama filenya tidak memuat tanggal ekspor, jadi ditampilkan sebagai tanggal analisis.';

  @override
  String get compareLostTitle => 'Yang unfollow kamu';

  @override
  String get compareLostEmpty =>
      'Tidak ada yang unfollow kamu pada periode ini.';

  @override
  String get compareNewEmpty => 'Tidak ada pengikut baru pada periode ini.';

  @override
  String get compareRenamedTitle => 'Akun yang mengganti username';

  @override
  String get compareDisappearedNote =>
      'Sebagian akun yang hilang dari daftar mungkin menonaktifkan atau menghapus akunnya, bukan unfollow. Ketuk profilnya untuk memeriksa.';

  @override
  String get compareNoChange => 'Tidak ada perubahan';

  @override
  String get compareExportDateNote =>
      'Tanggal adalah hari file diekspor dari Instagram.';

  @override
  String get compareChange => 'Perubahan';

  @override
  String get compareLost => 'Unfollow';

  @override
  String get appSettingsTitle => 'Setelan aplikasi';

  @override
  String get appSettingsAnalysisSection => 'Setelan analisis';

  @override
  String get appSettingsDataSection => 'Pengelolaan data';

  @override
  String get appSettingsAnalysisNotify => 'Notifikasi analisis';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'Terima notifikasi saat analisis selesai';

  @override
  String get appSettingsAutoRefresh => 'Segarkan riwayat otomatis';

  @override
  String get appSettingsAutoRefreshBody =>
      'Perbarui data riwayat secara otomatis';

  @override
  String get appSettingsClearHistory => 'Hapus riwayat analisis';

  @override
  String get appSettingsClearHistoryBody =>
      'Hapus semua data analisis yang tersimpan';

  @override
  String get appSettingsExportAll => 'Ekspor semua data';

  @override
  String get appSettingsExportAllBody =>
      'Ekspor semua data analisis sebagai teks';

  @override
  String get appSettingsClearTitle => 'Hapus riwayat';

  @override
  String get appSettingsClearMessage =>
      'Yakin ingin menghapus semua riwayat analisis? Tindakan ini tidak dapat dibatalkan.';

  @override
  String get appSettingsCleared => 'Riwayat analisis berhasil dihapus';

  @override
  String get appSettingsClearFailed => 'Gagal menghapus riwayat';

  @override
  String get appSettingsNothingToExport =>
      'Tidak ada data analisis untuk diekspor';

  @override
  String get appSettingsExportTitle => 'Ekspor data analisis TrackFollows';

  @override
  String appSettingsExportCreated(String date) {
    return 'Dibuat: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'Analisis $index';
  }

  @override
  String get appSettingsExportDate => 'Tanggal';

  @override
  String get appSettingsExportFailed => 'Gagal mengekspor data';

  @override
  String get settingsTitle => 'Setelan';

  @override
  String get settingsNotificationsSection => 'Notifikasi';

  @override
  String get settingsRecheckTitle => 'Pengingat cek ulang';

  @override
  String get settingsRecheckBody =>
      'Ingatkan untuk cek dengan file baru 2 minggu setelah analisis';

  @override
  String get settingsSupportSection => 'Bantuan dan info hukum';

  @override
  String get settingsFaq => 'Pertanyaan Umum';

  @override
  String get settingsTerms => 'Syarat Penggunaan';

  @override
  String get settingsPrivacy => 'Kebijakan Privasi';

  @override
  String get settingsAdPrivacy => 'Privasi iklan';

  @override
  String get settingsAppInfoSection => 'Info aplikasi';

  @override
  String get settingsAboutTitle => 'Tentang TrackFollows';

  @override
  String get settingsAboutBody =>
      'TrackFollows adalah alat untuk menganalisis data Instagram di perangkatmu. Informasi tentang pengolahan data layanan iklan ada di Kebijakan Privasi.';

  @override
  String settingsVersion(String version, String build) {
    return 'Versi $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. Hak cipta dilindungi.';

  @override
  String get settingsLanguage => 'Bahasa';

  @override
  String get settingsLanguageSystem => 'Ikuti bahasa perangkat';

  @override
  String get settingsOpenLinkFailed => 'Gagal membuka tautan.';

  @override
  String get adConsentNotReady => 'Buka layar ini lagi, lalu coba kembali.';

  @override
  String get adConsentPreparing =>
      'Sedang menyiapkan setelan privasi iklan. Coba lagi sebentar lagi.';

  @override
  String get adConsentNothingToChange =>
      'Saat ini tidak ada setelan privasi iklan yang perlu diubah.';

  @override
  String get adConsentOpenFailed =>
      'Gagal membuka setelan privasi. Coba lagi sebentar lagi.';

  @override
  String get adConsentStatusFailed =>
      'Gagal memeriksa status setelan privasi. Coba lagi sebentar lagi.';

  @override
  String get reminderTitle => 'Saatnya cek unfollow lagi';

  @override
  String get reminderBody =>
      'Sudah 2 minggu sejak analisis terakhir. Analisis dengan file baru untuk tahu siapa yang unfollow kamu sejak itu.';

  @override
  String get reminderChannelName => 'Pengingat cek ulang';

  @override
  String get reminderChannelDescription =>
      'Mengingatkan untuk cek ulang dengan file baru 2 minggu setelah analisis';

  @override
  String get faqTitle => 'Pertanyaan Umum';

  @override
  String get faqIsSafeQuestion => 'Apakah layanan ini aman?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows tidak meminta kata sandi Instagram atau masuk ke akun Anda. File yang dipilih dianalisis di perangkat Anda. Pengolahan data diagnostik penggunaan dan layanan iklan dijelaskan secara terpisah dalam Kebijakan Privasi.';

  @override
  String get faqDownloadTimeQuestion =>
      'Berapa lama waktu yang dibutuhkan untuk mengunduh data saya?';

  @override
  String get faqDownloadTimeAnswer =>
      'Instagram menyiapkan ekspor. Waktu persiapan bervariasi; periksa notifikasi atau layar ekspor dan unduh ZIP saat sudah siap.';

  @override
  String get faqWhatIsUnfollowerQuestion =>
      'Apa itu pengikut tidak timbal balik?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'Akun ini ada dalam daftar yang Anda ikuti, tetapi tidak dalam daftar pengikut di berkas yang Anda berikan. Ini dapat mencakup akun yang tidak pernah mengikuti Anda. Satu ekspor tidak dapat membuktikan apakah seseorang pernah mengikuti Anda atau kapan mereka berhenti.';

  @override
  String get faqThreadsQuestion =>
      'Apakah saya juga bisa melihat unfollower Threads?';

  @override
  String get faqThreadsAnswer =>
      'Ya. Jika ZIP yang Anda unduh dari Instagram berisi daftar pengikut dan diikuti Threads, Anda akan melihat hasil Threads terpisah dari hasil Instagram. Beralih antara Instagram dan Threads di bagian atas hasil. Pengikut Threads adalah daftar terpisah dari pengikut Instagram Anda.';

  @override
  String get faqIsFreeQuestion =>
      'Apakah ada biaya untuk menggunakan layanan ini?';

  @override
  String get faqIsFreeAnswer =>
      'Tidak, layanan ini sepenuhnya gratis. Anda dapat menggunakan semua fitur tanpa biaya.';

  @override
  String get faqIncorrectListQuestion =>
      'Daftar unfollower tampak berbeda dari yang saya harapkan. Mengapa?';

  @override
  String get faqIncorrectListAnswer =>
      'Hasil mencerminkan daftar dalam berkas ekspor dan mungkin berbeda dari Instagram saat ini. Waktu ekspor, rentang tanggal yang dipilih, serta akun yang dihapus atau dinonaktifkan dapat memengaruhi daftar dan jumlahnya.\n\nPilih Sepanjang waktu saat mengekspor dan pastikan semua berkas pengikut serta akun yang Anda ikuti disertakan. Ekspor baru pun tidak menjamin kesesuaian dengan status akun saat ini.';

  @override
  String get faqFileSelectErrorQuestion => 'Saya tidak bisa memilih file ZIP';

  @override
  String get faqFileSelectErrorAnswer =>
      'Saat membuka tautan dari aplikasi pesan seperti KakaoTalk, fitur pemilihan file mungkin tidak berfungsi dengan baik. Dalam hal ini, cobalah mengakses situs langsung melalui browser seperti Chrome atau Samsung Internet untuk memilih file. Biasanya, Anda dapat memilih file secara normal saat mengakses langsung melalui browser.';

  @override
  String get faqDataSecurityQuestion => 'Keamanan Data & Privasi';

  @override
  String get faqDataSecurityAnswer =>
      'File asli Instagram, nama akun, dan daftar pengikutmu tidak dikirim ke server untuk dianalisis. Agar bisa dibandingkan dengan analisis terakhir, username pengikut dan yang diikuti hanya disimpan di perangkat ini (browser atau aplikasi), dan kamu bisa menghapusnya kapan saja lewat \'Hapus riwayat\' di layar hasil. Lihat Kebijakan Privasi untuk pengolahan data diagnostik dan layanan iklan.';
}
