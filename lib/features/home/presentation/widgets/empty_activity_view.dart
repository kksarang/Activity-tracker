import 'package:activity/core/constants/app_routes.dart';
import 'package:activity/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmptyActivityView extends StatelessWidget {
  const EmptyActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history_edu,
                size: 48,
                color: Colors.grey.withValues(alpha: 0.5),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              AppStrings.noActivity,
              style: TextStyle(
                color: Colors.grey.withValues(alpha: 0.8),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              AppStrings.addFirstTransaction,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => context.push(AppRoutes.addExpense),
              icon: const Icon(Icons.add),
              label: const Text('Add Transaction'),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
