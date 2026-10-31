import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  static bool _isInitialized = false;

  static Future<void> initializeFirebase() async {
    if (_isInitialized) {
      return; // 이미 초기화되었으면 중복 초기화 방지
    }

    try {
      await Firebase.initializeApp();
      _isInitialized = true;
    } catch (e) {
      // Firebase 초기화 실패 시에도 앱이 계속 실행되도록 함
      print('Firebase initialization failed: $e');
    }
  }

  Future<void> initializeMessaging() async {
    try {
      // Firebase가 초기화되지 않았으면 초기화
      if (!_isInitialized) {
        await initializeFirebase();
      }

      // FCM 권한 요청
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // FCM 토큰 가져오기
        String? token = await messaging.getToken();
        if (token != null) {
          // 토큰을 서버에 전송하거나 로컬에 저장
        }
      }

      // 포그라운드 메시지 핸들러
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // 포그라운드에서 메시지 수신 시 처리
      });

      // 백그라운드 메시지 핸들러
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);
    } catch (e) {
      // 메시징 초기화 실패 시에도 앱이 계속 실행되도록 함
      print('Firebase messaging initialization failed: $e');
    }
  }
}

// 백그라운드 메시지 핸들러 (최상위 레벨 함수여야 함)
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 백그라운드에서 메시지 수신 시 처리
}
