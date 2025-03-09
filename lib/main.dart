import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    controller = WebViewController()
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
          onWebResourceError: (WebResourceError error) {
            // 오류 발생 시
          },
        ),
      )
      ..loadRequest(Uri.parse('https://trackfollows.com/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // 실제 앱바 내용이 필요 없다면 높이를 0으로 설정
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
