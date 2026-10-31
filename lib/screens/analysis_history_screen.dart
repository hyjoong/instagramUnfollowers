import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'analysis_visualization_screen.dart';
import 'package:share_plus/share_plus.dart';

class AnalysisHistoryScreen extends StatefulWidget {
  const AnalysisHistoryScreen({super.key});

  @override
  State<AnalysisHistoryScreen> createState() => _AnalysisHistoryScreenState();
}

class _AnalysisHistoryScreenState extends State<AnalysisHistoryScreen>
    with AutomaticKeepAliveClientMixin {
  List<AnalysisResult> _history = [];
  bool _isLoading = true;
  Timer? _refreshTimer;

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

      setState(() {
        _history = historyJson
            .map((json) => AnalysisResult.fromJson(jsonDecode(json)))
            .toList();
        _isLoading = false;
      });

    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
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
      _history.removeAt(index);

      final historyJson =
          _history.map((result) => jsonEncode(result.toJson())).toList();

      await prefs.setStringList('analysis_history', historyJson);
      setState(() {});

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
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _history.isEmpty
              ? _buildEmptyState()
              : _buildHistoryList(),
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
                final result = _history[index];
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
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              AnalysisVisualizationScreen(
                            analysisId: result.id,
                          ),
                        ),
                      );
                    },
                    title: Text(
                      '분석 ${_history.length - index}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        _buildStatRow('언팔로워', result.unfollowersCount),
                        _buildStatRow('팬', result.fansCount),
                        _buildStatRow('맞팔', result.mutualCount),
                        const SizedBox(height: 8),
                        Text(
                          '날짜: ${_formatDate(result.date)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.share, color: Colors.blue),
                          onPressed: () => _shareAnalysis(result),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red),
                          onPressed: () => _deleteHistoryItem(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, int count) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFEC4899),
            ),
          ),
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
    );
  }

  // 기존 코드와의 호환성을 위한 getter
  String get date => timestamp;
}
