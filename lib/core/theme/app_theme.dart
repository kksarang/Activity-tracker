import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Light Theme Palette
  static const Color lightBackground = Color(
    0xFFF8F9FE,
  ); // Very soft blue-white
  static const Color lightGlassOverlay = Color(0x99FFFFFF); // 60% White
  static const Color lightBorder = Color(0xFFFFFFFF); // 100% White

  // Dark Theme Palette
  static const Color darkBackground = Color(0xFF14141E); // Deep Navy/Black
  static const Color darkGlassOverlay = Color(0x26FFFFFF); // 15% White
  static const Color darkBorder = Color(0x1AFFFFFF); // 10% White

  // Accents (Pastels from Dribbble)
  static const Color primaryPurple = Color(0xFF8B5CF6); // Soft Purple
  static const Color softPink = Color(0xFFFFB6C1);
  static const Color peach = Color(0xFFFFDAC1);
  static const Color mint = Color(0xFFB5EAD7);
  static const Color skyBlue = Color(0xFFAED9E0);

  static const Color primary = primaryPurple;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      primaryColor: AppColors.primary,
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      primaryColor: AppColors.primary,
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),
    );
  }

  static BoxDecoration glassDecoration({
    required bool isDark,
    double radius = 24,
  }) {
    return BoxDecoration(
      color: isDark ? AppColors.darkGlassOverlay : AppColors.lightGlassOverlay,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  static BoxDecoration get meshGradientDecoration {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFE0C3FC), // Soft Purple
          Color(0xFF8EC5FC), // Soft Blue
          Color(0xFFFFFFFF), // White
        ],
        stops: [0.0, 0.5, 1.0],
      ),
    );
  }
}
