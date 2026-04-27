import 'package:flutter_test/flutter_test.dart';

import 'package:apuraqui/main.dart';

void main() {
  testWidgets('exibe a checklist de documentos', (WidgetTester tester) async {
    await tester.pumpWidget(const ApuraquiApp());

    expect(find.text('Checklist de Votação'), findsOneWidget);
    expect(find.text('Checklist de documentos'), findsOneWidget);
    expect(
      find.textContaining('O uso de telefone celular é proibido'),
      findsOneWidget,
    );
    expect(find.text('Documento oficial com foto'), findsOneWidget);
  });

  testWidgets('marca um documento da checklist', (WidgetTester tester) async {
    await tester.pumpWidget(const ApuraquiApp());

    await tester.tap(find.text('Documento oficial com foto'));
    await tester.pump();

    expect(find.text('1 de 4 documentos marcados'), findsOneWidget);
  });
}
