import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Konfigurasi tema global Material 3 untuk Museum Brawijaya
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.backgroundBase,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryGreen,
        surface: AppColors.cardBackground,
        error: AppColors.errorRed,
        onPrimary: AppColors.primaryGreenText,
        onSurface: AppColors.textWhite,
      ),
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: AppColors.textWhite,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: AppColors.textWhite,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textWhite,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textWhite,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textMuted,
        ),
        labelLarge: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: AppColors.textWhite,
        ),
      ),
    );
  }
}
