import 'package:flutter/material.dart';

import '../../core/navigation/app_routes.dart';
import '../../core/widgets/app_header.dart';
import 'data/candidates_mock.dart';
import 'models/candidate_profile.dart';
import 'widgets/candidate_selector_card.dart';
import 'widgets/government_plan_card.dart';

class CandidatosPage extends StatefulWidget {
  const CandidatosPage({this.onMenuPressed, this.onLogout, super.key});

  final VoidCallback? onMenuPressed;
  final VoidCallback? onLogout;

  @override
  State<CandidatosPage> createState() => _CandidatosPageState();
}

class _CandidatosPageState extends State<CandidatosPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final candidate = candidatesMock[_selectedIndex];

    return Scaffold(
      appBar: AppHeader(
        onMenuPressed: widget.onMenuPressed,
        onLogoutPressed: widget.onLogout,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 223, 0, 0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.group_rounded,
                    color: Color(0xFFB39E00),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Perfis dos Candidatos',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Conheça o histórico e as propostas de cada um',
                        style: textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF6A7282),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Text(
              'SELECIONE PARA VISUALIZAR',
              style: textTheme.labelLarge?.copyWith(
                color: const Color(0xFF99A1AF),
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CandidateSelectorCard(
                  candidate: candidatesMock[index],
                  selected: index == _selectedIndex,
                  onTap: () => setState(() => _selectedIndex = index),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: candidatesMock.length,
              ),
            ),
            const SizedBox(height: 16),
            _CandidateProfileCard(candidate: candidate),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AppRoutes.comparator),
              icon: const Icon(Icons.compare_arrows),
              label: const Text('Comparar propostas'),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Icon(Icons.library_books_outlined, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Plano de Governo',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            for (var i = 0; i < candidate.propostas.length; i++) ...[
              GovernmentPlanCard(item: candidate.propostas[i]),
              if (i != candidate.propostas.length - 1)
                const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }
}

class _CandidateProfileCard extends StatelessWidget {
  const _CandidateProfileCard({required this.candidate});

  final CandidateProfile candidate;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(229, 231, 235, 0.4),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(0, 155, 58, 0.20),
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -64),
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF009B3A), width: 4),
                color: Colors.white,
              ),
              child: CircleAvatar(
                radius: 56,
                backgroundColor: const Color(0xFFE5E7EB),
                child: ClipOval(
                  child: Image.asset(
                    candidate.foto,
                    width: 112,
                    height: 112,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Center(
                      child: Text(
                        candidate.nome.substring(0, 1),
                        style: textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Text(
                    candidate.nome,
                    style: textTheme.displaySmall?.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    candidate.cargo,
                    style: textTheme.titleLarge?.copyWith(
                      color: const Color(0xFF6A7282),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF3F4F6)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'NÚMERO',
                                style: textTheme.labelSmall?.copyWith(
                                  color: const Color(0xFF99A1AF),
                                  letterSpacing: 1.1,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                candidate.numero,
                                style: textTheme.displaySmall?.copyWith(
                                  color: const Color(0xFF009B3A),
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 40,
                          color: const Color(0xFFE5E7EB),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PARTIDO',
                                  style: textTheme.labelSmall?.copyWith(
                                    color: const Color(0xFF99A1AF),
                                    letterSpacing: 1.1,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  candidate.partido,
                                  style: textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(249, 250, 251, 0.8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF3F4F6)),
                    ),
                    child: Text(
                      candidate.sobre,
                      textAlign: TextAlign.center,
                      style: textTheme.titleSmall?.copyWith(height: 1.55),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
