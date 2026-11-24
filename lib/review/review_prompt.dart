import 'package:flutter/foundation.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// OS boundary so the request rules can be tested without the review sheet.
abstract interface class ReviewBackend {
  Future<bool> isAvailable();
  Future<void> requestReview();
}

class InAppReviewBackend implements ReviewBackend {
  @override
  Future<bool> isAvailable() => InAppReview.instance.isAvailable();

  @override
  Future<void> requestReview() => InAppReview.instance.requestReview();
}

/// Asks for a store review in every language (store ratings outside Korea are
/// still zero). The OS sheet is shown in the device language.
///
/// - Only after the second successful analysis, when the result has been seen.
/// - Never on an analysis that was followed by an interstitial.
/// - At most once every [interval].
class ReviewPromptController {
  ReviewPromptController({
    ReviewBackend? backend,
    Future<SharedPreferences> Function()? prefs,
    DateTime Function()? now,
  })  : _backend = backend ?? InAppReviewBackend(),
        _prefs = prefs ?? SharedPreferences.getInstance,
        _now = now ?? DateTime.now;

  static const completedKey = 'review_completed_analyses';
  static const lastRequestedKey = 'review_last_requested';
  static const interval = Duration(days: 90);

  final ReviewBackend _backend;
  final Future<SharedPreferences> Function() _prefs;
  final DateTime Function() _now;

  /// Records a successful analysis and asks for a review when the rules allow.
  /// Returns true when the review was requested.
  Future<bool> onAnalysisCompleted({required bool adShown}) async {
    final prefs = await _prefs();
    final completed = (prefs.getInt(completedKey) ?? 0) + 1;
    await prefs.setInt(completedKey, completed);
    if (completed < 2 || adShown) return false;

    final last = prefs.getInt(lastRequestedKey);
    final now = _now();
    if (last != null &&
        now.difference(DateTime.fromMillisecondsSinceEpoch(last)) < interval) {
      return false;
    }
    try {
      if (!await _backend.isAvailable()) return false;
      await _backend.requestReview();
    } catch (error) {
      debugPrint('Review request failed: $error');
      return false;
    }
    await prefs.setInt(lastRequestedKey, now.millisecondsSinceEpoch);
    return true;
  }
}
