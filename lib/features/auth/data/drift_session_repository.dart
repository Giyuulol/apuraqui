import '../../../core/database/app_database.dart';
import '../domain/auth_session.dart';
import '../domain/session_repository.dart';

class DriftSessionRepository implements SessionRepository {
  DriftSessionRepository(this._database);

  static const demoLogin = 'demo@apuraqui.app';
  static const demoPassword = '123456';
  static const demoUserId = 'demo-user';

  final AppDatabase _database;

  @override
  Stream<AuthSession?> watchSession() {
    return _database.watchSession().map((record) {
      if (record == null) return null;

      return AuthSession(
        userId: record.userId,
        login: record.login,
        authenticatedAt: record.authenticatedAt,
      );
    });
  }

  @override
  Future<bool> login({required String login, required String password}) async {
    final normalizedLogin = login.trim().toLowerCase();
    if (normalizedLogin != demoLogin || password != demoPassword) {
      return false;
    }

    await _database.saveSession(
      userId: demoUserId,
      login: demoLogin,
      authenticatedAt: DateTime.now().toUtc(),
    );
    return true;
  }

  @override
  Future<void> logout() => _database.clearSession();
}
