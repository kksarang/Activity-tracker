import 'package:activity/core/theme/app_theme.dart';
import 'package:activity/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithGoogle() {
    ref.read(authControllerProvider.notifier).signInWithGoogle();
  }

  void _signInAnonymously() {
    Navigator.pop(context); // Close confirmation sheet
    ref.read(authControllerProvider.notifier).signInAnonymously();
  }

  void _signInWithEmail() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context); // Close sheet (optional, or keep open for error)
      // Actually better to keep open until success/fail, but simplified for now
      // or handle loading state inside sheet.
      // Let's close it on success logic via listener, but for now just trigger.
      ref
          .read(authControllerProvider.notifier)
          .signInWithEmail(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listeners
    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    ref.listen(authStateProvider, (previous, next) {
      if (next.value != null) {
        // If sheet is open? Context might be tricky if not careful,
        // but go_router mostly handles stack clearing.
        context.go('/home');
      }
    });

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [const Color(0xFF1E1E2C), const Color(0xFF121212)]
                    : [
                        const Color(0xFFE3F2FD), // Very light blue
                        const Color(0xFFFAFAFA), // White-ish
                      ],
                stops: const [0.6, 1.0],
              ),
            ),
          ),

          // Abstract Shapes
          Positioned(
            top: -50,
            right: -50,
            child: _buildBlurBlob(AppColors.primaryPurple, 300),
          ),
          Positioned(
            top: 200,
            left: -100,
            child: _buildBlurBlob(AppColors.mint, 250),
          ),

          SafeArea(
            child: Column(
              children: [
                // 1. Hero Section (Flexible space)
                Expanded(
                  flex: 6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons
                              .incomplete_circle_rounded, // Abstract/Modern icon
                          size: 64,
                          color: AppColors.primaryPurple,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Activity Tracker',
                        style: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? Colors.white
                                  : const Color(0xFF2D3142),
                              letterSpacing: -0.5,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Track less. Achieve more.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isDark ? Colors.white60 : Colors.grey[600],
                          fontSize: 18,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. Action Section
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Primary: Google
                        SizedBox(
                          width: double.infinity,
                          height: 52, // Standard height
                          child: OutlinedButton(
                            onPressed: _signInWithGoogle,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black54,
                              elevation: 0,
                              side: const BorderSide(
                                color: Color(0xFFDADCE0),
                              ), // Official border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  26,
                                ), // Pill shape
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Official G Logo
                                Image.network(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/240px-Google_%22G%22_logo.svg.png',
                                  height: 24,
                                  width: 24,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                        Icons.g_mobiledata,
                                        size: 30,
                                        color: Colors.blue,
                                      ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Continue with Google',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    color: Color(
                                      0xFF3C4043,
                                    ), // Official text color
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Secondary: Guest
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: OutlinedButton(
                            onPressed: () =>
                                _showGuestConfirmationSheet(context, isDark),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isDark
                                    ? Colors.white24
                                    : Colors.grey.withValues(alpha: 0.3),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            child: const Text(
                              'Continue as Guest',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Offline only · No cloud backup',
                          style: TextStyle(
                            fontSize: 12,
                            color: isDark ? Colors.white38 : Colors.grey[500],
                          ),
                        ),

                        const Spacer(),

                        // Email Link
                        TextButton(
                          onPressed: () =>
                              _showEmailLoginSheet(context, isDark),
                          child: Text(
                            'Sign in with Email',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : Colors.grey[700],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "New here? ",
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white38
                                    : Colors.grey[500],
                                fontSize: 13,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.push('/sign-up'),
                              child: Text(
                                "Create an account",
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurBlob(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: 0.15),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 100,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }

  void _showGuestConfirmationSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Continue as Guest?',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Your data will stay on this device only. You won\'t be able to access it from other devices or recover it if you uninstall the app.',
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.grey[600],
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: FilledButton(
                onPressed: _signInAnonymously,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _showEmailLoginSheet(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow full height for keyboard
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E2C) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                TextFormField(
                  controller: _emailController,
                  validator: (val) => (val == null || !val.contains('@'))
                      ? 'Invalid email'
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    filled: true,
                    fillColor: isDark
                        ? Colors.black.withValues(alpha: 0.2)
                        : Colors.grey.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                StatefulBuilder(
                  builder: (context, setState) => TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    validator: (val) =>
                        (val == null || val.length < 6) ? 'Min 6 chars' : null,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: isDark
                          ? Colors.black.withValues(alpha: 0.2)
                          : Colors.grey.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            // Update local state in sheet
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                SizedBox(
                  height: 56,
                  child: FilledButton(
                    onPressed: _signInWithEmail,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaryPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
