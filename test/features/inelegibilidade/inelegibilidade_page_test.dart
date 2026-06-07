import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/features/inelegibilidade/inelegibilidade_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('inelegibilidade exibe casos simulados e estado vazio', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: InelegibilidadePage(onMenuPressed: () {}, onLogout: () {}),
      ),
    );

    expect(find.text('Exceções e Inelegibilidade'), findsOneWidget);
    expect(
      find.text('Dados simulados para orientação do eleitor'),
      findsOneWidget,
    );
    expect(find.text('Candidatura indeferida'), findsOneWidget);

    await tester.tap(find.text('Exibir estado vazio'));
    await tester.pump();

    expect(
      find.text('Nenhum caso encontrado para o filtro selecionado.'),
      findsOneWidget,
    );
  });
}
