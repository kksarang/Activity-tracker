import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/bills/presentation/providers/split_bill_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepOneAmount extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const StepOneAmount({super.key, required this.onNext});

  @override
  ConsumerState<StepOneAmount> createState() => _StepOneAmountState();
}

class _StepOneAmountState extends ConsumerState<StepOneAmount> {
  final TextEditingController _titleController = TextEditingController();
  String _amountStr = ''; // Logic to handle keypad string

  @override
  void initState() {
    super.initState();
    // Initialize with current state if navigating back
    final state = ref.read(splitBillProvider);
    _titleController.text = state.title;
    if (state.totalAmount > 0) {
      _amountStr = state.totalAmount.toStringAsFixed(
        0,
      ); // integer for simpler input
    }
  }

  void _onKeyTap(String value) {
    setState(() {
      if (value == '.') {
        if (!_amountStr.contains('.')) {
          _amountStr += value;
        }
      } else {
        if (_amountStr == '0') {
          _amountStr = value;
        } else {
          _amountStr += value;
        }
      }
    });
    _updateState();
  }

  void _onBackspace() {
    if (_amountStr.isNotEmpty) {
      setState(() {
        _amountStr = _amountStr.substring(0, _amountStr.length - 1);
      });
      _updateState();
    }
  }

  void _updateState() {
    final amount = double.tryParse(_amountStr) ?? 0;
    ref.read(splitBillProvider.notifier).setAmount(amount);
  }

  void _onTitleChanged(String value) {
    setState(() {
      ref.read(splitBillProvider.notifier).setTitle(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final amount = double.tryParse(_amountStr) ?? 0;
    final isValid = amount > 0 && _titleController.text.isNotEmpty;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What are you\nsplitting?',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add a name of the split so that it\'s easy to remember later',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),

                    // Title Input
                    TextField(
                      controller: _titleController,
                      onChanged: _onTitleChanged,
                      decoration: InputDecoration(
                        hintText: 'Dinner at Marina Walk',
                        hintStyle: TextStyle(
                          color: Colors.grey.withValues(alpha: 0.5),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withValues(alpha: 0.3),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primaryPurple,
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Amount Display
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white70 : Colors.black54,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _amountStr.isEmpty ? '0' : _amountStr,
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton(
                        onPressed: isValid ? widget.onNext : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primaryPurple,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          disabledBackgroundColor: isDark
                              ? Colors.grey[800]
                              : Colors.grey[300],
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Custom Keypad
                    _buildKeypad(context, isDark),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildKeypad(BuildContext context, bool isDark) {
    return SizedBox(
      height: 280,
      child: Column(
        children: [
          _buildKeypadRow(['1', '2', '3'], isDark),
          _buildKeypadRow(['4', '5', '6'], isDark),
          _buildKeypadRow(['7', '8', '9'], isDark),
          _buildKeypadRow(['.', '0', 'backspace'], isDark),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<dynamic> keys, bool isDark) {
    return Expanded(
      child: Row(
        children: keys.map((key) {
          return Expanded(
            child: InkWell(
              onTap: () {
                if (key == 'backspace') {
                  _onBackspace();
                } else {
                  _onKeyTap(key.toString());
                }
              },
              borderRadius: BorderRadius.circular(8),
              child: Center(
                child: key == 'backspace'
                    ? Icon(
                        Icons.backspace_outlined,
                        size: 24,
                        color: isDark ? Colors.white70 : Colors.black54,
                      )
                    : Text(
                        key.toString(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
