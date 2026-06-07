import 'package:flutter/material.dart';

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
    const checkedGreen = Color(0xFF009B3A);
    final borderColor = checked ? checkedGreen : const Color(0xFFE0E0E0);
    final tileBackground = checked
        ? const Color.fromRGBO(0, 155, 58, 0.05)
        : Colors.white;
    final boxShadow = checked
        ? const [
            BoxShadow(
              color: Color.fromRGBO(0, 155, 58, 0.10),
              blurRadius: 15,
              offset: Offset(0, 0),
            ),
          ]
        : const <BoxShadow>[];

    return DecoratedBox(
      decoration: BoxDecoration(
        color: tileBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: checked ? 1.9 : 1),
        boxShadow: boxShadow,
      ),
      child: Material(
        color: Colors.transparent,
        child: Theme(
          data: Theme.of(context).copyWith(
            checkboxTheme: CheckboxThemeData(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return checkedGreen;
                }

                return Colors.white;
              }),
              checkColor: const WidgetStatePropertyAll(Colors.white),
              side: const BorderSide(color: Color(0xFFD1D5DC), width: 1.9),
            ),
          ),
          child: CheckboxListTile(
            value: checked,
            onChanged: (value) => onChanged(value ?? false),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            controlAffinity: ListTileControlAffinity.leading,
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    documento.titulo,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      decoration: checked
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
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
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
