import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/daily_tracker/domain/models/expense.dart';
import 'package:activity/features/home/presentation/providers/activity_provider.dart';
import 'package:activity/features/shared/domain/models/expense_model.dart'
    as shared;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  final bool isIncome;
  const AddExpenseScreen({super.key, this.isIncome = false});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  late ExpenseCategory _selectedCategory;
  DateTime _selectedDate = DateTime.now();
  String? _amountError;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_validateAmount);
    // Set default category based on type
    _selectedCategory = widget.isIncome
        ? ExpenseCategory.salary
        : ExpenseCategory.food;
  }

  @override
  void dispose() {
    _amountController.removeListener(_validateAmount);
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _validateAmount() {
    final text = _amountController.text;
    if (text.isEmpty) {
      setState(() => _amountError = null);
      return;
    }

    final amount = double.tryParse(text);
    if (amount == null || amount <= 0) {
      setState(() => _amountError = 'Enter a valid amount');
      return;
    }

    if (text.contains('.') && text.split('.')[1].length > 2) {
      setState(() => _amountError = 'Max 2 decimal places');
      return;
    }

    setState(() => _amountError = null);
  }

  bool get _isValid {
    if (_amountError != null) return false;
    final text = _amountController.text;
    final amount = double.tryParse(text);
    return amount != null && amount > 0;
  }

  Future<void> _saveTransaction() async {
    final amountText = _amountController.text;
    final amount = double.tryParse(amountText);

    if (amount == null) return;

    setState(() => _isLoading = true);

    // Simulate network delay for "premium feel"
    await Future.delayed(const Duration(milliseconds: 600));

    if (!mounted) return;

    // Create Shared Domain ExpenseModel (for Activity Feed & Wallet)
    final transaction = shared.ExpenseModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _selectedCategory.label,
      type: widget.isIncome
          ? shared.TransactionType.income
          : shared.TransactionType.expense,
      amount: amount,
      date: _selectedDate.millisecondsSinceEpoch,
      categoryId: _selectedCategory.name,
      categoryName: _selectedCategory.label,
      payerId: 'currentUser',
      createdBy: 'currentUser',
      notes: _noteController.text.isNotEmpty ? _noteController.text : null,
    );

    // Add to ActivityProvider (updates Wallet Balance)
    ref.read(activityProvider.notifier).addTransaction(transaction);

    if (mounted) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isIncome
                ? 'Income added successfully'
                : 'Expense added successfully',
          ),
          backgroundColor: widget.isIncome ? Colors.green : Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isIncome = widget.isIncome;
    final title = isIncome ? 'Add Income' : 'Add Expense';

    // Filter categories
    final categories = ExpenseCategory.values.where((c) {
      final isIncomeCat =
          c == ExpenseCategory.salary ||
          c == ExpenseCategory.freelance ||
          c == ExpenseCategory.gift;
      return isIncome ? isIncomeCat : !isIncomeCat;
    }).toList();

    // Ensure selected is valid, else reset
    if (!categories.contains(_selectedCategory)) {
      _selectedCategory = categories.first;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount Input
            Text(
              'Amount',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                fontFamily: 'Outfit',
                color: isIncome ? AppColors.mint : null,
              ),
              decoration: InputDecoration(
                prefixText: '₹',
                prefixStyle: TextStyle(
                  color: isIncome ? AppColors.mint : null,
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
                border: InputBorder.none,
                hintText: '0',
                hintStyle: TextStyle(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black12,
                ),
                errorText: _amountError,
              ),
              onChanged: (_) =>
                  setState(() {}), // Trigger rebuild for button state
              autofocus: true,
            ),
            const SizedBox(height: 32),

            // Category Selection
            Text('Category', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: categories.map((category) {
                final isSelected = _selectedCategory == category;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 80,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? category.color
                          : (isDark
                                ? AppColors.darkGlassOverlay
                                : Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected
                            ? category.color
                            : (isDark ? AppColors.darkBorder : Colors.black12),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          category.icon,
                          color: isSelected ? Colors.black87 : Colors.grey,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          category.label,
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? Colors.black87 : Colors.grey,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Date Selection
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: AppTheme.glassDecoration(isDark: isDark, radius: 12)
                    .copyWith(
                      color: isDark ? AppColors.darkGlassOverlay : Colors.white,
                    ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      DateFormat('EEE, d MMM yyyy').format(_selectedDate),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Note Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: AppTheme.glassDecoration(isDark: isDark, radius: 12)
                  .copyWith(
                    color: isDark ? AppColors.darkGlassOverlay : Colors.white,
                  ),
              child: TextField(
                controller: _noteController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.edit, size: 20),
                  hintText: 'Add a note (optional)',
                  border: InputBorder.none,
                ),
              ),
            ),

            const SizedBox(height: 48),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: (_isValid && !_isLoading) ? _saveTransaction : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isIncome
                      ? AppColors.mint
                      : AppColors.primaryPurple,
                  foregroundColor: isIncome ? Colors.black87 : Colors.white,
                  disabledBackgroundColor:
                      (isIncome ? AppColors.mint : AppColors.primaryPurple)
                          .withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  shadowColor:
                      (isIncome ? AppColors.mint : AppColors.primaryPurple)
                          .withValues(alpha: 0.4),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        isIncome ? 'Save Income' : 'Save Expense',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
