import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'firebase_options.dart';

// FCM 백그라운드 메시지 핸들러
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // FCM 백그라운드 핸들러 설정
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
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
  late final WebViewController controller;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
    _requestPermissions();
    _initializeWebView();
  }

  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      await Permission.storage.request();
      await Permission.mediaLibrary.request();
    }
  }

  void _initializeWebView() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            _injectJavaScript();
          },
          onWebResourceError: (WebResourceError error) {
            print('웹뷰 에러: ${error.description}');
          },
        ),
      )
      ..setUserAgent(
          'Mozilla/5.0 (Android 10; Mobile; rv:68.0) Gecko/68.0 Firefox/68.0')
      ..loadRequest(
        Uri.parse('https://trackfollows.com/'),
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
          'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept',
        },
      );

    // Android 웹뷰 설정
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    // JavaScript 채널 설정
    controller.addJavaScriptChannel(
      'FlutterFileUpload',
      onMessageReceived: (JavaScriptMessage message) async {
        if (message.message == 'pickFile') {
          await _handleFileSelection();
        }
      },
    );
  }

  void _injectJavaScript() {
    controller.runJavaScript('''
      
      window.flutterFileUploaded = false;
      
      function interceptFileInput() {
        const fileInputs = document.querySelectorAll('input[type="file"]');
        fileInputs.forEach(function(input) {
          input.removeEventListener('click', handleFileClick);
          input.addEventListener('click', handleFileClick);
        });
      }
      
      function handleFileClick(e) {
        e.preventDefault();
        e.stopPropagation();
        window.FlutterFileUpload.postMessage('pickFile');
      }
      
      // "다시 분석하기" 버튼 클릭 감지
      function interceptResetButton() {
        // 기존 이벤트 리스너가 있는 버튼들을 찾아서 래핑
        const buttons = document.querySelectorAll('button');
        buttons.forEach(function(button) {
          if (button.textContent && button.textContent.includes('analyze')) {
            button.removeEventListener('click', handleResetClick);
            button.addEventListener('click', handleResetClick);
          }
        });
      }
      
      function handleResetClick(e) {
        window.flutterFileUploaded = false;
        setTimeout(() => {
          window.FlutterFileUpload.postMessage('resetComplete');
        }, 100);
      }
      
      // 웹뷰용 파일 설정 함수
      window.setFlutterFile = function(fileName, fileData, fileType) {
        
        const fileInput = document.querySelector('input[type="file"]#instagram-data');
        if (!fileInput) {
          return false;
        }
        
        try {
          const binaryString = atob(fileData);
          const bytes = new Uint8Array(binaryString.length);
          for (let i = 0; i < binaryString.length; i++) {
            bytes[i] = binaryString.charCodeAt(i);
          }
          
          const blob = new Blob([bytes], { type: fileType });
          const file = new File([blob], fileName, { type: fileType });
          
          const dataTransfer = new DataTransfer();
          dataTransfer.items.add(file);
          fileInput.files = dataTransfer.files;
          
          const changeEvent = new Event('change', { bubbles: true });
          fileInput.dispatchEvent(changeEvent);
          
          window.flutterFileUploaded = true;
          return true;
        } catch (error) {
          return false;
        }
      };
      
      const observer = new MutationObserver(function(mutations) {
        let shouldIntercept = false;
        mutations.forEach(function(mutation) {
          if (mutation.addedNodes.length > 0) {
            shouldIntercept = true;
          }
        });
        
        if (shouldIntercept) {
          setTimeout(() => {
            interceptFileInput();
            interceptResetButton();
          }, 100);
        }
      });
      
      observer.observe(document.body, {
        childList: true,
        subtree: true
      });
      
      setTimeout(() => {
        interceptFileInput();
        interceptResetButton();
      }, 500);
    ''');
  }

  Future<void> _handleFileSelection() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['zip', 'json', 'html'],
        allowMultiple: false,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        if (file.bytes != null) {
          String fileData = base64Encode(file.bytes!);
          String fileType = file.extension == 'zip'
              ? 'application/zip'
              : 'application/octet-stream';

          // 웹뷰에 파일 설정
          bool success = await _setFileInWebView(file.name, fileData, fileType);
        }
      } else {}
    } catch (e) {
      print('file picker error: $e');
    }
  }

  Future<bool> _setFileInWebView(
      String fileName, String fileData, String fileType) async {
    try {
      final result = await controller.runJavaScriptReturningResult('''
        window.setFlutterFile('$fileName', '$fileData', '$fileType');
      ''');

      return result == true || result.toString() == 'true';
    } catch (e) {
      print('webview error: $e');
      return false;
    }
  }

  Future<void> _initializeFirebaseMessaging() async {
    // 알림 권한 요청
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // FCM 토큰 가져오기
      String? token = await _firebaseMessaging.getToken();

      // 로컬 알림 설정
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings();
      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      );

      await _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      );

      // 포그라운드 메시지 핸들링
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          _flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'trackfollows_channel',
                'TrackFollows Notifications',
                channelDescription: 'TrackFollows 알림 채널',
                importance: Importance.max,
                priority: Priority.high,
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        // 웹뷰에서 뒤로갈 수 있는지 확인
        final canGoBack = await controller.canGoBack();
        if (canGoBack) {
          // 웹뷰에서 뒤로가기
          await controller.goBack();
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
          controller: controller,
        ),
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
