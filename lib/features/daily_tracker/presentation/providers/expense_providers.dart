import 'package:activity/features/daily_tracker/data/repositories/daily_tracker_repository.dart';
import 'package:activity/features/daily_tracker/domain/models/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Repository Provider
final dailyTrackerRepositoryProvider = Provider<DailyTrackerRepository>((ref) {
  return DailyTrackerRepository();
});

// Selected Date Provider (for filtering/display)
final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

// Expense List Notifier
class ExpenseListNotifier extends StateNotifier<AsyncValue<List<Expense>>> {
  final DailyTrackerRepository _repository;

  ExpenseListNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    state = const AsyncValue.loading();
    try {
      final expenses = await _repository.getExpenses();
      // Sort by date descending
      expenses.sort((a, b) => b.date.compareTo(a.date));
      state = AsyncValue.data(expenses);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> addExpense(Expense expense) async {
    try {
      await _repository.addExpense(expense);
      // Reload to reflect changes (and mock sort)
      await loadExpenses();
    } catch (e) {
      // Handle error (maybe show snackbar via presentation layer listener)
    }
  }
}

final expenseListProvider =
    StateNotifierProvider<ExpenseListNotifier, AsyncValue<List<Expense>>>((
      ref,
    ) {
      final repository = ref.watch(dailyTrackerRepositoryProvider);
      return ExpenseListNotifier(repository);
    });

// Computed Provider: Expenses for Selected Date
final dailyExpensesProvider = Provider<List<Expense>>((ref) {
  final expensesAsync = ref.watch(expenseListProvider);
  final selectedDate = ref.watch(selectedDateProvider);

  return expensesAsync.maybeWhen(
    data: (expenses) {
      return expenses.where((expense) {
        return expense.date.year == selectedDate.year &&
            expense.date.month == selectedDate.month &&
            expense.date.day == selectedDate.day;
      }).toList();
    },
    orElse: () => [],
  );
});

// Computed Provider: Today's Total Spend
final todayTotalSpendProvider = Provider<double>((ref) {
  final expensesAsync = ref.watch(expenseListProvider);
  final now = DateTime.now();

  return expensesAsync.maybeWhen(
    data: (expenses) {
      return expenses
          .where(
            (e) =>
                e.date.year == now.year &&
                e.date.month == now.month &&
                e.date.day == now.day &&
                e.type == TransactionType.expense,
          )
          .fold(0.0, (sum, item) => sum + item.amount);
    },
    orElse: () => 0.0,
  );
});

// Computed Provider: Budget Status (Mock Calculation)
final budgetStatusProvider = Provider<Map<String, dynamic>>((ref) {
  final totalSpent = ref.watch(todayTotalSpendProvider);
  const dailyBudget = 1000.0; // Mock budget
  final remaining = dailyBudget - totalSpent;

  return {
    'dailyBudget': dailyBudget,
    'totalSpent': totalSpent,
    'remaining': remaining,
    'isOverBudget': remaining < 0,
    'progress': (totalSpent / dailyBudget).clamp(0.0, 1.0),
  };
});
