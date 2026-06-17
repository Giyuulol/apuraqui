abstract interface class AppPreferencesRepository {
  Stream<int> watchNavigationIndex();

  Future<void> saveNavigationIndex(int index);

  Stream<String?> watchRememberedLogin();

  Future<String?> getRememberedLogin();

  Future<void> saveRememberedLogin(String login);

  Future<void> clearRememberedLogin();
}
