import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/persistence_providers.dart';
import '../data/composite_session_repository.dart';
import '../data/drift_session_repository.dart';
import '../data/firebase_auth_repository.dart';
import '../data/unavailable_phone_auth_repository.dart';
import '../domain/auth_exception.dart';
import '../domain/auth_session.dart';
import '../domain/phone_verification.dart';
import '../domain/session_repository.dart';

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final demoRepository = DriftSessionRepository(ref.watch(appDatabaseProvider));
  final phoneRepository = Firebase.apps.isEmpty
      ? const UnavailablePhoneAuthRepository()
      : FirebaseAuthRepository(firebase_auth.FirebaseAuth.instance);

  return CompositeSessionRepository(
    demoRepository: demoRepository,
    phoneRepository: phoneRepository,
  );
});

final sessionProvider = StreamProvider<AuthSession?>((ref) {
  return ref.watch(sessionRepositoryProvider).watchSession();
});

final authControllerProvider =
    AsyncNotifierProvider<AuthController, AuthControllerState>(
      AuthController.new,
    );

class AuthControllerState {
  const AuthControllerState({
    required this.status,
    this.verification,
    this.message,
  });

  const AuthControllerState.idle()
    : status = AuthFlowStatus.idle,
      verification = null,
      message = null;

  final AuthFlowStatus status;
  final PhoneVerification? verification;
  final String? message;

  AuthControllerState copyWith({
    AuthFlowStatus? status,
    PhoneVerification? verification,
    String? message,
    bool clearMessage = false,
  }) {
    return AuthControllerState(
      status: status ?? this.status,
      verification: verification ?? this.verification,
      message: clearMessage ? null : message ?? this.message,
    );
  }
}

enum AuthFlowStatus {
  idle,
  sendingCode,
  codeSent,
  verifyingCode,
  authenticated,
  error,
}

class AuthController extends AsyncNotifier<AuthControllerState> {
  @override
  FutureOr<AuthControllerState> build() => const AuthControllerState.idle();

  Future<bool> login({required String login, required String password}) async {
    return signInWithDemoCredentials(login: login, password: password);
  }

  Future<bool> signInWithDemoCredentials({
    required String login,
    required String password,
  }) async {
    state = const AsyncLoading<AuthControllerState>();
    try {
      final authenticated = await ref
          .read(sessionRepositoryProvider)
          .signInWithDemoCredentials(login: login, password: password);
      state = AsyncData(
        AuthControllerState(
          status: authenticated
              ? AuthFlowStatus.authenticated
              : AuthFlowStatus.error,
          message: authenticated ? null : 'Credenciais demo inválidas.',
        ),
      );
      return authenticated;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  Future<PhoneVerification?> requestPhoneVerification(
    String phoneNumber,
  ) async {
    state = const AsyncData(
      AuthControllerState(status: AuthFlowStatus.sendingCode),
    );
    try {
      final verification = await ref
          .read(sessionRepositoryProvider)
          .requestPhoneVerification(phoneNumber);

      state = AsyncData(
        AuthControllerState(
          status: verification.autoVerified
              ? AuthFlowStatus.authenticated
              : AuthFlowStatus.codeSent,
          verification: verification,
        ),
      );
      return verification;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return null;
    }
  }

  Future<bool> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final previousVerification = state.value?.verification;
    state = AsyncData(
      AuthControllerState(
        status: AuthFlowStatus.verifyingCode,
        verification: previousVerification,
      ),
    );

    try {
      await ref
          .read(sessionRepositoryProvider)
          .confirmPhoneCode(verificationId: verificationId, smsCode: smsCode);
      state = AsyncData(
        AuthControllerState(
          status: AuthFlowStatus.authenticated,
          verification: previousVerification,
        ),
      );
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }

  Future<void> logout() async {
    state = const AsyncLoading<AuthControllerState>();
    try {
      await ref.read(sessionRepositoryProvider).logout();
      state = const AsyncData(AuthControllerState.idle());
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      rethrow;
    }
  }

  String messageFor(Object error) {
    if (error is AuthException) return error.message;
    return 'Não foi possível concluir a autenticação. Tente novamente.';
  }
}
