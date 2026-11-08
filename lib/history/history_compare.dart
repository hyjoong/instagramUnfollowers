// 분석 기록 두 개를 비교해 그 사이에 나를 언팔한 사람·새 팔로워·아이디를 바꾼 계정을 찾습니다.
//
// 기록에는 언팔로워(내가 팔로우하지만 나를 팔로우하지 않음)·팬·맞팔 목록이 들어 있어서
// 팔로워 = 팬 + 맞팔, 팔로잉 = 언팔로워 + 맞팔 로 되살릴 수 있습니다.

/// 기록 하나를 비교에 필요한 형태로 정리한 것
class HistorySnapshot {
  HistorySnapshot({
    required this.id,
    required this.date,
    required this.dateFromFileName,
    required this.followers,
    required this.following,
    required this.fanTimes,
    required this.mutualTimes,
  });

  final String id;

  /// 인스타그램에서 파일을 내보낸 날. 모르면 분석한 시각입니다.
  final DateTime date;

  /// date가 파일 이름에서 읽은 내보낸 날인지 (false면 분석한 시각)
  final bool dateFromFileName;

  final Set<String> followers;
  final Set<String> following;

  /// 팬이 나를 팔로우한 시각(분 단위). 아이디가 바뀌어도 그대로라 짝을 찾는 데 씁니다.
  final Map<String, int> fanTimes;

  /// 맞팔 계정을 내가 팔로우한 시각(분 단위)
  final Map<String, int> mutualTimes;

  static HistorySnapshot fromJson(Map<String, dynamic> json) {
    final fans = _list(json['fans']);
    final mutuals = _list(json['mutualFollows']);
    final unfollowers = _list(json['unfollowers']);

    final exportDate = _parseExportDate(json['exportDate']);
    final analyzedAt =
        DateTime.tryParse('${json['timestamp'] ?? ''}')?.toLocal() ??
            DateTime.fromMillisecondsSinceEpoch(0);

    return HistorySnapshot(
      id: '${json['id'] ?? ''}',
      date: exportDate ?? analyzedAt,
      dateFromFileName: exportDate != null,
      followers: {..._names(fans), ..._names(mutuals)},
      following: {..._names(unfollowers), ..._names(mutuals)},
      fanTimes: _times(fans, 'followedDate'),
      mutualTimes: _times(mutuals, 'relationshipDate'),
    );
  }

  /// 내보낸 날이 같으면 먼저 분석한 기록(id가 분석 시각)을 예전 기록으로 봅니다.
  bool isEarlierThan(HistorySnapshot other) {
    if (date != other.date) return date.isBefore(other.date);
    return (int.tryParse(id) ?? 0) < (int.tryParse(other.id) ?? 0);
  }
}

class RenamedAccount {
  const RenamedAccount(this.from, this.to);
  final String from;
  final String to;
}

class HistoryDiff {
  const HistoryDiff({
    required this.older,
    required this.newer,
    required this.lostFollowers,
    required this.newFollowers,
    required this.renamed,
  });

  final HistorySnapshot older;
  final HistorySnapshot newer;
  final List<String> lostFollowers;
  final List<String> newFollowers;
  final List<RenamedAccount> renamed;

  int get followerChange => newer.followers.length - older.followers.length;
}

/// 두 기록을 시간 순서(예전 → 최근)로 비교합니다. 넘긴 순서와 상관없이 방향이 뒤집히지 않습니다.
HistoryDiff compareSnapshots(HistorySnapshot a, HistorySnapshot b) {
  final older = a.isEarlierThan(b) ? a : b;
  final newer = identical(older, a) ? b : a;

  var lost = older.followers.difference(newer.followers).toList()..sort();
  var gained = newer.followers.difference(older.followers).toList()..sort();
  final renamed = <RenamedAccount>[
    ..._matchRenames(lost, gained, older.fanTimes, newer.fanTimes),
    ..._matchRenames(lost, gained, older.mutualTimes, newer.mutualTimes),
  ];
  final renamedFrom = renamed.map((r) => r.from).toSet();
  final renamedTo = renamed.map((r) => r.to).toSet();
  lost = lost.where((name) => !renamedFrom.contains(name)).toList();
  gained = gained.where((name) => !renamedTo.contains(name)).toList();

  return HistoryDiff(
    older: older,
    newer: newer,
    lostFollowers: lost,
    newFollowers: gained,
    renamed: renamed,
  );
}

/// 기록 목록을 내보낸 날 최근 순으로 정렬합니다.
List<HistorySnapshot> sortNewestFirst(List<HistorySnapshot> snapshots) {
  final sorted = [...snapshots];
  sorted.sort((a, b) => a.isEarlierThan(b) ? 1 : -1);
  return sorted;
}

/// 같은 계정의 기록인지 대략 확인합니다. 팔로워가 30% 이상 겹쳐야 비교합니다.
bool looksLikeSameAccount(HistorySnapshot a, HistorySnapshot b) {
  final smaller =
      a.followers.length < b.followers.length ? a.followers : b.followers;
  final larger = identical(smaller, a.followers) ? b.followers : a.followers;
  if (smaller.isEmpty) return false;
  final shared = smaller.where(larger.contains).length;
  return shared / smaller.length >= 0.3;
}

// 같은 분에 사라진 아이디 하나와 생긴 아이디 하나만 있을 때 같은 계정으로 봅니다.
List<RenamedAccount> _matchRenames(
  List<String> lost,
  List<String> gained,
  Map<String, int> olderTimes,
  Map<String, int> newerTimes,
) {
  final lostByMinute = _uniqueByMinute(lost, olderTimes);
  final gainedByMinute = _uniqueByMinute(gained, newerTimes);
  final result = <RenamedAccount>[];
  lostByMinute.forEach((minute, from) {
    final to = gainedByMinute[minute];
    if (to != null) result.add(RenamedAccount(from, to));
  });
  return result;
}

Map<int, String> _uniqueByMinute(List<String> names, Map<String, int> times) {
  final byMinute = <int, String?>{};
  for (final name in names) {
    final minute = times[name];
    if (minute == null) continue;
    byMinute[minute] = byMinute.containsKey(minute) ? null : name;
  }
  return {
    for (final entry in byMinute.entries)
      if (entry.value != null) entry.key: entry.value!,
  };
}

List<Map<String, dynamic>> _list(dynamic value) {
  if (value is! List) return const [];
  return value
      .whereType<Map>()
      .map((item) => Map<String, dynamic>.from(item))
      .toList();
}

Set<String> _names(List<Map<String, dynamic>> items) => {
      for (final item in items)
        if ('${item['username'] ?? ''}'.isNotEmpty) '${item['username']}',
    };

Map<String, int> _times(List<Map<String, dynamic>> items, String key) {
  final times = <String, int>{};
  for (final item in items) {
    final date = DateTime.tryParse('${item[key] ?? ''}');
    final name = '${item['username'] ?? ''}';
    if (date == null || name.isEmpty) continue;
    times[name] = date.millisecondsSinceEpoch ~/ 60000;
  }
  return times;
}

DateTime? _parseExportDate(dynamic value) {
  final match = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$').firstMatch('${value ?? ''}');
  if (match == null) return null;
  return DateTime(
    int.parse(match.group(1)!),
    int.parse(match.group(2)!),
    int.parse(match.group(3)!),
  );
}
