import 'package:flutter_test/flutter_test.dart';
import 'package:trackfollows/history/history_compare.dart';

Map<String, dynamic> entry({
  required String id,
  String? exportDate,
  String timestamp = '2026-11-08T10:00:00.000Z',
  List<String> unfollowers = const [],
  Map<String, String> fans = const {},
  Map<String, String> mutuals = const {},
}) =>
    {
      'id': id,
      'timestamp': timestamp,
      if (exportDate != null) 'exportDate': exportDate,
      'unfollowers': [for (final u in unfollowers) {'username': u}],
      'fans': [
        for (final e in fans.entries) {'username': e.key, 'followedDate': e.value}
      ],
      'mutualFollows': [
        for (final e in mutuals.entries)
          {'username': e.key, 'relationshipDate': e.value}
      ],
    };

void main() {
  test('rebuilds followers from fans and mutual follows', () {
    final s = HistorySnapshot.fromJson(entry(
      id: '1',
      exportDate: '2026-11-06',
      unfollowers: ['x'],
      fans: {'a': '2026-01-01T00:00:00Z'},
      mutuals: {'m': '2026-01-02T00:00:00Z'},
    ));
    expect(s.followers, {'a', 'm'});
    expect(s.following, {'x', 'm'});
    expect(s.date, DateTime(2026, 11, 6));
    expect(s.dateFromFileName, isTrue);
  });

  test('compares in time order whatever order the records are given', () {
    final oct = HistorySnapshot.fromJson(entry(
        id: '200', exportDate: '2026-10-01', fans: {'a': '2026-01-01T00:00:00Z', 'b': '2026-01-02T00:00:00Z'}));
    final nov = HistorySnapshot.fromJson(entry(
        id: '100', exportDate: '2026-11-06', fans: {'b': '2026-01-02T00:00:00Z', 'c': '2026-03-01T00:00:00Z'}));
    for (final diff in [compareSnapshots(oct, nov), compareSnapshots(nov, oct)]) {
      expect(diff.older.id, '200');
      expect(diff.lostFollowers, ['a']);
      expect(diff.newFollowers, ['c']);
      expect(diff.followerChange, 0);
    }
  });

  test('a renamed follower is matched by follow time', () {
    final before = HistorySnapshot.fromJson(entry(
        id: '1', exportDate: '2026-10-01', fans: {'old_name': '2026-01-01T10:00:00Z', 'gone': '2026-02-01T00:00:00Z'}));
    final after = HistorySnapshot.fromJson(entry(
        id: '2', exportDate: '2026-11-01', fans: {'new_name': '2026-01-01T10:00:30Z'}));
    final diff = compareSnapshots(before, after);
    expect(diff.renamed.single.from, 'old_name');
    expect(diff.renamed.single.to, 'new_name');
    expect(diff.lostFollowers, ['gone']);
    expect(diff.newFollowers, isEmpty);
  });

  test('records without an export date fall back to the analysis time', () {
    final s = HistorySnapshot.fromJson(entry(id: '1', timestamp: '2026-11-07T01:00:00.000Z'));
    expect(s.dateFromFileName, isFalse);
    expect(s.date, DateTime.parse('2026-11-07T01:00:00.000Z').toLocal());
  });

  test('sorts newest export first and detects other accounts', () {
    final a = HistorySnapshot.fromJson(entry(id: '1', exportDate: '2026-09-01', fans: {'a': '', 'b': '', 'c': ''}));
    final b = HistorySnapshot.fromJson(entry(id: '2', exportDate: '2026-11-01', fans: {'a': '', 'b': '', 'd': ''}));
    final other = HistorySnapshot.fromJson(entry(id: '3', exportDate: '2026-10-01', fans: {'p': '', 'q': '', 'r': ''}));
    expect(sortNewestFirst([a, other, b]).map((s) => s.id), ['2', '3', '1']);
    expect(looksLikeSameAccount(a, b), isTrue);
    expect(looksLikeSameAccount(a, other), isFalse);
  });
}
