import 'package:activity/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [const Color(0xFF1E1E2C), const Color(0xFF121212)]
                    : [const Color(0xFFE3F2FD), const Color(0xFFFAFAFA)],
                stops: const [0.6, 1.0],
              ),
            ),
          ),
        ),
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
      ],
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
}
