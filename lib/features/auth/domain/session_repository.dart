import 'auth_session.dart';

abstract interface class SessionRepository {
  Stream<AuthSession?> watchSession();

  Future<bool> login({required String login, required String password});

  Future<void> logout();
}
