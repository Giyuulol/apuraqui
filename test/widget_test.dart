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
    expect(find.text('Usar dados de demonstração'), findsNothing);
    expect(find.text('Entrar como Candidato'), findsNothing);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Acessar Sistema'));
    await tester.pump();

    expect(find.text('Informe seu e-mail ou CPF'), findsOneWidget);
    expect(find.text('Informe sua senha'), findsOneWidget);

    await _disposeWidgetTree(tester);
  });

  testWidgets('login demo abre a home e persiste sessao', (tester) async {
    await _pumpApp(tester, database);

    await tester.enterText(_loginFieldAt(0), 'demo@apuraqui.app');
    await tester.enterText(_loginFieldAt(1), 'Apura@2026');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Acessar Sistema'));
    await tester.pumpAndSettle();

    expect(find.text('Total de Votos'), findsOneWidget);
    final sessions = await database.select(database.appSessions).get();
    expect(sessions.single.login, 'demo@apuraqui.app');

    await _disposeWidgetTree(tester);
  });

  testWidgets('login invalido exibe modal de acesso negado', (tester) async {
    await _pumpApp(tester, database);

    await tester.enterText(_loginFieldAt(0), 'erro@apuraqui.app');
    await tester.enterText(_loginFieldAt(1), 'Apura@2026');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Acessar Sistema'));
    await tester.pumpAndSettle();

    expect(find.text('Acesso Negado'), findsOneWidget);
    expect(
      find.text(
        'E-mail, CPF ou senha incorretos. Verifique seus dados e tente novamente.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Tentar Novamente'));
    await tester.pumpAndSettle();

    expect(find.text('Acesso Negado'), findsNothing);

    await _disposeWidgetTree(tester);
  });

  testWidgets('login rejeita senha fraca antes de autenticar', (tester) async {
    await _pumpApp(tester, database);

    await tester.enterText(_loginFieldAt(0), 'demo@apuraqui.app');
    await tester.enterText(_loginFieldAt(1), '123456');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Acessar Sistema'));
    await tester.pump();

    expect(
      find.text('Use 8+ caracteres com letra, número e símbolo'),
      findsOneWidget,
    );
    expect(await database.select(database.appSessions).get(), isEmpty);

    await _disposeWidgetTree(tester);
  });

  testWidgets('lembrar-me persiste somente o login na tela de login', (
    tester,
  ) async {
    await _pumpApp(tester, database);

    await tester.enterText(_loginFieldAt(0), 'demo@apuraqui.app');
    await tester.enterText(_loginFieldAt(1), 'Apura@2026');
    await tester.tap(find.text('Lembrar-me'));
    await tester.pump();
    expect(tester.widget<Checkbox>(find.byType(Checkbox).first).value, isTrue);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Acessar Sistema'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Sair'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sim, quero sair'));
    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: 50));

    final loginField = tester.widget<TextFormField>(_loginFieldAt(0));
    final passwordField = tester.widget<TextFormField>(_loginFieldAt(1));
    final rememberMe = tester.widget<Checkbox>(find.byType(Checkbox).first);

    expect(loginField.controller?.text, 'demo@apuraqui.app');
    expect(passwordField.controller?.text, isEmpty);
    expect(rememberMe.value, isTrue);
    expect(await database.select(database.appSessions).get(), isEmpty);

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

  testWidgets('drawer navega para excecoes e inelegibilidade', (tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await _pumpHome(tester, database);

    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Exceções e Inelegibilidade'),
      120,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('Exceções e Inelegibilidade'));
    await tester.pumpAndSettle();

    expect(find.text('Exceções e Inelegibilidade'), findsOneWidget);

    await _disposeWidgetTree(tester);
  });

  testWidgets('perfil abre comparador mantendo menu lateral', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await _pumpHome(tester, database);
    await _openDrawerDestination(tester, 'Perfis dos Candidatos');

    await tester.scrollUntilVisible(
      find.text('Comparar propostas'),
      120,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Comparar propostas'));
    await tester.pumpAndSettle();

    expect(find.text('Compare candidatos lado a lado'), findsOneWidget);
    expect(find.byTooltip('Menu'), findsOneWidget);

    await _disposeWidgetTree(tester);
  });

  testWidgets('santinho abre comparador mantendo menu lateral', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await _pumpHome(tester, database);
    await _openDrawerDestination(tester, 'Santinhos Digitais');

    await tester.tap(find.text('Ver Propostas').first);
    await tester.pumpAndSettle();

    expect(find.text('Compare candidatos lado a lado'), findsOneWidget);
    expect(find.byTooltip('Menu'), findsOneWidget);

    await _disposeWidgetTree(tester);
  });

  testWidgets('qr abre comparador mantendo menu lateral', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await _pumpHome(tester, database);
    await _openDrawerDestination(tester, 'Leitor de QR Code');

    await tester.tap(find.text('Tocar para Escanear'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ver propostas'));
    await tester.pumpAndSettle();

    expect(find.text('Compare candidatos lado a lado'), findsOneWidget);
    expect(find.byTooltip('Menu'), findsOneWidget);

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

Finder _loginFieldAt(int index) {
  return find.byType(TextFormField).at(index);
}

Future<void> _openDrawerDestination(
  WidgetTester tester,
  String destination,
) async {
  await tester.tap(find.byTooltip('Menu'));
  await tester.pumpAndSettle();
  await tester.scrollUntilVisible(
    find.text(destination),
    120,
    scrollable: find.byType(Scrollable).last,
  );
  await tester.tap(find.text(destination));
  await tester.pumpAndSettle();
}

Future<void> _disposeWidgetTree(WidgetTester tester) async {
  await tester.pumpWidget(const SizedBox());
  await tester.pump(const Duration(milliseconds: 1));
}
