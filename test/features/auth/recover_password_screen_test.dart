import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/features/auth/recover_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('recuperacao valida email vazio e nao encontrado', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const RecoverPasswordScreen(),
      ),
    );

    await tester.tap(find.text('Enviar Instruções'));
    await tester.pump();

    expect(find.text('Informe um e-mail válido'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'E-mail'),
      'naoexiste@apuraqui.app',
    );
    await tester.tap(find.text('Enviar Instruções'));
    await tester.pumpAndSettle();

    expect(find.text('Conta não encontrada'), findsOneWidget);
  });

  testWidgets('recuperacao demo confirma envio para email conhecido', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const RecoverPasswordScreen(),
      ),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'E-mail'),
      'demo@apuraqui.app',
    );
    await tester.tap(find.text('Enviar Instruções'));
    await tester.pumpAndSettle();

    expect(find.text('E-mail Enviado!'), findsOneWidget);
    expect(find.textContaining('demo@apuraqui.app'), findsOneWidget);
  });
}
