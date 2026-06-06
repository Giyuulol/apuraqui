import 'package:apuraqui/core/database/app_database.dart';
import 'package:apuraqui/core/providers/persistence_providers.dart';
import 'package:apuraqui/main.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  testWidgets('inicia pelo login e valida campos obrigatorios', (tester) async {
    await _pumpApp(tester, database);

    expect(find.text('Entrar'), findsOneWidget);
    expect(find.text('Acessar Sistema'), findsOneWidget);
    expect(find.text('E-mail ou CPF'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Acessar Sistema'));
    await tester.pump();

    expect(find.text('Informe seu e-mail ou CPF'), findsOneWidget);
    expect(find.text('Informe sua senha'), findsOneWidget);

    await _disposeWidgetTree(tester);
  });

  testWidgets('login demo abre a home e persiste sessao', (tester) async {
    await _pumpApp(tester, database);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'E-mail ou CPF'),
      'demo@apuraqui.app',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Senha'),
      '123456',
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'Acessar Sistema'));
    await tester.pumpAndSettle();

    expect(find.text('Total de Votos'), findsOneWidget);
    final sessions = await database.select(database.appSessions).get();
    expect(sessions.single.login, 'demo@apuraqui.app');

    await _disposeWidgetTree(tester);
  });

  testWidgets('sessao persistida abre diretamente a home', (tester) async {
    await database.saveSession(
      userId: 'demo-user',
      login: 'demo@apuraqui.app',
      authenticatedAt: DateTime.utc(2026, 5, 31),
    );

    await _pumpApp(tester, database);

    expect(find.text('Total de Votos'), findsOneWidget);
    expect(find.text('Acessar Sistema'), findsNothing);

    await _disposeWidgetTree(tester);
  });

  testWidgets('logout remove sessao e volta ao login', (tester) async {
    await database.saveSession(
      userId: 'demo-user',
      login: 'demo@apuraqui.app',
      authenticatedAt: DateTime.utc(2026, 5, 31),
    );
    await _pumpApp(tester, database);

    await tester.tap(find.byTooltip('Sair'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sim, quero sair'));
    await tester.pumpAndSettle();

    expect(find.text('Acessar Sistema'), findsOneWidget);
    expect(await database.select(database.appSessions).get(), isEmpty);

    await _disposeWidgetTree(tester);
  });

  testWidgets('home persiste a secao selecionada', (tester) async {
    await _pumpHome(tester, database);

    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Santinhos Digitais'));
    await tester.pumpAndSettle();

    expect(find.text('Santinhos Digitais'), findsOneWidget);
    final preferences = await database.select(database.appPreferences).get();
    expect(preferences.single.value, '1');

    await tester.pumpWidget(const SizedBox());
    await _pumpHome(tester, database);

    expect(find.text('Santinhos Digitais'), findsOneWidget);

    await _disposeWidgetTree(tester);
  });
}

Future<void> _pumpApp(WidgetTester tester, AppDatabase database) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
      child: const ApuraquiApp(),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _pumpHome(WidgetTester tester, AppDatabase database) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(database)],
      child: const MaterialApp(home: AppHomePage()),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _disposeWidgetTree(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(milliseconds: 1));
}
