import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/daily_tracker/domain/models/expense.dart';
import 'package:activity/features/daily_tracker/presentation/providers/expense_providers.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AnalyticsScreen extends ConsumerStatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  ConsumerState<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends ConsumerState<AnalyticsScreen> {
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final expensesAsync = ref.watch(expenseListProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
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
                color: AppColors.primaryPurple.withOpacity(0.15),
                boxShadow: const [
                  BoxShadow(blurRadius: 100, color: AppColors.primaryPurple),
                ],
              ),
            ),
          ),

          SafeArea(
            child: expensesAsync.when(
              data: (expenses) => _buildContent(context, expenses, isDark),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<Expense> expenses,
    bool isDark,
  ) {
    if (expenses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart_rounded,
              size: 64,
              color: Colors.grey.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'No data to display',
              style: TextStyle(color: Colors.grey.withOpacity(0.5)),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Spending Overview',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Weekly Chart Card
          Container(
            height: 300,
            padding: const EdgeInsets.all(24),
            decoration: AppTheme.glassDecoration(isDark: isDark, radius: 24)
                .copyWith(
                  color: isDark
                      ? AppColors.darkGlassOverlay
                      : Colors.white.withOpacity(0.8),
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Last 7 Days',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(child: _buildBarChart(expenses, isDark)),
              ],
            ),
          ),

          const SizedBox(height: 32),

          Text(
            'Category Breakdown',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Pie Chart Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: AppTheme.glassDecoration(isDark: isDark, radius: 24)
                .copyWith(
                  color: isDark
                      ? AppColors.darkGlassOverlay
                      : Colors.white.withOpacity(0.8),
                ),
            child: Column(
              children: [
                SizedBox(height: 200, child: _buildPieChart(expenses)),
                const SizedBox(height: 24),
                _buildCategoryIndicators(expenses, isDark),
              ],
            ),
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<Expense> expenses, bool isDark) {
    // Process data for last 7 days
    final now = DateTime.now();
    final List<double> dailyTotals = List.filled(7, 0.0);
    final List<String> dayLabels = [];

    for (int i = 0; i < 7; i++) {
      final day = now.subtract(Duration(days: 6 - i));
      dayLabels.add(DateFormat('E').format(day)); // Mon, Tue...

      // Sum expenses for this day
      final sum = expenses
          .where(
            (e) =>
                e.date.year == day.year &&
                e.date.month == day.month &&
                e.date.day == day.day &&
                e.type == TransactionType.expense,
          )
          .fold(0.0, (prev, e) => prev + e.amount);

      dailyTotals[i] = sum;
    }

    final maxY = dailyTotals.reduce((curr, next) => curr > next ? curr : next);
    // Add some buffer to maxY
    final yTarget = maxY == 0 ? 100.0 : maxY * 1.2;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: yTarget,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => AppColors.primaryPurple,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '₹${rod.toY.toInt()}',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value < 0 || value >= dayLabels.length) {
                  return const SizedBox();
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    dayLabels[value.toInt()],
                    style: TextStyle(
                      color: isDark ? Colors.white54 : Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              reservedSize: 30,
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: dailyTotals.asMap().entries.map((entry) {
          final isToday = entry.key == 6; // Last one is today
          return BarChartGroupData(
            x: entry.key,
            barRods: [
              BarChartRodData(
                toY: entry.value,
                color: isToday
                    ? AppColors.primaryPurple
                    : (isDark ? Colors.white24 : Colors.black12),
                width: 16,
                borderRadius: BorderRadius.circular(6),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: yTarget,
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : Colors.grey.withOpacity(0.1),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPieChart(List<Expense> expenses) {
    final Map<ExpenseCategory, double> categoryTotals = {};
    double total = 0;

    for (var e in expenses) {
      if (e.type == TransactionType.expense) {
        categoryTotals[e.category] =
            (categoryTotals[e.category] ?? 0) + e.amount;
        total += e.amount;
      }
    }

    if (total == 0) return const SizedBox();

    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                _touchedIndex = -1;
                return;
              }
              _touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: categoryTotals.entries.map((entry) {
          final index = categoryTotals.keys.toList().indexOf(entry.key);
          final isTouched = index == _touchedIndex;
          final fontSize = isTouched ? 18.0 : 14.0;
          final radius = isTouched ? 60.0 : 50.0;
          final percentage = (entry.value / total * 100);

          return PieChartSectionData(
            color: entry.key.color,
            value: entry.value,
            title: '${percentage.toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            badgeWidget: isTouched
                ? _Badge(entry.key.icon, size: 30, borderColor: Colors.black)
                : null,
            badgePositionPercentageOffset: .98,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryIndicators(List<Expense> expenses, bool isDark) {
    final Map<ExpenseCategory, double> categoryTotals = {};
    for (var e in expenses) {
      if (e.type == TransactionType.expense) {
        categoryTotals[e.category] =
            (categoryTotals[e.category] ?? 0) + e.amount;
      }
    }

    final sortedEntries = categoryTotals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      children: sortedEntries.map((entry) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: entry.key.color,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  entry.key.label,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ),
              Text(
                '₹${entry.value.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge(this.icon, {required this.size, required this.borderColor});
  final IconData icon;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Icon(icon, size: size * 0.6, color: Colors.black87),
      ),
    );
  }
}
