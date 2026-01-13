import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/home/presentation/pages/smart_action_screen.dart';
import 'package:activity/features/home/presentation/providers/activity_provider.dart';
import 'package:activity/features/shared/domain/models/activity_model.dart';
import 'package:activity/features/shared/domain/models/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activityState = ref.watch(activityProvider);
    final activities = activityState.activities;

    // Use data from provider
    final double currentBalance = activityState.accountBalance;
    final double totalExpense = activityState.totalExpense;
    final double totalIncome = activityState.totalIncome;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'My Wallet',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true, // ... rest of AppBar

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.darkGlassOverlay
                  : Colors.white.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                const Icon(Icons.notifications_none_rounded, size: 24),
                if (activityState.unreadNotificationCount > 0)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 8,
                        minHeight: 8,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // ... background gradients (unchanged)
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryPurple.withValues(alpha: 0.2),
                image: null,
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
                color: AppColors.softPink.withValues(alpha: 0.2),
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
                const SizedBox(height: 10),
                // Pass income as well
                _buildBalanceCard(
                  context,
                  currentBalance,
                  totalExpense,
                  totalIncome,
                ),
                const SizedBox(height: 32),
                _buildActionButtons(context, isDark, ref),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Brief Activity',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('See All')),
                  ],
                ),
                const SizedBox(height: 16),
                if (activities.isEmpty)
                  Padding(
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
                            'No activity yet',
                            style: TextStyle(
                              color: Colors.grey.withValues(alpha: 0.8),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add your first expense or income\nto start tracking.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          const SizedBox(height: 24),
                          OutlinedButton.icon(
                            onPressed: () => context.push('/add-expense'),
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
                  )
                else
                  ...activityState.recentActivities.map((activity) {
                    final isCredit =
                        activity.direction == ActivityDirection.credit;
                    final sign = isCredit ? '+' : '-';
                    final color = isCredit
                        ? AppColors.mint
                        : (isDark ? Colors.white : Colors.black87);

                    IconData icon;
                    switch (activity.type) {
                      case ActivityType.income:
                        icon = Icons.arrow_downward_rounded;
                        break;
                      case ActivityType.expense:
                        icon = Icons.receipt_long_rounded;
                        break;
                      case ActivityType.split:
                        icon = Icons.call_split_rounded;
                        break;
                      case ActivityType.settlement:
                        icon = Icons.handshake_rounded;
                        break;
                      default:
                        icon = Icons.local_activity_rounded;
                    }

                    return _buildTransactionItem(
                      context,
                      isDark,
                      activity.title,
                      'Today', // TODO: Add proper date formatter
                      '$sign₹${activity.amount.toStringAsFixed(2)}',
                      icon,
                      color,
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
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
          if (index == 2) context.go('/profile');
        },
      ),
    );
  }

  Widget _buildBalanceCard(
    BuildContext context,
    double balance,
    double expense,
    double income,
  ) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      // Use constrained height to allow growth if content overflows
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Currency switching coming soon!'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'INR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Dynamic Balance Text
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '₹${balance.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCardStat(
                'Income',
                '₹${income.toStringAsFixed(2)}',
                AppColors.accentGreen,
              ),
              _buildCardStat(
                'Expense',
                '₹${expense.toStringAsFixed(2)}',
                AppColors.accentRed,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardStat(String label, String value, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.4),
            shape: BoxShape.circle,
          ),
          child: Icon(
            label == 'Income' ? Icons.arrow_downward : Icons.arrow_upward,
            size: 14,
            color: color,
          ),
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

  Widget _buildActionButtons(BuildContext context, bool isDark, WidgetRef ref) {
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
          'Insights', // Renamed from Tools
          () => _showToolsSheet(context, isDark, ref),
        ),
      ],
    );
  }

  void _showPaySheet(BuildContext context, bool isDark) {
    _showActionSheet(context, isDark, 'Pay', [
      _ActionItem(Icons.add_circle_outline, 'Add Expense (Self)', () {
        Navigator.pop(context);
        context.push('/add-expense', extra: false); // isIncome = false
      }),
      _ActionItem(Icons.attach_money, 'Add Income', () {
        Navigator.pop(context);
        context.push('/add-expense', extra: true); // isIncome = true
      }),
      _ActionItem(Icons.person_outline, 'Pay to Friend', () {
        Navigator.pop(context);
        context.push('/smart-action', extra: SmartActionType.payToFriend);
      }),
      _ActionItem(Icons.account_balance_wallet_outlined, 'Settle Balance', () {
        Navigator.pop(context);
        context.push('/smart-action', extra: SmartActionType.settleBalance);
      }),
      _ActionItem(Icons.compare_arrows, 'Wallet Transfer', () {
        Navigator.pop(context);
        context.push('/smart-action', extra: SmartActionType.walletTransfer);
      }),
    ]);
  }

  void _showCollectSheet(BuildContext context, bool isDark) {
    _showActionSheet(context, isDark, 'Collect', [
      _ActionItem(Icons.person_add_outlined, 'Request from Friend', () {
        Navigator.pop(context);
        context.push('/smart-action', extra: SmartActionType.requestFromFriend);
      }),
      _ActionItem(Icons.group_add_outlined, 'Request from Group', () {
        Navigator.pop(context);
        context.push('/smart-action', extra: SmartActionType.requestFromGroup);
      }),
      _ActionItem(Icons.receipt_long_outlined, 'Split Custom Amount', () {
        Navigator.pop(context);
        context.push('/split-bill');
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
        context.push('/scan-simulation');
      }),
      _ActionItem(Icons.qr_code, 'Scan QR Code', () {
        Navigator.pop(context);
        context.push('/scan-simulation');
      }),
      _ActionItem(Icons.group_outlined, 'Scan & Split', () {
        Navigator.pop(context);
        context.push('/split-bill');
      }),
    ]);
  }

  void _showToolsSheet(BuildContext context, bool isDark, WidgetRef ref) {
    _showActionSheet(context, isDark, 'Insights & Settings', [
      _ActionItem(Icons.analytics_outlined, 'Expense Analytics', () async {
        Navigator.pop(context); // Close sheet
        await Future.delayed(
          const Duration(milliseconds: 150),
        ); // Wait for animation
        if (context.mounted) {
          context.push('/analytics');
        }
      }),
      _ActionItem(Icons.description_outlined, 'Monthly Reports', () {
        _showComingSoon(context);
      }),
      _ActionItem(Icons.category_outlined, 'Categories', () {
        _showComingSoon(context);
      }),
      _ActionItem(Icons.account_balance, 'Set Opening Balance', () async {
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 150));
        if (context.mounted) {
          _showOpeningBalanceDialog(context, ref);
        }
      }),
      _ActionItem(Icons.savings_outlined, 'Budget Settings', () {
        _showComingSoon(context);
      }),
      _ActionItem(Icons.settings_outlined, 'App Settings', () {
        _showComingSoon(context);
      }),
    ]);
  }

  void _showOpeningBalanceDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Opening Balance'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            prefixText: '₹',
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

  void _showComingSoon(BuildContext context) {
    Navigator.pop(context); // Close sheet first
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'This feature is coming soon 🚀',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primaryPurple,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
      isScrollControlled: true, // Fix for smaller screens/overflow
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
  /*
  Widget _buildActivityList(BuildContext context, bool isDark) {
     // Replaced by dynamic list in build method
  }
  */

  Widget _buildTransactionItem(
    BuildContext context,
    bool isDark,
    String title,
    String subtitle,
    String amount,
    IconData icon,
    Color bgColor,
  ) {
    final isPositive = amount.startsWith('+');
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.glassDecoration(
        isDark: isDark,
        radius: 24,
      ).copyWith(color: isDark ? AppColors.darkGlassOverlay : Colors.white),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: bgColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: Colors.black87,
            ), // Icons black for contrast on pastel
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isPositive
                  ? AppColors.mint
                  : (isDark ? Colors.white : Colors.black87),
            ),
          ),
        ],
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
