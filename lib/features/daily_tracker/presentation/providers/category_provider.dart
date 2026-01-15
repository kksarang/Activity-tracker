import 'package:activity/features/shared/domain/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<CategoryModel>>((ref) {
      return CategoryNotifier();
    });

class CategoryNotifier extends StateNotifier<List<CategoryModel>> {
  CategoryNotifier() : super(_initialCategories);

  static const _uuid = Uuid();

  static final List<CategoryModel> _initialCategories = [
    CategoryModel(
      id: '1',
      name: 'Food',
      iconCodePoint: Icons.restaurant.codePoint,
      colorValue: Colors.orange.value,
    ),
    CategoryModel(
      id: '2',
      name: 'Transport',
      iconCodePoint: Icons.directions_bus.codePoint,
      colorValue: Colors.blue.value,
    ),
    CategoryModel(
      id: '3',
      name: 'Shopping',
      iconCodePoint: Icons.shopping_bag.codePoint,
      colorValue: Colors.purple.value,
    ),
    CategoryModel(
      id: '4',
      name: 'Entertainment',
      iconCodePoint: Icons.movie.codePoint,
      colorValue: Colors.red.value,
    ),
    CategoryModel(
      id: '5',
      name: 'Health',
      iconCodePoint: Icons.medical_services.codePoint,
      colorValue: Colors.teal.value,
    ),
    CategoryModel(
      id: '6',
      name: 'Education',
      iconCodePoint: Icons.school.codePoint,
      colorValue: Colors.indigo.value,
    ),
    CategoryModel(
      id: '7',
      name: 'Bills',
      iconCodePoint: Icons.receipt.codePoint,
      colorValue: Colors.green.value,
    ),
    CategoryModel(
      id: '8',
      name: 'Others',
      iconCodePoint: Icons.more_horiz.codePoint,
      colorValue: Colors.grey.value,
    ),
  ];

  void addCategory({
    required String name,
    required IconData icon,
    required Color color,
  }) {
    final newCategory = CategoryModel(
      id: _uuid.v4(),
      name: name,
      iconCodePoint: icon.codePoint,
      colorValue: color.value,
      isCustom: true,
    );
    state = [...state, newCategory];
  }

  // Method to remove custom categories if needed
  void removeCategory(String id) {
    state = state.where((c) => c.id != id).toList();
  }
}
