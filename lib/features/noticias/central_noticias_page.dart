import 'package:flutter/material.dart';

import '../../core/widgets/app_info_alert.dart';
import 'data/noticias_mock.dart';
import 'widgets/noticia_card.dart';

class CentralNoticiasPage extends StatelessWidget {
  const CentralNoticiasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.newspaper),
        titleSpacing: 4,
        title: const Text('Central de Notícias'),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: noticiasMock.length + 2,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Text(
                'Acompanhe notícias e verificações sobre o processo eleitoral em fontes oficiais.',
                style: textTheme.bodyLarge,
              );
            }

            if (index == 1) {
              return const AppInfoAlert(
                message:
                    'Verifique sempre a fonte da informação antes de compartilhar conteúdo sobre eleições.',
                boldText: 'fonte',
              );
            }

            return NoticiaCard(noticia: noticiasMock[index - 2]);
          },
        ),
      ),
    );
  }
}
