import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/core/constants/app_routes.dart';
import 'package:activity/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    // Artificial delay for splash effect (e.g., 2 seconds)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final user = ref.read(authStateProvider).value;

    if (user != null) {
      context.go(AppRoutes.home);
    } else {
      final prefs = await SharedPreferences.getInstance();

      if (!mounted) return;

      final seenWalkthrough = prefs.getBool('seenWalkthrough') ?? false;

      if (seenWalkthrough) {
        context.go(AppRoutes.login); // Login
      } else {
        context.go(AppRoutes.walkthrough);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E2C) : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            SizedBox(
              width: 180,
              height: 180,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(height: 24),
            Text(
              'Activity Tracker',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primaryPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
