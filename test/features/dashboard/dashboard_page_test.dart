import 'package:apuraqui/core/design_system/theme/app_theme.dart';
import 'package:apuraqui/features/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('dashboard renderiza apuracao simulada sem overflow', (
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

    expect(
      find.text('Dados simulados para demonstração acadêmica'),
      findsOneWidget,
    );
    expect(find.text('Atualizado há 2 min'), findsOneWidget);
    expect(find.text('Maria Silva'), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
