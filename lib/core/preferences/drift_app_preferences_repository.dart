import '../database/app_database.dart';
import 'app_preferences_repository.dart';

class DriftAppPreferencesRepository implements AppPreferencesRepository {
  DriftAppPreferencesRepository(this._database);

  static const navigationIndexKey = 'navigation-index';
  static const rememberedLoginKey = 'remembered-login';
  static const navigationDestinationCount = 9;

  final AppDatabase _database;

  @override
  Stream<int> watchNavigationIndex() {
    return _database.watchPreference(navigationIndexKey).map(_parseIndex);
  }

  @override
  Future<void> saveNavigationIndex(int index) {
    return _database.setPreference(
      navigationIndexKey,
      _parseIndex('$index').toString(),
    );
  }

  @override
  Stream<String?> watchRememberedLogin() {
    return _database.watchPreference(rememberedLoginKey).map((value) {
      final normalized = value?.trim();
      if (normalized == null || normalized.isEmpty) return null;
      return normalized;
    });
  }

  @override
  Future<String?> getRememberedLogin() async {
    final value = await _database.getPreference(rememberedLoginKey);
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return null;
    return normalized;
  }

  @override
  Future<void> saveRememberedLogin(String login) {
    return _database.setPreference(rememberedLoginKey, login.trim());
  }

  @override
  Future<void> clearRememberedLogin() {
    return _database.setPreference(rememberedLoginKey, '');
  }

  int _parseIndex(String? value) {
    final index = int.tryParse(value ?? '');
    if (index == null || index < 0 || index >= navigationDestinationCount) {
      return 0;
    }
    return index;
  }
}
