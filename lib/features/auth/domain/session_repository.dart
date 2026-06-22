import 'auth_session.dart';
import 'phone_verification.dart';

abstract interface class SessionRepository {
  Stream<AuthSession?> watchSession();

  Future<bool> signInWithDemoCredentials({
    required String login,
    required String password,
  });

  Future<PhoneVerification> requestPhoneVerification(String phoneNumber);

  Future<AuthSession> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  });

  Future<void> logout();
}
