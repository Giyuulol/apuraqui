abstract interface class SavedSantinhosRepository {
  Stream<Set<String>> watchSavedIds();

  Future<void> setSaved(String santinhoId, {required bool saved});
}
