import 'package:apuraqui/core/database/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('persiste e remove a sessao local singleton', () async {
    await database.saveSession(
      userId: 'demo-user',
      login: 'demo@apuraqui.app',
      authenticatedAt: DateTime.utc(2026, 5, 31),
    );

    final session = await database.watchSession().first;

    expect(session?.userId, 'demo-user');
    expect(session?.login, 'demo@apuraqui.app');

    await database.clearSession();

    expect(await database.watchSession().first, isNull);
  });

  test('persiste documentos marcados no checklist', () async {
    await database.setChecklistDocumentChecked('e-titulo', checked: true);

    expect(await database.watchCheckedDocumentIds().first, {'e-titulo'});

    await database.setChecklistDocumentChecked('e-titulo', checked: false);

    expect(await database.watchCheckedDocumentIds().first, isEmpty);
  });

  test('persiste santinhos salvos', () async {
    await database.setSantinhoSaved('s1', saved: true);

    expect(await database.watchSavedSantinhoIds().first, {'s1'});

    await database.setSantinhoSaved('s1', saved: false);

    expect(await database.watchSavedSantinhoIds().first, isEmpty);
  });

  test('persiste preferencia de navegacao', () async {
    expect(await database.watchPreference('navigation-index').first, isNull);

    await database.setPreference('navigation-index', '2');

    expect(await database.watchPreference('navigation-index').first, '2');
  });
}
