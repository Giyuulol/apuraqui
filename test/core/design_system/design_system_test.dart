import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/core/design_system/tokens/app_colors.dart';
import 'package:apuraqui/core/design_system/tokens/app_radius.dart';
import 'package:apuraqui/core/design_system/tokens/app_spacing.dart';
import 'package:apuraqui/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('expoe tokens fundamentais do design system', () {
    expect(AppSpacing.md, 16);
    expect(AppRadius.card, 8);
    expect(AppColors.interactionOnLight, const Color(0xFF1351B4));
  });

  test('configura o tema GOV.BR-DS adaptado para Flutter', () {
    expect(AppTheme.lightTheme.useMaterial3, isTrue);
    final styles = <TextStyle?>[
      AppTheme.lightTheme.textTheme.displayLarge,
      AppTheme.lightTheme.textTheme.displayMedium,
      AppTheme.lightTheme.textTheme.displaySmall,
      AppTheme.lightTheme.textTheme.headlineLarge,
      AppTheme.lightTheme.textTheme.headlineMedium,
      AppTheme.lightTheme.textTheme.headlineSmall,
      AppTheme.lightTheme.textTheme.titleLarge,
      AppTheme.lightTheme.textTheme.titleMedium,
      AppTheme.lightTheme.textTheme.titleSmall,
      AppTheme.lightTheme.textTheme.bodyLarge,
      AppTheme.lightTheme.textTheme.bodyMedium,
      AppTheme.lightTheme.textTheme.bodySmall,
      AppTheme.lightTheme.textTheme.labelLarge,
      AppTheme.lightTheme.textTheme.labelMedium,
      AppTheme.lightTheme.textTheme.labelSmall,
    ];

    expect(styles.map((style) => style?.fontFamily).toSet(), {
      AppTypography.fontFamilyBase,
    });
  });
}
