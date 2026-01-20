import 'package:activity/features/auth/constants/auth_strings.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: Image.asset('assets/images/logo.png'),
        ),
        const SizedBox(height: 32),
        Text(
          AuthStrings.appName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF2D3142),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AuthStrings.appTagline,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: isDark ? Colors.white60 : Colors.grey[600],
            fontSize: 18,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
