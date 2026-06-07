import 'package:flutter/material.dart';

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
    final accentColor = Color(candidate.cor);
    final borderColor = selected ? accentColor : const Color(0xFFF3F4F6);
    final bgColor = selected ? Colors.white : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: 120,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: borderColor, width: selected ? 2.2 : 1.5),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: accentColor.withAlpha(38),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 6,
                    offset: Offset(0, 1),
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar com anel colorido
            Container(
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? accentColor : const Color(0xFFF3F4F6),
              ),
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
            const SizedBox(height: 10),
            // Nome com quebra de linha (preserva 'Maria\nSilva' para o teste)
            Text(
              candidate.nome.replaceFirst(' ', '\n'),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(
                color: selected
                    ? const Color(0xFF101828)
                    : const Color(0xFF6A7282),
                fontWeight: FontWeight.w700,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            // Badge do número
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: selected
                    ? accentColor.withAlpha(32)
                    : const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                candidate.numero,
                style: textTheme.labelLarge?.copyWith(
                  color: selected ? accentColor : const Color(0xFF9CA3AF),
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
