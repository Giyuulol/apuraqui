import '../../../core/database/app_database.dart';
import '../domain/checklist_progress_repository.dart';

class DriftChecklistProgressRepository implements ChecklistProgressRepository {
  DriftChecklistProgressRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<Set<String>> watchCheckedIds() {
    return _database.watchCheckedDocumentIds();
  }

  @override
  Future<void> setChecked(String documentId, {required bool checked}) {
    return _database.setChecklistDocumentChecked(documentId, checked: checked);
  }
}
