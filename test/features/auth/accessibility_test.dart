import 'package:apuraqui/core/preferences/app_preferences_providers.dart';
import 'package:apuraqui/core/preferences/app_preferences_repository.dart';
import 'package:apuraqui/features/auth/application/auth_providers.dart';
import 'package:apuraqui/features/auth/create_account_screen.dart';
import 'package:apuraqui/features/auth/domain/auth_exception.dart';
import 'package:apuraqui/features/auth/domain/auth_session.dart';
import 'package:apuraqui/features/auth/domain/phone_verification.dart';
import 'package:apuraqui/features/auth/domain/session_repository.dart';
import 'package:apuraqui/features/auth/login_screen.dart';
import 'package:apuraqui/features/auth/phone_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UX-001 acessibilidade', () {
    testWidgets(
      'toggles de senha do cadastro expõem rótulo acessível de mostrar/ocultar',
      (tester) async {
        await tester.pumpWidget(const MaterialApp(home: CreateAccountScreen()));

        // Senha e confirmação começam ocultas: dois controles "Mostrar senha".
        expect(find.byTooltip('Mostrar senha'), findsNWidgets(2));

        await tester.tap(find.byTooltip('Mostrar senha').first);
        await tester.pumpAndSettle();

        expect(find.byTooltip('Ocultar senha'), findsOneWidget);
        expect(find.byTooltip('Mostrar senha'), findsOneWidget);
      },
    );

    testWidgets('fluxo de telefone permanece utilizável com texto ampliado', (
      tester,
    ) async {
      final repository = _StubPhoneSessionRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [sessionRepositoryProvider.overrideWithValue(repository)],
          child: MaterialApp(
            home: const PhoneLoginScreen(),
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: const TextScaler.linear(2),
                ),
                child: child!,
              );
            },
          ),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Enviar código'), findsOneWidget);
    });

    testWidgets('login permanece utilizável com texto ampliado', (
      tester,
    ) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appPreferencesRepositoryProvider.overrideWithValue(
              _StubPreferencesRepository(),
            ),
          ],
          child: MaterialApp(
            home: const LoginScreen(),
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  textScaler: const TextScaler.linear(2),
                ),
                child: child!,
              );
            },
          ),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull);
      expect(find.text('Acessar Sistema'), findsOneWidget);
    });

    testWidgets('erro ao enviar código é anunciado em região viva', (
      tester,
    ) async {
      final repository = _FailingPhoneSessionRepository();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [sessionRepositoryProvider.overrideWithValue(repository)],
          child: const MaterialApp(home: PhoneLoginScreen()),
        ),
      );

      await tester.enterText(find.byType(TextFormField).first, '85999999999');
      await tester.tap(find.widgetWithText(ElevatedButton, 'Enviar código'));
      // pump() em vez de pumpAndSettle(): o indicador de envio anima em loop.
      await tester.pump();
      await tester.pump();

      const message = 'Número de telefone inválido.';
      expect(find.text(message), findsOneWidget);

      final errorSemantics = tester.widget<Semantics>(
        find
            .ancestor(of: find.text(message), matching: find.byType(Semantics))
            .first,
      );
      expect(errorSemantics.properties.liveRegion, isTrue);
    });
  });
}

class _StubPhoneSessionRepository implements SessionRepository {
  @override
  Stream<AuthSession?> watchSession() => Stream<AuthSession?>.value(null);

  @override
  Future<AuthSession> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) => throw UnimplementedError();

  @override
  Future<void> logout() async {}

  @override
  Future<PhoneVerification> requestPhoneVerification(String phoneNumber) async {
    return const PhoneVerification(verificationId: 'stub');
  }

  @override
  Future<bool> signInWithDemoCredentials({
    required String login,
    required String password,
  }) async => false;
}

class _FailingPhoneSessionRepository implements SessionRepository {
  @override
  Stream<AuthSession?> watchSession() => Stream<AuthSession?>.value(null);

  @override
  Future<AuthSession> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) => throw UnimplementedError();

  @override
  Future<void> logout() async {}

  @override
  Future<PhoneVerification> requestPhoneVerification(String phoneNumber) async {
    throw const AuthException(
      AuthExceptionCode.invalidPhoneNumber,
      'Número de telefone inválido.',
    );
  }

  @override
  Future<bool> signInWithDemoCredentials({
    required String login,
    required String password,
  }) async => false;
}

class _StubPreferencesRepository implements AppPreferencesRepository {
  @override
  Future<String?> getRememberedLogin() async => null;

  @override
  Stream<String?> watchRememberedLogin() => Stream<String?>.value(null);

  @override
  Future<void> saveRememberedLogin(String login) async {}

  @override
  Future<void> clearRememberedLogin() async {}

  @override
  Stream<int> watchNavigationIndex() => Stream<int>.value(0);

  @override
  Future<void> saveNavigationIndex(int index) async {}
}
