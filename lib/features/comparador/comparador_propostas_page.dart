import 'package:flutter/material.dart';

import '../../core/design_system/tokens/app_colors.dart';
import '../../core/widgets/app_header.dart';
import '../perfil/data/candidates_mock.dart';
import '../perfil/models/candidate_profile.dart';
import '../perfil/models/government_plan_item.dart';
import '../santinho/data/santinhos_mock.dart';

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
  String _categoria = 'Educação';

  @override
  void initState() {
    super.initState();
    _candidato1 = _candidatos[0];
    _candidato2 = _candidatos[1];
  }

  void _abrirSeletorCandidato({required int slotIndex}) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          shrinkWrap: true,
          itemCount: _candidatos.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final candidato = _candidatos[index];
            final selecionado = slotIndex == 1
                ? _candidato1.id == candidato.id
                : _candidato2.id == candidato.id;

            return InkWell(
              onTap: () {
                setState(() {
                  if (slotIndex == 1) {
                    _candidato1 = candidato;
                    if (_candidato1.id == _candidato2.id) {
                      _candidato2 =
                          _candidatos[(index + 1) % _candidatos.length];
                    }
                  } else {
                    _candidato2 = candidato;
                    if (_candidato2.id == _candidato1.id) {
                      _candidato1 =
                          _candidatos[(index + 1) % _candidatos.length];
                    }
                  }
                });
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(18),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: selecionado
                      ? AppColors.successAlternative
                      : Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: selecionado
                        ? AppColors.success
                        : const Color(0xFFE7E7E7),
                  ),
                ),
                child: Row(
                  children: [
                    _CandidateAvatar(candidate: candidato, radius: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            candidato.nome,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text('${candidato.numero} • ${candidato.partido}'),
                        ],
                      ),
                    ),
                    if (selecionado)
                      const Icon(Icons.check_circle, color: AppColors.success),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final categories = _candidato1.propostas
        .map((item) => item.titulo)
        .toList();

    return Scaffold(
      appBar: AppHeader(
        onMenuPressed: widget.onMenuPressed,
        onLogoutPressed: widget.onLogout,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.warningAlternative,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.balance_outlined,
                    color: Color(0xFFB39E00),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Comparar Propostas',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Toque nos cards para trocar os candidatos e compare as principais propostas por tema.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE7E7E7)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _CandidateSummaryCard(
                      candidate: _candidato1,
                      onTap: () => _abrirSeletorCandidato(slotIndex: 1),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFFFFDF00), Color(0xFFFFC107)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'VS',
                        style: TextStyle(
                          color: Color(0xFF002776),
                          fontWeight: FontWeight.w900,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _CandidateSummaryCard(
                      candidate: _candidato2,
                      onTap: () => _abrirSeletorCandidato(slotIndex: 2),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Categorias',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final categoria in categories)
                  ChoiceChip(
                    label: Text(categoria),
                    selected: _categoria == categoria,
                    onSelected: (_) => setState(() => _categoria = categoria),
                    selectedColor: AppColors.successAlternative,
                    labelStyle: TextStyle(
                      color: _categoria == categoria
                          ? AppColors.success
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    side: BorderSide(
                      color: _categoria == categoria
                          ? AppColors.success
                          : const Color(0xFFE7E7E7),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            _ProposalComparisonCard(
              title: _categoria,
              firstCandidate: _candidato1,
              secondCandidate: _candidato2,
            ),
          ],
        ),
      ),
    );
  }
}

class _CandidateSummaryCard extends StatelessWidget {
  const _CandidateSummaryCard({required this.candidate, required this.onTap});

