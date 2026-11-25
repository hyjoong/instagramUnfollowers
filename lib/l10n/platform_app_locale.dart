import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart' show Locale;
import 'package:shared_preferences/shared_preferences.dart';

import 'app_locale.dart';

/// The OS-level per-app language (Android 13+ Settings › Apps › Language).
abstract interface class PlatformAppLocale {
  /// Language tag set for this app in the OS, or null when none is set.
  Future<String?> read();

  /// Sets the app's OS language; null clears it (follow the system).
  Future<void> write(String? code);
}

class AndroidPlatformAppLocale implements PlatformAppLocale {
  static const _channel = MethodChannel('trackfollows/app_locale');

  @override
  Future<String?> read() => _channel.invokeMethod<String>('get');

  @override
  Future<void> write(String? code) => _channel.invokeMethod<void>('set', code);
}

/// Keeps [AppLocaleStore] and the OS per-app language as one setting, so the
/// language picked in either place wins and both screens show the same value.
class PlatformLocaleSync {
  PlatformLocaleSync(this.store, this.platform, this.prefs) {
    store.addListener(_onStoreChanged);
  }

  /// The value last written to (or read from) the OS: a language code, '' for
  /// none, missing when the two have never been synced.
  static const syncedKey = 'app_locale_platform_synced';

  final AppLocaleStore store;
  final PlatformAppLocale platform;
  final SharedPreferences prefs;

  /// Android 13+ only; null elsewhere.
  static PlatformLocaleSync? create(
    AppLocaleStore store,
    SharedPreferences prefs,
  ) {
    if (kIsWeb || !Platform.isAndroid) return null;
    return PlatformLocaleSync(store, AndroidPlatformAppLocale(), prefs);
  }

  /// Applies a change made in the OS settings, or pushes the app's choice to
  /// the OS when the OS has nothing new. Call at start and whenever the
  /// device languages change.
  Future<void> pull() async {
    final String? os;
    try {
      os = _normalize(await platform.read());
    } catch (error) {
      debugPrint('Reading the OS app language failed: $error');
      return;
    }
    final synced = prefs.getString(syncedKey);
    if (os != null) {
      if (os == synced && os != store.savedCode) {
        // Unchanged in the OS since the last sync: the app's choice is newer.
        await _push();
        return;
      }
      await prefs.setString(syncedKey, os);
      if (os != store.savedCode) await store.select(Locale(os));
    } else if (synced != null && synced.isNotEmpty) {
      // Cleared in the OS settings: follow the device again.
      await prefs.setString(syncedKey, '');
      if (store.savedCode != null) await store.select(null);
    } else {
      // Nothing set in the OS (first run): show the app's choice there too,
      // including Korean pinned for existing users.
      await _push();
    }
  }

  void _onStoreChanged() {
    if ((store.savedCode ?? '') != prefs.getString(syncedKey)) {
      unawaited(_push());
    }
  }

  Future<void> _push() async {
    final code = store.savedCode;
    await prefs.setString(syncedKey, code ?? '');
    try {
      await platform.write(code);
    } catch (error) {
      debugPrint('Writing the OS app language failed: $error');
    }
  }

  /// `id-ID` → `id`. Older Java names Indonesian `in`.
  static String? _normalize(String? tag) {
    if (tag == null || tag.isEmpty) return null;
    var code = tag.split(RegExp('[-_]')).first.toLowerCase();
    if (code == 'in') code = 'id';
    return supportedLanguageCodes.contains(code) ? code : null;
  }

  void dispose() => store.removeListener(_onStoreChanged);
}
