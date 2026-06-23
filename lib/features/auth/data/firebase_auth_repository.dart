import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../domain/auth_exception.dart';
import '../domain/auth_session.dart';
import '../domain/phone_verification.dart';
import '../domain/session_repository.dart';

class FirebaseAuthRepository implements SessionRepository {
  FirebaseAuthRepository(this._firebaseAuth);

  final firebase_auth.FirebaseAuth _firebaseAuth;

  @override
  Stream<AuthSession?> watchSession() {
    return _firebaseAuth.authStateChanges().map(_mapUser);
  }

  @override
  Future<bool> signInWithDemoCredentials({
    required String login,
    required String password,
  }) {
    throw const AuthException(
      AuthExceptionCode.unavailable,
      'O login demo não é responsabilidade do Firebase Auth.',
    );
  }

  @override
  Future<PhoneVerification> requestPhoneVerification(String phoneNumber) {
    final completer = Completer<PhoneVerification>();

    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) async {
        try {
          await _firebaseAuth.signInWithCredential(credential);
          if (!completer.isCompleted) {
            completer.complete(
              const PhoneVerification(verificationId: '', autoVerified: true),
            );
          }
        } on firebase_auth.FirebaseAuthException catch (error) {
          if (!completer.isCompleted) {
            completer.completeError(_mapFirebaseError(error));
          }
        }
      },
      verificationFailed: (error) {
        if (!completer.isCompleted) {
          completer.completeError(_mapFirebaseError(error));
        }
      },
      codeSent: (verificationId, resendToken) {
        if (!completer.isCompleted) {
          completer.complete(
            PhoneVerification(
              verificationId: verificationId,
              resendToken: resendToken,
            ),
          );
        }
      },
      codeAutoRetrievalTimeout: (verificationId) {
        if (!completer.isCompleted) {
          completer.complete(PhoneVerification(verificationId: verificationId));
        }
      },
    );

    return completer.future;
  }

  @override
  Future<AuthSession> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final credential = firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final result = await _firebaseAuth.signInWithCredential(credential);
      final session = _mapUser(result.user);
      if (session == null) {
        throw const AuthException(
          AuthExceptionCode.unknown,
          'Não foi possível criar a sessão do usuário.',
        );
      }
      return session;
    } on firebase_auth.FirebaseAuthException catch (error) {
      throw _mapFirebaseError(error);
    }
  }

  @override
  Future<void> logout() => _firebaseAuth.signOut();

  AuthSession? _mapUser(firebase_auth.User? user) {
    if (user == null) return null;

    return AuthSession(
      userId: user.uid,
      loginLabel: user.phoneNumber ?? user.uid,
      authProvider: AuthProviderType.phone,
      authenticatedAt:
          user.metadata.lastSignInTime?.toUtc() ?? DateTime.now().toUtc(),
      phoneNumber: user.phoneNumber,
    );
  }

  AuthException _mapFirebaseError(firebase_auth.FirebaseAuthException error) {
    return switch (error.code) {
      'invalid-phone-number' => const AuthException(
        AuthExceptionCode.invalidPhoneNumber,
        'Informe um telefone válido no formato internacional. Exemplo: +5585999999999.',
      ),
      'invalid-verification-code' ||
      'invalid-verification-id' => const AuthException(
        AuthExceptionCode.invalidVerificationCode,
        'Código inválido. Confira o SMS e tente novamente.',
      ),
      'too-many-requests' || 'quota-exceeded' => const AuthException(
        AuthExceptionCode.tooManyRequests,
        'Muitas tentativas. Aguarde alguns minutos antes de tentar novamente.',
      ),
      'internal-error' => const AuthException(
        AuthExceptionCode.unavailable,
        'O Firebase não conseguiu enviar o SMS. Confirme se o número é um celular e tente novamente mais tarde.',
      ),
      'captcha-check-failed' ||
      'invalid-app-credential' ||
      'app-not-authorized' => const AuthException(
        AuthExceptionCode.unavailable,
        'Não foi possível validar este aplicativo. Feche e abra o app novamente antes de tentar.',
      ),
      'operation-not-allowed' => const AuthException(
        AuthExceptionCode.unavailable,
        'O login por telefone não está habilitado neste ambiente.',
      ),
      'network-request-failed' => const AuthException(
        AuthExceptionCode.unavailable,
        'Não foi possível conectar ao Firebase. Verifique sua conexão.',
      ),
      _ => AuthException(
        AuthExceptionCode.unknown,
        error.message ?? 'Não foi possível concluir a autenticação.',
      ),
    };
  }
}
