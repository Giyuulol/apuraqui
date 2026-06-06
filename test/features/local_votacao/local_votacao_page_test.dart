import 'package:apuraqui/features/local_votacao/local_votacao_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('a mensagem de fila permanece visível após 3 segundos', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      MaterialApp(
        home: LocalVotacaoPage(onMenuPressed: () {}, onLogout: () {}),
      ),
    );

    await tester.tap(find.text('Buscar Local'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Rápida').first);
    await tester.pump();

    expect(
      find.textContaining('Você informou que a fila está rápida'),
      findsOneWidget,
    );

    await tester.pump(const Duration(seconds: 3));
    await tester.pump();

    expect(
      find.textContaining('Você informou que a fila está rápida'),
      findsOneWidget,
    );
  });
}
