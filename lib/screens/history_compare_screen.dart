import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../history/history_compare.dart';
import 'analysis_visualization_screen.dart';

const _pink = Color(0xFFEC4899);

String formatSnapshotDate(HistorySnapshot s) {
  final d = s.date;
  final day =
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  return s.dateFromFileName ? day : '$day (분석일)';
}

/// 두 분석 기록 사이에 달라진 팔로워를 보여 주는 화면
class HistoryCompareScreen extends StatelessWidget {
  const HistoryCompareScreen({super.key, required this.diff});

  final HistoryDiff diff;

  @override
  Widget build(BuildContext context) {
    final usesAnalysisDate =
        !diff.older.dateFromFileName || !diff.newer.dateFromFileName;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('기록 비교',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: '최근 기록 통계',
            icon: const Icon(Icons.bar_chart, color: Colors.black54),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) =>
                  AnalysisVisualizationScreen(analysisId: diff.newer.id),
            )),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _Header(diff: diff),
          if (usesAnalysisDate)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                '(분석일)은 파일 이름에 내보낸 날짜가 없는 예전 기록이라 분석한 날로 표시했어요.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          const SizedBox(height: 16),
          _Section(
            icon: Icons.person_remove_outlined,
            color: Colors.red,
            title: '나를 언팔한 사람',
            names: diff.lostFollowers,
            emptyText: '이 기간에 나를 언팔한 사람이 없어요.',
            initiallyExpanded: true,
          ),
          _Section(
            icon: Icons.person_add_alt_outlined,
            color: Colors.green,
            title: '새 팔로워',
            names: diff.newFollowers,
            emptyText: '이 기간에 새로 생긴 팔로워가 없어요.',
          ),
          if (diff.renamed.isNotEmpty)
            _Section(
              icon: Icons.sync,
              color: Colors.grey,
              title: '아이디를 바꾼 계정',
              names: [for (final r in diff.renamed) r.to],
              labels: [for (final r in diff.renamed) '@${r.from} → @${r.to}'],
              emptyText: '',
            ),
          const SizedBox(height: 12),
          const Text(
            '목록에서 사라진 계정 중에는 언팔 대신 계정을 비활성화·삭제한 경우도 있어요. 프로필을 눌러 확인해 보세요.',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.diff});
  final HistoryDiff diff;

  @override
  Widget build(BuildContext context) {
    final change = diff.followerChange;
    final changeText = change == 0 ? '변화 없음' : (change > 0 ? '+$change' : '$change');
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.pink.shade50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${formatSnapshotDate(diff.older)} → ${formatSnapshotDate(diff.newer)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          const Text('날짜는 인스타그램에서 파일을 내보낸 날이에요.',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 12),
          Row(
            children: [
              _Stat(label: '팔로워', value: '${diff.older.followers.length} → ${diff.newer.followers.length}'),
              _Stat(label: '증감', value: changeText),
              _Stat(label: '언팔', value: '${diff.lostFollowers.length}', color: Colors.red),
              _Stat(label: '새 팔로워', value: '${diff.newFollowers.length}', color: Colors.green.shade700),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value, this.color = Colors.black87});
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.icon,
    required this.color,
    required this.title,
    required this.names,
    required this.emptyText,
    this.labels,
    this.initiallyExpanded = false,
  });

  final IconData icon;
  final Color color;
  final String title;
  final List<String> names;
  final List<String>? labels;
  final String emptyText;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        initiallyExpanded: initiallyExpanded && names.isNotEmpty,
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Text('${names.length}',
            style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
        children: names.isEmpty
            ? [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Text(emptyText, style: const TextStyle(color: Colors.grey)),
                )
              ]
            : [
                for (var i = 0; i < names.length; i++)
                  ListTile(
                    dense: true,
                    title: Text(labels?[i] ?? '@${names[i]}'),
                    trailing: const Icon(Icons.open_in_new, size: 18, color: _pink),
                    onTap: () => launchUrl(
                      Uri.parse('https://www.instagram.com/${names[i]}/'),
                      mode: LaunchMode.externalApplication,
                    ),
                  ),
              ],
      ),
    );
  }
}
