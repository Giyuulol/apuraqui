import 'package:flutter_test/flutter_test.dart';

import 'package:apuraqui/main.dart';

void main() {
  testWidgets('exibe a checklist de documentos', (WidgetTester tester) async {
    await tester.pumpWidget(const ApuraquiApp());

    await tester.tap(find.text('Checklist'));
    await tester.pumpAndSettle();

    expect(find.text('Checklist do Eleitor'), findsOneWidget);
    expect(find.text('Prepare-se para o dia da eleição'), findsOneWidget);
    expect(find.textContaining('Atenção com o celular!'), findsOneWidget);
    expect(find.text('Documento oficial com foto'), findsOneWidget);
  });

  testWidgets('marca um documento da checklist', (WidgetTester tester) async {
    await tester.pumpWidget(const ApuraquiApp());

    await tester.tap(find.text('Checklist'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Documento oficial com foto'));
    await tester.pump();

    expect(find.text('Documento oficial com foto'), findsOneWidget);
  });

  testWidgets('navega para central de noticias', (WidgetTester tester) async {
    await tester.pumpWidget(const ApuraquiApp());

    await tester.tap(find.text('Notícias'));
    await tester.pumpAndSettle();

    expect(find.text('Central de Notícias'), findsOneWidget);
    expect(find.text('Notícias e Verificação'), findsOneWidget);
    expect(find.text('Jornais com Credibilidade'), findsOneWidget);
    expect(find.text('Central Anti-Fake News'), findsOneWidget);
  });

  testWidgets('exibe a feature de perfil dos candidatos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ApuraquiApp());

    expect(find.text('Perfis dos Candidatos'), findsOneWidget);
    expect(find.text('Plano de Governo'), findsOneWidget);
    expect(find.text('Maria Silva'), findsAtLeastNWidgets(1));
  });
}
