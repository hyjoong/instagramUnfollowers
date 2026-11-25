import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackfollows/review/review_prompt.dart';

class _FakeReview implements ReviewBackend {
  bool available = true;
  int requests = 0;

  @override
  Future<bool> isAvailable() async => available;

  @override
  Future<void> requestReview() async => requests++;
}

void main() {
  late DateTime now;
  late _FakeReview backend;

  ReviewPromptController controller() =>
      ReviewPromptController(backend: backend, now: () => now);

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    now = DateTime(2026, 11, 25, 10);
    backend = _FakeReview();
  });

  test('asks after the second successful analysis, not the first', () async {
    final c = controller();
    expect(await c.onAnalysisCompleted(adShown: false), isFalse);
    expect(await c.onAnalysisCompleted(adShown: false), isTrue);
    expect(backend.requests, 1);
  });

  test('skips an analysis that showed an interstitial', () async {
    final c = controller();
    await c.onAnalysisCompleted(adShown: false);
    expect(await c.onAnalysisCompleted(adShown: true), isFalse);
    expect(await c.onAnalysisCompleted(adShown: false), isTrue);
  });

  test('asks at most once every 90 days', () async {
    final c = controller();
    await c.onAnalysisCompleted(adShown: false);
    await c.onAnalysisCompleted(adShown: false);

    now = now.add(const Duration(days: 89));
    expect(await c.onAnalysisCompleted(adShown: false), isFalse);
    now = now.add(const Duration(days: 1));
    expect(await c.onAnalysisCompleted(adShown: false), isTrue);
    expect(backend.requests, 2);
  });

  test('records nothing when the store review is unavailable', () async {
    backend.available = false;
    final c = controller();
    await c.onAnalysisCompleted(adShown: false);
    expect(await c.onAnalysisCompleted(adShown: false), isFalse);

    backend.available = true;
    expect(await c.onAnalysisCompleted(adShown: false), isTrue);
  });
}
