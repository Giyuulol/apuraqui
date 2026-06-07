import 'package:apuraqui/core/database/app_database.dart';
import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/core/navigation/app_routes.dart';
import 'package:apuraqui/core/providers/persistence_providers.dart';
import 'package:apuraqui/features/leitor_qr/leitor_qr_page.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('qr demo mostra santinho simulado e permite salvar', (
    tester,
  ) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          routes: {
            AppRoutes.comparator: (_) => const Text('Comparador aberto'),
          },
          home: LeitorQrCodePage(onMenuPressed: () {}, onLogout: () {}),
        ),
      ),
    );

    await tester.tap(find.text('Tocar para Escanear'));
    await tester.pumpAndSettle();

    expect(find.text('Resultado simulado do QR Code'), findsOneWidget);
    expect(find.text('Maria Silva'), findsOneWidget);

    await tester.tap(find.text('Salvar santinho'));
    await tester.pumpAndSettle();

    final records = await database.select(database.savedSantinhos).get();
    expect(records.map((record) => record.santinhoId), ['s1']);
    expect(find.text('Santinho salvo na sua lista.'), findsOneWidget);

    await tester.tap(find.text('Ver propostas'));
    await tester.pumpAndSettle();

    expect(find.text('Comparador aberto'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
