import 'package:activity/features/daily_tracker/domain/models/expense.dart';

class DailyTrackerRepository {
  // In-memory mock storage
  final List<Expense> _expenses = [];

  Future<List<Expense>> getExpenses() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _expenses;
  }

  Future<void> addExpense(Expense expense) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _expenses.add(expense);
  }

  Future<void> deleteExpense(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _expenses.removeWhere((e) => e.id == id);
  }
}
