import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'firebase_service.dart';
import 'webview_service.dart';
import 'file_handler.dart';
import 'screens/settings_screen.dart';
import 'screens/loading_screen.dart';
import 'screens/error_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/analysis_history_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화 (실패해도 앱은 계속 실행)
  try {
    await FirebaseService.initializeFirebase();
  } catch (e) {
    print('Firebase initialization failed, but app will continue: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFEC4899)),
        useMaterial3: true,
      ),
      home: const TrackFollowsPage(),
    );
  }
}

class TrackFollowsPage extends StatefulWidget {
  const TrackFollowsPage({super.key});

  @override
  State<TrackFollowsPage> createState() => _TrackFollowsPageState();
}

class _TrackFollowsPageState extends State<TrackFollowsPage> {
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
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final onboardingCompleted = prefs.getBool('onboarding_completed') ?? false;

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
      await _requestPermissions();
      _webViewService!.initializeWebView(
        onFilePickRequested: _handleFileSelection,
        onResetComplete: _onResetComplete,
        onAnalysisComplete: _onAnalysisComplete,
      );

      setState(() {
        _isInitialized = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = 'Failed to initialize app: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await Permission.storage.request();
      await Permission.mediaLibrary.request();
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
          await _webViewService!
              .setFileInWebView(fileName, fileData, fileType);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('파일 선택에 실패했습니다'),
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
    // 분석 완료 시 히스토리 화면 갱신
    if (_currentIndex == 1) {
      setState(() {
        // 히스토리 화면을 다시 빌드하여 갱신
      });
    }
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
              body: WebViewWidget(
                controller: _webViewService!.controller!,
              ),
            ),
          ),
          // 히스토리 화면
          AnalysisHistoryScreen(key: ValueKey('history_$_currentIndex')),
          // 설정 화면
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFEC4899),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: '분석',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: '히스토리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
      ),
    );
  }

  Future<bool> _showExitDialog() async {
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('앱 종료'),
            content: const Text('앱을 종료하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('종료'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
