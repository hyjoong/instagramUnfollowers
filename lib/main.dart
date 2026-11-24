import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_service.dart';
import 'webview_service.dart';
import 'file_handler.dart';
import 'screens/settings_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/error_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/analysis_history_screen.dart';
import 'ads/admob_banner.dart';
import 'ads/admob_config.dart';
import 'ads/admob_interstitial.dart';
import 'ads/ad_consent_controller.dart';
import 'reminders/recheck_reminder.dart';
import 'l10n/app_locale.dart';
import 'l10n/gen/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화 (실패해도 앱은 계속 실행)
  try {
    await FirebaseService.initializeFirebase();
  } catch (e) {
    debugPrint('Firebase initialization failed, but app will continue: $e');
  }

  // Resolve the app language before the first frame so the WebView and the
  // native screens start in the same language.
  final prefs = await SharedPreferences.getInstance();
  final localeStore = await AppLocaleStore.load(
    prefs,
    WidgetsBinding.instance.platformDispatcher.locales,
  );

  WidgetsBinding.instance.addObserver(DeviceLocaleObserver(localeStore));

  runApp(MyApp(localeStore: localeStore));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.localeStore});

  final AppLocaleStore localeStore;

  @override
  Widget build(BuildContext context) {
    // Rebuilds with the new language when it changes in settings or on the web.
    return ValueListenableBuilder<Locale>(
      valueListenable: localeStore,
      builder: (context, locale, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => 'TrackFollows',
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEC4899)),
          useMaterial3: true,
        ),
        home: TrackFollowsPage(localeStore: localeStore),
      ),
    );
  }
}

class TrackFollowsPage extends StatefulWidget {
  const TrackFollowsPage({super.key, required this.localeStore});

  final AppLocaleStore localeStore;

  @override
  State<TrackFollowsPage> createState() => _TrackFollowsPageState();
}

class _TrackFollowsPageState extends State<TrackFollowsPage> {
  AppLocalizations get _l10n => AppLocalizations.of(context);

  final _adConfig = AdMobConfig.current;
  final _adConsent = AdConsentController();
  late final _interstitial = AdMobInterstitialController(
    adUnitId: _adConfig.interstitialAdUnitId,
  );
  late final _reminder = RecheckReminderController(
    locale: () => widget.localeStore.value,
  );
  WebViewService? _webViewService;
  FirebaseService? _firebaseService;
  FileHandler? _fileHandler;
  bool _isInitialized = false;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  bool _showOnboarding = false;
  int _currentIndex = 0;
  int _lastHistoryIndex = -1;

  @override
  void initState() {
    super.initState();
    _adConsent.addListener(_syncInterstitialConsent);
    widget.localeStore.addListener(_onLocaleChanged);
    _checkOnboardingStatus();
  }

  // Notification copy is fixed when scheduled; re-schedule it in the new
  // language.
  void _onLocaleChanged() => unawaited(_reminder.onLocaleChanged());

  void _syncInterstitialConsent() {
    _interstitial.updateConsent(_adConfig.isTest || _adConsent.canRequestAds);
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

    if (!mounted) return;
    setState(() {
      _showOnboarding = !onboardingCompleted;
    });

    if (!_showOnboarding) {
      _initializeServices();
    }
  }

  Future<void> _initializeServices() async {
    try {
      _firebaseService = FirebaseService();
      _fileHandler = FileHandler();
      _webViewService = WebViewService();

      await _firebaseService!.initializeMessaging();
      await _webViewService!.initializeWebView(
        onFilePickRequested: _handleFileSelection,
        onResetComplete: _onResetComplete,
        onAnalysisComplete: _onAnalysisComplete,
        localeStore: widget.localeStore,
      );

      if (!mounted) return;
      setState(() {
        _isInitialized = true;
        _isLoading = false;
      });
      if (_adConfig.isTest) _syncInterstitialConsent();
      if (_adConfig.enabled && !_adConfig.isTest) {
        // Present UMP only after onboarding and the app's first visible frame.
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) unawaited(_adConsent.initialize());
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _hasError = true;
        _errorMessage = 'Failed to initialize app: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _handleFileSelection() async {
    try {
      FilePickerResult? result = await _fileHandler!.pickFile();

      if (result != null && result.files.isNotEmpty) {
        String? fileData = _fileHandler!.getFileData(result);
        String? fileName = _fileHandler!.getFileName(result);
        String fileType =
            _fileHandler!.getFileType(result.files.first.extension);

        if (fileData != null && fileName != null) {
          await _webViewService!.setFileInWebView(fileName, fileData, fileType);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_l10n.mainFilePickFailed),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _onResetComplete() {
    // 리셋 완료 시 필요한 로직
  }

  void _onAnalysisComplete() {
    // 분석 탭에서 결과를 받았을 때만 전면 광고 후보 (첫 분석·하루 2회 이상 제외)
    unawaited(_afterAnalysis(onAnalysisTab: _currentIndex == 0));
    // 분석 완료 시 히스토리 화면 갱신
    if (_currentIndex == 1) {
      setState(() {
        // 히스토리 화면을 다시 빌드하여 갱신
      });
    }
  }

  Future<void> _afterAnalysis({required bool onAnalysisTab}) async {
    final adShown = onAnalysisTab &&
        await _interstitial.onAnalysisCompleted(
          beforeShow: _showAdLeadIn,
        );
    await _reminder.onAnalysisCompleted();
    // 광고가 뜬 분석에는 권유를 겹치지 않는다.
    if (adShown || !onAnalysisTab || !mounted) return;
    if (!await _reminder.shouldPrompt() || !mounted) return;
    await _reminder.markPrompted();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 8),
        // 하단 배너 광고를 가리지 않도록 그 위에 띄운다.
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 96),
        content: Text(
          _l10n.mainReminderPrompt,
        ),
        action: SnackBarAction(label: _l10n.mainReminderAction, onPressed: _enableReminder),
      ),
    );
  }

