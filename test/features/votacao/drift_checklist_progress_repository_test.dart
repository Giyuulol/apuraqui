import 'package:apuraqui/core/database/app_database.dart';
import 'package:apuraqui/features/votacao/data/drift_checklist_progress_repository.dart';
import 'package:apuraqui/features/votacao/domain/checklist_progress_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;
  late ChecklistProgressRepository repository;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    repository = DriftChecklistProgressRepository(database);
  });

  tearDown(() async {
    await database.close();
  });

  test('altera documentos marcados pelo repository', () async {
    await repository.setChecked('e-titulo', checked: true);

    expect(await repository.watchCheckedIds().first, {'e-titulo'});

    await repository.setChecked('e-titulo', checked: false);

    expect(await repository.watchCheckedIds().first, isEmpty);
  });
}