  final CandidateProfile candidate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final accentColor = _candidateAccentColor(candidate);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFE7E7E7)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                color: accentColor,
              ),
            ),
            const SizedBox(height: 10),
            _CandidateAvatar(
              candidate: candidate,
              radius: 28,
              backgroundColor: accentColor.withValues(alpha: 0.12),
              fallbackTextColor: accentColor,
            ),
            const SizedBox(height: 10),
            Text(
              candidate.nome,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              '${candidate.numero} • ${candidate.partido.split(' ').first}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              candidate.cargo,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: accentColor,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CandidateAvatar extends StatelessWidget {
  const _CandidateAvatar({
    required this.candidate,
    required this.radius,
    this.backgroundColor,
    this.fallbackTextColor,
  });

  final CandidateProfile candidate;
  final double radius;
  final Color? backgroundColor;
  final Color? fallbackTextColor;

  @override
  Widget build(BuildContext context) {
    final imageAsset = _imageAssetForCandidate(candidate);

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? AppColors.infoAlternative,
      child: ClipOval(
        child: Image.asset(
          imageAsset,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Text(
              candidate.iniciais,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: fallbackTextColor ?? AppColors.info,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _imageAssetForCandidate(CandidateProfile candidate) {
  for (final item in santinhosMock) {
    if (item.candidateId == candidate.id) {
      return item.imageAsset;
    }
  }

  return candidate.foto;
}

Color _candidateAccentColor(CandidateProfile candidate) {
  switch (candidate.id) {
    case 'maria':
      return const Color(0xFF009B3A);
    case 'joao':
      return const Color(0xFF002776);
    default:
      return const Color(0xFFEAB308);
  }
}

class _ProposalComparisonCard extends StatelessWidget {
  const _ProposalComparisonCard({
    required this.title,
    required this.firstCandidate,
    required this.secondCandidate,
  });

  final String title;
  final CandidateProfile firstCandidate;
  final CandidateProfile secondCandidate;

  @override
  Widget build(BuildContext context) {
    final firstText =
        firstCandidate.propostaPorTitulo(title)?.descricao ??
        'Sem proposta cadastrada para esta categoria.';
    final secondText =
        secondCandidate.propostaPorTitulo(title)?.descricao ??
        'Sem proposta cadastrada para esta categoria.';

    final categoryIcon = _categoryIcon(title, firstCandidate);
    final categoryColor = _categoryColor(title, firstCandidate);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE7E7E7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(categoryIcon, color: categoryColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Confira como cada candidato enxerga esse tema.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 14),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 860;
              return isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _ProposalBlock(
                            candidate: firstCandidate,
                            text: firstText,
                            accentColor: _candidateAccentColor(firstCandidate),
                            categoryTitle: title,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _ProposalBlock(
                            candidate: secondCandidate,
                            text: secondText,
                            accentColor: _candidateAccentColor(secondCandidate),
                            categoryTitle: title,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _ProposalBlock(
                          candidate: firstCandidate,
                          text: firstText,
                          accentColor: _candidateAccentColor(firstCandidate),
                          categoryTitle: title,
                        ),
                        const SizedBox(height: 12),
                        _ProposalBlock(
                          candidate: secondCandidate,
                          text: secondText,
                          accentColor: _candidateAccentColor(secondCandidate),
                          categoryTitle: title,
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }
}

class _ProposalBlock extends StatelessWidget {
  const _ProposalBlock({
    required this.candidate,
    required this.text,
    required this.accentColor,
    required this.categoryTitle,
  });

  final CandidateProfile candidate;
  final String text;
  final Color accentColor;
  final String categoryTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accentColor.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _CandidateAvatar(
                candidate: candidate,
                radius: 16,
                backgroundColor: accentColor.withValues(alpha: 0.12),
                fallbackTextColor: accentColor,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  candidate.nome,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}

IconData _categoryIcon(String title, CandidateProfile candidate) {
  return _iconFromName(
    candidate.propostaItemPorTitulo(title)?.icone ?? 'category',
  );
}

Color _categoryColor(String title, CandidateProfile candidate) {
  final colorValue = candidate.propostaItemPorTitulo(title)?.iconeCor;
  return colorValue != null ? Color(colorValue) : AppColors.success;
}

IconData _iconFromName(String name) {
  switch (name.toLowerCase()) {
    case 'school':
      return Icons.school_rounded;
    case 'payments':
      return Icons.payments_rounded;
    case 'local_hospital':
      return Icons.local_hospital_rounded;
    case 'security':
      return Icons.security_rounded;
    case 'park':
      return Icons.park_rounded;
    default:
      return Icons.category_rounded;
  }
}

extension on CandidateProfile {
  GovernmentPlanItem? propostaItemPorTitulo(String titulo) {
    for (final proposta in propostas) {
      if (proposta.titulo == titulo) {
        return proposta;
      }
    }
    return null;
  }

  String get iniciais {
    final partes = nome.trim().split(RegExp(r'\s+'));
    if (partes.isEmpty) return '?';
    if (partes.length == 1) {
      return partes.first.substring(0, 1).toUpperCase();
    }
    return '${partes.first.substring(0, 1)}${partes.last.substring(0, 1)}'
        .toUpperCase();
  }

  ({String descricao})? propostaPorTitulo(String titulo) {
    for (final proposta in propostas) {
      if (proposta.titulo == titulo) {
        return (descricao: proposta.descricao);
      }
    }
    return null;
  }
}
