import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/persistence_providers.dart';
import '../data/drift_session_repository.dart';
import '../domain/auth_session.dart';
import '../domain/session_repository.dart';

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return DriftSessionRepository(ref.watch(appDatabaseProvider));
});

final sessionProvider = StreamProvider<AuthSession?>((ref) {
  return ref.watch(sessionRepositoryProvider).watchSession();
});

final authControllerProvider = AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<bool> login({required String login, required String password}) async {
    state = const AsyncLoading();
    try {
      final authenticated = await ref
          .read(sessionRepositoryProvider)
          .login(login: login, password: password);
      state = const AsyncData(null);
      return authenticated;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading();
    try {
      await ref.read(sessionRepositoryProvider).logout();
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }
}
