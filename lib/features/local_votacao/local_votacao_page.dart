import 'package:flutter/material.dart';

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
  int _queueMinutes = 25;
  String _feedbackMessage = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateQueueStatus(String label, int minutes) {
    setState(() {
      _queueMinutes = minutes;
      _feedbackMessage =
          'Obrigado! Você informou que a fila está ${label.toLowerCase()}.';
    });
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 980;

            return ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.interactionOnLight.withValues(
                          alpha: 0.1,
                        ),
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
                const SizedBox(height: 18),
                if (isWide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _SearchCard(
                          controller: _controller,
                          onSearch: () => setState(() => _hasResult = true),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        flex: 2,
                        child: _hasResult
                            ? _ResultPanel(
                                queueMinutes: _queueMinutes,
                                feedbackMessage: _feedbackMessage,
                                onQueueSelected: _updateQueueStatus,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      _SearchCard(
                        controller: _controller,
                        onSearch: () => setState(() => _hasResult = true),
                      ),
                      const SizedBox(height: 18),
                      if (_hasResult)
                        _ResultPanel(
                          queueMinutes: _queueMinutes,
                          feedbackMessage: _feedbackMessage,
                          onQueueSelected: _updateQueueStatus,
                        ),
                    ],
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SearchCard extends StatelessWidget {
  const _SearchCard({required this.controller, required this.onSearch});

  final TextEditingController controller;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
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
          Text(
            'Onde eu voto?',
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Digite seu Título de Eleitor ou CPF para encontrar sua zona, seção e verificar a fila.',
            style: textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            maxLength: 12,
            decoration: InputDecoration(
              labelText: 'Documento',
              hintText: 'Apenas números',
              prefixIcon: const Icon(Icons.badge_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF009B3A),
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Color(0xFFE7E7E7)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton.icon(
              onPressed: onSearch,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF009B3A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.search_rounded),
              label: const Text('Buscar Local'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({
    required this.queueMinutes,
    required this.feedbackMessage,
    required this.onQueueSelected,
  });

  final int queueMinutes;
  final String feedbackMessage;
  final void Function(String label, int minutes) onQueueSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successAlternative,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  children: const [
                    Icon(
                      Icons.check_circle,
                      size: 14,
                      color: AppColors.success,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Situação Regular',
                      style: TextStyle(
                        color: AppColors.success,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Escola Estadual Professor Silva',
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 6),
          Text(
            'Rua das Flores, 123 • Centro\nSão Paulo - SP • 01234-567',
            style: textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: const [
              Expanded(
                child: _InfoTile(label: 'Zona', value: '123'),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _InfoTile(label: 'Seção', value: '456'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1524661135-423995f22d0b?w=800&auto=format&fit=crop&q=60',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(
                      colors: [Color(0x00000000), Color(0xAA000000)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: FilledButton.icon(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white.withValues(alpha: 0.18),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      icon: const Icon(Icons.navigation_rounded),
                      label: const Text('Traçar rota'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _QueueMonitorCard(
            queueMinutes: queueMinutes,
            feedbackMessage: feedbackMessage,
            onQueueSelected: onQueueSelected,
          ),
        ],
      ),
    );
  }
}

class _QueueMonitorCard extends StatelessWidget {
  const _QueueMonitorCard({
    required this.queueMinutes,
    required this.feedbackMessage,
    required this.onQueueSelected,
  });

  final int queueMinutes;
  final String feedbackMessage;
  final void Function(String label, int minutes) onQueueSelected;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8EE),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF4E1BE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFDE68A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.timer_outlined,
                  color: Color(0xFFB45309),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monitor de Fila',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Tempo estimado na sua seção',
                      style: textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7D6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '~ $queueMinutes min',
                  style: const TextStyle(
                    color: Color(0xFFB7791F),
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: (queueMinutes / 60).clamp(0.0, 1.0),
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFFF5B800),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Você está no local? Ajude outros eleitores indicando como está a fila no momento.',
            style: textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          if (feedbackMessage.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F5E1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                feedbackMessage,
                style: const TextStyle(
                  color: Color(0xFF168821),
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          Row(
            children: [
              Expanded(
                child: _QueueOptionButton(
                  label: 'Rápida',
                  subtitle: '10 min',
                  color: const Color(0xFFE3F5E1),
                  textColor: const Color(0xFF168821),
                  onPressed: () => onQueueSelected('Rápida', 10),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QueueOptionButton(
                  label: 'Média',
                  subtitle: '20 min',
                  color: const Color(0xFFFFF7D6),
                  textColor: const Color(0xFFB7791F),
                  onPressed: () => onQueueSelected('Média', 20),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QueueOptionButton(
                  label: 'Demorada',
                  subtitle: '30 min',
                  color: const Color(0xFFFDE0DB),
                  textColor: const Color(0xFFE52207),
                  onPressed: () => onQueueSelected('Demorada', 30),
                ),
              ),
            ],
          ),
        ],
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

class _QueueOptionButton extends StatelessWidget {
  const _QueueOptionButton({
    required this.label,
    required this.subtitle,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  final String label;
  final String subtitle;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
      ),
    );
  }
}
