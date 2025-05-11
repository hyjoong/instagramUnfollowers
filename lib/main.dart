import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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

    // 플랫폼별 설정
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
      params = AndroidWebViewControllerCreationParams();
      // Android 웹뷰 설정
      final AndroidWebViewController androidController =
          AndroidWebViewController(
              params as AndroidWebViewControllerCreationParams);
      androidController.setMediaPlaybackRequiresUserGesture(false);
      androidController
          .setOnShowFileSelector((FileSelectorParams params) async {
        // 파일 선택기 처리
        return [];
      });
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // 페이지 로딩 진행 상황
          },
          onPageStarted: (String url) {
            // 페이지 로딩 시작
          },
          onPageFinished: (String url) {
            // 페이지 로딩 완료
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..setUserAgent(
          'Mozilla/5.0 (Android 10; Mobile; rv:68.0) Gecko/68.0 Firefox/68.0')
<<<<<<< Updated upstream
      ..loadRequest(Uri.parse('https://trackfollows.com/'));
=======
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
      'flutter_inappwebview',
      onMessageReceived: (JavaScriptMessage message) async {
        if (message.message == 'openFilePicker') {
          await _pickFile();
        }
      },
    );
  }

  void _injectJavaScript() {
    controller.runJavaScript('''
      // 파일 선택 버튼 클릭 이벤트 처리
      document.addEventListener('click', function(e) {
        const target = e.target;
        if (target && (
          target.matches('input[type="file"]') ||
          target.matches('button[type="file"]') ||
          target.closest('input[type="file"]') ||
          target.closest('button[type="file"]')
        )) {
          e.preventDefault();
          e.stopPropagation();
          window.flutter_inappwebview.postMessage('openFilePicker');
        }
      }, true);
    ''');
  }

  Future<void> _pickFile() async {
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

          // 파일 데이터를 웹뷰로 전달
          await controller.runJavaScript('''
            const fileInput = document.querySelector('input[type="file"]');
            if (fileInput) {
              // base64 데이터를 ArrayBuffer로 변환
              const binaryString = atob('$fileData');
              const bytes = new Uint8Array(binaryString.length);
              for (let i = 0; i < binaryString.length; i++) {
                bytes[i] = binaryString.charCodeAt(i);
              }
              
              // Blob 생성
              const blob = new Blob([bytes], { type: 'application/octet-stream' });
              
              // File 객체 생성
              const file = new File([blob], '${file.name}', {
                type: '${file.extension == 'zip' ? 'application/zip' : 'application/octet-stream'}'
              });
              
              // DataTransfer 객체 생성 및 파일 설정
              const dataTransfer = new DataTransfer();
              dataTransfer.items.add(file);
              fileInput.files = dataTransfer.files;
              
              // change 이벤트 발생
              const event = new Event('change', { bubbles: true });
              fileInput.dispatchEvent(event);
              
              // 파일 업로드 완료 후 분석 시작
              if (typeof analyzeFiles === 'function') {
                analyzeFiles();
              }
            }
          ''');
        }
      }
    } catch (e) {
      print('파일 선택 에러: $e');
    }
>>>>>>> Stashed changes
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
