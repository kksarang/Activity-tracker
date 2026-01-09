import 'package:activity/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AddFriendBottomSheet extends StatelessWidget {
  const AddFriendBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Invite Friend',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter email or phone number to invite',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: AppTheme.glassDecoration(isDark: isDark, radius: 16)
                .copyWith(
                  color: isDark
                      ? const Color(0xFF2C2C2E)
                      : Colors.grey.withOpacity(0.1),
                  border: Border.all(color: Colors.transparent),
                ),
            child: TextField(
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'john@example.com',
                icon: Icon(
                  Icons.email_outlined,
                  color: AppColors.primaryPurple,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invitation sent!')),
                );
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Send Invite',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).viewInsets.bottom,
          ), // keyboard padding
        ],
      ),
    );
  }
}
