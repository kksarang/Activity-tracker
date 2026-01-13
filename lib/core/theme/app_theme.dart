import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFF8B5CF6);
  static const Color primaryDark = Color(0xFF6D28D9);
  static const Color primaryLight = Color(0xFFDDD6FE);

  // Accents
  static const Color accentBlue = Color(0xFF60A5FA);
  static const Color accentGreen = Color(0xFF34D399); // Success
  static const Color accentRed = Color(0xFFF87171); // Error
  static const Color accentOrange = Color(0xFFFB923C); // Warning

  // Background & Surface
  static const Color background = Color(0xFFF9FAFB);
  static const Color cardSurface = Color(0xFFFFFFFF);
  static const Color bottomSheetBg = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE5E7EB);
  static const Color overlay = Color.fromRGBO(0, 0, 0, 0.35);

  // Text Colors
  static const Color textPrimary = Color(0xFF111827); // Titles
  static const Color textSecondary = Color(0xFF6B7280); // Descriptions
  static const Color textDisabled = Color(0xFF9CA3AF);
  static const Color textPositive = Color(0xFF16A34A); // Credit
  static const Color textNegative = Color(0xFFDC2626); // Debit
  static const Color textWarning = Color(0xFFF59E0B);

  // Dark Mode Equivalents (Inferred to maintain contrast)
  static const Color darkBackground = Color(0xFF111827); // Very Dark Gray
  static const Color darkCardSurface = Color(0xFF1F2937); // Dark Gray
  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFF9CA3AF);

  // Legacy Compatibility (Aliases)
  static const Color primaryPurple = primary;
  static const Color mint = accentGreen;
  static const Color softPink = accentRed;
  static const Color peach = Color(0xFFFFDAC1);
  static const Color skyBlue = Color(0xFFAED9E0);

  static const Color lightBackground = background;
  static const Color lightGlassOverlay = Color(0x99FFFFFF);
  static const Color lightBorder = Color(0xFFFFFFFF);

  static const Color darkGlassOverlay = Color(0x26FFFFFF);
  static const Color darkBorder = Color(0x1AFFFFFF);
}

class AppSpacings {
  static const double xs = 4;
  static const double s = 8;
  static const double m = 16;
  static const double l = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,

      // Text Theme
      textTheme: GoogleFonts.outfitTextTheme().copyWith(
        titleLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
        bodySmall: const TextStyle(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      ),

      // Component Themes
      cardTheme: CardThemeData(
        color: AppColors.cardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.divider, width: 1),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: AppColors.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
      ),

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        surface: AppColors.cardSurface,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.darkBackground,

      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme)
          .copyWith(
            titleLarge: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.darkTextPrimary,
            ),
            titleMedium: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkTextPrimary,
            ),
            bodyMedium: const TextStyle(
              fontSize: 14,
              color: AppColors.darkTextSecondary,
            ),
            bodySmall: const TextStyle(
              fontSize: 12,
              color: AppColors.darkTextSecondary,
            ),
          ),

      cardTheme: CardThemeData(
        color: AppColors.darkCardSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.divider.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        surface: AppColors.darkCardSurface,
      ),
      useMaterial3: true,
    );
  }

  // Helper for Responsive Shadows
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
  // Legacy Methods
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
}
