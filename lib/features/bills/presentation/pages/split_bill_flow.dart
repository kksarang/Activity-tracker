import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/core/constants/app_routes.dart';
import 'package:activity/features/bills/presentation/providers/split_bill_provider.dart';
import 'package:activity/features/bills/presentation/widgets/steps/step_one_amount.dart';
import 'package:activity/features/bills/presentation/widgets/steps/step_two_people.dart';
import 'package:activity/features/bills/presentation/widgets/steps/step_three_split.dart';
import 'package:activity/features/bills/presentation/widgets/steps/step_four_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplitBillFlow extends ConsumerStatefulWidget {
  const SplitBillFlow({super.key});

  @override
  ConsumerState<SplitBillFlow> createState() => _SplitBillFlowState();
}

class _SplitBillFlowState extends ConsumerState<SplitBillFlow> {
  final PageController _pageController = PageController();
  int _currentStep = 1;
  final int _totalSteps = 4;

  void _nextStep() {
    if (_currentStep < _totalSteps) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 1) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep--;
      });
    } else {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(AppRoutes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : Colors.black,
          ),
          onPressed: _previousStep,
        ),
        title: Text(
          'Step $_currentStep of $_totalSteps',
          style: TextStyle(
            color: isDark ? Colors.white70 : Colors.grey,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.grey),
            onPressed: () {
              ref.read(splitBillProvider.notifier).reset();
              context.go(AppRoutes.home);
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // distinct linear progress bar
          LinearProgressIndicator(
            value: _currentStep / _totalSteps,
            backgroundColor: isDark ? Colors.white12 : Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.primaryPurple,
            ),
            minHeight: 4,
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              children: [
                StepOneAmount(onNext: _nextStep),
                StepTwoPeople(onNext: _nextStep),
                StepThreeSplit(onNext: _nextStep),
                StepFourReview(
                  onSubmit: () {
                    // TODO: Submit Logic
                    context.go(AppRoutes.home);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
