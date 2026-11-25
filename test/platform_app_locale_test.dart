import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackfollows/l10n/app_locale.dart';
import 'package:trackfollows/l10n/platform_app_locale.dart';

class _FakeOs implements PlatformAppLocale {
  String? value;
  final writes = <String?>[];

  @override
  Future<String?> read() async => value;

  @override
  Future<void> write(String? code) async {
    writes.add(code);
    value = code;
  }
}

void main() {
  late SharedPreferences prefs;
  late _FakeOs os;

  Future<PlatformLocaleSync> start(
    Map<String, Object> saved, {
    List<Locale> device = const [Locale('en')],
  }) async {
    SharedPreferences.setMockInitialValues(saved);
    prefs = await SharedPreferences.getInstance();
    final store = await AppLocaleStore.load(prefs, device);
    final sync = PlatformLocaleSync(store, os, prefs);
    await sync.pull();
    return sync;
  }

  setUp(() => os = _FakeOs());

  test('first run shows the pinned Korean in the OS settings', () async {
    final sync = await start({AppLocaleStore.onboardingCompletedKey: true});
    expect(os.writes, ['ko']);
    expect(sync.store.value, const Locale('ko'));
  });

  test('first run with no choice leaves the OS on the system language',
      () async {
    final sync = await start({});
    expect(os.writes, [null]);
    expect(sync.store.savedCode, isNull);
  });

  test('a language set in the OS settings wins over the saved one', () async {
    os.value = 'ja-JP';
    final sync = await start({AppLocaleStore.prefsKey: 'ko'});
    expect(sync.store.value, const Locale('ja'));
    expect(prefs.getString(AppLocaleStore.prefsKey), 'ja');
    expect(os.writes, isEmpty);
  });

  test('a language picked in the app is written to the OS', () async {
    final sync = await start({AppLocaleStore.prefsKey: 'ko'});
    await sync.store.select(const Locale('de'));
    await pumpEventQueue();
    expect(os.writes.last, 'de');

    // The OS reports the change back; nothing moves.
    await sync.pull();
    expect(sync.store.value, const Locale('de'));
    expect(os.writes.last, 'de');
  });

  test('clearing the OS setting goes back to the device language', () async {
    final sync = await start({AppLocaleStore.prefsKey: 'ko'},
        device: const [Locale('es')]);
    os.value = null;
    await sync.pull();
    expect(sync.store.savedCode, isNull);
    expect(sync.store.value, const Locale('es'));
  });

  test('Indonesian under its legacy code is understood', () async {
    os.value = 'in-ID';
    final sync = await start({});
    expect(sync.store.value, const Locale('id'));
  });

  test('a failing platform call leaves the app language alone', () async {
    final sync = await start({AppLocaleStore.prefsKey: 'ko'});
    final broken = PlatformLocaleSync(sync.store, _BrokenOs(), prefs);
    await broken.pull();
    expect(sync.store.value, const Locale('ko'));
  });
}

class _BrokenOs implements PlatformAppLocale {
  @override
  Future<String?> read() => throw StateError('no channel');

  @override
  Future<void> write(String? code) => throw StateError('no channel');
}
