import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTypography {
  const AppTypography._();

  static const String fontFamilyBase = 'Rawline';

  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  static const double scaleUp07 = 50.16;
  static const double scaleUp06 = 41.80;
  static const double scaleUp05 = 34.84;
  static const double scaleUp04 = 29.03;
  static const double scaleUp03 = 24.19;
  static const double scaleUp02 = 20.16;
  static const double scaleUp01 = 16.80;
  static const double scaleBase = 14.00;
  static const double scaleDown01 = 11.67;
  static const double scaleDown02 = 9.72;
  static const double scaleDown03 = 8.10;

  static const double lineHeightLow = 1.15;
  static const double lineHeightMedium = 1.45;
  static const double lineHeightHigh = 1.85;

  static TextTheme get textTheme {
    // Adapta a escala GOV.BR/Rawline ao contrato de TextTheme do Material 3.
    return const TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleUp06,
        fontWeight: light,
        height: lineHeightLow,
        color: AppColors.readingOnLight,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleUp05,
        fontWeight: regular,
        height: lineHeightLow,
        color: AppColors.readingOnLight,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleUp04,
        fontWeight: medium,
        height: lineHeightLow,
        color: AppColors.readingOnLight,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleUp04,
        fontWeight: medium,
        height: lineHeightLow,
        color: AppColors.readingOnLight,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleUp03,
        fontWeight: semiBold,
        height: lineHeightLow,
        color: AppColors.readingOnLight,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleUp02,
        fontWeight: bold,
        height: lineHeightLow,
        color: AppColors.readingOnLight,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleUp02,
        fontWeight: bold,
        height: lineHeightLow,
        color: AppColors.readingOnLight,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleUp01,
        fontWeight: semiBold,
        height: lineHeightLow,
        color: AppColors.readingOnLight,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleBase,
        fontWeight: extraBold,
        height: lineHeightLow,
        color: AppColors.readingOnLight,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleUp01,
        fontWeight: regular,
        height: lineHeightMedium,
        color: AppColors.readingOnLight,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleBase,
        fontWeight: regular,
        height: lineHeightMedium,
        color: AppColors.readingOnLight,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleDown01,
        fontWeight: regular,
        height: lineHeightMedium,
        color: AppColors.readingOnLight,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleBase,
        fontWeight: semiBold,
        height: lineHeightMedium,
        color: AppColors.readingOnLight,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleDown01,
        fontWeight: semiBold,
        height: lineHeightMedium,
        color: AppColors.readingOnLight,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamilyBase,
        fontSize: scaleDown02,
        fontWeight: semiBold,
        height: lineHeightMedium,
        color: AppColors.readingOnLight,
      ),
    );
  }
}
