import '../../../core/database/app_database.dart';
import '../domain/auth_exception.dart';
import '../domain/auth_session.dart';
import '../domain/phone_verification.dart';
import '../domain/session_repository.dart';

class DriftSessionRepository implements SessionRepository {
  DriftSessionRepository(this._database);

  static const demoLogin = 'demo@apuraqui.app';
  static const demoPassword = 'Apura@2026';
  static const demoUserId = 'demo-user';

  final AppDatabase _database;

  @override
  Stream<AuthSession?> watchSession() {
    return _database.watchSession().map((record) {
      if (record == null) return null;

      return AuthSession(
        userId: record.userId,
        loginLabel: record.login,
        authProvider: AuthProviderType.demo,
        authenticatedAt: record.authenticatedAt,
      );
    });
  }

  @override
  Future<bool> signInWithDemoCredentials({
    required String login,
    required String password,
  }) async {
    final normalizedLogin = login.trim().toLowerCase();
    final isDemo = normalizedLogin == demoLogin;
    final isCandidate = normalizedLogin == 'candidato@apuraqui.app';

    if ((!isDemo && !isCandidate) || password != demoPassword) {
      return false;
    }

    await _database.saveSession(
      userId: isDemo ? demoUserId : 'candidate-user',
      login: normalizedLogin,
      authenticatedAt: DateTime.now().toUtc(),
    );
    return true;
  }

  @override
  Future<PhoneVerification> requestPhoneVerification(String phoneNumber) {
    throw const AuthException(
      AuthExceptionCode.unavailable,
      'A autenticação por telefone não está disponível no modo demo.',
    );
  }

  @override
  Future<AuthSession> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) {
    throw const AuthException(
      AuthExceptionCode.unavailable,
      'A autenticação por telefone não está disponível no modo demo.',
    );
  }

  @override
  Future<void> logout() => _database.clearSession();
}
