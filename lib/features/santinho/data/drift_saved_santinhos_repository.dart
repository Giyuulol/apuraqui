import '../../../core/database/app_database.dart';
import '../domain/saved_santinhos_repository.dart';

class DriftSavedSantinhosRepository implements SavedSantinhosRepository {
  DriftSavedSantinhosRepository(this._database);

  final AppDatabase _database;

  @override
  Stream<Set<String>> watchSavedIds() {
    return _database.watchSavedSantinhoIds();
  }

  @override
  Future<void> setSaved(String santinhoId, {required bool saved}) {
    return _database.setSantinhoSaved(santinhoId, saved: saved);
  }
}
