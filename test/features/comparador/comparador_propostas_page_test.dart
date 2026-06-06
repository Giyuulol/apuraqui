import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/features/comparador/comparador_propostas_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('comparador reutiliza propostas completas do perfil', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const ComparadorPropostasPage(),
      ),
    );

    expect(find.text('Comparar Propostas'), findsOneWidget);
    expect(find.text('Categorias'), findsOneWidget);
    expect(find.text('Meio Ambiente'), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
    await tester.tap(find.text('Meio Ambiente'));
    await tester.pump();

    expect(find.byIcon(Icons.park_rounded), findsOneWidget);

    expect(
      find.textContaining('Transição energética acelerada'),
      findsOneWidget,
    );
  });
}
