import 'package:activity/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class BudgetSettingsScreen extends StatelessWidget {
  const BudgetSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF121212)
          : const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Budget Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildBudgetCard(context, isDark),
            const SizedBox(height: 24),
            Text(
              'Budget per Category',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildCategoryBudgetList(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCard(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Monthly Limit',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit, color: AppColors.primaryPurple),
              ),
            ],
          ),
          const Divider(height: 32),
          const Text(
            '₹20,000',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryPurple,
            ),
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: 0.65, // Mock progress
            backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.1),
            color: AppColors.primaryPurple,
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Spent: ₹13,000'), Text('Remaining: ₹7,000')],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBudgetList(BuildContext context, bool isDark) {
    // Mock data
    final budgets = [
      {'name': 'Food', 'limit': '₹8,000', 'spent': '₹5,500', 'percent': 0.68},
      {
        'name': 'Transport',
        'limit': '₹5,000',
        'spent': '₹2,000',
        'percent': 0.4,
      },
      {
        'name': 'Shopping',
        'limit': '₹4,000',
        'spent': '₹3,500',
        'percent': 0.87,
      },
    ];

    return Column(
      children: budgets.map((budget) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    budget['name'] as String,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${budget['spent']} / ${budget['limit']}',
                    style: TextStyle(
                      color: isDark ? Colors.white70 : Colors.black54,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              LinearProgressIndicator(
                value: budget['percent'] as double,
                backgroundColor: AppColors.primaryPurple.withValues(alpha: 0.1),
                color: (budget['percent'] as double) > 0.8
                    ? Colors.redAccent
                    : AppColors.primaryPurple,
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
