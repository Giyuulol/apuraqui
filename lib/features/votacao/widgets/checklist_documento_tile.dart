import 'package:flutter/material.dart';
import '../models/checklist_documento.dart';

class ChecklistDocumentoTile extends StatelessWidget {
  const ChecklistDocumentoTile({
    required this.documento,
    required this.checked,
    required this.onChanged,
    this.isCandidato = false,
    super.key,
  });

  final ChecklistDocumento documento;
  final bool checked;
  final ValueChanged<bool> onChanged;
  final bool isCandidato;

  IconData _getIconData(String id) {
    switch (id) {
      case 'documento-oficial-foto':
        return Icons.credit_card_outlined;
      case 'e-titulo':
        return Icons.phone_android_outlined;
      case 'papel-cola':
        return Icons.description_outlined;
      case 'local-votacao':
        return Icons.location_on_outlined;
      case 'candidato-perfil':
        return Icons.badge_outlined;
      case 'candidato-material':
        return Icons.print_outlined;
      case 'candidato-equipe':
        return Icons.people_alt_outlined;
      case 'candidato-agenda':
        return Icons.calendar_today_outlined;
      case 'candidato-redes':
        return Icons.campaign_outlined;
      case 'candidato-doacoes':
        return Icons.description_outlined;
      default:
        return Icons.check_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final primaryColor = isCandidato
        ? const Color(0xFF002776)
        : const Color(0xFF009B3A);
    final lightBgColor = isCandidato
        ? const Color.fromRGBO(0, 39, 118, 0.05)
        : const Color.fromRGBO(0, 155, 58, 0.05);
    final borderColor = checked ? primaryColor : const Color(0xFFF3F4F6);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: checked ? lightBgColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: checked ? 2.0 : 1.5),
        boxShadow: checked
            ? [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ]
            : const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.02),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => onChanged(!checked),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Custom Checkbox
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: checked ? primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: checked ? primaryColor : const Color(0xFFD1D5DC),
                        width: 2.0,
                      ),
                    ),
                    child: checked
                        ? const Icon(Icons.check, color: Colors.white, size: 16)
                        : null,
                  ),
                ),
                const SizedBox(width: 14),

                // Icon Background
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: checked
                        ? primaryColor.withValues(alpha: 0.15)
                        : const Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconData(documento.id),
                    color: checked ? primaryColor : const Color(0xFF6B7280),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        documento.titulo,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: checked
                              ? const Color(0xFF111827).withValues(alpha: 0.8)
                              : const Color(0xFF111827),
                          decoration: checked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        documento.descricao,
                        style: textTheme.bodyMedium?.copyWith(
                          color: checked
                              ? colorScheme.onSurfaceVariant.withValues(
                                  alpha: 0.7,
                                )
                              : colorScheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
