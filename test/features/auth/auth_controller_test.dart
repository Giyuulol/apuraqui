import 'package:apuraqui/features/auth/application/auth_providers.dart';
import 'package:apuraqui/features/auth/domain/auth_exception.dart';
import 'package:apuraqui/features/auth/domain/auth_session.dart';
import 'package:apuraqui/features/auth/domain/phone_verification.dart';
import 'package:apuraqui/features/auth/domain/session_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('envia codigo de telefone e registra estado codeSent', () async {
    final repository = _FakeSessionRepository();
    final container = ProviderContainer(
      overrides: [sessionRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final verification = await container
        .read(authControllerProvider.notifier)
        .requestPhoneVerification('+5585999999999');

    expect(verification?.verificationId, 'verification-id');
    expect(
      container.read(authControllerProvider).value?.status,
      AuthFlowStatus.codeSent,
    );
  });

  test('mapeia erro ao enviar codigo', () async {
    final repository = _FakeSessionRepository(
      requestError: const AuthException(
        AuthExceptionCode.invalidPhoneNumber,
        'Telefone inválido.',
      ),
    );
    final container = ProviderContainer(
      overrides: [sessionRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final verification = await container
        .read(authControllerProvider.notifier)
        .requestPhoneVerification('123');

    expect(verification, isNull);
    expect(container.read(authControllerProvider).hasError, isTrue);
  });

  test('confirma codigo e autentica sessao phone', () async {
    final repository = _FakeSessionRepository();
    final container = ProviderContainer(
      overrides: [sessionRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final authenticated = await container
        .read(authControllerProvider.notifier)
        .confirmPhoneCode(verificationId: 'verification-id', smsCode: '123456');

    expect(authenticated, isTrue);
    expect(
      container.read(authControllerProvider).value?.status,
      AuthFlowStatus.authenticated,
    );
  });

  test('falha ao confirmar codigo invalido', () async {
    final repository = _FakeSessionRepository(
      confirmError: const AuthException(
        AuthExceptionCode.invalidVerificationCode,
        'Código inválido.',
      ),
    );
    final container = ProviderContainer(
      overrides: [sessionRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);

    final authenticated = await container
        .read(authControllerProvider.notifier)
        .confirmPhoneCode(verificationId: 'verification-id', smsCode: '000000');

    expect(authenticated, isFalse);
    expect(container.read(authControllerProvider).hasError, isTrue);
  });
}

class _FakeSessionRepository implements SessionRepository {
  _FakeSessionRepository({this.requestError, this.confirmError});

  final AuthException? requestError;
  final AuthException? confirmError;

  @override
  Stream<AuthSession?> watchSession() => Stream<AuthSession?>.value(null);

  @override
  Future<bool> signInWithDemoCredentials({
    required String login,
    required String password,
  }) async {
    return login == 'demo@apuraqui.app' && password == 'Apura@2026';
  }

  @override
  Future<PhoneVerification> requestPhoneVerification(String phoneNumber) async {
    final error = requestError;
    if (error != null) throw error;
    return const PhoneVerification(verificationId: 'verification-id');
  }

  @override
  Future<AuthSession> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final error = confirmError;
    if (error != null) throw error;
    return AuthSession(
      userId: 'firebase-user',
      loginLabel: '+5585999999999',
      authProvider: AuthProviderType.phone,
      authenticatedAt: DateTime.utc(2026, 6, 17),
      phoneNumber: '+5585999999999',
    );
  }

  @override
  Future<void> logout() async {}
}
