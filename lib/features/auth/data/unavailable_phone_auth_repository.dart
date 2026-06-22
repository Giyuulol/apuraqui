import '../domain/auth_exception.dart';
import '../domain/auth_session.dart';
import '../domain/phone_verification.dart';
import '../domain/session_repository.dart';

class UnavailablePhoneAuthRepository implements SessionRepository {
  const UnavailablePhoneAuthRepository();

  @override
  Stream<AuthSession?> watchSession() => Stream<AuthSession?>.value(null);

  @override
  Future<bool> signInWithDemoCredentials({
    required String login,
    required String password,
  }) {
    throw const AuthException(
      AuthExceptionCode.unavailable,
      'O login demo não é responsabilidade do adapter de telefone.',
    );
  }

  @override
  Future<PhoneVerification> requestPhoneVerification(String phoneNumber) {
    throw const AuthException(
      AuthExceptionCode.unavailable,
      'Firebase ainda não foi configurado. Adicione os arquivos do Firebase e inicialize o app.',
    );
  }

  @override
  Future<AuthSession> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) {
    throw const AuthException(
      AuthExceptionCode.unavailable,
      'Firebase ainda não foi configurado. Adicione os arquivos do Firebase e inicialize o app.',
    );
  }

  @override
  Future<void> logout() async {}
}
