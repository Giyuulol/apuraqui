import 'package:flutter/material.dart';

import '../../core/widgets/app_header.dart';
import '../perfil/data/candidates_mock.dart';
import '../perfil/models/candidate_profile.dart';

// ─── Dados de tópicos idênticos ao mock de candidatos ───────────────────────
class _Topic {
  const _Topic({
    required this.id,
    required this.title,
    required this.icon,
  });
  final String id;
  final String title;
  final IconData icon;
}

const _topics = <_Topic>[
  _Topic(id: 'educacao', title: 'Educação', icon: Icons.school_outlined),
  _Topic(
    id: 'economia',
    title: 'Economia',
    icon: Icons.payments_outlined,
  ),
  _Topic(
    id: 'saude',
    title: 'Saúde Pública',
    icon: Icons.local_hospital_outlined,
  ),
  _Topic(id: 'seguranca', title: 'Segurança', icon: Icons.security_outlined),
  _Topic(
    id: 'ambiente',
    title: 'Meio Ambiente',
    icon: Icons.park_outlined,
  ),
];

// ─────────────────────────────────────────────────────────────────────────────
class ComparadorPropostasPage extends StatefulWidget {
  const ComparadorPropostasPage({this.onMenuPressed, this.onLogout, super.key});

  final VoidCallback? onMenuPressed;
  final VoidCallback? onLogout;

  @override
  State<ComparadorPropostasPage> createState() =>
      _ComparadorPropostasPageState();
}

class _ComparadorPropostasPageState extends State<ComparadorPropostasPage> {
  final List<CandidateProfile> _candidatos = candidatesMock;

  late CandidateProfile _candidato1;
  late CandidateProfile _candidato2;

  @override
  void initState() {
    super.initState();
    _candidato1 = _candidatos[0];
    _candidato2 = _candidatos[1];
  }

  // Cor de identidade de cada candidato
  Color _colorOf(CandidateProfile c) => Color(c.cor);

  void _abrirSeletorCandidato({required int slotIndex}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _CandidateSelectorSheet(
        candidatos: _candidatos,
        slotIndex: slotIndex,
        candidato1: _candidato1,
        candidato2: _candidato2,
        colorOf: _colorOf,
        onSelect: (candidato) {
          setState(() {
            if (slotIndex == 1) {
              _candidato1 = candidato;
            } else {
              _candidato2 = candidato;
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final c1Color = _colorOf(_candidato1);
    final c2Color = _colorOf(_candidato2);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppHeader(
        onMenuPressed: widget.onMenuPressed,
        onLogoutPressed: widget.onLogout,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // ─── Cabeçalho ─────────────────────────────────────────
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 39, 118, 0.10),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.scale_outlined,
                    color: Color(0xFF002776),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        // Preservado para o teste: find.text('Compare candidatos lado a lado')
                        'Compare candidatos lado a lado',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Toque nos candidatos para alterar',
                        style: textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF6B7280),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ─── Seletor de candidatos (VS) ─────────────────────────
            Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _SelectorCard(
                        candidate: _candidato1,
                        color: c1Color,
                        chevronRight: true,
                        onTap: () => _abrirSeletorCandidato(slotIndex: 1),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _SelectorCard(
                        candidate: _candidato2,
                        color: c2Color,
                        chevronRight: false,
                        onTap: () => _abrirSeletorCandidato(slotIndex: 2),
                      ),
                    ),
                  ],
                ),
                // Badge VS
                Positioned(
                  top: 20,
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFDF00), Color(0xFFF5B800)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFF8F9FB),
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF5B800).withAlpha(90),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'VS',
                      style: TextStyle(
                        color: Color(0xFF002776),
                        fontWeight: FontWeight.w900,
                        fontSize: 13,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // ─── Lista completa de tópicos ──────────────────────────
            for (final topic in _topics) ...[
              _TopicComparisonCard(
                topic: topic,
                c1: _candidato1,
                c2: _candidato2,
                c1Color: c1Color,
                c2Color: c2Color,
              ),
              const SizedBox(height: 16),
            ],
          ], // children do Column
          ), // Column
        ), // SingleChildScrollView
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card seletor de candidato (topo da página)
// ─────────────────────────────────────────────────────────────────────────────
class _SelectorCard extends StatelessWidget {
  const _SelectorCard({
    required this.candidate,
    required this.color,
    required this.onTap,
    required this.chevronRight,
  });

