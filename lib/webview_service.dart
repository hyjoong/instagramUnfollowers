import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'file_handler.dart';
import 'javascript_injector.dart';

class WebViewService {
  late final WebViewController controller;
  final FileHandler fileHandler = FileHandler();

  void initializeWebView({
    required Function() onFilePickRequested,
    required Function() onResetComplete,
  }) {
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
          onWebResourceError: (WebResourceError error) {},
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
          await onFilePickRequested();
        } else if (message.message == 'resetComplete') {
          onResetComplete();
        }
      },
    );
  }

  void _injectJavaScript() {
    controller.runJavaScript(JavaScriptInjector.getInjectionCode());
  }

  Future<bool> canGoBack() async {
    return await controller.canGoBack();
  }

  Future<void> goBack() async {
    await controller.goBack();
  }

  Future<bool> setFileInWebView(
      String fileName, String fileData, String fileType) async {
    try {
      final result = await controller.runJavaScriptReturningResult('''
        window.setFlutterFile('$fileName', '$fileData', '$fileType');
      ''');

      return result == true || result.toString() == 'true';
    } catch (e) {
      return false;
    }
  }
}
