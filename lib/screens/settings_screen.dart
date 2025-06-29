import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'faq_screen.dart';
import 'terms_screen.dart';
import 'privacy_screen.dart';
import 'analysis_history_screen.dart';
import 'theme_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          '설정',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('지원 및 법적 고지'),
            const SizedBox(height: 12),
            _buildButton(
              '자주 묻는 질문',
              Icons.help_outline,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQScreen()),
              ),
            ),
            const SizedBox(height: 8),
            _buildButton(
              '이용약관',
              Icons.description_outlined,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TermsScreen()),
              ),
            ),
            const SizedBox(height: 8),
            _buildButton(
              '개인정보 처리방침',
              Icons.privacy_tip_outlined,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyScreen()),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('분석 히스토리'),
            const SizedBox(height: 12),
            _buildButton(
              '분석 히스토리 보기',
              Icons.history,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AnalysisHistoryScreen()),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('앱 정보'),
            const SizedBox(height: 12),
            _buildInfoCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildButton(String label, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFEC4899).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: const Color(0xFFEC4899),
          size: 20,
        ),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'TrackFollows 소개',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'TrackFollows는 개인정보 보호에 중점을 둔 인스타그램 분석 도구입니다. 모든 처리는 브라우저에서 로컬로 이루어지며, 개인정보를 수집하거나 저장하지 않습니다.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            '© 2025 TrackFollows. 모든 권리 보유.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
