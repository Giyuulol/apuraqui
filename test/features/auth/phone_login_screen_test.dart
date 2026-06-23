import 'package:apuraqui/features/auth/application/auth_providers.dart';
import 'package:apuraqui/features/auth/domain/auth_session.dart';
import 'package:apuraqui/features/auth/domain/phone_verification.dart';
import 'package:apuraqui/features/auth/domain/session_repository.dart';
import 'package:apuraqui/features/auth/phone_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('normaliza telefone e permite reenviar codigo apos cooldown', (
    tester,
  ) async {
    final repository = _PhoneSessionRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [sessionRepositoryProvider.overrideWithValue(repository)],
        child: const MaterialApp(home: PhoneLoginScreen()),
      ),
    );

    await tester.enterText(find.byType(TextFormField).first, '85999999999');
    expect(
      tester
          .widget<TextFormField>(find.byType(TextFormField).first)
          .controller
          ?.text,
      '(85) 99999-9999',
    );

    await tester.tap(find.widgetWithText(ElevatedButton, 'Enviar código'));
    await tester.pump();

    expect(repository.requestedPhones, ['+5585999999999']);
    expect(
      find.text('Código enviado para +55 (85) 99999-9999'),
      findsOneWidget,
    );
    expect(find.text('Reenviar em 00:30'), findsOneWidget);

    await tester.pump(const Duration(seconds: 30));

    expect(find.text('Reenviar código'), findsOneWidget);
    await tester.tap(find.widgetWithText(TextButton, 'Reenviar código'));
    await tester.pump();

    expect(repository.requestedPhones, ['+5585999999999', '+5585999999999']);

    await tester.pumpWidget(const SizedBox());
  });
}

class _PhoneSessionRepository implements SessionRepository {
  final List<String> requestedPhones = [];

  @override
  Stream<AuthSession?> watchSession() => Stream<AuthSession?>.value(null);

  @override
  Future<AuthSession> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() async {}

  @override
  Future<PhoneVerification> requestPhoneVerification(String phoneNumber) async {
    requestedPhones.add(phoneNumber);
    return PhoneVerification(
      verificationId: 'verification-${requestedPhones.length}',
    );
  }

  @override
  Future<bool> signInWithDemoCredentials({
    required String login,
    required String password,
  }) async {
    return false;
  }
}
