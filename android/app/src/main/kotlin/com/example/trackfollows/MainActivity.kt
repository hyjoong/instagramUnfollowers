package com.example.trackfollows

import android.app.LocaleManager
import android.os.Build
import android.os.LocaleList
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Keeps the Android 13+ per-app language (Settings › Apps › Language)
        // in step with the language picked inside the app.
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "trackfollows/app_locale")
            .setMethodCallHandler { call, result ->
                if (Build.VERSION.SDK_INT < Build.VERSION_CODES.TIRAMISU) {
                    result.success(null)
                    return@setMethodCallHandler
                }
                val localeManager = getSystemService(LocaleManager::class.java)
                when (call.method) {
                    "get" -> {
                        val locales = localeManager.applicationLocales
                        result.success(if (locales.isEmpty) null else locales[0].toLanguageTag())
                    }
                    "set" -> {
                        val code = call.arguments as String?
                        localeManager.applicationLocales =
                            if (code == null) LocaleList.getEmptyLocaleList()
                            else LocaleList.forLanguageTags(code)
                        result.success(null)
                    }
                    else -> result.notImplemented()
                }
            }
    }
}
