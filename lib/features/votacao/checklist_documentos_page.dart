import 'package:flutter/material.dart';

import '../../core/widgets/app_card.dart';
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

  int get _totalMarcados => _documentosMarcados.length;

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
      appBar: AppBar(title: const Text('Checklist de Documentos')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: checklistDocumentosMock.length + 1,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          if (index == 0) {
            return AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Prepare-se para votar',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Marque os documentos que você já separou para o dia da votação.',
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '$_totalMarcados de ${checklistDocumentosMock.length} documentos marcados',
                    style: textTheme.labelLarge,
                  ),
                ],
              ),
            );
          }

          final documento = checklistDocumentosMock[index - 1];

          return ChecklistDocumentoTile(
            documento: documento,
            checked: _documentosMarcados.contains(documento.id),
            onChanged: (marcado) => _alternarDocumento(documento.id, marcado),
          );
        },
      ),
    );
  }
}
