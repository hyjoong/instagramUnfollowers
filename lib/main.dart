import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

void main() {
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

  @override
  void initState() {
    super.initState();

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
      ..loadRequest(Uri.parse('https://trackfollows.com/'));
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
