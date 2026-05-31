import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/persistence_providers.dart';
import '../data/drift_saved_santinhos_repository.dart';
import '../domain/saved_santinhos_repository.dart';

final savedSantinhosRepositoryProvider = Provider<SavedSantinhosRepository>((
  ref,
) {
  return DriftSavedSantinhosRepository(ref.watch(appDatabaseProvider));
});

final savedSantinhoIdsProvider = StreamProvider<Set<String>>((ref) {
  return ref.watch(savedSantinhosRepositoryProvider).watchSavedIds();
});
