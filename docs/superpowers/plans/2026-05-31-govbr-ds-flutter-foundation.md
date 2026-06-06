# GOV.BR-DS Flutter Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Criar uma camada local de design system Flutter inspirada no GOV.BR-DS sem quebrar os imports atuais.

**Architecture:** A nova camada vive em `lib/core/design_system` e concentra tokens, tema e componentes compartilhados. Os arquivos antigos tornam-se adapters por `export`, permitindo migracao gradual das features sem mudanca visual nesta etapa.

**Tech Stack:** Flutter, Dart, Material 3, `flutter_test`

---

### Task 1: Contrato Da Nova Camada

**Files:**
- Create: `test/core/design_system/design_system_test.dart`

- [x] **Step 1: Write the failing test**

```dart
import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/core/design_system/tokens/app_colors.dart';
import 'package:apuraqui/core/design_system/tokens/app_radius.dart';
import 'package:apuraqui/core/design_system/tokens/app_spacing.dart';
import 'package:apuraqui/core/design_system/tokens/app_typography.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('expoe tokens fundamentais do design system', () {
    expect(AppSpacing.md, 16);
    expect(AppRadius.card, 8);
    expect(AppColors.interactionOnLight.value, 0xFF1351B4);
  });

  test('configura o tema GOV.BR-DS adaptado para Flutter', () {
    expect(AppTheme.lightTheme.useMaterial3, isTrue);
    expect(AppTheme.lightTheme.fontFamily, AppTypography.fontFamilyBase);
  });
}
```

- [x] **Step 2: Run test to verify it fails**

Run: `flutter test test/core/design_system/design_system_test.dart`

Expected: FAIL because `core/design_system` does not exist yet.

### Task 2: Tokens E Tema

**Files:**
- Create: `lib/core/design_system/tokens/app_colors.dart`
- Create: `lib/core/design_system/tokens/app_spacing.dart`
- Create: `lib/core/design_system/tokens/app_radius.dart`
- Create: `lib/core/design_system/tokens/app_typography.dart`
- Create: `lib/core/design_system/theme/app_theme.dart`
- Modify: `lib/core/theme/app_colors.dart`
- Modify: `lib/core/theme/app_typography.dart`
- Modify: `lib/core/theme/app_theme.dart`

- [x] **Step 1: Move the existing color, typography and theme definitions**

Preserve the current public classes and values in the new paths.

- [x] **Step 2: Add spacing and radius token scales**

```dart
class AppSpacing {
  const AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

class AppRadius {
  const AppRadius._();

  static const double control = 4;
  static const double card = 8;
  static const double surface = 12;
  static const double pill = 999;
}
```

- [x] **Step 3: Replace old files with compatibility exports**

```dart
export '../design_system/tokens/app_colors.dart';
export '../design_system/tokens/app_typography.dart';
export '../design_system/theme/app_theme.dart';
```

### Task 3: Componentes Compartilhados

**Files:**
- Create: `lib/core/design_system/components/app_card.dart`
- Create: `lib/core/design_system/components/app_info_alert.dart`
- Modify: `lib/core/widgets/app_card.dart`
- Modify: `lib/core/widgets/app_info_alert.dart`

- [x] **Step 1: Move the existing component definitions**

Preserve constructors and behavior in the new paths.

- [x] **Step 2: Replace old files with compatibility exports**

```dart
export '../design_system/components/app_card.dart';
export '../design_system/components/app_info_alert.dart';
```

### Task 4: Compatibilidade E Verificacao

**Files:**
- Modify: `test/core/design_system/design_system_test.dart`

- [x] **Step 1: Add adapter compatibility assertions**

```dart
expect(legacy.AppColors.interactionOnLight, AppColors.interactionOnLight);
expect(legacy_widgets.AppCard, AppCard);
```

- [x] **Step 2: Run formatter**

Run: `dart format lib/core test/core`

Expected: formatter exits with status `0`.

- [x] **Step 3: Run focused test**

Run: `flutter test test/core/design_system/design_system_test.dart`

Expected: PASS.

- [x] **Step 4: Run project verification**

Run: `flutter analyze`

Expected: no new analyzer issues from the design-system foundation.

Run: `flutter test`

Expected: PASS.
