import 'package:apuraqui/core/database/app_database.dart';
import 'package:apuraqui/features/santinho/data/drift_saved_santinhos_repository.dart';
import 'package:apuraqui/features/santinho/domain/saved_santinhos_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late SavedSantinhosRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftSavedSantinhosRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('salva e remove santinho pelo repository', () async {
    await repository.setSaved('s1', saved: true);

    expect(await repository.watchSavedIds().first, {'s1'});

    await repository.setSaved('s1', saved: false);

    expect(await repository.watchSavedIds().first, isEmpty);
  });
}
