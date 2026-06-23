import 'package:apuraqui/features/auth/application/auth_providers.dart';
import 'package:apuraqui/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('falha de sessao nao expoe detalhes tecnicos e oferece retry', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sessionProvider.overrideWith(
            (ref) => Stream.error(StateError('database file path interno')),
          ),
        ],
        child: const MaterialApp(home: AuthGate()),
      ),
    );
    await tester.pump();

    expect(find.text('Algo deu errado'), findsOneWidget);
    expect(find.text('Tentar novamente'), findsOneWidget);
    expect(find.textContaining('database file path interno'), findsNothing);
  });
}
