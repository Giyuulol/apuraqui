import 'package:flutter/material.dart';

import '../../core/design_system/components/app_card.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../../core/widgets/app_header.dart';

class LocalVotacaoPage extends StatefulWidget {
  const LocalVotacaoPage({
    required this.onMenuPressed,
    required this.onLogout,
    super.key,
  });

  final VoidCallback onMenuPressed;
  final VoidCallback onLogout;

  @override
  State<LocalVotacaoPage> createState() => _LocalVotacaoPageState();
}

class _LocalVotacaoPageState extends State<LocalVotacaoPage> {
  final _controller = TextEditingController();
  bool _hasResult = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.interactionOnLight.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.interactionOnLight,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Local de Votação',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Consulte sua seção e acompanhe o tamanho da fila',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8D8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Digite seu Título de Eleitor ou CPF para encontrar sua zona, seção e verificar a fila.',
                      style: textTheme.bodySmall,
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Documento',
                      hintText: 'Apenas números',
                      prefixIcon: Icon(Icons.badge_outlined),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => setState(() => _hasResult = true),
                      child: const Text('Buscar Local'),
                    ),
                  ),
                ],
              ),
            ),
            if (_hasResult) ...[
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'SITUAÇÃO REGULAR',
                          style: textTheme.labelLarge?.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Escola Estadual Professor Silva',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Rua das Flores, 123 • Centro\nSão Paulo - SP • 01234-567',
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _InfoTile(label: 'Zona', value: '123'),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _InfoTile(label: 'Seção', value: '456'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFCDD5DF), Color(0xFFE8ECF1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.my_location_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      'Monitor de Fila',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        minHeight: 8,
                        value: 0.35,
                        backgroundColor: const Color(0xFFF3E8FF),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFF5B800),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Você está no local? Ajude outros eleitores informando como está a fila.',
                      style: textTheme.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Expanded(
                          child: _QueueStatusCard(
                            label: 'Rápida',
                            subtitle: 'Até 15 min',
                            color: Color(0xFFE3F5E1),
                            textColor: Color(0xFF168821),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _QueueStatusCard(
                            label: 'Média',
                            subtitle: 'Até 30 min',
                            color: Color(0xFFFFF7D6),
                            textColor: Color(0xFFB7791F),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _QueueStatusCard(
                            label: 'Demorada',
                            subtitle: 'Mais de 40 min',
                            color: Color(0xFFFDE0DB),
                            textColor: Color(0xFFE52207),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE7E7E7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}

class _QueueStatusCard extends StatelessWidget {
  const _QueueStatusCard({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.textColor,
  });

  final String label;
  final String subtitle;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: textColor, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
