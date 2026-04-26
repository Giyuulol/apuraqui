import 'package:flutter/material.dart';

class AppTheme {
  static const Color govBrBlue = Color(0xFF1351B4);
  static const Color govBrGreen = Color(0xFF168821);
  static const Color govBrYellow = Color(0xFFFFCD07);
  static const Color neutralBackground = Color(0xFFF8F8F8);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: govBrBlue,
      primary: govBrBlue,
      secondary: govBrGreen,
      tertiary: govBrYellow,
      surface: Colors.white,
      surfaceContainerHighest: neutralBackground,
    ),
    scaffoldBackgroundColor: neutralBackground,
    appBarTheme: const AppBarTheme(
      backgroundColor: govBrBlue,
      foregroundColor: Colors.white,
      centerTitle: false,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return govBrBlue;
        }

        return Colors.white;
      }),
      checkColor: const WidgetStatePropertyAll(Colors.white),
      side: const BorderSide(color: govBrBlue, width: 1.5),
    ),
  );
}
