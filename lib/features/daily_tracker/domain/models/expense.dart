import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

enum ExpenseCategory {
  food(Icons.restaurant, Color(0xFFFFB6C1), 'Food'),
  travel(Icons.directions_car, Color(0xFFB5EAD7), 'Travel'),
  shopping(Icons.shopping_bag, Color(0xFFAED9E0), 'Shopping'),
  bills(Icons.receipt, Color(0xFFE0C3FC), 'Bills'),
  entertainment(Icons.movie, Color(0xFFFFDAC1), 'Fun'),
  health(Icons.medical_services, Color(0xFF8EC5FC), 'Health'),
  other(Icons.category, Color(0xFFE0E0E0), 'Other');

  final IconData icon;
  final Color color;
  final String label;

  const ExpenseCategory(this.icon, this.color, this.label);
}

enum TransactionType { expense, income }

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;
  final TransactionType type;
  final String? note;

  Expense({
    String? id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    this.type = TransactionType.expense,
    this.note,
  }) : id = id ?? const Uuid().v4();

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    ExpenseCategory? category,
    TransactionType? type,
    String? note,
  }) {
    return Expense(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      type: type ?? this.type,
      note: note ?? this.note,
    );
  }
}
