import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/widgets/app_header.dart';
import 'application/checklist_progress_providers.dart';
import 'data/checklist_documentos_mock.dart';
import 'widgets/checklist_documento_tile.dart';

class ChecklistDocumentosPage extends ConsumerWidget {
  const ChecklistDocumentosPage({this.onMenuPressed, this.onLogout, super.key});

  final VoidCallback? onMenuPressed;
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final documentosMarcados =
        ref.watch(checkedDocumentIdsProvider).value ?? {};

    return Scaffold(
      appBar: AppHeader(
        onMenuPressed: onMenuPressed,
        onLogoutPressed: onLogout,
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: checklistDocumentosMock.length + 2,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/selected_green.svg',
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Checklist do Eleitor',
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Prepare-se para o dia da eleição',
                              style: textTheme.bodyMedium?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

            if (index == 1) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFFEDD4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DecoratedBox(
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFEDD4),
                              shape: BoxShape.circle,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.warning_amber_rounded,
                                size: 20,
                                color: Color(0xFFF54900),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Atenção com o celular!',
                                  style: textTheme.titleSmall?.copyWith(
                                    color: const Color(0xFF9F2D00),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text.rich(
                                  TextSpan(
                                    text:
                                        'O uso de telefone celular, máquina fotográfica ou filmadora é ',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: const Color(0xFFCA3500),
                                      height: 1.45,
                                    ),
                                    children: const [
                                      TextSpan(
                                        text: 'rigorosamente proibido',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' dentro da cabine de votação. Deixe os equipamentos com o mesário antes de votar.',
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }

            final documento = checklistDocumentosMock[index - 2];

            return ChecklistDocumentoTile(
              documento: documento,
              checked: documentosMarcados.contains(documento.id),
              onChanged: (marcado) {
                ref
                    .read(checklistProgressRepositoryProvider)
                    .setChecked(documento.id, checked: marcado);
              },
            );
          },
        ),
      ),
    );
  }
}
