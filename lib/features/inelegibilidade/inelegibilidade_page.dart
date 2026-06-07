import 'package:flutter/material.dart';

import '../../core/design_system/components/app_card.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../../core/widgets/app_header.dart';
import '../../core/widgets/app_state_view.dart';
import 'data/inelegibilidade_mock.dart';

class InelegibilidadePage extends StatefulWidget {
  const InelegibilidadePage({
    required this.onMenuPressed,
    required this.onLogout,
    super.key,
  });

  final VoidCallback onMenuPressed;
  final VoidCallback onLogout;

  @override
  State<InelegibilidadePage> createState() => _InelegibilidadePageState();
}

class _InelegibilidadePageState extends State<InelegibilidadePage> {
  bool _showEmpty = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppHeader(
        onMenuPressed: widget.onMenuPressed,
        onLogoutPressed: widget.onLogout,
      ),
      body: SafeArea(
        child: _showEmpty
            ? AppStateView.empty(
                message: 'Nenhum caso encontrado para o filtro selecionado.',
              )
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          color: AppColors.errorAlternative,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.gavel_outlined,
                          color: AppColors.error,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Exceções e Inelegibilidade',
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Dados simulados para orientação do eleitor',
                              style: textTheme.bodyMedium?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Consulta demonstrativa',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Esta tela mostra como o app comunicaria exceções eleitorais sem depender de uma API real nesta fase.',
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        OutlinedButton.icon(
                          onPressed: () => setState(() => _showEmpty = true),
                          icon: const Icon(Icons.filter_alt_outlined),
                          label: const Text('Exibir estado vazio'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  for (final item in inelegibilidadeMock) ...[
                    _InelegibilidadeCard(item: item),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
      ),
    );
  }
}

class _InelegibilidadeCard extends StatelessWidget {
  const _InelegibilidadeCard({required this.item});

  final InelegibilidadeCase item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  item.title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              _StatusBadge(status: item.status),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.candidateName,
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(item.reason, style: textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    final isDenied = status == 'Indeferida';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isDenied
            ? AppColors.errorAlternative
            : AppColors.infoAlternative,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        status,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: isDenied ? AppColors.error : AppColors.info,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
