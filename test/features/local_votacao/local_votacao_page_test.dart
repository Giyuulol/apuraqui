import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/features/local_votacao/local_votacao_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('local de votacao valida documento vazio e invalido', (
    tester,
  ) async {
    _useTallMobileViewport(tester);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: LocalVotacaoPage(onMenuPressed: () {}, onLogout: () {}),
      ),
    );

    await tester.tap(find.text('Buscar Local'));
    await tester.pump();

    expect(find.text('Informe CPF ou título de eleitor.'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '123');
    await tester.tap(find.text('Buscar Local'));
    await tester.pump();

    expect(
      find.text('Digite 11 dígitos para CPF ou 12 para título.'),
      findsOneWidget,
    );
  });

  testWidgets('local de votacao retorna resultado e permite informar fila', (
    tester,
  ) async {
    _useTallMobileViewport(tester);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: LocalVotacaoPage(onMenuPressed: () {}, onLogout: () {}),
      ),
    );

    await tester.enterText(find.byType(TextFormField), '12345678901');
    await tester.tap(find.text('Buscar Local'));
    await tester.pump();

    expect(find.text('Escola Estadual Professor Silva'), findsOneWidget);
    expect(find.text('Fila média informada pela comunidade'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Demorada'),
      120,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Demorada'));
    await tester.pump();

    expect(
      find.text('Obrigado! Fila atualizada para demorada.'),
      findsOneWidget,
    );
  });
}

void _useTallMobileViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}
