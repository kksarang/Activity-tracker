import 'package:activity/core/constants/app_routes.dart';
import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/home/presentation/pages/smart_action_screen.dart';
import 'package:activity/features/home/presentation/providers/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeActionButtons extends ConsumerWidget {
  const HomeActionButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          context,
          isDark,
          Icons.arrow_upward_rounded,
          'Pay',
          () => _showPaySheet(context, isDark),
        ),
        _buildActionButton(
          context,
          isDark,
          Icons.arrow_downward_rounded,
          'Collect',
          () => _showCollectSheet(context, isDark),
        ),
        _buildActionButton(
          context,
          isDark,
          Icons.qr_code_scanner_rounded,
          'Scan Bill',
          () => _showScanSheet(context, isDark),
        ),
        _buildActionButton(
          context,
          isDark,
          Icons.grid_view_rounded,
          'Insights',
          () => _showToolsSheet(context, isDark, ref),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    bool isDark,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: AppTheme.glassDecoration(isDark: isDark, radius: 20)
                .copyWith(
                  color: isDark ? AppColors.darkGlassOverlay : Colors.white,
                ),
            child: Icon(icon, color: AppColors.primaryPurple),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black54,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showPaySheet(BuildContext context, bool isDark) {
    _showActionSheet(context, isDark, 'Pay', [
      _ActionItem(Icons.add_circle_outline, 'Add Expense (Self)', () {
        Navigator.pop(context);
        context.push(AppRoutes.addExpense, extra: false);
      }),
      _ActionItem(Icons.attach_money, 'Add Income', () {
        Navigator.pop(context);
        context.push(AppRoutes.addExpense, extra: true);
      }),
      _ActionItem(Icons.person_outline, 'Pay to Friend', () {
        Navigator.pop(context);
        context.push(AppRoutes.smartAction, extra: SmartActionType.payToFriend);
      }),
      _ActionItem(Icons.account_balance_wallet_outlined, 'Settle Balance', () {
        Navigator.pop(context);
        context.push(
          AppRoutes.smartAction,
          extra: SmartActionType.settleBalance,
        );
      }),
      _ActionItem(Icons.compare_arrows, 'Wallet Transfer', () {
        Navigator.pop(context);
        context.push(
          AppRoutes.smartAction,
          extra: SmartActionType.walletTransfer,
        );
      }),
    ]);
  }

  void _showCollectSheet(BuildContext context, bool isDark) {
    _showActionSheet(context, isDark, 'Collect', [
      _ActionItem(Icons.person_add_outlined, 'Request from Friend', () {
        Navigator.pop(context);
        context.push(
          AppRoutes.smartAction,
          extra: SmartActionType.requestFromFriend,
        );
      }),
      _ActionItem(Icons.group_add_outlined, 'Request from Group', () {
        Navigator.pop(context);
        context.push(
          AppRoutes.smartAction,
          extra: SmartActionType.requestFromGroup,
        );
      }),
      _ActionItem(Icons.receipt_long_outlined, 'Split Custom Amount', () {
        Navigator.pop(context);
        context.push(AppRoutes.splitBill);
      }),
      _ActionItem(Icons.pending_actions_outlined, 'Pending Requests', () {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('No pending requests')));
      }),
    ]);
  }

  void _showScanSheet(BuildContext context, bool isDark) {
    _showActionSheet(context, isDark, 'Scan Bill', [
      _ActionItem(Icons.document_scanner_outlined, 'Scan Receipt', () {
        Navigator.pop(context);
        context.push(AppRoutes.scanSimulation);
      }),
      _ActionItem(Icons.qr_code, 'Scan QR Code', () {
        Navigator.pop(context);
        context.push(AppRoutes.scanSimulation);
      }),
      _ActionItem(Icons.group_outlined, 'Scan & Split', () {
        Navigator.pop(context);
        context.push(AppRoutes.splitBill);
      }),
    ]);
  }

  void _showToolsSheet(BuildContext context, bool isDark, WidgetRef ref) {
    _showActionSheet(context, isDark, 'Insights & Settings', [
      _ActionItem(Icons.analytics_outlined, 'Expense Analytics', () async {
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 150));
        if (context.mounted) {
          context.push(AppRoutes.analytics);
        }
      }),
      _ActionItem(Icons.description_outlined, 'Monthly Reports', () async {
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 150));
        if (context.mounted) context.push(AppRoutes.monthlyReport);
      }),
      _ActionItem(Icons.category_outlined, 'Categories', () async {
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 150));
        if (context.mounted) context.push(AppRoutes.categories);
      }),
      _ActionItem(Icons.account_balance, 'Set Opening Balance', () async {
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 150));
        if (context.mounted) {
          _showOpeningBalanceDialog(context, ref);
        }
      }),
      _ActionItem(Icons.savings_outlined, 'Budget Settings', () async {
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 150));
        if (context.mounted) context.push(AppRoutes.budgetSettings);
      }),
      _ActionItem(Icons.settings_outlined, 'App Settings', () async {
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 150));
        if (context.mounted) context.push(AppRoutes.appSettings);
      }),
    ]);
  }

  void _showOpeningBalanceDialog(BuildContext context, WidgetRef ref) {
    // Note: Strings should ideally be in AppStrings or HomeStrings
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Opening Balance'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            prefixText: '₹', // TODO: Use AppStrings
            hintText: 'Enter amount',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final amount = double.tryParse(controller.text);
              if (amount != null) {
                ref.read(activityProvider.notifier).setOpeningBalance(amount);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showActionSheet(
    BuildContext context,
    bool isDark,
    String title,
    List<_ActionItem> actions,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E212B) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...actions.map(
                  (action) => ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryPurple.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        action.icon,
                        color: AppColors.primaryPurple,
                        size: 20,
                      ),
                    ),
                    title: Text(action.label),
                    onTap: () {
                      action.onTap();
                    },
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionItem {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  _ActionItem(this.icon, this.label, this.onTap);
}
