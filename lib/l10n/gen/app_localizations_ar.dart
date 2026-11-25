// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get commonCancel => 'إلغاء';

  @override
  String get commonDelete => 'حذف';

  @override
  String get commonRetry => 'إعادة المحاولة';

  @override
  String get commonUnfollowers => 'غير المتابعين بالمقابل';

  @override
  String get commonFans => 'المعجبون';

  @override
  String get commonMutual => 'متابعة متبادلة';

  @override
  String get commonFollowers => 'المتابِعون';

  @override
  String get commonTotalFollowers => 'إجمالي المتابِعين';

  @override
  String get commonTotalFollowing => 'إجمالي المتابَعين';

  @override
  String get commonNewFollowers => 'متابعون جدد';

  @override
  String get commonNotificationPermissionOff =>
      'إذن الإشعارات متوقف. يرجى السماح بالإشعارات من إعدادات الجهاز.';

  @override
  String get navAnalyze => 'تحليل';

  @override
  String get navHistory => 'السجل';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get mainFilePickFailed => 'فشل اختيار الملف';

  @override
  String get mainPreparingResults => 'نجهّز نتائج التحليل';

  @override
  String get mainReminderPrompt =>
      'ستعرف من ألغى متابعتك في التحليل القادم. هل نذكّرك بعد أسبوعين؟';

  @override
  String get mainReminderAction => 'تفعيل التذكير';

  @override
  String get mainReminderEnabled =>
      'سنذكّرك بعد أسبوعين. يمكنك إيقافه من الإعدادات.';

  @override
  String get mainExitTitle => 'إغلاق التطبيق';

  @override
  String get mainExitMessage => 'هل تريد إغلاق التطبيق؟';

  @override
  String get mainExitConfirm => 'إغلاق';

  @override
  String get loadingTitle => 'تحليل متابعي Instagram';

  @override
  String get loadingMessage => 'جارٍ التحميل...';

  @override
  String get errorTitle => 'خطأ في الاتصال';

  @override
  String get onboardingWelcomeTitle => 'مرحبًا بك في TrackFollows';

  @override
  String get onboardingWelcomeBody =>
      'حلّل بيانات متابعيك على Instagram لمعرفة غير المتابعين بالمقابل وحالة المتابعة المتبادلة وتواريخ المتابعة.';

  @override
  String get onboardingSafeTitle => 'آمن 100% ويحمي خصوصيتك';

  @override
  String get onboardingSafeBody =>
      'تتم معالجة جميع البيانات على جهازك. لا نجمع بياناتك الشخصية ولا نخزّنها.';

  @override
  String get onboardingEasyTitle => 'سهل الاستخدام';

  @override
  String get onboardingEasyBody =>
      'ما عليك سوى تحميل ملف بيانات Instagram لترى نتائج التحليل فورًا.';

  @override
  String get onboardingReadyTitle => 'أنت جاهز للبدء';

  @override
  String get onboardingReadyBody => 'ابدأ تحليل متابعيك على Instagram!';

  @override
  String get onboardingSkip => 'تخطّي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingStart => 'ابدأ';

  @override
  String get historyTitle => 'سجل التحليلات';

  @override
  String get historyLowOverlap =>
      'يكاد لا يوجد تشابه بين متابعي السجلين. تأكد من أنهما للحساب نفسه.';

  @override
  String get historyDeleteTitle => 'حذف سجل التحليل';

  @override
  String get historyDeleteMessage => 'هل تريد حذف سجل التحليل هذا؟';

  @override
  String get historyDeleted => 'تم حذف سجل التحليل';

  @override
  String get historyDeleteFailed => 'فشل الحذف';

  @override
  String get historyShareSubject => 'نتيجة تحليل Instagram';

  @override
  String get historyShareFooter => 'تم الإنشاء بواسطة تطبيق TrackFollows';

  @override
  String get historyCompare => 'مقارنة سجلين';

  @override
  String get historyCompareSelected => 'قارن السجلين المحددين';

  @override
  String historyCompareHint(String count) {
    return 'اختر سجلين للمقارنة ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'لا يوجد سجل تحليلات';

  @override
  String get historyEmptyBody => 'ستظهر نتائج التحليل هنا';

  @override
  String historyExportedOn(String date) {
    return 'تم التصدير في $date';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'المتابِعون $followers · المتابَعون $following · غير المتابعين بالمقابل $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'التحليل: $date';
  }

  @override
  String get historyViewStats => 'عرض الإحصاءات';

  @override
  String get historyShare => 'مشاركة';

  @override
  String get historyFirstRecord =>
      'أول سجل · نقارن التغييرات بدءًا من التحليل القادم';

  @override
  String get historyNoChange => 'لا تغيّر في المتابعين عن السجل السابق';

  @override
  String get historyVsPrevious => 'مقارنة بالسجل السابق';

  @override
  String historyLostCount(String count) {
    return 'ألغوا المتابعة $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'متابعون جدد $count';
  }

  @override
  String get statsTitle => 'نتيجة التحليل';

  @override
  String get statsNotFoundTitle => 'تعذر العثور على بيانات التحليل';

  @override
  String get statsNotFoundBody => 'البيانات محذوفة أو غير موجودة';

  @override
  String get statsBack => 'رجوع';

  @override
  String get statsSummary => 'ملخص التحليل';

  @override
  String get statsNoData => 'لا توجد بيانات تحليل';

  @override
  String get statsDistribution => 'توزيع المتابِعين';

  @override
  String get statsDetailedStats => 'إحصاءات مفصلة';

  @override
  String get statsDetails => 'التفاصيل';

  @override
  String get statsAnalysisDate => 'تاريخ التحليل';

  @override
  String statsMutualRate(String rate) {
    return 'نسبة المتابعة المتبادلة: $rate%';
  }

  @override
  String get compareTitle => 'مقارنة السجلات';

  @override
  String get compareRecentStats => 'إحصاءات أحدث سجل';

  @override
  String compareAnalysisDay(String date) {
    return '$date (يوم التحليل)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(يوم التحليل) يعني سجلًا قديمًا لا يحتوي اسم ملفه على تاريخ التصدير، فعرضنا يوم التحليل بدلًا منه.';

  @override
  String get compareLostTitle => 'من ألغى متابعتك';

  @override
  String get compareLostEmpty => 'لم يلغِ أحد متابعتك خلال هذه الفترة.';

  @override
  String get compareNewEmpty => 'لا يوجد متابعون جدد خلال هذه الفترة.';

  @override
  String get compareRenamedTitle => 'حسابات غيّرت اسم المستخدم';

  @override
  String get compareDisappearedNote =>
      'قد يكون بعض الحسابات التي اختفت من القائمة قد عطّل حسابه أو حذفه بدل إلغاء المتابعة. افتح الملف الشخصي للتأكد.';

  @override
  String get compareNoChange => 'لا تغيير';

  @override
  String get compareExportDateNote =>
      'التاريخ هو يوم تصدير الملف من Instagram.';

  @override
  String get compareChange => 'التغيّر';

  @override
  String get compareLost => 'ألغوا المتابعة';

  @override
  String get appSettingsTitle => 'إعدادات التطبيق';

  @override
  String get appSettingsAnalysisSection => 'إعدادات التحليل';

  @override
  String get appSettingsDataSection => 'إدارة البيانات';

  @override
  String get appSettingsAnalysisNotify => 'إشعارات التحليل';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'تلقَّ إشعارًا عند اكتمال التحليل';

  @override
  String get appSettingsAutoRefresh => 'تحديث السجل تلقائيًا';

  @override
  String get appSettingsAutoRefreshBody => 'تحديث بيانات السجل تلقائيًا';

  @override
  String get appSettingsClearHistory => 'حذف سجل التحليلات';

  @override
  String get appSettingsClearHistoryBody => 'حذف جميع بيانات التحليل المحفوظة';

  @override
  String get appSettingsExportAll => 'تصدير كل البيانات';

  @override
  String get appSettingsExportAllBody => 'تصدير جميع بيانات التحليل كنص';

  @override
  String get appSettingsClearTitle => 'حذف السجل';

  @override
  String get appSettingsClearMessage =>
      'هل تريد حذف كل سجل التحليلات؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get appSettingsCleared => 'تم حذف سجل التحليلات بنجاح';

  @override
  String get appSettingsClearFailed => 'فشل حذف السجل';

  @override
  String get appSettingsNothingToExport => 'لا توجد بيانات تحليل للتصدير';

  @override
  String get appSettingsExportTitle => 'تصدير بيانات تحليل TrackFollows';

  @override
  String appSettingsExportCreated(String date) {
    return 'تاريخ الإنشاء: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'التحليل $index';
  }

  @override
  String get appSettingsExportDate => 'التاريخ';

  @override
  String get appSettingsExportFailed => 'فشل تصدير البيانات';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsNotificationsSection => 'الإشعارات';

  @override
  String get settingsRecheckTitle => 'تذكير بإعادة التحقق';

  @override
  String get settingsRecheckBody =>
      'نذكّرك بعد أسبوعين من التحليل لتتحقق بملف جديد';

  @override
  String get settingsSupportSection => 'الدعم والمعلومات القانونية';

  @override
  String get settingsFaq => 'الأسئلة الشائعة';

  @override
  String get settingsTerms => 'شروط الخدمة';

  @override
  String get settingsPrivacy => 'سياسة الخصوصية';

  @override
  String get settingsAdPrivacy => 'إعدادات خصوصية الإعلانات';

  @override
  String get settingsAppInfoSection => 'معلومات التطبيق';

  @override
  String get settingsAboutTitle => 'عن TrackFollows';

  @override
  String get settingsAboutBody =>
      'TrackFollows أداة تحلّل بيانات Instagram على جهازك. يمكنك الاطلاع على كيفية معالجة خدمات الإعلانات للمعلومات في سياسة الخصوصية.';

  @override
  String settingsVersion(String version, String build) {
    return 'الإصدار $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. جميع الحقوق محفوظة.';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsLanguageSystem => 'اتباع لغة الجهاز';

  @override
  String get settingsOpenLinkFailed => 'تعذّر فتح الرابط.';

  @override
  String get adConsentNotReady => 'أعد فتح الشاشة ثم حاول مرة أخرى.';

  @override
  String get adConsentPreparing =>
      'نجهّز إعدادات خصوصية الإعلانات. حاول مرة أخرى بعد قليل.';

  @override
  String get adConsentNothingToChange =>
      'لا توجد حاليًا إعدادات خصوصية إعلانات لتغييرها.';

  @override
  String get adConsentOpenFailed =>
      'تعذّر فتح إعدادات الخصوصية. حاول مرة أخرى بعد قليل.';

  @override
  String get adConsentStatusFailed =>
      'تعذّر التحقق من حالة إعدادات الخصوصية. حاول مرة أخرى بعد قليل.';

  @override
  String get reminderTitle => 'حان وقت التحقق من إلغاء المتابعة';

  @override
  String get reminderBody =>
      'مرّ أسبوعان على آخر تحليل. حلّل ملفًا جديدًا لتعرف من ألغى متابعتك خلال هذه الفترة.';

  @override
  String get reminderChannelName => 'تذكير بإعادة التحقق';

  @override
  String get reminderChannelDescription =>
      'نذكّرك بعد أسبوعين من التحليل لتتحقق مجددًا بملف جديد';

  @override
  String get faqTitle => 'الأسئلة الشائعة';

  @override
  String get faqIsSafeQuestion => 'هل هذه الخدمة آمنة؟';

  @override
  String get faqIsSafeAnswer =>
      'لا يطلب TrackFollows كلمة مرور Instagram ولا يسجّل الدخول إلى حسابك. تُحلّل الملفات المحددة على جهازك. توضّح سياسة الخصوصية بشكل منفصل معالجة بيانات تشخيص الاستخدام والخدمات الإعلانية.';

  @override
  String get faqDownloadTimeQuestion => 'كم من الوقت يستغرق تنزيل بياناتي؟';

  @override
  String get faqDownloadTimeAnswer =>
      'يُعدّ Instagram ملف التصدير. يختلف وقت التجهيز؛ تحقق من الإشعار أو شاشة التصدير ونزّل ملف ZIP عندما يصبح جاهزاً.';

  @override
  String get faqWhatIsUnfollowerQuestion =>
      'ما هو المتابع غير المتبادل بالضبط؟';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'هي حسابات تظهر في قائمة الحسابات التي تتابعها ولا تظهر في قائمة متابعيك ضمن الملفات التي تقدمها. قد تشمل حسابات لم تتابعك من قبل. لا يثبت تصدير واحد أن شخصاً كان يتابعك سابقاً أو متى ألغى متابعتك.';

  @override
  String get faqThreadsQuestion =>
      'هل يمكنني أيضًا معرفة من ألغى متابعتي على Threads؟';

  @override
  String get faqThreadsAnswer =>
      'نعم. إذا كان ملف ZIP الذي نزّلته من Instagram يتضمن قائمتي المتابعين والمتابَعين في Threads، فستظهر لك نتيجة Threads منفصلة عن نتيجة Instagram. يمكنك التبديل بين Instagram وThreads أعلى صفحة النتائج. متابعو Threads قائمة منفصلة عن متابعيك على Instagram.';

  @override
  String get faqIsFreeQuestion => 'هل هناك رسوم لاستخدام هذه الخدمة؟';

  @override
  String get faqIsFreeAnswer =>
      'لا، هذه الخدمة مجانية بالكامل. يمكنك استخدام جميع الميزات مجاناً.';

  @override
  String get faqIncorrectListQuestion =>
      'قائمة المتابعين غير المتبادلين تظهر بشكل مختلف عما هو متوقع. لماذا؟';

  @override
  String get faqIncorrectListAnswer =>
      'تعكس النتائج القوائم الموجودة في ملفات التصدير وقد تختلف عن الحالة الحالية في Instagram. قد يؤثر وقت التصدير والفترة المحددة والحسابات المحذوفة أو المعطّلة في القوائم والأعداد.\n\nاختر كل الوقت عند التصدير وتحقق من تضمين جميع ملفات المتابعين والحسابات التي تتابعها. حتى التصدير الجديد لا يضمن مطابقة الحالة الحالية للحسابات.';

  @override
  String get faqFileSelectErrorQuestion => 'لا يمكنني تحديد ملف ZIP';

  @override
  String get faqFileSelectErrorAnswer =>
      'عند فتح الروابط من تطبيقات المراسلة مثل KakaoTalk، قد لا تعمل ميزة تحديد الملفات بشكل صحيح. في هذه الحالة، حاول الوصول إلى الموقع مباشرة من خلال متصفحات مثل Chrome أو Samsung Internet لتحديد الملف. عادةً، يمكنك تحديد الملفات بشكل طبيعي عند الوصول مباشرة من خلال متصفح.';

  @override
  String get faqDataSecurityQuestion => 'أمان البيانات والخصوصية';

  @override
  String get faqDataSecurityAnswer =>
      'لا يتم إرسال ملفات Instagram الأصلية أو أسماء الحسابات أو قوائم المتابعين إلى أي خادم للتحليل. للمقارنة مع تحليلك السابق، تُحفظ أسماء مستخدمي المتابعين والمتابَعين على هذا الجهاز فقط (المتصفح أو التطبيق)، ويمكنك حذفها في أي وقت عبر «حذف السجل» في شاشة النتائج. راجع سياسة الخصوصية لمعرفة كيفية معالجة بيانات التشخيص وخدمات الإعلانات.';
}
