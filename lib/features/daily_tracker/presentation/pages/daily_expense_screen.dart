import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/daily_tracker/domain/models/expense.dart';
import 'package:activity/features/daily_tracker/presentation/providers/expense_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class DailyExpenseScreen extends ConsumerWidget {
  const DailyExpenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedDate = ref.watch(selectedDateProvider);
    final expensesAsync = ref.watch(expenseListProvider);
    final dailyBudget = ref.watch(budgetStatusProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              ref.read(selectedDateProvider.notifier).state = picked;
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('MMM yyyy').format(selectedDate),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart_rounded),
            onPressed: () {
              context.push('/analytics');
            },
          ),
        ],
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
                color: AppColors.peach.withValues(alpha: 0.2),
                boxShadow: const [
                  BoxShadow(blurRadius: 80, color: AppColors.peach),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    // Date Selector Strip
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: 30, // Mock 30 days around selected
                        itemBuilder: (context, index) {
                          // Just centering current date for demo roughly
                          final date = selectedDate
                              .subtract(const Duration(days: 3))
                              .add(Duration(days: index));
                          final isSelected =
                              date.day == selectedDate.day &&
                              date.month == selectedDate.month &&
                              date.year == selectedDate.year;

                          return GestureDetector(
                            onTap: () {
                              ref.read(selectedDateProvider.notifier).state =
                                  date;
                            },
                            child: Container(
                              width: 60,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 4,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primaryPurple
                                    : (isDark
                                          ? AppColors.darkGlassOverlay
                                          : Colors.white),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.transparent
                                      : (isDark
                                            ? AppColors.darkBorder
                                            : Colors.black12),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('E').format(date).toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: isSelected
                                          ? Colors.white70
                                          : Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: isSelected
                                          ? Colors.white
                                          : (isDark
                                                ? Colors.white
                                                : Colors.black87),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Daily Summary Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: _buildSummaryCard(context, dailyBudget, isDark),
                    ),

                    const SizedBox(height: 24),

                    // Expense List
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkGlassOverlay
                              : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: expensesAsync.when(
                          data: (expenses) => _buildExpenseList(
                            context,
                            expenses,
                            selectedDate,
                          ),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (err, stack) =>
                              Center(child: Text('Error: $err')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-expense'),
        icon: const Icon(Icons.add),
        label: const Text('Add Expense'),
        backgroundColor: AppColors.primaryPurple,
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    Map<String, dynamic> budget,
    bool isDark,
  ) {
    final double totalSpent = budget['totalSpent'];
    final double remaining = budget['remaining'];
    final bool isOverBudget = budget['isOverBudget'];
    final double progress = budget['progress'];
    // final double budgetAmount = budget['dailyBudget']; // Unused

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF2C2C35)
            : AppColors
                  .lightBackground, // Solid color for better readability or glass
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF2C2C35), const Color(0xFF1F1F26)]
              : [Colors.white, const Color(0xFFF8F9FE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s Spend',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${totalSpent.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Outfit',
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: (isOverBudget ? Colors.red : Colors.green).withValues(
                    alpha: 0.1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isOverBudget ? 'Over Budget' : 'On Track',
                  style: TextStyle(
                    color: isOverBudget ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: isDark ? Colors.white12 : Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                isOverBudget ? Colors.redAccent : AppColors.primaryPurple,
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(progress * 100).toInt()}% of daily budget',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                '₹${remaining.abs().toStringAsFixed(0)} ${isOverBudget ? 'over' : 'left'}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isOverBudget ? Colors.redAccent : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseList(
    BuildContext context,
    List<Expense> allExpenses,
    DateTime selectedDate,
  ) {
    if (allExpenses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 64,
              color: Colors.grey.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No expenses yet',
              style: TextStyle(color: Colors.grey.withValues(alpha: 0.5)),
            ),
          ],
        ),
      );
    }

    // Filters expenses for viewing purposes - currently showing ALL but grouped,
    // or we could filter by selected date only.
    // The prompt implies "Grouped by Date" list.
    // Let's group all available expenses by day for the list view,
    // but the top summary was specific to the selected date.
    // If the user selects a date, maybe we should scroll to it or filter?
    // For this implementation, let's show all expenses grouped by date headers.

    final grouped = <String, List<Expense>>{};
    for (var expense in allExpenses) {
      final dateKey = DateFormat('yyyy-MM-dd').format(expense.date);
      if (grouped[dateKey] == null) grouped[dateKey] = [];
      grouped[dateKey]!.add(expense);
    }

    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      padding: const EdgeInsets.only(top: 24, bottom: 100, left: 16, right: 16),
      itemCount: sortedKeys.length,
      itemBuilder: (context, index) {
        final dateKey = sortedKeys[index];
        final expenses = grouped[dateKey]!;
        final date = DateTime.parse(dateKey);

        String headerText;
        final now = DateTime.now();
        if (date.year == now.year &&
            date.month == now.month &&
            date.day == now.day) {
          headerText = 'Today';
        } else if (date.year == now.year &&
            date.month == now.month &&
            date.day == now.day - 1) {
          headerText = 'Yesterday';
        } else {
          headerText = DateFormat('EEE, d MMM').format(date);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Text(
                headerText,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
            ...expenses.map((expense) => _buildExpenseTile(context, expense)),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  Widget _buildExpenseTile(BuildContext context, Expense expense) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E26) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.withValues(alpha: 0.1),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: expense.category.color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            expense.category.icon,
            color: Colors.black87, // Icons always dark on pastel
            size: 20,
          ),
        ),
        title: Text(
          expense.title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Row(
          children: [
            Text(
              DateFormat('h:mm a').format(expense.date),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            if (expense.note != null) ...[
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '• ${expense.note}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ],
        ),
        trailing: Text(
          '-₹${expense.amount.toStringAsFixed(0)}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors
                .redAccent, // Input said red/green. Expenses usually red visually or neutral.
          ),
        ),
      ),
    );
  }
}
