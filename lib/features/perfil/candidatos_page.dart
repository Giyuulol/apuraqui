import 'package:flutter/material.dart';

import '../../core/navigation/app_routes.dart';
import '../../core/widgets/app_header.dart';
import 'data/candidates_mock.dart';
import 'models/candidate_profile.dart';
import 'widgets/candidate_selector_card.dart';
import 'widgets/government_plan_card.dart';

class CandidatosPage extends StatefulWidget {
  const CandidatosPage({
    this.onMenuPressed,
    this.onLogout,
    this.onViewProposals,
    this.initialCandidateId,
    super.key,
  });

  final VoidCallback? onMenuPressed;
  final VoidCallback? onLogout;
  final void Function(String candidateId)? onViewProposals;

  /// ID do candidato a ser pré-selecionado ao abrir a tela.
  final String? initialCandidateId;

  @override
  State<CandidatosPage> createState() => _CandidatosPageState();
}

class _CandidatosPageState extends State<CandidatosPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    // Resolve o índice inicial pelo candidateId, se fornecido
    final initialId = widget.initialCandidateId;
    if (initialId != null) {
      final idx = candidatesMock.indexWhere((c) => c.id == initialId);
      if (idx != -1) _selectedIndex = idx;
    }
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _selectCandidate(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);
    _fadeController
      ..reset()
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final candidate = candidatesMock[_selectedIndex];
    final accentColor = Color(candidate.cor);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppHeader(
        onMenuPressed: widget.onMenuPressed,
        onLogoutPressed: widget.onLogout,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            // ─── Cabeçalho ───────────────────────────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 223, 0, 0.20),
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
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 3),
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
            const SizedBox(height: 24),

            // ─── Label do seletor ────────────────────────────────────
            Text(
              'SELECIONE PARA VISUALIZAR',
              style: textTheme.labelLarge?.copyWith(
                color: const Color(0xFF99A1AF),
                letterSpacing: 1.4,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            // ─── Seletor horizontal ──────────────────────────────────
            SizedBox(
              height: 190,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemCount: candidatesMock.length,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemBuilder: (context, index) => CandidateSelectorCard(
                  candidate: candidatesMock[index],
                  selected: index == _selectedIndex,
                  onTap: () => _selectCandidate(index),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ─── Card principal do candidato (com animação) ──────────
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _CandidateProfileCard(
                  candidate: candidate,
                  accentColor: accentColor,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // ─── Botão comparar ──────────────────────────────────────
            FadeTransition(
              opacity: _fadeAnimation,
              child: _ComparadorButton(
                onPressed: () {
                  final callback = widget.onViewProposals;
                  if (callback != null) {
                    callback(candidate.id);
                    return;
                  }
                  Navigator.of(context).pushNamed(AppRoutes.comparator);
                },
              ),
            ),

            const SizedBox(height: 28),

            // ─── Título do plano de governo ──────────────────────────
            FadeTransition(
              opacity: _fadeAnimation,
              child: Row(
                children: [
                  Icon(
                    Icons.library_books_outlined,
                    size: 24,
                    color: accentColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Plano de Governo',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ─── Cards de propostas ──────────────────────────────────
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    for (var i = 0; i < candidate.propostas.length; i++) ...[
                      GovernmentPlanCard(
                        item: candidate.propostas[i],
                        candidateAccentColor: accentColor,
                      ),
                      if (i != candidate.propostas.length - 1)
                        const SizedBox(height: 14),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card de perfil principal
// ─────────────────────────────────────────────────────────────────────────────
class _CandidateProfileCard extends StatelessWidget {
  const _CandidateProfileCard({
    required this.candidate,
    required this.accentColor,
  });

  final CandidateProfile candidate;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withAlpha(20),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          const BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Column(
          children: [
            // Faixa de cor no topo + foto transpassando
            Stack(
              alignment: Alignment.topCenter,
              children: [
                // Fundo colorido
                Column(
                  children: [
                    Container(
                      height: 110,
                      decoration: BoxDecoration(
                        color: accentColor.withAlpha(38),
                      ),
                    ),
                    const SizedBox(height: 64), // espaço da foto transpassada
                  ],
                ),

                // Foto circular transpassando o banner
                Positioned(
                  top: 52,
                  child: Container(
                    width: 118,
                    height: 118,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: accentColor, width: 3.5),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: accentColor.withAlpha(50),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        candidate.foto,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: accentColor.withAlpha(30),
                          child: Center(
                            child: Text(
                              candidate.nome.substring(0, 1),
                              style: textTheme.displaySmall?.copyWith(
                                fontWeight: FontWeight.w900,
                                color: accentColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // ─── Info abaixo do banner ───────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Column(
                children: [
                  // Nome e cargo
                  Text(
                    candidate.nome,
                    style: textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    candidate.cargo,
                    style: textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF6A7282),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Info box: número + partido
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: const Color(0xFFF3F4F6)),
                    ),
                    child: Row(
                      children: [
                        // Número
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'NÚMERO',
                                style: textTheme.labelSmall?.copyWith(
                                  color: const Color(0xFF99A1AF),
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                candidate.numero,
                                style: textTheme.displaySmall?.copyWith(
                                  color: accentColor,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 32,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 44,
                          color: const Color(0xFFE5E7EB),
                        ),
                        // Partido
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
                                    letterSpacing: 1.2,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  candidate.partido,
                                  style: textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Biografia
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(249, 250, 251, 0.9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFF3F4F6)),
                    ),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Sobre: ',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF101828),
                            ),
                          ),
                          TextSpan(
                            text: candidate.sobre,
                            style: textTheme.bodyMedium?.copyWith(
                              height: 1.6,
                              color: const Color(0xFF4B5563),
                            ),
                          ),
                        ],
                      ),
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

// ─────────────────────────────────────────────────────────────────────────────
// Botão comparar propostas
// ─────────────────────────────────────────────────────────────────────────────
class _ComparadorButton extends StatelessWidget {
  const _ComparadorButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF009B3A), Color(0xFF002776)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 39, 118, 0.26),
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: onPressed,
          icon: const Icon(Icons.compare_arrows_rounded, size: 20),
          label: const Text(
            'Comparar propostas',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
