abstract interface class AppPreferencesRepository {
  Stream<int> watchNavigationIndex();

  Future<void> saveNavigationIndex(int index);
}
