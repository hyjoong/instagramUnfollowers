import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../ads/ad_consent_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import '../l10n/app_locale.dart';
import '../l10n/gen/app_localizations.dart';
import '../reminders/recheck_reminder.dart';
import '../webview_service.dart';
import 'faq_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    this.adConsent,
    this.reminder,
    this.localeStore,
    this.onLocaleSelected,
  });

  final AdConsentController? adConsent;
  final RecheckReminderController? reminder;
  final AppLocaleStore? localeStore;

  /// Called after the user picks a language, with the resulting app language
  /// (used to reopen the WebView in it).
  final ValueChanged<Locale>? onLocaleSelected;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppLocalizations get _l10n => AppLocalizations.of(context);

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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_l10n.commonNotificationPermissionOff),
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
      SnackBar(content: Text(_l10n.settingsOpenLinkFailed)),
    );
  }

  Future<void> _pickLanguage() async {
    final store = widget.localeStore;
    if (store == null) return;
    // '' stands for "follow the device language".
    final current = store.savedCode ?? '';
    final picked = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (final code in ['', ...supportedLanguageCodes])
              ListTile(
                title: Text(code.isEmpty
                    ? _l10n.settingsLanguageSystem
                    : languageNativeNames[code]!),
                trailing: code == current
                    ? const Icon(Icons.check, color: Color(0xFFEC4899))
                    : null,
                onTap: () => Navigator.of(context).pop(code),
              ),
          ],
        ),
      ),
    );
    if (picked == null || picked == current) return;
    await store.select(picked.isEmpty ? null : Locale(picked));
    widget.onLocaleSelected?.call(store.value);
  }

  Future<void> _showAdPrivacyOptions() async {
    final error = await widget.adConsent?.showPrivacyOptions();
    if (!mounted || error == null) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error.message(_l10n))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          _l10n.settingsTitle,
          style: const TextStyle(
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
              _buildSectionTitle(_l10n.settingsNotificationsSection),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _reminderEnabled,
                onChanged: _setReminder,
                activeThumbColor: const Color(0xFFEC4899),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: Text(_l10n.settingsRecheckTitle),
                subtitle: Text(_l10n.settingsRecheckBody),
              ),
              const SizedBox(height: 24),
            ],
            if (widget.localeStore != null) ...[
              _buildSectionTitle(_l10n.settingsLanguage),
              const SizedBox(height: 12),
              _buildButton(
                widget.localeStore!.savedCode == null
                    ? _l10n.settingsLanguageSystem
                    : languageNativeNames[widget.localeStore!.value.languageCode]!,
                Icons.language,
                _pickLanguage,
              ),
              const SizedBox(height: 24),
            ],
            _buildSectionTitle(_l10n.settingsSupportSection),
            const SizedBox(height: 12),
            _buildButton(
              _l10n.settingsFaq,
              Icons.help_outline,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FAQScreen()),
              ),
            ),
            const SizedBox(height: 8),
            _buildButton(
              _l10n.settingsTerms,
              Icons.description_outlined,
              () => _openLegalPage('/terms'),
            ),
            const SizedBox(height: 8),
            _buildButton(
              _l10n.settingsPrivacy,
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
                      _l10n.settingsAdPrivacy,
                      Icons.tune,
                      consent.isBusy ? null : _showAdPrivacyOptions,
                    ),
                  ]);
                },
              ),
            const SizedBox(height: 24),
            _buildSectionTitle(_l10n.settingsAppInfoSection),
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
          Text(
            _l10n.settingsAboutTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            _l10n.settingsAboutBody,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (_appVersion.isNotEmpty)
            Text(
              _l10n.settingsVersion(_appVersion, _buildNumber),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 4),
          Text(
            _l10n.settingsCopyright,
            style: const TextStyle(
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
