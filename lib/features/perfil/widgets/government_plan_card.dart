import 'package:flutter/material.dart';

import '../../../core/widgets/app_card.dart';
import '../models/government_plan_item.dart';

class GovernmentPlanCard extends StatelessWidget {
  const GovernmentPlanCard({required this.item, super.key});

  final GovernmentPlanItem item;

  IconData _iconFromName(String name) {
    switch (name) {
      case 'school':
        return Icons.school_outlined;
      case 'payments':
        return Icons.payments_outlined;
      case 'local_hospital':
        return Icons.local_hospital_outlined;
      case 'security':
        return Icons.security_outlined;
      case 'park':
        return Icons.park_outlined;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconColor = Color(item.iconeCor);
    final iconBg = Color(item.iconeFundo);

    return AppCard(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(_iconFromName(item.icone), color: iconColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.titulo,
                    style: textTheme.headlineSmall?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              item.descricao,
              style: textTheme.bodyMedium?.copyWith(height: 1.5),
            ),
            const SizedBox(height: 14),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFF3F4F6))),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified_outlined,
                    size: 16,
                    color: Color(0xFF009B3A),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'PROPOSTA OFICIAL',
                    style: textTheme.labelSmall?.copyWith(
                      color: const Color(0xFF99A1AF),
                      letterSpacing: 0.6,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
