import 'package:apuraqui/core/database/app_database.dart';
import 'package:apuraqui/core/providers/persistence_providers.dart';
import 'package:apuraqui/features/votacao/checklist_documentos_page.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('checklist grava documento marcado no SQLite', (tester) async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [appDatabaseProvider.overrideWithValue(database)],
        child: const MaterialApp(home: ChecklistDocumentosPage()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('e-Título ou Título Físico'));
    await tester.pumpAndSettle();

    final records = await database.select(database.checklistProgress).get();
    expect(records.map((record) => record.documentId), ['e-titulo']);

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
