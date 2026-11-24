import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'analysis_visualization_screen.dart';
import 'history_compare_screen.dart';
import '../history/history_compare.dart';
import 'package:share_plus/share_plus.dart';
import '../ads/ad_consent_controller.dart';
import '../ads/admob_native_card.dart';
import 'package:intl/intl.dart';
import '../l10n/gen/app_localizations.dart';

class AnalysisHistoryScreen extends StatefulWidget {
  const AnalysisHistoryScreen({
    super.key,
    this.nativeAdUnitId,
    this.adConsent,
    this.adsAlwaysAllowed = false,
  });

  /// Null hides the ad card.
  final String? nativeAdUnitId;
  final AdConsentController? adConsent;

  /// Test builds request sample ads without waiting for consent.
  final bool adsAlwaysAllowed;

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

  AppLocalizations get _l10n => AppLocalizations.of(context);
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
        SnackBar(content: Text(_l10n.historyLowOverlap)),
      );
      return;
    }
    _openCompare(compareSnapshots(picked[0], picked[1]));
  }

  Future<void> _deleteHistoryItem(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(_l10n.historyDeleteTitle),
        content: Text(_l10n.historyDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(_l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              _l10n.commonDelete,
              style: const TextStyle(color: Colors.red),
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
          SnackBar(
            content: Text(_l10n.historyDeleted),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_l10n.historyDeleteFailed),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _formatDate(String timestamp) {
    try {
      final date = DateTime.parse(timestamp).toLocal();
      final locale = Localizations.localeOf(context).toLanguageTag();
      return DateFormat.yMMMd(locale).add_Hm().format(date);
    } catch (e) {
      return timestamp;
    }
  }

  void _shareAnalysis(AnalysisResult result) {
    final l10n = _l10n;
    final analysisText = '''
${l10n.historyShareSubject}

📊 ${l10n.statsSummary}:
• ${l10n.commonUnfollowers}: ${result.unfollowersCount}
• ${l10n.commonFans}: ${result.fansCount}
• ${l10n.commonMutual}: ${result.mutualCount}
• ${l10n.commonTotalFollowers}: ${result.totalFollowers}
• ${l10n.commonTotalFollowing}: ${result.totalFollowing}

📅 ${l10n.statsAnalysisDate}: ${_formatDate(result.timestamp)}

${l10n.historyShareFooter}
''';

    Share.share(analysisText, subject: l10n.historyShareSubject);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          _l10n.historyTitle,
          style: const TextStyle(
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
              child: Text(_selecting ? _l10n.commonCancel : _l10n.historyCompare,
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
                      ? _l10n.historyCompareSelected
                      : _l10n.historyCompareHint('${_selectedIds.length}')),
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
          Text(
            _l10n.historyEmptyTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _l10n.historyEmptyBody,
            style: const TextStyle(
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
              itemCount: _history.length + (_showsAdCard ? 1 : 0),
              itemBuilder: (context, listIndex) {
                if (_showsAdCard && listIndex == _adCardIndex) {
                  return _buildAdCard();
                }
                final index = _showsAdCard && listIndex > _adCardIndex
                    ? listIndex - 1
                    : listIndex;
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

  /// 광고 카드는 가장 최근 기록 바로 아래에 한 장만 둔다.
  static const _adCardIndex = 1;

  bool get _showsAdCard =>
      widget.nativeAdUnitId != null && _history.isNotEmpty && !_selecting;

  Widget _buildAdCard() {
    final consent = widget.adConsent;
    if (consent == null) {
      return AdMobNativeCard(
        key: const ValueKey('history_native_ad'),
        adUnitId: widget.nativeAdUnitId,
        canRequestAds: widget.adsAlwaysAllowed,
      );
    }
    return AnimatedBuilder(
      animation: consent,
      builder: (context, child) => AdMobNativeCard(
        key: const ValueKey('history_native_ad'),
        adUnitId: widget.nativeAdUnitId,
        canRequestAds: widget.adsAlwaysAllowed || consent.canRequestAds,
      ),
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
                        ? _l10n.historyExportedOn(formatSnapshotDate(snapshot))
                        : formatSnapshotDate(snapshot),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _l10n.historyCounts('${result.totalFollowers}', '${result.totalFollowing}', '${result.unfollowersCount}'),
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  _buildChangeChip(diff),
                  const SizedBox(height: 6),
                  Text(
                    _l10n.historyAnalyzedOn(_formatDate(result.date)),
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
                itemBuilder: (_) => [
                  PopupMenuItem(value: 'stats', child: Text(_l10n.historyViewStats)),
                  PopupMenuItem(value: 'share', child: Text(_l10n.historyShare)),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(_l10n.commonDelete, style: const TextStyle(color: Colors.red)),
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
      return Text(_l10n.historyFirstRecord,
          style: const TextStyle(fontSize: 12, color: Colors.grey));
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
            Text(_l10n.historyNoChange,
                style: const TextStyle(fontSize: 12, color: Colors.black54))
          else ...[
            Text('${_l10n.historyVsPrevious}  ',
                style: const TextStyle(fontSize: 12, color: Colors.black54)),
            Text(_l10n.historyLostCount('$lost'),
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)),
            const Text('  ·  ', style: TextStyle(fontSize: 12, color: Colors.black38)),
            Text(_l10n.historyGainedCount('$gained'),
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
