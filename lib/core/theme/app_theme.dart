import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.darkGreen,
      onPrimary: AppColors.white,
      secondary: AppColors.green,
      onSecondary: AppColors.white,
      tertiary: AppColors.blue,
      onTertiary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: Color(0xFF1F2937),
      surfaceContainerHighest: Color(0xFFF9FAFB),
      outline: Color(0xFFE5E7EB),
      outlineVariant: Color(0xFFD1D5DB),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: Color(0xFF1F2937),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.heading2,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: AppColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.green, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.red, width: 1.5),
        ),
        hintStyle: AppTextStyles.body.copyWith(color: const Color(0xFF9CA3AF)),
        labelStyle: AppTextStyles.subtitle.copyWith(color: const Color(0xFF6B7280)),
        errorStyle: AppTextStyles.caption.copyWith(color: AppColors.red),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkGreen,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle: AppTextStyles.button,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.darkGreen,
          foregroundColor: AppColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          textStyle: AppTextStyles.button,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xFFE5E7EB),
        thickness: 0.8,
        space: 0,
      ),
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.heading1,
        headlineMedium: AppTextStyles.heading1,
        titleLarge: AppTextStyles.heading2,
        titleMedium: AppTextStyles.title,
        bodyLarge: AppTextStyles.body,
        bodyMedium: AppTextStyles.body,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.button,
        labelMedium: AppTextStyles.subtitle,
      ),
    );
  }
}
