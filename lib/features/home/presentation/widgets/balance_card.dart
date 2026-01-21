import 'package:activity/core/constants/app_routes.dart';
import 'package:activity/core/constants/app_strings.dart';
import 'package:activity/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BalanceCard extends StatelessWidget {
  final double currentBalance;
  final double totalIncome;
  final double totalExpense;

  const BalanceCard({
    super.key,
    required this.currentBalance,
    required this.totalIncome,
    required this.totalExpense,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => context.push(AppRoutes.dailyTracker),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: size.height * 0.22),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDark],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.4),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(context),
            _buildBalance(context),
            _buildStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
      AppStrings.totalBalance,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.7),
        fontSize: 16,
      ),
    );
  }

  Widget _buildBalance(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        '${AppStrings.currencySymbol}${currentBalance.toStringAsFixed(2)}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _CardStat(
          label: AppStrings.income,
          value:
              '${AppStrings.currencySymbol}${totalIncome.toStringAsFixed(2)}',
          color: AppColors.accentGreen,
          icon: Icons.arrow_downward,
        ),
        _CardStat(
          label: AppStrings.expense,
          value:
              '${AppStrings.currencySymbol}${totalExpense.toStringAsFixed(2)}',
          color: AppColors.accentRed,
          icon: Icons.arrow_upward,
        ),
      ],
    );
  }
}

class _CardStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _CardStat({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: color),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
