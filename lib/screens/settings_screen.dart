import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../ads/ad_consent_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_locale.dart';
import '../reminders/recheck_reminder.dart';
import '../webview_service.dart';
import 'faq_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    this.adConsent,
    this.reminder,
    this.localeStore,
  });

  final AdConsentController? adConsent;
  final RecheckReminderController? reminder;
  final AppLocaleStore? localeStore;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _appVersion = '';
  String _buildNumber = '';
  bool _reminderEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
    _loadReminder();
  }

  Future<void> _loadReminder() async {
    final enabled = await widget.reminder?.isEnabled() ?? false;
    if (!mounted) return;
    setState(() => _reminderEnabled = enabled);
  }

  Future<void> _setReminder(bool value) async {
    final reminder = widget.reminder;
    if (reminder == null) return;
    if (!value) {
      await reminder.disable();
    } else if (!await reminder.enable()) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('알림 권한이 꺼져 있어요. 기기 설정에서 알림을 허용해 주세요.'),
      ));
      return;
    }
    if (!mounted) return;
    setState(() => _reminderEnabled = value);
  }

  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (!mounted) return;
    setState(() {
      _appVersion = packageInfo.version;
      _buildNumber = packageInfo.buildNumber;
    });
  }

  /// Legal documents live on the web only, so they stay in one place.
  Future<void> _openLegalPage(String path) async {
    final locale = widget.localeStore?.value ?? fallbackLocale;
    final url = Uri.parse(legalUrlFor(WebViewService.webOrigin, locale, path));
    final opened = await launchUrl(url, mode: LaunchMode.externalApplication)
        .catchError((_) => false);
    if (opened || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('링크를 열지 못했어요.')),
    );
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
            if (widget.reminder != null) ...[
              _buildSectionTitle('알림'),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _reminderEnabled,
                onChanged: _setReminder,
                activeThumbColor: const Color(0xFFEC4899),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: const Text('다시 확인 알림'),
                subtitle: const Text('분석하고 2주 뒤에 새 파일로 확인하라고 알려 드려요'),
              ),
              const SizedBox(height: 24),
            ],
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
              () => _openLegalPage('/terms'),
            ),
            const SizedBox(height: 8),
            _buildButton(
              '개인정보 처리방침',
              Icons.privacy_tip_outlined,
              () => _openLegalPage('/privacy'),
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
