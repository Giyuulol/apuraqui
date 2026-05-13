import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/widgets/app_header.dart';
import 'data/checklist_documentos_mock.dart';
import 'widgets/checklist_documento_tile.dart';

class ChecklistDocumentosPage extends StatefulWidget {
  const ChecklistDocumentosPage({super.key});

  @override
  State<ChecklistDocumentosPage> createState() =>
      _ChecklistDocumentosPageState();
}

class _ChecklistDocumentosPageState extends State<ChecklistDocumentosPage> {
  final Set<String> _documentosMarcados = {};

  void _alternarDocumento(String documentoId, bool marcado) {
    setState(() {
      if (marcado) {
        _documentosMarcados.add(documentoId);
      } else {
        _documentosMarcados.remove(documentoId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const AppHeader(),
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
              checked: _documentosMarcados.contains(documento.id),
              onChanged: (marcado) => _alternarDocumento(documento.id, marcado),
            );
          },
        ),
      ),
    );
  }
}
