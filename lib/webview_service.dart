import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'file_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class WebViewService {
  WebViewController? controller;
  final FileHandler fileHandler = FileHandler();
  late FlutterLocalNotificationsPlugin notificationsPlugin;
  bool _isWebViewReady = false;
  Function()? onFilePickRequested;
  Function()? onResetComplete;
  Function()? onAnalysisComplete;

  void initializeWebView({
    Function()? onFilePickRequested,
    Function()? onResetComplete,
    Function()? onAnalysisComplete,
  }) async {
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
          onPageFinished: (String url) async {
            _isWebViewReady = true;
            // 페이지 로딩 완료 후 Flutter 식별자 재설정
            await controller?.runJavaScript('''
              if (!window.isFlutterWebView) {
                window.isFlutterWebView = true;
                window.flutterApp = true;
                console.log('Flutter WebView re-initialized');
              }
            ''');
          },
          onWebResourceError: (WebResourceError error) {
            print('WebView error: ${error.description}');
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
          print(
              'Received message from unfollowerNotification channel: ${message.message}');
          _handleUnfollowerNotification(message.message);
        },
      )
      ..addJavaScriptChannel(
        'FilePicker',
        onMessageReceived: (JavaScriptMessage message) {
          print('File picker requested');
          onFilePickRequested?.call();
        },
      )
      ..addJavaScriptChannel(
        'ResetComplete',
        onMessageReceived: (JavaScriptMessage message) {
          print('Reset complete');
          onResetComplete?.call();
        },
      )
      ..loadRequest(Uri.parse('https://trackfollows.com'));

    // Flutter 웹뷰 식별자 설정
    await controller?.runJavaScript('''
      // Flutter 웹뷰 식별자 설정
      window.isFlutterWebView = true;
      window.flutterApp = true;
      
      // Flutter 메시지 전송 함수
      window.sendToFlutter = function(data) {
        if (window.Flutter) {
          window.Flutter.postMessage(JSON.stringify(data));
        }
      };
      
      // 분석 완료 시 Flutter로 전송하는 함수
      window.notifyFlutterAnalysisComplete = function(analysisData) {
        const message = {
          type: 'detailed_analysis_complete',
          data: analysisData
        };
        window.sendToFlutter(message);
      };
      
      console.log('Flutter WebView initialized');
    ''');

    // iOS에서 미디어 재생 설정
    if (Platform.isIOS) {
      // iOS에서는 별도 설정이 필요하지 않음
    }
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
          print('Notification tapped: ${response.payload}');
        },
      );
    } catch (e) {
      print('Failed to initialize notifications: $e');
    }
  }

  void _handleJavaScriptMessage(String message) {
    try {
      final data = Map<String, dynamic>.from(
          jsonDecode(message) as Map<String, dynamic>);

      if (data['type'] == 'unfollower_analysis_complete') {
        _showAnalysisNotification(data['data']);
      } else if (data['type'] == 'detailed_analysis_complete') {
        _showAnalysisNotification(data['data']);
        _saveDetailedAnalysisToHistory(data['data']);
      }
    } catch (e) {
      print('Failed to handle JavaScript message: $e');
    }
  }

  void _handleUnfollowerNotification(String message) {
    try {
      final data = Map<String, dynamic>.from(
          jsonDecode(message) as Map<String, dynamic>);

      if (data['type'] == 'unfollower_analysis_complete') {
        _showAnalysisNotification(data['data']);
      } else if (data['type'] == 'detailed_analysis_complete') {
        _showAnalysisNotification(data['data']);
        _saveDetailedAnalysisToHistory(data['data']);
      }
    } catch (e) {
      print('Failed to handle unfollower notification: $e');
    }
  }

  void _showAnalysisNotification(Map<String, dynamic> data) {
    final unfollowersCount = data['unfollowersCount'] ?? 0;
    final fansCount = data['fansCount'] ?? 0;
    final mutualCount = data['mutualCount'] ?? 0;
    final totalFollowers = data['totalFollowers'] ?? 0;
    final totalFollowing = data['totalFollowing'] ?? 0;

    final message = '분석 완료!\n'
        '언팔로워: $unfollowersCount명\n'
        '팬: $fansCount명\n'
        '맞팔: $mutualCount명\n'
        '총 팔로워: $totalFollowers명\n'
        '총 팔로잉: $totalFollowing명';

    // 로컬 알림 표시
    notificationsPlugin.show(
      0,
      '인스타그램 분석 완료',
      message,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'unfollower_analysis',
          '언팔로워 분석',
          channelDescription: '인스타그램 언팔로워 분석 알림',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  void _saveDetailedAnalysisToHistory(Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyKey = 'analysis_history';

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

      print('Analysis history saved successfully');

      // 분석 완료 콜백 호출
      onAnalysisComplete?.call();
    } catch (e) {
      print('Failed to save analysis history: $e');
    }
  }

  Future<bool> canGoBack() async {
    try {
      return await controller?.canGoBack() ?? false;
    } catch (e) {
      print('Failed to check if can go back: $e');
      return false;
    }
  }

  Future<void> goBack() async {
    try {
      await controller?.goBack();
    } catch (e) {
      print('Failed to go back: $e');
    }
  }

  Future<bool> setFileInWebView(
      String fileName, String fileData, String fileType) async {
    try {
      if (!_isWebViewReady) {
        print('WebView is not ready yet');
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
      print('Failed to set file in WebView: $e');
      return false;
    }
  }
}
