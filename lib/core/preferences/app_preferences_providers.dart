import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/persistence_providers.dart';
import 'app_preferences_repository.dart';
import 'drift_app_preferences_repository.dart';

final appPreferencesRepositoryProvider = Provider<AppPreferencesRepository>((
  ref,
) {
  return DriftAppPreferencesRepository(ref.watch(appDatabaseProvider));
});

final navigationIndexProvider = StreamProvider<int>((ref) {
  return ref.watch(appPreferencesRepositoryProvider).watchNavigationIndex();
});
