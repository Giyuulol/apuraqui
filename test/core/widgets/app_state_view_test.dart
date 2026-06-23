import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/core/widgets/app_state_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('estado offline dispara tentativa de recarregar', (tester) async {
    var retries = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: AppStateView.offline(onRetry: () => retries++),
      ),
    );

    await tester.tap(find.text('Tentar novamente'));

    expect(retries, 1);
  });

  testWidgets('estado de carregamento anuncia uma mensagem neutra', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: const Scaffold(
          body: AppStateView.loading(message: 'Carregando sua sessão...'),
        ),
      ),
    );

    expect(find.text('Carregando'), findsOneWidget);
    expect(find.text('Carregando sua sessão...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('estado compacto de erro mantém retry disponível', (
    tester,
  ) async {
    var retries = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(
          body: AppStateView.serverErrorCompact(
            message: 'Não foi possível carregar seus dados.',
            onRetry: () => retries++,
          ),
        ),
      ),
    );

    await tester.tap(find.text('Tentar novamente'));

    expect(retries, 1);
  });
}
