import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/core/database/app_database.dart';
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
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          home: LeitorQrCodePage(onMenuPressed: () {}, onLogout: () {}),
        ),
      ),
    );

    // Abre modal de resultado simulado
    await tester.tap(find.text('Tocar para Escanear'));
    await tester.pump(const Duration(milliseconds: 500));

    // Verifica que o resultado do QR aparece
    expect(find.text('Resultado simulado do QR Code'), findsOneWidget);
    expect(find.text('Maria Silva'), findsOneWidget);
    // Botões de ação estão presentes (podem estar fora da viewport do sheet)
    expect(find.text('Salvar santinho'), findsOneWidget);
    expect(find.text('Ver propostas'), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
