import 'package:apuraqui/core/database/app_database.dart';
import 'package:apuraqui/core/preferences/app_preferences_repository.dart';
import 'package:apuraqui/core/preferences/drift_app_preferences_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late AppPreferencesRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftAppPreferencesRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('indice de navegacao inicia em zero e permanece valido', () async {
    expect(await repository.watchNavigationIndex().first, 0);

    await repository.saveNavigationIndex(3);
    expect(await repository.watchNavigationIndex().first, 3);

    await repository.saveNavigationIndex(99);
    expect(await repository.watchNavigationIndex().first, 0);
  });

  test('persiste e limpa login lembrado', () async {
    expect(await repository.watchRememberedLogin().first, isNull);
    expect(await repository.getRememberedLogin(), isNull);

    await repository.saveRememberedLogin(' demo@apuraqui.app ');
    expect(await repository.watchRememberedLogin().first, 'demo@apuraqui.app');
    expect(await repository.getRememberedLogin(), 'demo@apuraqui.app');

    await repository.clearRememberedLogin();
    expect(await repository.watchRememberedLogin().first, isNull);
    expect(await repository.getRememberedLogin(), isNull);
  });
}
