import 'package:activity/features/daily_tracker/domain/models/expense.dart';

class DailyTrackerRepository {
  // In-memory mock storage
  final List<Expense> _expenses = [
    Expense(
      title: 'Spotify Subscription',
      amount: 49,
      date: DateTime.now(),
      category: ExpenseCategory.entertainment,
    ),
    Expense(
      title: 'Grocery',
      amount: 240,
      date: DateTime.now(),
      category: ExpenseCategory.food,
    ),
    Expense(
      title: 'Travel',
      amount: 120,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: ExpenseCategory.travel,
    ),
    Expense(
      title: 'Lunch',
      amount: 92,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: ExpenseCategory.food,
    ),
  ];

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