  /// 파일을 고르자마자 광고가 화면을 덮으면 잘못 누르기 쉬워서, 잠깐 알린 뒤 띄운다.
  Future<void> _showAdLeadIn() async {
    if (!mounted) return;
    unawaited(showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 16),
                  Text(_l10n.mainPreparingResults),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
    await Future<void>.delayed(const Duration(milliseconds: 900));
    if (mounted) Navigator.of(context, rootNavigator: true).pop();
  }

  Future<void> _enableReminder() async {
    final enabled = await _reminder.enable();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 96),
        content: Text(
          enabled
              ? _l10n.mainReminderEnabled
              : _l10n.commonNotificationPermissionOff,
        ),
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // 히스토리 탭으로 전환할 때 히스토리 갱신
    if (index == 1 && _lastHistoryIndex != 1) {
      // 히스토리 탭에 처음 들어갈 때 갱신
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshHistoryIfNeeded();
      });
    }
    _lastHistoryIndex = index;
  }

  void _refreshHistoryIfNeeded() {
    // 히스토리 화면이 현재 표시되어 있다면 갱신
    if (_currentIndex == 1) {
      setState(() {
        // 히스토리 화면을 다시 빌드하여 갱신
      });
    }
  }

  void _retryInitialization() {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });
    _initializeServices();
  }

  void _onOnboardingComplete() {
    setState(() {
      _showOnboarding = false;
    });
    _initializeServices();
  }

  @override
  void dispose() {
    _adConsent.removeListener(_syncInterstitialConsent);
    widget.localeStore.removeListener(_onLocaleChanged);
    _interstitial.dispose();
    _adConsent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 온보딩 화면
    if (_showOnboarding) {
      return OnboardingScreen(onComplete: _onOnboardingComplete);
    }

    // 로딩 중
    if (_isLoading) {
      return const LoadingScreen();
    }

    // 에러 발생
    if (_hasError) {
      return ErrorScreen(
        errorMessage: _errorMessage,
        onRetry: _retryInitialization,
      );
    }

    // 초기화되지 않음
    if (!_isInitialized) {
      return const LoadingScreen();
    }

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // 메인 웹뷰 화면
          PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) async {
              if (didPop) return;
              // 웹뷰에서 뒤로갈 수 있는지 확인
              final canGoBack = await _webViewService!.canGoBack();
              if (canGoBack) {
                // 웹뷰에서 뒤로가기
                await _webViewService!.goBack();
              } else {
                final shouldExit = await _showExitDialog();
                if (shouldExit && context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                toolbarHeight: 0,
              ),
              body: Column(children: [
                Expanded(
                  child: WebViewWidget(
                    controller: _webViewService!.controller!,
                  ),
                ),
                if (_adConfig.enabled && _currentIndex == 0)
                  AnimatedBuilder(
                    animation: _adConsent,
                    builder: (context, child) => AdMobBanner(
                      config: _adConfig,
                      canRequestAds:
                          _adConfig.isTest || _adConsent.canRequestAds,
                    ),
                  ),
              ]),
            ),
          ),
          // 히스토리 화면
          AnalysisHistoryScreen(
            key: ValueKey('history_$_currentIndex'),
            // 탭이 보일 때만 광고 카드를 요청한다.
            nativeAdUnitId:
                _currentIndex == 1 ? _adConfig.historyNativeAdUnitId : null,
            adConsent: _adConsent,
            adsAlwaysAllowed: _adConfig.isTest,
          ),
          // 설정 화면
          SettingsScreen(
            reminder: _reminder,
            localeStore: widget.localeStore,
            onLocaleSelected: (locale) =>
                unawaited(_webViewService?.reloadForLocale(locale)),
            adConsent:
                _adConfig.enabled && !_adConfig.isTest ? _adConsent : null,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFEC4899),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.analytics_outlined),
            activeIcon: const Icon(Icons.analytics),
            label: _l10n.navAnalyze,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.history_outlined),
            activeIcon: const Icon(Icons.history),
            label: _l10n.navHistory,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            activeIcon: const Icon(Icons.settings),
            label: _l10n.navSettings,
          ),
        ],
      ),
    );
  }

  Future<bool> _showExitDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(_l10n.mainExitTitle),
            content: Text(_l10n.mainExitMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(_l10n.commonCancel),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(_l10n.mainExitConfirm),
              ),
            ],
          ),
        ) ??
        false;
  }
}
