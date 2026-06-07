abstract interface class ChecklistProgressRepository {
  Stream<Set<String>> watchCheckedIds();

  Future<void> setChecked(String documentId, {required bool checked});
}
