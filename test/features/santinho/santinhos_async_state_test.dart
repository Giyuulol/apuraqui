import 'package:apuraqui/features/santinho/application/saved_santinhos_providers.dart';
import 'package:apuraqui/features/santinho/santinhos_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'falha de persistencia mantem santinhos navegaveis e oferece retry',
    (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            savedSantinhoIdsProvider.overrideWith(
              (ref) =>
                  Stream<Set<String>>.error(StateError('sqlite unavailable')),
            ),
          ],
          child: const MaterialApp(home: SantinhosPage()),
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(
        find.textContaining('Não foi possível carregar seus santinhos salvos.'),
        findsOneWidget,
      );
      expect(find.text('Tentar novamente'), findsOneWidget);
      expect(find.text('Santinhos Digitais'), findsOneWidget);
    },
  );
}
