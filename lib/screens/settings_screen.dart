import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../ads/ad_consent_controller.dart';
import 'faq_screen.dart';
import 'terms_screen.dart';
import 'privacy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, this.adConsent});

  final AdConsentController? adConsent;

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
    if (!mounted) return;
    setState(() {
      _appVersion = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  Future<void> _showAdPrivacyOptions() async {
    final error = await widget.adConsent?.showPrivacyOptions();
    if (!mounted || error == null) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
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
            if (widget.adConsent != null)
              AnimatedBuilder(
                animation: widget.adConsent!,
                builder: (context, child) {
                  final consent = widget.adConsent!;
                  if (!consent.privacyOptionsRequired) {
                    return const SizedBox.shrink();
                  }
                  return Column(children: [
                    const SizedBox(height: 8),
                    _buildButton(
                      '광고 개인정보 설정',
                      Icons.tune,
                      consent.isBusy ? null : _showAdPrivacyOptions,
                    ),
                  ]);
                },
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

  Widget _buildButton(String label, IconData icon, VoidCallback? onTap) {
    return ListTile(
      enabled: onTap != null,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFEC4899).withValues(alpha: 0.1),
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
            color: Colors.grey.withValues(alpha: 0.1),
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
            'TrackFollows는 인스타그램 데이터를 기기에서 분석하는 도구입니다. 광고 서비스의 정보 처리에 관한 내용은 개인정보 처리방침에서 확인할 수 있습니다.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (_appVersion.isNotEmpty)
            Text(
              '버전 $_appVersion ($_buildNumber)',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 4),
          const Text(
            '© 2025-2026 TrackFollows. 모든 권리 보유.',
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
