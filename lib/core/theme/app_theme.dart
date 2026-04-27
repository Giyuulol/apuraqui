import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: AppTypography.fontFamilyBase,
    textTheme: AppTypography.textTheme,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.interactionOnLight,
      primary: AppColors.interactionOnLight,
      onPrimary: AppColors.readingOnDark,
      secondary: AppColors.success,
      onSecondary: AppColors.readingOnDark,
      tertiary: AppColors.warning,
      onTertiary: AppColors.readingOnLight,
      error: AppColors.error,
      onError: AppColors.readingOnDark,
      surface: AppColors.surfaceLightPrimary,
      onSurface: AppColors.readingOnLight,
      surfaceContainerHighest: AppColors.surfaceLightAlternative,
      onSurfaceVariant: AppColors.readingOnLight,
    ),
    scaffoldBackgroundColor: AppColors.surfaceLightAlternative,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.interactionOnLight,
      foregroundColor: AppColors.readingOnDark,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: AppTypography.fontFamilyBase,
        color: AppColors.readingOnDark,
        fontSize: AppTypography.scaleUp02,
        fontWeight: AppTypography.semiBold,
        height: AppTypography.lineHeightLow,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: AppColors.borderLight),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.interactionOnLight;
        }

        return AppColors.surfaceLightPrimary;
      }),
      checkColor: const WidgetStatePropertyAll(AppColors.readingOnDark),
      side: const BorderSide(color: AppColors.interactionOnLight, width: 1.5),
    ),
  );
}
