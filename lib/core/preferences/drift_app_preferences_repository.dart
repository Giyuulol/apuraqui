import '../database/app_database.dart';
import 'app_preferences_repository.dart';

class DriftAppPreferencesRepository implements AppPreferencesRepository {
  DriftAppPreferencesRepository(this._database);

  static const navigationIndexKey = 'navigation-index';
  static const navigationDestinationCount = 8;

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

  int _parseIndex(String? value) {
    final index = int.tryParse(value ?? '');
    if (index == null || index < 0 || index >= navigationDestinationCount) {
      return 0;
    }
    return index;
  }
}
