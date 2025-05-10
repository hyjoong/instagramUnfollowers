package com.hyjoong.trackfollows;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.webviewflutter.WebViewFlutterPlugin;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        
        // 웹뷰 설정
        WebViewFlutterPlugin webViewPlugin = new WebViewFlutterPlugin();
        flutterEngine.getPlugins().add(webViewPlugin);
    }
} 