import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/features/perfil/candidatos_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('cards de selecao de candidato nao causam overflow', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.lightTheme, home: const CandidatosPage()),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Maria\nSilva'), findsOneWidget);
  });
}
