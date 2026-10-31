import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'ads/admob_test_banner.dart';
import 'ads/admob_test_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Fail before any platform SDK/network initialization in a release build.
  AdMobTestConfig.current.requireEnabled();
  runApp(const AdMobSmokeApp());
}

class AdMobSmokeApp extends StatelessWidget {
  const AdMobSmokeApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'TrackFollows AdMob Test',
        theme: ThemeData(colorSchemeSeed: const Color(0xFFEC4899)),
        home: const _SmokeScreen(),
      );
}

class _SmokeScreen extends StatefulWidget {
  const _SmokeScreen();

  @override
  State<_SmokeScreen> createState() => _SmokeScreenState();
}

class _SmokeScreenState extends State<_SmokeScreen> {
  late final WebViewController _controller;
  bool _showBanner = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..setNavigationDelegate(NavigationDelegate(
        // No navigation interception: the static fixture has no links, scripts
        // or remote resources. Blocking navigation also blocks WKWebView's
        // initial loadHtmlString document on iOS.
        onPageFinished: (url) =>
            debugPrint('[AdMob TEST] local WebView fixture loaded: $url'),
        onWebResourceError: (error) => debugPrint(
            '[AdMob TEST] local WebView error: ${error.description}'),
      ))
      ..loadHtmlString('''
<!doctype html><html lang="ko"><head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>body{font-family:-apple-system,sans-serif;padding:24px;color:#172033}
h1{font-size:24px}p{line-height:1.7}.card{padding:20px;background:#fdf2f8;border-radius:16px}</style>
</head><body><h1>TrackFollows 광고 테스트</h1>
<p>이 화면은 앱에 포함된 로컬 HTML입니다. 실제 분석이나 웹 광고를 요청하지 않습니다.</p>
<div class="card"><strong>WebView + 네이티브 배너</strong>
<p>아래 Google 테스트 광고와 로드 상태를 확인하세요. 테스트 광고는 실제 수익을 만들지 않습니다.</p></div>
<p>화면을 회전하거나 앱을 백그라운드로 보낸 뒤 돌아와 배너 크기와 재요청을 확인할 수 있습니다.</p>
</body></html>''');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('AdMob 테스트 환경')),
        body: Column(children: [
          SwitchListTile(
            title: const Text('테스트 배너 표시'),
            subtitle: const Text('Google 샘플 ID만 사용 · Firebase 연결 없음'),
            value: _showBanner,
            onChanged: (value) => setState(() => _showBanner = value),
          ),
          Expanded(child: WebViewWidget(controller: _controller)),
          if (_showBanner) const AdMobTestBanner(),
        ]),
      );
}
