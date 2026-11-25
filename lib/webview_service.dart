import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:file_picker/file_picker.dart';
import 'file_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'ads/admob_config.dart';
import 'l10n/app_locale.dart';

class WebViewService {
  /// Web origin; development builds point it elsewhere with
  /// `--dart-define=TRACKFOLLOWS_URL=...`. The language path goes after it.
  static const webOrigin = String.fromEnvironment(
    'TRACKFOLLOWS_URL',
    defaultValue: 'https://trackfollows.com',
  );

  WebViewController? controller;
  AppLocaleStore? _localeStore;
  final FileHandler fileHandler = FileHandler();
  late FlutterLocalNotificationsPlugin notificationsPlugin;
  final bool _isWebViewReady = false;
  Function()? onFilePickRequested;
  Function()? onResetComplete;
  Function()? onAnalysisComplete;

  Future<void> initializeWebView({
    Function()? onFilePickRequested,
    Function()? onResetComplete,
    Function()? onAnalysisComplete,
    AppLocaleStore? localeStore,
  }) async {
    _localeStore = localeStore;
    this.onFilePickRequested = onFilePickRequested;
    this.onResetComplete = onResetComplete;
    this.onAnalysisComplete = onAnalysisComplete;

    // 로컬 알림 플러그인 초기화
    _initializeNotifications();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // 로딩 진행률 업데이트
          },
          onPageStarted: (String url) {
            // 페이지 로딩 시작
          },
          // The web switches language with client-side navigation
          // (pushState), which does not fire onPageFinished.
          onUrlChange: (UrlChange change) {
            final url = change.url;
            if (url != null) _rememberWebLocale(url);
          },
          onPageFinished: (String url) async {
            _rememberWebLocale(url);
            // 페이지 로딩 완료 후 Flutter 식별자 재설정
            await controller?.runJavaScript('''
              if (!window.isFlutterWebView) {
                window.isFlutterWebView = true;
                window.flutterApp = true;
                console.log('Flutter WebView re-initialized');
              }
              window.sendToFlutter = function(data) {
                if (window.Flutter) {
                  window.Flutter.postMessage(JSON.stringify(data));
                }
              };
              window.notifyFlutterAnalysisComplete = function(analysisData) {
                window.sendToFlutter({
                  type: 'detailed_analysis_complete',
                  data: analysisData
                });
              };
            ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Android에서만 인스타그램 링크를 Chrome Custom Tab으로 열기
            if (Platform.isAndroid &&
                request.url.contains('instagram.com/') &&
                !request.url.contains('trackfollows.com')) {
              launchUrl(Uri.parse(request.url),
                  mode: LaunchMode.inAppBrowserView);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Flutter',
        onMessageReceived: (JavaScriptMessage message) {
          _handleJavaScriptMessage(message.message);
        },
      )
      ..addJavaScriptChannel(
        'unfollowerNotification',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint(
              'Received message from unfollowerNotification channel: ${message.message}');
          _handleUnfollowerNotification(message.message);
        },
      )
      ..addJavaScriptChannel(
        'FilePicker',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('File picker requested');
          onFilePickRequested?.call();
        },
      )
      ..addJavaScriptChannel(
        'ResetComplete',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('Reset complete');
          onResetComplete?.call();
        },
      );

    // Web ad components can suppress placements before the SDK renders them.
    // Keep web placements hidden even if native consent is denied or no ad
    // fills. Falling back to AdFit would bypass the native consent decision.
    if (AdMobConfig.current.enabled) {
      final userAgent = await controller!.getUserAgent() ?? '';
      await controller!.setUserAgent(
        '$userAgent ${AdMobConfig.nativeAdsUserAgent}'.trim(),
      );
    }

    await controller!.loadRequest(
      Uri.parse(webUrlFor(webOrigin, localeStore?.value ?? fallbackLocale)),
    );

    // Android에서 <input type="file"> 지원
    if (Platform.isAndroid) {
      final androidController =
          controller!.platform as AndroidWebViewController;
      androidController
          .setOnShowFileSelector((FileSelectorParams params) async {
        // 웹의 accept(.zip,.json,.html)를 따라 선택 창을 거릅니다.
        // 필터가 없으면 사진·PDF까지 보여서 잘못된 파일 업로드가 잦았습니다(iOS는 accept를 따름).
        final extensions = allowedExtensionsFromAccept(params.acceptTypes);
        final allowMultiple = params.mode == FileSelectorMode.openMultiple;
        FilePickerResult? result;
        try {
          result = extensions.isEmpty
              ? await FilePicker.platform
                  .pickFiles(allowMultiple: allowMultiple)
              : await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: extensions,
                  allowMultiple: allowMultiple,
                );
        } catch (_) {
          // 일부 기기에서 확장자 필터가 실패하면 예전처럼 전체 파일을 보여 줍니다.
          result =
              await FilePicker.platform.pickFiles(allowMultiple: allowMultiple);
        }
        if (result == null) return [];
        return result.files
            .where((file) => file.path != null)
            .map((file) => Uri.file(file.path!).toString())
            .toList();
      });
    }

    // iOS에서 미디어 재생 설정
    if (Platform.isIOS) {
      // iOS에서는 별도 설정이 필요하지 않음
    }
  }

  /// `<input accept>` 값(".zip", "application/json" 등)을 파일 선택 창 확장자 목록으로 바꿉니다.
  /// 알 수 없는 값만 있으면 빈 목록을 돌려 전체 파일을 보여 줍니다.
  static List<String> allowedExtensionsFromAccept(List<String> acceptTypes) {
    const mimeToExtension = {
      'application/zip': 'zip',
      'application/x-zip-compressed': 'zip',
      'application/json': 'json',
      'text/html': 'html',
    };
    final result = <String>{};
    for (final raw in acceptTypes.expand((value) => value.split(','))) {
      final type = raw.trim().toLowerCase();
      if (type.isEmpty) continue;
      if (type.startsWith('.')) {
        final ext = type.substring(1);
        if (RegExp(r'^[a-z0-9]{1,10}$').hasMatch(ext)) result.add(ext);
      } else if (mimeToExtension.containsKey(type)) {
        result.add(mimeToExtension[type]!);
      }
    }
    return result.toList();
  }

  /// When the user switches language on the web (another `/{locale}` path on
  /// our origin), keep that choice for the next launch and the native screens.
  void _rememberWebLocale(String url) {
    final store = _localeStore;
    final uri = Uri.tryParse(url);
    if (store == null || uri == null) return;
    if (uri.host != Uri.parse(webOrigin).host) return;
    final webLocale = localeFromWebUrl(url);
    if (webLocale != store.value) unawaited(store.select(webLocale));
  }

  /// Reopens the web app in [locale] unless the page is already in it (a
  /// switch made on the web itself leaves the page where it is).
  Future<void> showLocale(Locale locale) async {
    final current = await controller?.currentUrl();
    final uri = current == null ? null : Uri.tryParse(current);
    if (uri != null &&
        uri.host == Uri.parse(webOrigin).host &&
        localeFromWebUrl(current!) == locale) {
      return;
    }
    await controller?.loadRequest(Uri.parse(webUrlFor(webOrigin, locale)));
  }

  void _initializeNotifications() {
    try {
      notificationsPlugin = FlutterLocalNotificationsPlugin();

      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          // 알림 탭 시 처리
          debugPrint('Notification tapped: ${response.payload}');
        },
      );
    } catch (e) {
      debugPrint('Failed to initialize notifications: $e');
    }
  }

  void _handleJavaScriptMessage(String message) {
    try {
      final data = Map<String, dynamic>.from(
          jsonDecode(message) as Map<String, dynamic>);

      // 분석은 앱을 보고 있는 동안 바로 끝나므로 완료 알림은 띄우지 않는다.
      if (data['type'] == 'detailed_analysis_complete') {
        _saveDetailedAnalysisToHistory(data['data']);
      }
    } catch (e) {
      debugPrint('Failed to handle JavaScript message: $e');
    }
  }

  void _handleUnfollowerNotification(String message) {
    try {
      final data = Map<String, dynamic>.from(
          jsonDecode(message) as Map<String, dynamic>);

      // 분석은 앱을 보고 있는 동안 바로 끝나므로 완료 알림은 띄우지 않는다.
      if (data['type'] == 'detailed_analysis_complete') {
        _saveDetailedAnalysisToHistory(data['data']);
      }
    } catch (e) {
      debugPrint('Failed to handle unfollower notification: $e');
    }
  }

  void _saveDetailedAnalysisToHistory(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      const historyKey = 'analysis_history';

      // 기존 히스토리 가져오기
      final existingHistoryJson = prefs.getStringList(historyKey) ?? [];
      final existingHistory = existingHistoryJson
          .map((json) => Map<String, dynamic>.from(jsonDecode(json)))
          .toList();

      // 새로운 분석 결과 생성
      final newAnalysis = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'timestamp': data['timestamp'] ?? DateTime.now().toIso8601String(),
        'unfollowersCount': data['unfollowersCount'] ?? 0,
        'fansCount': data['fansCount'] ?? 0,
        'mutualCount': data['mutualCount'] ?? 0,
        'totalFollowers': data['totalFollowers'] ?? 0,
        'totalFollowing': data['totalFollowing'] ?? 0,
        'unfollowers': data['unfollowers'] ?? [],
        'fans': data['fans'] ?? [],
        'mutualFollows': data['mutualFollows'] ?? [],
        // 웹이 파일 이름에서 읽은 내보낸 날(YYYY-MM-DD). 히스토리 비교 순서에 씁니다.
        if (data['exportDate'] is String) 'exportDate': data['exportDate'],
      };

      // 새 분석을 맨 앞에 추가
      existingHistory.insert(0, newAnalysis);

      // 최대 50개까지만 유지
      if (existingHistory.length > 50) {
        existingHistory.removeRange(50, existingHistory.length);
      }

      // JSON으로 변환하여 저장
      final historyJson =
          existingHistory.map((item) => jsonEncode(item)).toList();

      await prefs.setStringList(historyKey, historyJson);

      debugPrint('Analysis history saved successfully');

      // 분석 완료 콜백 호출
      onAnalysisComplete?.call();
    } catch (e) {
      debugPrint('Failed to save analysis history: $e');
    }
  }

  Future<bool> canGoBack() async {
    try {
      return await controller?.canGoBack() ?? false;
    } catch (e) {
      debugPrint('Failed to check if can go back: $e');
      return false;
    }
  }

  Future<void> goBack() async {
    try {
      await controller?.goBack();
    } catch (e) {
      debugPrint('Failed to go back: $e');
    }
  }

  Future<bool> setFileInWebView(
      String fileName, String fileData, String fileType) async {
    try {
      if (!_isWebViewReady) {
        debugPrint('WebView is not ready yet');
        return false;
      }

      await controller?.runJavaScript('''
        // 파일 데이터를 웹뷰에 전달
        if (window.setFileData) {
          window.setFileData('$fileName', '$fileData', '$fileType');
        } else {
          console.log('setFileData function not found');
        }
      ''');
      return true;
    } catch (e) {
      debugPrint('Failed to set file in WebView: $e');
      return false;
    }
  }
}
