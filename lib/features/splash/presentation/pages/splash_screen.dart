import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
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
      context.go('/home');
    } else {
      final prefs = await SharedPreferences.getInstance();

      if (!mounted) return;

      final seenWalkthrough = prefs.getBool('seenWalkthrough') ?? false;

      if (seenWalkthrough) {
        context.go('/'); // Login
      } else {
        context.go('/walkthrough');
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
            // Lottie Animation
            SizedBox(
              width: 200,
              height: 200,
              child: Lottie.network(
                'https://assets2.lottiefiles.com/packages/lf20_a2chheio.json', // Generic Loading
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.incomplete_circle_rounded,
                    size: 80,
                    color: AppColors.primaryPurple,
                  );
                },
              ),
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
