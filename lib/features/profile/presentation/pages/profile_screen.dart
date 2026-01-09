import 'package:activity/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient blobs
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mint.withOpacity(0.2),
                boxShadow: const [
                  BoxShadow(blurRadius: 100, color: AppColors.mint),
                ],
              ),
            ),
          ),

          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const SizedBox(height: 20),
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                          image: const DecorationImage(
                            image: NetworkImage(
                              'https://i.pravatar.cc/300?u=a042581f4e29026024d',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Sarang R',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'sarang@example.com',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark ? Colors.white60 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Settings Section
                Text(
                  'Settings',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryPurple,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsTile(
                  context,
                  isDark,
                  Icons.group_add_outlined,
                  'Create New Group',
                  onTap: () => context.push('/create-group'),
                ),
                _buildSettingsTile(
                  context,
                  isDark,
                  Icons.person_outline,
                  'Personal Information',
                ),
                _buildSettingsTile(
                  context,
                  isDark,
                  Icons.credit_card,
                  'Payment Methods',
                ),
                _buildSettingsTile(
                  context,
                  isDark,
                  Icons.notifications_none,
                  'Notifications',
                ),
                _buildSettingsTile(context, isDark, Icons.security, 'Security'),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/'),
                    icon: const Icon(Icons.logout),
                    label: const Text('Log Out'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      side: const BorderSide(color: Colors.redAccent),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 2,
        backgroundColor: isDark ? const Color(0xFF1E212B) : Colors.white,
        elevation: 0,
        height: 70,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          NavigationDestination(
            icon: Icon(Icons.pie_chart_outline_rounded),
            selectedIcon: Icon(Icons.pie_chart_rounded),
            label: 'Split Bill',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
        onDestinationSelected: (index) {
          if (index == 0) context.go('/home');
          if (index == 1) context.go('/split-bill');
        },
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    bool isDark,
    IconData icon,
    String title, {
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: AppTheme.glassDecoration(isDark: isDark, radius: 16).copyWith(
        color: isDark
            ? AppColors.darkGlassOverlay
            : Colors.white.withOpacity(0.8),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryPurple.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryPurple, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
