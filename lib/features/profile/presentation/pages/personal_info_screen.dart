import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PersonalInformationScreen extends ConsumerWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userAsync = ref.watch(authStateProvider);
    final user = userAsync.value;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Personal Information',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient blobs
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryPurple.withValues(alpha: 0.15),
                boxShadow: const [
                  BoxShadow(blurRadius: 100, color: AppColors.primaryPurple),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.softPink.withValues(alpha: 0.1),
                boxShadow: const [
                  BoxShadow(blurRadius: 100, color: AppColors.softPink),
                ],
              ),
            ),
          ),

          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Hero(
                    tag: 'profile_pic',
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        color: Colors.grey.withValues(alpha: 0.1),
                      ),
                      child: ClipOval(
                        child: Image.network(
                          user?.photoUrl ??
                              'https://i.pravatar.cc/300?u=a042581f4e29026024d',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.withValues(alpha: 0.2),
                              child: const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Details Sections
                _buildSectionHeader(context, 'Basic Details'),
                const SizedBox(height: 16),
                _buildInfoTile(
                  context,
                  isDark,
                  label: 'Full Name',
                  value: user?.name ?? 'Guest User',
                  icon: Icons.person_outline_rounded,
                ),
                _buildInfoTile(
                  context,
                  isDark,
                  label: 'Email Address',
                  value: user?.email ?? 'No email linked',
                  icon: Icons.email_outlined,
                ),

                // Add phone number placeholder if user might want it
                // _buildInfoTile(
                //   context,
                //   isDark,
                //   label: 'Phone Number',
                //   value: '+1 (555) 000-0000',
                //   icon: Icons.phone_outlined,
                // ),
                const SizedBox(height: 32),
                _buildSectionHeader(context, 'Account Status'),
                const SizedBox(height: 16),
                _buildInfoTile(
                  context,
                  isDark,
                  label: 'User ID',
                  value: user?.id ?? 'N/A',
                  icon: Icons.badge_outlined,
                  isCopyable: true,
                ),
                _buildInfoTile(
                  context,
                  isDark,
                  label: 'Verification',
                  value: (user?.isEmailVerified ?? false)
                      ? 'Verified'
                      : 'Unverified',
                  icon: (user?.isEmailVerified ?? false)
                      ? Icons.verified_user_rounded
                      : Icons.gpp_maybe_outlined,
                  valueColor: (user?.isEmailVerified ?? false)
                      ? AppColors.accentGreen
                      : AppColors.accentOrange,
                ),

                const SizedBox(height: 32),
                _buildSectionHeader(context, 'Preferences'),
                const SizedBox(height: 16),
                _buildInfoTile(
                  context,
                  isDark,
                  label: 'Language',
                  value: 'English (US)',
                  icon: Icons.language_rounded,
                ),
                _buildInfoTile(
                  context,
                  isDark,
                  label: 'Timezone',
                  value: 'UTC-05:00', // Mock data
                  icon: Icons.access_time_rounded,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: AppColors.primaryPurple,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context,
    bool isDark, {
    required String label,
    required String value,
    required IconData icon,
    bool isCopyable = false,
    Color? valueColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.glassDecoration(isDark: isDark, radius: 16).copyWith(
        color: isDark
            ? AppColors.darkGlassOverlay
            : Colors.white.withValues(alpha: 0.8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryPurple, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white60 : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color:
                        valueColor ??
                        (isDark ? Colors.white : AppColors.textPrimary),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (isCopyable)
            IconButton(
              icon: const Icon(
                Icons.copy_rounded,
                size: 18,
                color: Colors.grey,
              ),
              onPressed: () {
                // TODO: Implement copy
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Copied to clipboard'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
