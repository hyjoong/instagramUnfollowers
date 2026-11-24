import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../history/history_compare.dart';
import '../l10n/gen/app_localizations.dart';
import 'analysis_visualization_screen.dart';

const _pink = Color(0xFFEC4899);

String formatSnapshotDate(HistorySnapshot s, AppLocalizations l10n) {
  final day = DateFormat.yMMMd(l10n.localeName).format(s.date);
  return s.dateFromFileName ? day : l10n.compareAnalysisDay(day);
}

/// 두 분석 기록 사이에 달라진 팔로워를 보여 주는 화면
class HistoryCompareScreen extends StatelessWidget {
  const HistoryCompareScreen({super.key, required this.diff});

  final HistoryDiff diff;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final usesAnalysisDate =
        !diff.older.dateFromFileName || !diff.newer.dateFromFileName;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(l10n.compareTitle,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: l10n.compareRecentStats,
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
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                l10n.compareAnalysisDayNote,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          const SizedBox(height: 16),
          _Section(
            icon: Icons.person_remove_outlined,
            color: Colors.red,
            title: l10n.compareLostTitle,
            names: diff.lostFollowers,
            emptyText: l10n.compareLostEmpty,
            initiallyExpanded: true,
          ),
          _Section(
            icon: Icons.person_add_alt_outlined,
            color: Colors.green,
            title: l10n.commonNewFollowers,
            names: diff.newFollowers,
            emptyText: l10n.compareNewEmpty,
          ),
          if (diff.renamed.isNotEmpty)
            _Section(
              icon: Icons.sync,
              color: Colors.grey,
              title: l10n.compareRenamedTitle,
              names: [for (final r in diff.renamed) r.to],
              labels: [for (final r in diff.renamed) '@${r.from} → @${r.to}'],
              emptyText: '',
            ),
          const SizedBox(height: 12),
          Text(
            l10n.compareDisappearedNote,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
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
    final l10n = AppLocalizations.of(context);
    final change = diff.followerChange;
    final changeText = change == 0 ? l10n.compareNoChange : (change > 0 ? '+$change' : '$change');
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
            '${formatSnapshotDate(diff.older, l10n)} → ${formatSnapshotDate(diff.newer, l10n)}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(l10n.compareExportDateNote,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 12),
          Row(
            children: [
              _Stat(label: l10n.commonFollowers, value: '${diff.older.followers.length} → ${diff.newer.followers.length}'),
              _Stat(label: l10n.compareChange, value: changeText),
              _Stat(label: l10n.compareLost, value: '${diff.lostFollowers.length}', color: Colors.red),
              _Stat(label: l10n.commonNewFollowers, value: '${diff.newFollowers.length}', color: Colors.green.shade700),
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
