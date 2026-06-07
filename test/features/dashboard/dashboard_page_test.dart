import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/features/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('dashboard renderiza metricas e candidatos sem overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.lightTheme,
        home: DashboardPage(onMenuPressed: () {}, onLogout: () {}),
      ),
    );

    // Faixa de métricas
    expect(find.text('Total de Votos'), findsOneWidget);
    expect(find.text('Candidatos'), findsWidgets);
    expect(find.text('Participação'), findsOneWidget);
    expect(find.text('Urnas Apuradas'), findsOneWidget);

    // Aba Resultados com candidatos
    expect(find.text('Ana Silva'), findsOneWidget);
    expect(find.text('Carlos Mendes'), findsOneWidget);

    // Sem overflow ou exceções
    expect(tester.takeException(), isNull);
  });
}
