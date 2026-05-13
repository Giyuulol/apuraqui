import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/candidate_profile.dart';

class CandidateSelectorCard extends StatelessWidget {
  const CandidateSelectorCard({
    required this.candidate,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final CandidateProfile candidate;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final borderColor = selected ? AppColors.success : const Color(0xFFF3F4F6);

    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: onTap,
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: borderColor, width: 1.9),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              blurRadius: 6,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? AppColors.success : const Color(0xFFF3F4F6),
              ),
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 28,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    candidate.foto,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Text(
                        candidate.nome.substring(0, 1),
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              candidate.nome.replaceFirst(' ', '\n'),
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(
                color: selected
                    ? const Color(0xFF101828)
                    : const Color(0xFF6A7282),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: selected
                    ? const Color.fromRGBO(0, 155, 58, 0.12)
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                candidate.numero,
                style: textTheme.labelLarge?.copyWith(
                  color: selected ? AppColors.success : const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
