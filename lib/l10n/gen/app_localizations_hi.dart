// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get commonCancel => 'रद्द करें';

  @override
  String get commonDelete => 'हटाएँ';

  @override
  String get commonRetry => 'फिर कोशिश करें';

  @override
  String get commonUnfollowers => 'अनफॉलोअर्स';

  @override
  String get commonFans => 'फैन्स';

  @override
  String get commonMutual => 'म्यूचुअल';

  @override
  String get commonFollowers => 'फॉलोअर्स';

  @override
  String get commonTotalFollowers => 'कुल फॉलोअर्स';

  @override
  String get commonTotalFollowing => 'कुल फॉलोइंग';

  @override
  String get commonNewFollowers => 'नए फॉलोअर्स';

  @override
  String get commonNotificationPermissionOff =>
      'सूचनाएँ बंद हैं। कृपया डिवाइस सेटिंग में सूचनाओं की अनुमति दें।';

  @override
  String get navAnalyze => 'विश्लेषण';

  @override
  String get navHistory => 'इतिहास';

  @override
  String get navSettings => 'सेटिंग';

  @override
  String get mainFilePickFailed => 'फ़ाइल चुनने में विफल';

  @override
  String get mainPreparingResults => 'विश्लेषण के नतीजे तैयार हो रहे हैं';

  @override
  String get mainReminderPrompt =>
      'किसने आपको अनफॉलो किया, यह अगले विश्लेषण में पता चलेगा। क्या 2 हफ़्ते बाद याद दिलाएँ?';

  @override
  String get mainReminderAction => 'याद दिलाएँ';

  @override
  String get mainReminderEnabled =>
      'हम 2 हफ़्ते बाद याद दिलाएँगे। इसे सेटिंग में बंद किया जा सकता है।';

  @override
  String get mainExitTitle => 'ऐप बंद करें';

  @override
  String get mainExitMessage => 'क्या आप ऐप बंद करना चाहते हैं?';

  @override
  String get mainExitConfirm => 'बंद करें';

  @override
  String get loadingTitle => 'Instagram अनफॉलोअर विश्लेषण';

  @override
  String get loadingMessage => 'लोड हो रहा है...';

  @override
  String get errorTitle => 'कनेक्शन त्रुटि';

  @override
  String get onboardingWelcomeTitle => 'TrackFollows में आपका स्वागत है';

  @override
  String get onboardingWelcomeBody =>
      'अपने Instagram फॉलोअर डेटा का विश्लेषण करें और अनफॉलोअर्स, म्यूचुअल फॉलो और फॉलो की तारीखें देखें।';

  @override
  String get onboardingSafeTitle => '100% सुरक्षित और निजी';

  @override
  String get onboardingSafeBody =>
      'सारा डेटा आपके डिवाइस पर ही प्रोसेस होता है। कोई निजी जानकारी इकट्ठा या सेव नहीं की जाती।';

  @override
  String get onboardingEasyTitle => 'इस्तेमाल में आसान';

  @override
  String get onboardingEasyBody =>
      'बस अपनी Instagram डेटा फ़ाइल अपलोड करें और विश्लेषण के नतीजे तुरंत देखें।';

  @override
  String get onboardingReadyTitle => 'शुरू करने के लिए तैयार';

  @override
  String get onboardingReadyBody =>
      'अपने Instagram फॉलोअर्स का विश्लेषण शुरू करें!';

  @override
  String get onboardingSkip => 'छोड़ें';

  @override
  String get onboardingNext => 'आगे';

  @override
  String get onboardingStart => 'शुरू करें';

  @override
  String get historyTitle => 'विश्लेषण इतिहास';

  @override
  String get historyLowOverlap =>
      'दोनों रिकॉर्ड के फॉलोअर्स लगभग मेल नहीं खाते। कृपया जाँचें कि वे एक ही खाते के हैं।';

  @override
  String get historyDeleteTitle => 'विश्लेषण रिकॉर्ड हटाएँ';

  @override
  String get historyDeleteMessage =>
      'क्या आप यह विश्लेषण रिकॉर्ड हटाना चाहते हैं?';

  @override
  String get historyDeleted => 'विश्लेषण रिकॉर्ड हटा दिया गया';

  @override
  String get historyDeleteFailed => 'हटाने में विफल';

  @override
  String get historyShareSubject => 'Instagram विश्लेषण नतीजा';

  @override
  String get historyShareFooter => 'TrackFollows ऐप से बनाया गया';

  @override
  String get historyCompare => 'दो रिकॉर्ड की तुलना करें';

  @override
  String get historyCompareSelected => 'चुने हुए रिकॉर्ड की तुलना करें';

  @override
  String historyCompareHint(String count) {
    return 'तुलना के लिए दो रिकॉर्ड चुनें ($count/2)';
  }

  @override
  String get historyEmptyTitle => 'कोई विश्लेषण इतिहास नहीं है';

  @override
  String get historyEmptyBody => 'आपके विश्लेषण के नतीजे यहाँ दिखेंगे';

  @override
  String historyExportedOn(String date) {
    return '$date को एक्सपोर्ट किया';
  }

  @override
  String historyCounts(String followers, String following, String unfollowers) {
    return 'फॉलोअर्स $followers · फॉलोइंग $following · अनफॉलोअर्स $unfollowers';
  }

  @override
  String historyAnalyzedOn(String date) {
    return 'विश्लेषण: $date';
  }

  @override
  String get historyViewStats => 'आँकड़े देखें';

  @override
  String get historyShare => 'शेयर करें';

  @override
  String get historyFirstRecord =>
      'पहला रिकॉर्ड · अगले विश्लेषण से बदलाव की तुलना होगी';

  @override
  String get historyNoChange => 'पिछले रिकॉर्ड से फॉलोअर्स में कोई बदलाव नहीं';

  @override
  String get historyVsPrevious => 'पिछले रिकॉर्ड की तुलना में';

  @override
  String historyLostCount(String count) {
    return 'अनफॉलो $count';
  }

  @override
  String historyGainedCount(String count) {
    return 'नए फॉलोअर्स $count';
  }

  @override
  String get statsTitle => 'विश्लेषण नतीजा';

  @override
  String get statsNotFoundTitle => 'विश्लेषण डेटा नहीं मिला';

  @override
  String get statsNotFoundBody => 'डेटा हटा दिया गया है या मौजूद नहीं है';

  @override
  String get statsBack => 'वापस जाएँ';

  @override
  String get statsSummary => 'विश्लेषण सारांश';

  @override
  String get statsNoData => 'कोई विश्लेषण डेटा नहीं है';

  @override
  String get statsDistribution => 'फॉलोअर्स का वितरण';

  @override
  String get statsDetailedStats => 'विस्तृत आँकड़े';

  @override
  String get statsDetails => 'विवरण';

  @override
  String get statsAnalysisDate => 'विश्लेषण की तारीख';

  @override
  String statsMutualRate(String rate) {
    return 'म्यूचुअल दर: $rate%';
  }

  @override
  String get compareTitle => 'रिकॉर्ड की तुलना';

  @override
  String get compareRecentStats => 'सबसे हाल के रिकॉर्ड के आँकड़े';

  @override
  String compareAnalysisDay(String date) {
    return '$date (विश्लेषण का दिन)';
  }

  @override
  String get compareAnalysisDayNote =>
      '(विश्लेषण का दिन) उन पुराने रिकॉर्ड पर लगता है जिनके फ़ाइल नाम में एक्सपोर्ट की तारीख़ नहीं है, इसलिए वहाँ विश्लेषण वाला दिन दिखाया गया है।';

  @override
  String get compareLostTitle => 'जिन्होंने आपको अनफॉलो किया';

  @override
  String get compareLostEmpty => 'इस अवधि में किसी ने आपको अनफॉलो नहीं किया।';

  @override
  String get compareNewEmpty => 'इस अवधि में कोई नया फॉलोअर नहीं है।';

  @override
  String get compareRenamedTitle => 'यूज़रनेम बदलने वाले खाते';

  @override
  String get compareDisappearedNote =>
      'सूची से गायब हुए खातों में कुछ ऐसे भी हो सकते हैं जिन्हें अनफॉलो के बजाय डिएक्टिवेट या डिलीट किया गया है। प्रोफ़ाइल खोलकर जाँचें।';

  @override
  String get compareNoChange => 'कोई बदलाव नहीं';

  @override
  String get compareExportDateNote =>
      'यह तारीख़ वह दिन है जब Instagram से फ़ाइल एक्सपोर्ट की गई थी।';

  @override
  String get compareChange => 'बदलाव';

  @override
  String get compareLost => 'अनफॉलो';

  @override
  String get appSettingsTitle => 'ऐप सेटिंग';

  @override
  String get appSettingsAnalysisSection => 'विश्लेषण सेटिंग';

  @override
  String get appSettingsDataSection => 'डेटा प्रबंधन';

  @override
  String get appSettingsAnalysisNotify => 'विश्लेषण सूचना';

  @override
  String get appSettingsAnalysisNotifyBody =>
      'विश्लेषण पूरा होने पर सूचना मिलेगी';

  @override
  String get appSettingsAutoRefresh => 'इतिहास अपने-आप रीफ़्रेश करें';

  @override
  String get appSettingsAutoRefreshBody =>
      'इतिहास का डेटा अपने-आप अपडेट होता है';

  @override
  String get appSettingsClearHistory => 'विश्लेषण इतिहास हटाएँ';

  @override
  String get appSettingsClearHistoryBody =>
      'सेव किया हुआ सारा विश्लेषण डेटा हट जाएगा';

  @override
  String get appSettingsExportAll => 'सारा डेटा एक्सपोर्ट करें';

  @override
  String get appSettingsExportAllBody =>
      'सारा विश्लेषण डेटा टेक्स्ट के रूप में एक्सपोर्ट होगा';

  @override
  String get appSettingsClearTitle => 'इतिहास हटाएँ';

  @override
  String get appSettingsClearMessage =>
      'क्या आप पूरा विश्लेषण इतिहास हटाना चाहते हैं? इसे वापस नहीं किया जा सकता।';

  @override
  String get appSettingsCleared => 'विश्लेषण इतिहास सफलतापूर्वक हटा दिया गया';

  @override
  String get appSettingsClearFailed => 'इतिहास हटाने में विफल';

  @override
  String get appSettingsNothingToExport =>
      'एक्सपोर्ट करने के लिए कोई विश्लेषण डेटा नहीं है';

  @override
  String get appSettingsExportTitle => 'TrackFollows विश्लेषण डेटा एक्सपोर्ट';

  @override
  String appSettingsExportCreated(String date) {
    return 'बनाया गया: $date';
  }

  @override
  String appSettingsExportItem(String index) {
    return 'विश्लेषण $index';
  }

  @override
  String get appSettingsExportDate => 'तारीख़';

  @override
  String get appSettingsExportFailed => 'डेटा एक्सपोर्ट करने में विफल';

  @override
  String get settingsTitle => 'सेटिंग';

  @override
  String get settingsNotificationsSection => 'सूचनाएँ';

  @override
  String get settingsRecheckTitle => 'दोबारा जाँचने की याद';

  @override
  String get settingsRecheckBody =>
      'विश्लेषण के 2 हफ़्ते बाद नई फ़ाइल से दोबारा जाँचने की याद दिलाएँगे';

  @override
  String get settingsSupportSection => 'सहायता और कानूनी जानकारी';

  @override
  String get settingsFaq => 'अक्सर पूछे जाने वाले प्रश्न';

  @override
  String get settingsTerms => 'उपयोग की शर्तें';

  @override
  String get settingsPrivacy => 'गोपनीयता नीति';

  @override
  String get settingsAdPrivacy => 'विज्ञापन गोपनीयता सेटिंग';

  @override
  String get settingsAppInfoSection => 'ऐप की जानकारी';

  @override
  String get settingsAboutTitle => 'TrackFollows के बारे में';

  @override
  String get settingsAboutBody =>
      'TrackFollows एक टूल है जो आपके Instagram डेटा का विश्लेषण आपके डिवाइस पर करता है। विज्ञापन सेवाओं द्वारा डेटा प्रबंधन की जानकारी गोपनीयता नीति में मिलेगी।';

  @override
  String settingsVersion(String version, String build) {
    return 'वर्ज़न $version ($build)';
  }

  @override
  String get settingsCopyright =>
      '© 2025-2026 TrackFollows. सर्वाधिकार सुरक्षित।';

  @override
  String get settingsLanguage => 'भाषा';

  @override
  String get settingsLanguageSystem => 'डिवाइस की भाषा के अनुसार';

  @override
  String get settingsOpenLinkFailed => 'लिंक नहीं खुल सका।';

  @override
  String get adConsentNotReady => 'कृपया स्क्रीन दोबारा खोलकर फिर कोशिश करें।';

  @override
  String get adConsentPreparing =>
      'विज्ञापन गोपनीयता सेटिंग तैयार हो रही है। कृपया थोड़ी देर बाद फिर कोशिश करें।';

  @override
  String get adConsentNothingToChange =>
      'अभी बदलने के लिए कोई विज्ञापन गोपनीयता सेटिंग नहीं है।';

  @override
  String get adConsentOpenFailed =>
      'गोपनीयता सेटिंग नहीं खुल सकी। कृपया थोड़ी देर बाद फिर कोशिश करें।';

  @override
  String get adConsentStatusFailed =>
      'गोपनीयता सेटिंग की स्थिति जाँची नहीं जा सकी। कृपया थोड़ी देर बाद फिर कोशिश करें।';

  @override
  String get reminderTitle => 'अनफॉलो दोबारा जाँचने का समय';

  @override
  String get reminderBody =>
      'पिछले विश्लेषण को 2 हफ़्ते हो गए हैं। नई फ़ाइल का विश्लेषण करें और जानें कि इस बीच किसने आपको अनफॉलो किया।';

  @override
  String get reminderChannelName => 'दोबारा जाँचने की याद';

  @override
  String get reminderChannelDescription =>
      'विश्लेषण के 2 हफ़्ते बाद नई फ़ाइल से दोबारा जाँचने की याद दिलाता है';

  @override
  String get faqTitle => 'अक्सर पूछे जाने वाले प्रश्न';

  @override
  String get faqIsSafeQuestion => 'क्या यह सेवा सुरक्षित है?';

  @override
  String get faqIsSafeAnswer =>
      'TrackFollows आपका Instagram पासवर्ड नहीं माँगता और आपके खाते में लॉगिन नहीं करता। चुनी गई फ़ाइलों का विश्लेषण आपके डिवाइस पर होता है। उपयोग और त्रुटि निदान तथा विज्ञापन सेवाओं के डेटा प्रबंधन की जानकारी गोपनीयता नीति में अलग से दी गई है।';

  @override
  String get faqDownloadTimeQuestion =>
      'मेरा डेटा डाउनलोड होने में कितना समय लगता है?';

  @override
  String get faqDownloadTimeAnswer =>
      'एक्सपोर्ट Instagram तैयार करता है। इसमें लगने वाला समय अलग-अलग हो सकता है। सूचना या एक्सपोर्ट स्क्रीन देखें और तैयार होने पर ZIP डाउनलोड करें।';

  @override
  String get faqWhatIsUnfollowerQuestion => 'अनफॉलोअर वास्तव में क्या है?';

  @override
  String get faqWhatIsUnfollowerAnswer =>
      'ये वे खाते हैं जो दी गई फ़ाइलों की फ़ॉलोइंग सूची में हैं, लेकिन आपकी फ़ॉलोअर सूची में नहीं हैं। इनमें ऐसे खाते भी हो सकते हैं जिन्होंने आपको कभी फ़ॉलो नहीं किया। एक एक्सपोर्ट से यह साबित नहीं होता कि किसी ने आपको पहले फ़ॉलो किया था या कब अनफ़ॉलो किया।';

  @override
  String get faqThreadsQuestion =>
      'क्या Threads पर अनफॉलो करने वालों को भी देखा जा सकता है?';

  @override
  String get faqThreadsAnswer =>
      'हाँ। अगर Instagram से डाउनलोड की गई ZIP में आपकी Threads फ़ॉलोअर और फ़ॉलोइंग सूचियाँ हैं, तो Instagram से अलग Threads का परिणाम दिखाया जाता है। परिणामों के ऊपर Instagram और Threads के बीच स्विच करें। Threads फ़ॉलोअर आपकी Instagram फ़ॉलोअर सूची से अलग सूची है।';

  @override
  String get faqIsFreeQuestion =>
      'क्या इस सेवा का उपयोग करने के लिए कोई शुल्क लगता है?';

  @override
  String get faqIsFreeAnswer =>
      'नहीं, यह सेवा पूरी तरह से नि:शुल्क है। आप सभी सुविधाओं का उपयोग बिना किसी लागत के कर सकते हैं।';

  @override
  String get faqIncorrectListQuestion =>
      'अनफॉलोअर सूची मेरी अपेक्षा से अलग दिखाई दे रही है। क्यों?';

  @override
  String get faqIncorrectListAnswer =>
      'नतीजे एक्सपोर्ट फ़ाइलों की सूचियों पर आधारित हैं और मौजूदा Instagram से अलग हो सकते हैं। एक्सपोर्ट का समय, चुनी गई अवधि और हटाए गए या निष्क्रिय खाते सूचियों और गिनती को प्रभावित कर सकते हैं।\n\nएक्सपोर्ट करते समय पूरी अवधि चुनें और जाँचें कि फ़ॉलोअर व फ़ॉलोइंग की सभी फ़ाइलें शामिल हैं। नया एक्सपोर्ट भी खातों की मौजूदा स्थिति से मेल खाने की गारंटी नहीं देता।';

  @override
  String get faqFileSelectErrorQuestion =>
      'मैं ZIP फ़ाइल का चयन नहीं कर पा रहा हूँ';

  @override
  String get faqFileSelectErrorAnswer =>
      'जब आप KakaoTalk जैसे मैसेजिंग ऐप्स से लिंक खोलते हैं, तो फ़ाइल चयन सुविधा ठीक से काम नहीं कर सकती है। इस स्थिति में, फ़ाइल चुनने के लिए Chrome या Samsung इंटरनेट जैसे ब्राउज़र के माध्यम से सीधे साइट पर जाने का प्रयास करें। आमतौर पर, आप ब्राउज़र के माध्यम से सीधे एक्सेस करते समय सामान्य रूप से फ़ाइलें चुन सकते हैं।';

  @override
  String get faqDataSecurityQuestion => 'डेटा सुरक्षा और गोपनीयता';

  @override
  String get faqDataSecurityAnswer =>
      'विश्लेषण के लिए आपकी मूल Instagram फ़ाइलें, अकाउंट नाम और फ़ॉलोअर सूचियाँ किसी सर्वर पर नहीं भेजी जातीं। पिछले विश्लेषण से तुलना के लिए फ़ॉलोअर और फ़ॉलोइंग के यूज़रनेम सिर्फ़ इसी डिवाइस (ब्राउज़र या ऐप) में सेव होते हैं, और आप नतीजों की स्क्रीन पर \'इतिहास हटाएँ\' से इन्हें कभी भी हटा सकते हैं। उपयोग व त्रुटि जाँच और विज्ञापन सेवाओं के डेटा के बारे में गोपनीयता नीति देखें।';
}
