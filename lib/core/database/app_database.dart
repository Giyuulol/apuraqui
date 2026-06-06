import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

@DataClassName('SessionRecord')
class AppSessions extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get userId => text()();
  TextColumn get login => text()();
  DateTimeColumn get authenticatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('ChecklistProgressRecord')
class ChecklistProgress extends Table {
  TextColumn get documentId => text()();
  BoolColumn get checked => boolean()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {documentId};
}

@DataClassName('SavedSantinhoRecord')
class SavedSantinhos extends Table {
  TextColumn get santinhoId => text()();
  DateTimeColumn get savedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {santinhoId};
}

@DataClassName('AppPreferenceRecord')
class AppPreferences extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DriftDatabase(
  tables: [AppSessions, ChecklistProgress, SavedSantinhos, AppPreferences],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.executor);

  AppDatabase.defaults() : super(driftDatabase(name: 'apuraqui'));

  @override
  int get schemaVersion => 1;

  Stream<SessionRecord?> watchSession() {
    return (select(
      appSessions,
    )..where((table) => table.id.equals(1))).watchSingleOrNull();
  }

  Future<void> saveSession({
    required String userId,
    required String login,
    required DateTime authenticatedAt,
  }) {
    return into(appSessions).insertOnConflictUpdate(
      AppSessionsCompanion.insert(
        userId: userId,
        login: login,
        authenticatedAt: authenticatedAt,
      ),
    );
  }

  Future<void> clearSession() async {
    await (delete(appSessions)..where((table) => table.id.equals(1))).go();
  }

  Stream<Set<String>> watchCheckedDocumentIds() {
    return (select(checklistProgress)
          ..where((table) => table.checked.equals(true)))
        .watch()
        .map((records) => records.map((record) => record.documentId).toSet());
  }

  Future<void> setChecklistDocumentChecked(
    String documentId, {
    required bool checked,
  }) async {
    if (!checked) {
      await (delete(
        checklistProgress,
      )..where((table) => table.documentId.equals(documentId))).go();
      return;
    }

    await into(checklistProgress).insertOnConflictUpdate(
      ChecklistProgressCompanion.insert(
        documentId: documentId,
        checked: true,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Stream<Set<String>> watchSavedSantinhoIds() {
    return select(savedSantinhos).watch().map(
      (records) => records.map((record) => record.santinhoId).toSet(),
    );
  }

  Future<void> setSantinhoSaved(
    String santinhoId, {
    required bool saved,
  }) async {
    if (!saved) {
      await (delete(
        savedSantinhos,
      )..where((table) => table.santinhoId.equals(santinhoId))).go();
      return;
    }

    await into(savedSantinhos).insertOnConflictUpdate(
      SavedSantinhosCompanion.insert(
        santinhoId: santinhoId,
        savedAt: DateTime.now().toUtc(),
      ),
    );
  }

  Stream<String?> watchPreference(String key) {
    return (select(appPreferences)..where((table) => table.key.equals(key)))
        .watchSingleOrNull()
        .map((record) => record?.value);
  }

  Future<void> setPreference(String key, String value) {
    return into(appPreferences).insertOnConflictUpdate(
      AppPreferencesCompanion.insert(
        key: key,
        value: value,
        updatedAt: DateTime.now().toUtc(),
      ),
    );
  }
}
