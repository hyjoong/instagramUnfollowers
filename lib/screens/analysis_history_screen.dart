import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'analysis_visualization_screen.dart';
import 'history_compare_screen.dart';
import '../history/history_compare.dart';
import 'package:share_plus/share_plus.dart';

class AnalysisHistoryScreen extends StatefulWidget {
  const AnalysisHistoryScreen({super.key});

  @override
  State<AnalysisHistoryScreen> createState() => _AnalysisHistoryScreenState();
}

class _AnalysisHistoryScreenState extends State<AnalysisHistoryScreen>
    with AutomaticKeepAliveClientMixin {
  List<AnalysisResult> _history = [];
  // 내보낸 날 최근 순으로 정렬한 비교용 기록. _history와 같은 순서입니다.
  List<HistorySnapshot> _snapshots = [];
  // 각 기록과 그 직전(같은 계정) 기록의 비교 결과. 직전 기록이 없으면 null
  List<HistoryDiff?> _previousDiffs = [];
  String _loadedSignature = '';
  bool _isLoading = true;
  Timer? _refreshTimer;
  // 두 기록 비교 모드에서 고른 기록 id
  final List<String> _selectedIds = [];
  bool _selecting = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _setupAutoRefresh();
  }

  Future<void> _setupAutoRefresh() async {
    final prefs = await SharedPreferences.getInstance();
    final autoRefreshEnabled = prefs.getBool('auto_refresh_enabled') ?? true;

    if (autoRefreshEnabled) {
      _refreshTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (mounted) {
          _loadHistory();
        }
      });
    }
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final historyJson = prefs.getStringList('analysis_history') ?? [];
      // 5초마다 다시 읽으므로, 내용이 그대로면 비교를 다시 계산하지 않습니다.
      final signature = '${historyJson.length}:${historyJson.isEmpty ? '' : historyJson.first.hashCode}';
      if (signature == _loadedSignature && !_isLoading) return;

      final decoded = historyJson
          .map((json) => Map<String, dynamic>.from(jsonDecode(json)))
          .toList();
      final pairs = [
        for (final json in decoded)
          (AnalysisResult.fromJson(json), HistorySnapshot.fromJson(json))
      ];
      pairs.sort((a, b) => a.$2.isEarlierThan(b.$2) ? 1 : -1);

      final snapshots = [for (final p in pairs) p.$2];
      final diffs = <HistoryDiff?>[];
      for (var i = 0; i < snapshots.length; i++) {
        HistoryDiff? diff;
        for (var j = i + 1; j < snapshots.length; j++) {
          if (looksLikeSameAccount(snapshots[i], snapshots[j])) {
            diff = compareSnapshots(snapshots[j], snapshots[i]);
            break;
          }
        }
        diffs.add(diff);
      }

      if (!mounted) return;
      setState(() {
        _history = [for (final p in pairs) p.$1];
        _snapshots = snapshots;
        _previousDiffs = diffs;
        _loadedSignature = signature;
        _selectedIds.removeWhere((id) => !_history.any((r) => r.id == id));
        _isLoading = false;
      });

    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _openCompare(HistoryDiff diff) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HistoryCompareScreen(diff: diff)),
    );
  }

  void _toggleSelect(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        if (_selectedIds.length == 2) _selectedIds.removeAt(0);
        _selectedIds.add(id);
      }
    });
  }

  void _compareSelected() {
    final picked = [
      for (final id in _selectedIds) _snapshots.firstWhere((s) => s.id == id)
    ];
    if (picked.length != 2) return;
    if (!looksLikeSameAccount(picked[0], picked[1])) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('두 기록의 팔로워가 거의 겹치지 않아요. 같은 계정의 기록인지 확인해 주세요.')),
      );
      return;
    }
    _openCompare(compareSnapshots(picked[0], picked[1]));
  }

  Future<void> _deleteHistoryItem(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('분석 기록 삭제'),
        content: const Text('이 분석 기록을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              '삭제',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final targetId = _history[index].id;
      final historyJson = (prefs.getStringList('analysis_history') ?? [])
          .where((json) => '${jsonDecode(json)['id']}' != targetId)
          .toList();

      await prefs.setStringList('analysis_history', historyJson);
      _loadedSignature = '';
      await _loadHistory();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('분석 기록이 삭제되었습니다'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('삭제에 실패했습니다'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _formatDate(String timestamp) {
    try {
      final date = DateTime.parse(timestamp).toLocal();
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return timestamp;
    }
  }

  void _shareAnalysis(AnalysisResult result) {
    final analysisText = '''
인스타그램 분석 결과

📊 분석 요약:
• 언팔로워: ${result.unfollowersCount}
• 팬: ${result.fansCount}
• 맞팔: ${result.mutualCount}
• 총 팔로워: ${result.totalFollowers}
• 총 팔로잉: ${result.totalFollowing}

📅 분석 날짜: ${_formatDate(result.timestamp)}

TrackFollows 앱으로 생성됨
''';

    Share.share(analysisText, subject: '인스타그램 분석 결과');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          '분석 히스토리',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          if (_history.length >= 2)
            TextButton(
              onPressed: () => setState(() {
                _selecting = !_selecting;
                _selectedIds.clear();
              }),
              child: Text(_selecting ? '취소' : '두 기록 비교',
                  style: const TextStyle(color: Color(0xFFEC4899))),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _history.isEmpty
              ? _buildEmptyState()
              : _buildHistoryList(),
      bottomNavigationBar: _selecting
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFEC4899),
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: _selectedIds.length == 2 ? _compareSelected : null,
                  child: Text(_selectedIds.length == 2
                      ? '고른 두 기록 비교하기'
                      : '비교할 기록 두 개를 골라 주세요 (${_selectedIds.length}/2)'),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.history,
              size: 50,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            '분석 히스토리가 없습니다',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '분석 결과가 여기에 표시됩니다',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return Column(
      children: [
        // 히스토리 리스트
        Expanded(
          child: RefreshIndicator(
            onRefresh: _loadHistory,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _history.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: _buildHistoryCard(index),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryCard(int index) {
    final result = _history[index];
    final snapshot = _snapshots[index];
    final diff = _previousDiffs[index];
    final selected = _selectedIds.contains(result.id);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        if (_selecting) {
          _toggleSelect(result.id);
        } else if (diff != null) {
          _openCompare(diff);
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => AnalysisVisualizationScreen(analysisId: result.id),
          ));
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_selecting)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Icon(
                  selected ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: selected ? const Color(0xFFEC4899) : Colors.grey,
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    snapshot.dateFromFileName
                        ? '${formatSnapshotDate(snapshot)} 내보내기'
                        : formatSnapshotDate(snapshot),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '팔로워 ${result.totalFollowers} · 팔로잉 ${result.totalFollowing} · 언팔로워 ${result.unfollowersCount}',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  _buildChangeChip(diff),
                  const SizedBox(height: 6),
                  Text(
                    '분석: ${_formatDate(result.date)}',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            if (!_selecting)
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onSelected: (value) {
                  if (value == 'stats') {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) =>
                          AnalysisVisualizationScreen(analysisId: result.id),
                    ));
                  } else if (value == 'share') {
                    _shareAnalysis(result);
                  } else if (value == 'delete') {
                    _deleteHistoryItem(index);
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'stats', child: Text('통계 보기')),
                  PopupMenuItem(value: 'share', child: Text('공유')),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('삭제', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // 직전 기록과 비교한 변화. 눌러서 자세히 볼 수 있다는 걸 함께 보여 줍니다.
  Widget _buildChangeChip(HistoryDiff? diff) {
    if (diff == null) {
      return const Text('첫 기록 · 다음 분석부터 변화를 비교해요',
          style: TextStyle(fontSize: 12, color: Colors.grey));
    }
    final lost = diff.lostFollowers.length;
    final gained = diff.newFollowers.length;
    final noChange = lost == 0 && gained == 0 && diff.renamed.isEmpty;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF2F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (noChange)
            const Text('직전 기록과 팔로워 변화 없음',
                style: TextStyle(fontSize: 12, color: Colors.black54))
          else ...[
            const Text('직전 기록 대비  ',
                style: TextStyle(fontSize: 12, color: Colors.black54)),
            Text('언팔 $lost',
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)),
            const Text('  ·  ', style: TextStyle(fontSize: 12, color: Colors.black38)),
            Text('새 팔로워 $gained',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700)),
          ],
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, size: 16, color: Colors.black38),
        ],
      ),
    );
  }

}

class AnalysisResult {
  final String id;
  final String timestamp;
  final int unfollowersCount;
  final int fansCount;
  final int mutualCount;
  final int totalFollowers;
  final int totalFollowing;
  final List<dynamic> unfollowers;
  final List<dynamic> fans;
  final List<dynamic> mutualFollows;
  final String? exportDate;

  AnalysisResult({
    required this.id,
    required this.timestamp,
    required this.unfollowersCount,
    required this.fansCount,
    required this.mutualCount,
    required this.totalFollowers,
    required this.totalFollowing,
    required this.unfollowers,
    required this.fans,
    required this.mutualFollows,
    this.exportDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestamp': timestamp,
      'unfollowersCount': unfollowersCount,
      'fansCount': fansCount,
      'mutualCount': mutualCount,
      'totalFollowers': totalFollowers,
      'totalFollowing': totalFollowing,
      'unfollowers': unfollowers,
      'fans': fans,
      'mutualFollows': mutualFollows,
      if (exportDate != null) 'exportDate': exportDate,
    };
  }

  factory AnalysisResult.fromJson(Map<String, dynamic> json) {
    return AnalysisResult(
      id: json['id'] ?? '',
      timestamp: json['timestamp'] ?? '',
      unfollowersCount: json['unfollowersCount'] ?? 0,
      fansCount: json['fansCount'] ?? 0,
      mutualCount: json['mutualCount'] ?? 0,
      totalFollowers: json['totalFollowers'] ?? 0,
      totalFollowing: json['totalFollowing'] ?? 0,
      unfollowers: json['unfollowers'] ?? [],
      fans: json['fans'] ?? [],
      mutualFollows: json['mutualFollows'] ?? [],
      exportDate: json['exportDate'] as String?,
    );
  }

  // 기존 코드와의 호환성을 위한 getter
  String get date => timestamp;
}
