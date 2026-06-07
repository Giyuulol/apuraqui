import 'package:apuraqui/core/database/app_database.dart';
import 'package:apuraqui/core/navigation/app_routes.dart';
import 'package:apuraqui/core/providers/persistence_providers.dart';
import 'package:apuraqui/features/santinho/santinhos_page.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('salvar santinho grava estado no SQLite', (tester) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          routes: {AppRoutes.comparator: (_) => const SizedBox()},
          home: const SantinhosPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar Santinho').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Santinho salvo!'), findsOneWidget);
    final records = await database.select(database.savedSantinhos).get();
    expect(records.map((record) => record.santinhoId), ['s1']);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 1));
  });

  testWidgets('remover santinho salvo (toggle) atualiza banco e UI', (
    tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    tester.view.physicalSize = const Size(800, 2500);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          routes: {AppRoutes.comparator: (_) => const SizedBox()},
          home: const SantinhosPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // 1. Salvar o santinho
    await tester.tap(find.text('Salvar Santinho').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Santinho salvo!'), findsOneWidget);
    var records = await database.select(database.savedSantinhos).get();
    expect(records.map((record) => record.santinhoId), ['s1']);

    // 2. Remover o santinho (toggle) clicando no botão de salvo
    await tester.tap(find.text('Santinho salvo!').first);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      find.text('Salvar Santinho'),
      findsNWidgets(3),
    ); // volta a ter 3 botões "Salvar Santinho"
    records = await database.select(database.savedSantinhos).get();
    expect(records, isEmpty);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
