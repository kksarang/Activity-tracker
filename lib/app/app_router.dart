import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_routes.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/sign_up_screen.dart';
import '../../features/bills/presentation/pages/split_bill_flow.dart';
import '../../features/daily_tracker/presentation/pages/add_expense_screen.dart';
import '../../features/daily_tracker/presentation/pages/analytics_screen.dart';
import '../../features/daily_tracker/presentation/pages/daily_expense_screen.dart';
import '../../features/friends/presentation/pages/create_group_screen.dart';
import '../../features/friends/presentation/pages/friends_list_screen.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/home/presentation/pages/notifications_screen.dart';
import '../../features/onboarding/presentation/pages/walkthrough_screen.dart';
import '../../features/profile/presentation/pages/profile_screen.dart';
import '../../features/profile/presentation/pages/personal_info_screen.dart';
import '../../features/daily_tracker/presentation/pages/budget_settings_screen.dart';
import '../../features/daily_tracker/presentation/pages/categories_screen.dart';
import '../../features/daily_tracker/presentation/pages/monthly_report_screen.dart';
import '../../features/settings/presentation/pages/app_settings_screen.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/home/presentation/pages/scan_simulation_screen.dart';
import '../../features/home/presentation/pages/smart_action_screen.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.signUp,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.splitBill,
      builder: (context, state) => const SplitBillFlow(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: AppRoutes.personalInfo,
      builder: (context, state) => const PersonalInformationScreen(),
    ),
    GoRoute(
      path: AppRoutes.createGroup,
      builder: (context, state) => const CreateGroupScreen(),
    ),
    GoRoute(
      path: AppRoutes.walkthrough,
      builder: (context, state) => const WalkthroughScreen(),
    ),
    GoRoute(
      path: AppRoutes.dailyTracker,
      builder: (context, state) => const DailyExpenseScreen(),
    ),
    GoRoute(
      path: AppRoutes.addExpense,
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
      path: AppRoutes.analytics,
      builder: (context, state) => const AnalyticsScreen(),
    ),
    GoRoute(
      path: AppRoutes.monthlyReport,
      builder: (context, state) => const MonthlyReportScreen(),
    ),
    GoRoute(
      path: AppRoutes.categories,
      builder: (context, state) => const CategoriesScreen(),
    ),
    GoRoute(
      path: AppRoutes.budgetSettings,
      builder: (context, state) => const BudgetSettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.appSettings,
      builder: (context, state) => const AppSettingsScreen(),
    ),
    GoRoute(
      path: AppRoutes.smartAction,
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
      path: AppRoutes.scanSimulation,
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const ScanSimulationScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.notifications,
      builder: (context, state) => const NotificationsScreen(),
    ),
    GoRoute(
      path: AppRoutes.friends,
      builder: (context, state) => const FriendsListScreen(),
    ),
  ],
);
