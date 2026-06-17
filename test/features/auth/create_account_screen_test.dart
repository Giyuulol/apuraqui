import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/features/auth/create_account_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('cadastro valida campos obrigatorios e senha divergente', (
    tester,
  ) async {
    _useTallMobileViewport(tester);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const CreateAccountScreen(),
      ),
    );

    await tester.tap(find.text('Criar Conta').last);
    await tester.pump();

    expect(find.text('Informe seu nome completo'), findsOneWidget);
    expect(find.text('Informe um e-mail válido'), findsOneWidget);
    expect(find.text('Informe um CPF com 11 dígitos'), findsOneWidget);
    expect(
      find.text('Use 8+ caracteres com letra, número e símbolo'),
      findsOneWidget,
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nome Completo'),
      'Francisco Serafim',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'E-mail'),
      'francisco@apuraqui.app',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'CPF'),
      '12345678901',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Senha'),
      'Apura@2026',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirmar Senha'),
      'Outra@2026',
    );
    await tester.tap(find.text('Criar Conta').last);
    await tester.pump();

    expect(find.text('As senhas precisam ser iguais'), findsOneWidget);
  });

  testWidgets('cadastro demo confirma sucesso e volta ao login', (
    tester,
  ) async {
    _useTallMobileViewport(tester);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const CreateAccountScreen(),
      ),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nome Completo'),
      'Francisco Serafim',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'E-mail'),
      'francisco@apuraqui.app',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'CPF'),
      '12345678901',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Senha'),
      'Apura@2026',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Confirmar Senha'),
      'Apura@2026',
    );
    await tester.tap(find.text('Criar Conta').last);
    await tester.pumpAndSettle();

    expect(find.text('Conta demo criada com sucesso.'), findsOneWidget);
  });
}

void _useTallMobileViewport(WidgetTester tester) {
  tester.view.physicalSize = const Size(800, 1000);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
}