  final CandidateProfile candidate;
  final Color color;
  final VoidCallback onTap;
  final bool chevronRight;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF3F4F6), width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Faixa colorida no topo
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(height: 4, color: color),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 14),
                child: Column(
                  children: [
                    // Avatar + badge chevron
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 62,
                          height: 62,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: color, width: 2.2),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              candidate.foto,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                    Icons.person_outline,
                                    color: color,
                                    size: 28,
                                  ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: -4,
                          right: chevronRight ? -4 : null,
                          left: chevronRight ? null : -4,
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 16,
                              color: Color(0xFF9CA3AF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      candidate.nome,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${candidate.numero} • ${candidate.partido.split(' ').first}',
                        style: textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF4B5563),
                          fontWeight: FontWeight.w700,
                          fontSize: 10.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card de comparação de um tópico (mostra propostas dos dois candidatos)
// ─────────────────────────────────────────────────────────────────────────────
class _TopicComparisonCard extends StatelessWidget {
  const _TopicComparisonCard({
    required this.topic,
    required this.c1,
    required this.c2,
    required this.c1Color,
    required this.c2Color,
  });

  final _Topic topic;
  final CandidateProfile c1;
  final CandidateProfile c2;
  final Color c1Color;
  final Color c2Color;

  String _proposta(CandidateProfile c, String topicId) {
    for (final p in c.propostas) {
      if (p.id == topicId) return p.descricao;
    }
    // fallback por título normalizado
    final norm = topicId.toLowerCase().replaceAll('-', '').replaceAll(' ', '');
    for (final p in c.propostas) {
      final t = p.titulo.toLowerCase().replaceAll(' ', '');
      if (t.contains(norm) || norm.contains(t)) return p.descricao;
    }
    return 'Proposta não cadastrada para este tema.';
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final p1 = _proposta(c1, topic.id);
    final p2 = _proposta(c2, topic.id);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Cabeçalho do tópico ──
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFF9FAFB), Colors.white],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6))),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFF3F4F6).withAlpha(128),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(topic.icon, color: const Color(0xFF4B5563), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    topic.title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF111827),
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),

            // ── Proposta candidato 1 ──
            _ProposalPanel(
              candidate: c1,
              color: c1Color,
              text: p1,
              hasDivider: true,
            ),

            // ── Proposta candidato 2 (fundo levemente cinza) ──
            _ProposalPanel(
              candidate: c2,
              color: c2Color,
              text: p2,
              isSecondary: true,
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Painel de uma proposta dentro do card de tópico
// ─────────────────────────────────────────────────────────────────────────────
class _ProposalPanel extends StatelessWidget {
  const _ProposalPanel({
    required this.candidate,
    required this.color,
    required this.text,
    this.hasDivider = false,
    this.isSecondary = false,
  });

  final CandidateProfile candidate;
  final Color color;
  final String text;
  final bool hasDivider;
  final bool isSecondary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final firstName = candidate.nome.split(' ').first;

    return Container(
      decoration: BoxDecoration(
        color: isSecondary
            ? const Color.fromRGBO(249, 250, 251, 0.3)
            : Colors.white,
        border: hasDivider
            ? const Border(bottom: BorderSide(color: Color(0xFFF3F4F6)))
            : null,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Barra lateral colorida
            Container(
              width: 4,
              color: color.withAlpha(153), // ~60% opacity
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mini avatar + label "X defende:"
                    Row(
                      children: [
                        SizedBox(
                          width: 26,
                          height: 26,
                          child: ClipOval(
                            child: Image.asset(
                              candidate.foto,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  CircleAvatar(
                                    radius: 13,
                                    backgroundColor: color.withAlpha(30),
                                    child: Icon(
                                      Icons.person,
                                      size: 14,
                                      color: color,
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '$firstName defende:',
                          style: textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      text,
                      style: textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF374151),
                        fontWeight: FontWeight.w500,
                        height: 1.55,
                      ),
                    ),
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
// Bottom Sheet de seleção de candidato
// ─────────────────────────────────────────────────────────────────────────────
class _CandidateSelectorSheet extends StatelessWidget {
  const _CandidateSelectorSheet({
    required this.candidatos,
    required this.slotIndex,
    required this.candidato1,
    required this.candidato2,
    required this.colorOf,
    required this.onSelect,
  });

  final List<CandidateProfile> candidatos;
  final int slotIndex;
  final CandidateProfile candidato1;
  final CandidateProfile candidato2;
  final Color Function(CandidateProfile) colorOf;
  final void Function(CandidateProfile) onSelect;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Cabeçalho do sheet
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 12, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Trocar Candidato $slotIndex',
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Selecione quem você quer comparar',
                          style: textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Botão X circular
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Color(0xFF6B7280),
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 20, color: Color(0xFFF3F4F6)),
            // Lista de candidatos
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                itemCount: candidatos.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final candidato = candidatos[index];
                  final cColor = colorOf(candidato);

                  final isOnOtherSlot = slotIndex == 1
                      ? candidato2.id == candidato.id
                      : candidato1.id == candidato.id;

                  final isCurrentSlot = slotIndex == 1
                      ? candidato1.id == candidato.id
                      : candidato2.id == candidato.id;

                  return Opacity(
                    opacity: isOnOtherSlot ? 0.45 : 1.0,
                    child: GestureDetector(
                      onTap: isOnOtherSlot
                          ? null
                          : () {
                              onSelect(candidato);
                              Navigator.of(context).pop();
                            },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: isCurrentSlot
                              ? const Color(0xFFE8F5E9)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isCurrentSlot
                                ? const Color(0xFF009B3A)
                                : const Color(0xFFE5E7EB),
                            width: isCurrentSlot ? 2.2 : 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Avatar com borda colorida
                            Container(
                              width: 52,
                              height: 52,
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: cColor, width: 2),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  candidato.foto,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.person_outline,
                                        color: cColor,
                                      ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          candidato.nome,
                                          style: textTheme.titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w800,
                                                color: const Color(0xFF111827),
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      if (isCurrentSlot)
                                        const Icon(
                                          Icons.check_circle_rounded,
                                          color: Color(0xFF009B3A),
                                          size: 20,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        candidato.numero,
                                        style: TextStyle(
                                          color: cColor,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const Text(
                                        '  •  ',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Expanded(
                                        child: Text(
                                          candidato.partido,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodySmall?.copyWith(
                                            color: const Color(0xFF6B7280),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


