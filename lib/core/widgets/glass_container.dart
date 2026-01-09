import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final BoxBorder? border;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 15.0,
    this.opacity = 0.1,
    this.color,
    this.padding,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Default base color based on theme if not provided
    final baseColor = color ?? (isDark ? Colors.black : Colors.white);

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: baseColor.withValues(
              alpha: opacity,
            ), // Use withValues for alpha (newer Flutter API) or withOpacity
            borderRadius: borderRadius ?? BorderRadius.circular(24),
            border:
                border ??
                Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                baseColor.withValues(alpha: opacity + 0.05),
                baseColor.withValues(alpha: opacity),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
