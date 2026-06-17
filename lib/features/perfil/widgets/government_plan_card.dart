import 'package:flutter/material.dart';

import '../models/government_plan_item.dart';

class GovernmentPlanCard extends StatelessWidget {
  const GovernmentPlanCard({
    required this.item,
    this.candidateAccentColor,
    super.key,
  });

  final GovernmentPlanItem item;
  final Color? candidateAccentColor;

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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _iconFromName(item.icone),
                    color: iconColor,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.titulo,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              item.descricao,
              style: textTheme.bodyMedium?.copyWith(
                height: 1.55,
                color: const Color(0xFF4B5563),
              ),
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
                    size: 15,
                    color: Color(0xFF009B3A),
                  ),
                  const SizedBox(width: 5),
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
