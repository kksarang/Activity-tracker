import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/core/theme/theme_provider.dart';
import 'package:activity/features/auth/presentation/pages/login_screen.dart';
import 'package:activity/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:activity/features/bills/presentation/pages/split_bill_flow.dart';
import 'package:activity/features/daily_tracker/presentation/pages/add_expense_screen.dart';
import 'package:activity/features/daily_tracker/presentation/pages/analytics_screen.dart';
import 'package:activity/features/daily_tracker/presentation/pages/daily_expense_screen.dart';
import 'package:activity/features/friends/presentation/pages/create_group_screen.dart';
import 'package:activity/features/home/presentation/pages/home_screen.dart';
import 'package:activity/features/onboarding/presentation/pages/walkthrough_screen.dart';
import 'package:activity/features/profile/presentation/pages/profile_screen.dart';
import 'package:activity/features/daily_tracker/presentation/pages/budget_settings_screen.dart';
import 'package:activity/features/daily_tracker/presentation/pages/categories_screen.dart';
import 'package:activity/features/daily_tracker/presentation/pages/monthly_report_screen.dart';
import 'package:activity/features/settings/presentation/pages/app_settings_screen.dart';
import 'package:activity/features/splash/presentation/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:activity/features/home/presentation/pages/scan_simulation_screen.dart';
import 'package:activity/features/home/presentation/pages/smart_action_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: ActivityApp()));
}

class ActivityApp extends ConsumerWidget {
  const ActivityApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      title: 'Activity Tracker',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/split-bill',
      builder: (context, state) => const SplitBillFlow(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/create-group',
      builder: (context, state) => const CreateGroupScreen(),
    ),
    GoRoute(
      path: '/walkthrough',
      builder: (context, state) => const WalkthroughScreen(),
    ),
    GoRoute(
      path: '/daily-tracker',
      builder: (context, state) => const DailyExpenseScreen(),
    ),
    GoRoute(
      path: '/add-expense',
      pageBuilder: (context, state) {
        final isIncome = state.extra as bool? ?? false;
        return CustomTransitionPage(
          key: state.pageKey,
          child: AddExpenseScreen(isIncome: isIncome),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: '/analytics',
      builder: (context, state) => const AnalyticsScreen(),
    ),
    GoRoute(
      path: '/monthly-report',
      builder: (context, state) => const MonthlyReportScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: '/budget-settings',
      builder: (context, state) => const BudgetSettingsScreen(),
    ),
    GoRoute(
      path: '/app-settings',
      builder: (context, state) => const AppSettingsScreen(),
    ),
    GoRoute(
      path: '/smart-action',
      pageBuilder: (context, state) {
        final actionType = state.extra as SmartActionType;
        return CustomTransitionPage(
          child: SmartActionScreen(actionType: actionType),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        );
      },
    ),
    GoRoute(
      path: '/scan-simulation',
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const ScanSimulationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
  ],
);
