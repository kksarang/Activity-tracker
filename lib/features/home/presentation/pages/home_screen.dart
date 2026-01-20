import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/core/constants/app_routes.dart';
import 'package:activity/core/constants/app_strings.dart';

import 'package:activity/features/home/presentation/providers/activity_provider.dart';

import 'package:activity/features/shared/presentation/extensions/activity_extensions.dart';
import 'package:activity/features/home/presentation/widgets/balance_card.dart';
import 'package:activity/features/home/presentation/widgets/home_action_buttons.dart';
import 'package:activity/features/home/presentation/widgets/quick_action.dart';
import 'package:activity/features/home/presentation/widgets/transaction_item.dart';
import 'package:activity/features/home/presentation/widgets/empty_activity_view.dart';

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
          AppStrings.myWallet,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true, // ... rest of AppBar

        actions: [
          GestureDetector(
            onTap: () => context.push(AppRoutes.notifications),
            child: Container(
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
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const SizedBox(height: 10),
                    BalanceCard(
                      currentBalance: currentBalance,
                      totalIncome: totalIncome,
                      totalExpense: totalExpense,
                    ),
                    const SizedBox(height: 32),
                    QuickAction(
                      icon: Icons.people_alt_rounded,
                      label: 'Friends',
                      onTap: () => context.push(AppRoutes.friends),
                    ),
                    const SizedBox(height: 32),
                    HomeActionButtons(),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Brief Activity',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('See All'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (activities.isEmpty)
                      const EmptyActivityView()
                    else
                      ...activityState.recentActivities.map((activity) {
                        final sign = activity.direction.sign;
                        final color = activity.direction.color(isDark);
                        final icon = activity.type.icon;

                        return TransactionItem(
                          title: activity.title,
                          subtitle: 'Today', // TODO: Add proper date formatter
                          amount:
                              '$sign${AppStrings.currencySymbol}${activity.amount.toStringAsFixed(2)}',
                          icon: icon,
                          bgColor: color,
                        );
                      }),
                  ],
                ),
              ),
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
          if (index == 0) context.go(AppRoutes.home);
          if (index == 1) context.go(AppRoutes.splitBill);
          if (index == 2) context.go(AppRoutes.profile);
        },
      ),
    );
  }
}
