import 'package:flutter/material.dart';

import '../../core/design_system/components/app_card.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../perfil/data/candidates_mock.dart';
import '../perfil/models/candidate_profile.dart';

class ComparadorPropostasPage extends StatefulWidget {
  const ComparadorPropostasPage({super.key});

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
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: AppColors.infoAlternative,
                      child: Text(
                        candidato.iniciais,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.info,
                        ),
                      ),
                    ),
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
      appBar: AppBar(title: const Text('Comparador de Propostas')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Compare candidatos lado a lado',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 12),
                Text(
                  'Troque os candidatos e veja as propostas por categoria.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _CandidateSummaryCard(
                  candidate: _candidato1,
                  onTap: () => _abrirSeletorCandidato(slotIndex: 1),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _CandidateSummaryCard(
                  candidate: _candidato2,
                  onTap: () => _abrirSeletorCandidato(slotIndex: 2),
                ),
              ),
            ],
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
    );
  }
}

class _CandidateSummaryCard extends StatelessWidget {
  const _CandidateSummaryCard({required this.candidate, required this.onTap});

  final CandidateProfile candidate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.interactionOnLight.withValues(
                    alpha: 0.08,
                  ),
                  child: Text(
                    candidate.iniciais,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.interactionOnLight,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.swap_horiz,
                  color: AppColors.interactionOnLight,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              candidate.nome,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text('${candidate.numero} • ${candidate.partido}'),
          ],
        ),
      ),
    );
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

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          _ProposalBlock(candidate: firstCandidate, text: firstText),
          const SizedBox(height: 12),
          const Divider(height: 24),
          _ProposalBlock(candidate: secondCandidate, text: secondText),
        ],
      ),
    );
  }
}

class _ProposalBlock extends StatelessWidget {
  const _ProposalBlock({required this.candidate, required this.text});

  final CandidateProfile candidate;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          candidate.nome,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 6),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
      ],
    );
  }
}

extension on CandidateProfile {
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
