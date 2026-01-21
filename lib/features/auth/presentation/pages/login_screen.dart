import 'package:activity/core/constants/app_routes.dart';
import 'package:activity/core/network/api_result.dart';
import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/auth/constants/auth_strings.dart';
import 'package:activity/features/auth/presentation/providers/auth_provider.dart';
import 'package:activity/features/auth/presentation/widgets/auth_background.dart';
import 'package:activity/features/auth/presentation/widgets/email_login_form.dart';
import 'package:activity/features/auth/presentation/widgets/guest_login_button.dart';
import 'package:activity/features/auth/presentation/widgets/guest_login_sheet.dart';
import 'package:activity/features/auth/presentation/widgets/login_header.dart';
import 'package:activity/features/auth/presentation/widgets/social_login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  void _signInWithGoogle() {
    ref.read(authControllerProvider.notifier).signInWithGoogle();
  }

  Future<void> _signInAnonymously() async {
    Navigator.pop(context); // Close confirmation sheet
    await ref.read(authControllerProvider.notifier).signInAnonymously();
    if (mounted) {
      context.go(AppRoutes.home);
    }
  }

  void _onEmailSubmit(String email, String password) {
    Navigator.pop(context);
    ref.read(authControllerProvider.notifier).signInWithEmail(email, password);
  }

  @override
  Widget build(BuildContext context) {
    // Listeners
    ref.listen(authControllerProvider, (previous, next) {
      if (next is Failure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text((next as Failure).message),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    ref.listen(authStateProvider, (previous, next) {
      if (next.value != null) {
        context.go(AppRoutes.home);
      }
    });

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Stack(
                  children: [
                    // Background
                    const AuthBackground(),
                    // Content
                    Center(
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SafeArea(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Spacer(flex: 2),

                              // 1. Header Section
                              const LoginHeader(),

                              const Spacer(flex: 3),

                              // 2. Action Section
                              Column(
                                children: [
                                  // Primary: Google
                                  SocialLoginButton(
                                    text: AuthStrings.googleButton,
                                    onPressed: _signInWithGoogle,
                                    icon: const Text(
                                      'G',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xFF4285F4),
                                        fontFamily: 'Roboto',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // Secondary: Guest
                                  GuestLoginButton(
                                    onPressed: () =>
                                        _showGuestConfirmationSheet(
                                          context,
                                          isDark,
                                        ),
                                  ),

                                  const SizedBox(height: 32),

                                  // Email Link
                                  TextButton(
                                    onPressed: () =>
                                        _showEmailLoginSheet(context),
                                    child: Text(
                                      AuthStrings.emailButton,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white70
                                            : Colors.grey[700],
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        AuthStrings.newHere,
                                        style: TextStyle(
                                          color: isDark
                                              ? Colors.white38
                                              : Colors.grey[500],
                                          fontSize: 13,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            context.push(AppRoutes.signUp),
                                        child: Text(
                                          AuthStrings.createAccount,
                                          style: TextStyle(
                                            color: AppColors.primaryPurple,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 32),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showGuestConfirmationSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GuestLoginSheet(onContinue: _signInAnonymously),
    );
  }

  void _showEmailLoginSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EmailLoginForm(onSubmit: _onEmailSubmit),
    );
  }
}
