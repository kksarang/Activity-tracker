import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/core/theme/theme_provider.dart';
import 'package:activity/features/settings/constants/settings_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettingsScreen extends ConsumerStatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  ConsumerState<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends ConsumerState<AppSettingsScreen> {
  bool _notifications = true;
  bool _biometrics = false;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Determine the switch state based on the actual theme mode or system brightness if system
    final bool isDarkModeSwitchOn =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            MediaQuery.platformBrightnessOf(context) == Brightness.dark);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(SettingsStrings.appSettings),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader(SettingsStrings.preferences),
          _buildSwitchTile(
            SettingsStrings.darkMode,
            SettingsStrings.darkModeDesc,
            isDarkModeSwitchOn,
            (val) {
              ref.read(themeProvider.notifier).toggleTheme(val);
            },
            icon: Icons.dark_mode_outlined,
          ),
          _buildSwitchTile(
            SettingsStrings.notifications,
            SettingsStrings.notificationsDesc,
            _notifications,
            (val) => setState(() => _notifications = val),
            icon: Icons.notifications_none_rounded,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(SettingsStrings.security),
          _buildSwitchTile(
            SettingsStrings.biometricLock,
            SettingsStrings.biometricLockDesc,
            _biometrics,
            (val) => setState(() => _biometrics = val),
            icon: Icons.fingerprint,
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(SettingsStrings.about),
          _buildListTile(
            SettingsStrings.version,
            '1.0.0 (Build 24)',
            onTap: () {},
            icon: Icons.info_outline,
          ),
          _buildListTile(
            SettingsStrings.privacyPolicy,
            SettingsStrings.privacyPolicyDesc,
            onTap: () {},
            icon: Icons.privacy_tip_outlined,
          ),
          _buildListTile(
            SettingsStrings.termsOfService,
            SettingsStrings.termsOfServiceDesc,
            onTap: () {},
            icon: Icons.description_outlined,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                // Show logout dialog
              },
              style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
              child: const Text(SettingsStrings.logOut),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryPurple,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged, {
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryPurple,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        ),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryPurple.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryPurple),
        ),
      ),
    );
  }

  Widget _buildListTile(
    String title,
    String subtitle, {
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryPurple.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryPurple),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }
}
