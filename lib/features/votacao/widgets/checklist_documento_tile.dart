import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../models/checklist_documento.dart';

class ChecklistDocumentoTile extends StatelessWidget {
  const ChecklistDocumentoTile({
    required this.documento,
    required this.checked,
    required this.onChanged,
    super.key,
  });

  final ChecklistDocumento documento;
  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return AppCard(
      padding: EdgeInsets.zero,
      child: CheckboxListTile(
        value: checked,
        onChanged: (value) => onChanged(value ?? false),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        controlAffinity: ListTileControlAffinity.leading,
        title: Row(
          children: [
            Expanded(
              child: Text(
                documento.titulo,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (documento.obrigatorio)
              Semantics(
                label: 'Documento obrigatório',
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Text(
                      'Obrigatório',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            documento.descricao,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}
