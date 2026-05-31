import 'package:apuraqui/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('inicia pelo login e valida campos obrigatorios', (tester) async {
    await tester.pumpWidget(const ApuraquiApp());

    expect(find.text('Entrar'), findsNWidgets(2));
    expect(find.text('E-mail ou CPF'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();

    expect(find.text('Informe seu e-mail ou CPF'), findsOneWidget);
    expect(find.text('Informe sua senha'), findsOneWidget);
  });

  testWidgets('login mock abre a home com navegacao principal', (tester) async {
    await tester.pumpWidget(const ApuraquiApp());

    await tester.enterText(
      find.widgetWithText(TextFormField, 'E-mail ou CPF'),
      'eleitor@apuraqui.app',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Senha'),
      '123456',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Entrar'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    await tester.pumpAndSettle();

    expect(find.text('Perfis dos Candidatos'), findsOneWidget);
    expect(find.text('Checklist'), findsOneWidget);
    expect(find.text('Notícias'), findsOneWidget);
    expect(find.text('Santinhos'), findsOneWidget);
  });

  testWidgets('home navega pelas features importadas do Rafael', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: AppHomePage()));

    await tester.tap(find.text('Checklist'));
    await tester.pumpAndSettle();
    expect(find.text('Checklist do Eleitor'), findsOneWidget);

    await tester.tap(find.text('Notícias'));
    await tester.pumpAndSettle();
    expect(find.text('Notícias e Verificação'), findsOneWidget);

    await tester.tap(find.text('Santinhos'));
    await tester.pumpAndSettle();
    expect(find.text('Santinhos Digitais'), findsOneWidget);
  });
}
