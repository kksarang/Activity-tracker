import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/bills/presentation/providers/split_bill_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StepThreeSplit extends ConsumerStatefulWidget {
  final VoidCallback onNext;

  const StepThreeSplit({super.key, required this.onNext});

  @override
  ConsumerState<StepThreeSplit> createState() => _StepThreeSplitState();
}

class _StepThreeSplitState extends ConsumerState<StepThreeSplit> {
  final Map<String, TextEditingController> _customControllers = {};

  @override
  void initState() {
    super.initState();
    // Initialize controllers for custom split if needed
  }

  @override
  void dispose() {
    for (var controller in _customControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onToggleSplitType(SplitType type) {
    ref.read(splitBillProvider.notifier).setSplitType(type);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final state = ref.watch(splitBillProvider);
    final participants = state.participants;

    // Add "You" if not present in participants list visualization,
    // BUT typically "You" should be in the list.
    // Assuming "You" is just the current user, let's assume the provider list contains everyone including "You" if they were selected.
    // If Step 2 allows selecting "You", fine. If not, we might need to inject "You".
    // For now, let's assume the participants list is the source of truth.

    // Calculate Equal Split
    final double equalShare = participants.isNotEmpty
        ? state.totalAmount / participants.length
        : 0;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How do you want to\nsplit ₹${state.totalAmount.toStringAsFixed(0)}?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              // Toggle
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF2C2C2E)
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onToggleSplitType(SplitType.equal),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: state.splitType == SplitType.equal
                                ? AppColors.primaryPurple
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Equal Split',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: state.splitType == SplitType.equal
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _onToggleSplitType(SplitType.custom),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: state.splitType == SplitType.custom
                                ? AppColors.primaryPurple
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Custom Split',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: state.splitType == SplitType.custom
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                state.splitType == SplitType.equal
                    ? 'Split equally between all members'
                    : 'Specify exact amounts for each person',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: participants.length,
            itemBuilder: (context, index) {
              final user = participants[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(user.avatarUrl),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        user.name,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (state.splitType == SplitType.equal)
                      Text(
                        '₹${equalShare.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      )
                    else
                      SizedBox(
                        width: 100,
                        child: TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textAlign: TextAlign.end,
                          decoration: const InputDecoration(
                            prefixText: '₹ ',
                            isDense: true,
                            border: UnderlineInputBorder(),
                          ),
                          onChanged: (value) {
                            final amount = double.tryParse(value) ?? 0;
                            ref
                                .read(splitBillProvider.notifier)
                                .updateCustomAmount(user.id, amount);
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),

        // Validation / Total for Custom Split
        if (state.splitType == SplitType.custom)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Entered:',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(
                  '₹${state.customAmounts.values.fold(0.0, (sum, val) => sum + val).toStringAsFixed(2)} / ₹${state.totalAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        state.customAmounts.values.fold(
                              0.0,
                              (sum, val) => sum + val,
                            ) ==
                            state.totalAmount
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ],
            ),
          ),

        // Next Button
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: () {
                if (state.splitType == SplitType.custom) {
                  final currentTotal = state.customAmounts.values.fold(
                    0.0,
                    (sum, val) => sum + val,
                  );
                  // Simple validation: Allow small floating point diff
                  if ((currentTotal - state.totalAmount).abs() > 0.01) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Total amount does not match split total',
                        ),
                      ),
                    );
                    return;
                  }
                }
                widget.onNext();
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
