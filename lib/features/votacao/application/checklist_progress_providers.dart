import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/persistence_providers.dart';
import '../data/drift_checklist_progress_repository.dart';
import '../domain/checklist_progress_repository.dart';

final checklistProgressRepositoryProvider =
    Provider<ChecklistProgressRepository>((ref) {
      return DriftChecklistProgressRepository(ref.watch(appDatabaseProvider));
    });

final checkedDocumentIdsProvider = StreamProvider<Set<String>>((ref) {
  return ref.watch(checklistProgressRepositoryProvider).watchCheckedIds();
});
