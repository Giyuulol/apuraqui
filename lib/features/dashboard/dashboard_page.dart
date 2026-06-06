import 'package:flutter/material.dart';

import '../../core/design_system/components/app_card.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../../core/widgets/app_header.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    required this.onMenuPressed,
    required this.onLogout,
    super.key,
  });

  final VoidCallback onMenuPressed;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppHeader(
        onMenuPressed: onMenuPressed,
        onLogoutPressed: onLogout,
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                child: Row(
                  children: const [
                    Expanded(
                      child: _StatCard(
                        value: '10.000',
                        label: 'Total de Votos',
                        background: LinearGradient(
                          colors: [Color(0xFF1DB954), Color(0xFFE3F5E1)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _StatCard(
                        value: '4',
                        label: 'Candidatos',
                        background: LinearGradient(
                          colors: [Color(0xFFFFE45C), Color(0xFFFFF7CC)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _StatCard(
                        value: '78.4%',
                        label: 'Participação',
                        background: LinearGradient(
                          colors: [Color(0xFFFFC84D), Color(0xFFFFF2C2)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _StatCard(
                        value: '85.2%',
                        label: 'Urnas Aptas',
                        background: LinearGradient(
                          colors: [Color(0xFF3761A8), Color(0xFFD8E4FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE7E7E7)),
                  ),
                  child: const TabBar(
                    tabs: [
                      Tab(text: 'Resultados'),
                      Tab(text: 'Gráficos'),
                      Tab(text: 'Regiões'),
                      Tab(text: 'Ao Vivo'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Expanded(
                child: TabBarView(
                  children: [
                    _ResultadosTab(textTheme: textTheme),
                    _GraficosTab(textTheme: textTheme),
                    _RegioesTab(textTheme: textTheme),
                    _AoVivoTab(textTheme: textTheme),
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.background,
  });

  final String value;
  final String label;
  final Gradient background;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.bar_chart_rounded, size: 18, color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ResultadosTab extends StatelessWidget {
  const _ResultadosTab({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final candidates = [
      _ResultItem(
        'AS',
        'Ana Silva',
        'Partido Progressista',
        30.71,
        '3.345.329',
        AppColors.success,
        '+ 2.477',
      ),
      _ResultItem(
        'CM',
        'Carlos Mendes',
        'Movimento Democrático',
        28.06,
        '3.056.606',
        AppColors.interactionOnLight,
        '+ 5.973',
      ),
      _ResultItem(
        'BC',
        'Beatriz Costa',
        'União Nacional',
        23.83,
        '2.595.683',
        const Color(0xFFF5B800),
        '+ 2.249',
      ),
      _ResultItem(
        'DP',
        'Daniel Pereira',
        'Frente Popular',
        17.40,
        '1.895.891',
        const Color(0xFFFF8A00),
        '+ 2.602',
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: candidates.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) =>
          _ResultCard(item: candidates[index], textTheme: textTheme),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.item, required this.textTheme});

  final _ResultItem item;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: item.color.withValues(alpha: 0.12),
                child: Text(
                  item.initials,
                  style: TextStyle(
                    color: item.color,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      item.party,
                      style: textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${item.percent.toStringAsFixed(2)}%',
                style: textTheme.titleMedium?.copyWith(
                  color: item.color,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: item.percent / 100,
              backgroundColor: const Color(0xFFE9EEF6),
              valueColor: AlwaysStoppedAnimation<Color>(item.color),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total de votos', style: textTheme.bodySmall),
              Text(
                item.totalVotes,
                style: textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            item.delta,
            style: textTheme.bodySmall?.copyWith(
              color: AppColors.success,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _GraficosTab extends StatelessWidget {
  const _GraficosTab({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final bars = [
      _BarItem('Ana', 0.84, AppColors.success),
      _BarItem('Carlos', 0.76, AppColors.interactionOnLight),
      _BarItem('Beatriz', 0.63, const Color(0xFFF5B800)),
      _BarItem('Daniel', 0.47, const Color(0xFFFF8A00)),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Distribuição',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 260,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final bar in bars) ...[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 48,
                              height: 200 * bar.value,
                              decoration: BoxDecoration(
                                color: bar.color,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(bar.label, style: textTheme.labelSmall),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RegioesTab extends StatelessWidget {
  const _RegioesTab({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final regions = [
      _RegionItem(
        'Região Norte',
        '19.000 eleitores',
        0.75,
        'Ana Silva',
        AppColors.success,
      ),
      _RegionItem(
        'Região Sul',
        '23.000 eleitores',
        0.85,
        'Carlos Mendes',
        AppColors.interactionOnLight,
      ),
      _RegionItem(
        'Região Centro Oeste',
        '18.000 eleitores',
        0.85,
        'Ana Silva',
        AppColors.success,
      ),
      _RegionItem(
        'Região Nordeste',
        '16.000 eleitores',
        0.79,
        'Carlos Mendes',
        AppColors.interactionOnLight,
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: regions.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) => AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              regions[index].name,
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              regions[index].electors,
              style: textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                minHeight: 6,
                value: regions[index].progress,
                backgroundColor: const Color(0xFFE9EEF6),
                valueColor: AlwaysStoppedAnimation<Color>(regions[index].color),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: regions[index].color.withValues(alpha: 0.12),
                  child: Text(
                    regions[index].winner.substring(0, 2).toUpperCase(),
                    style: TextStyle(
                      color: regions[index].color,
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  regions[index].winner,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(regions[index].progress * 100).round()}%',
                  style: textTheme.labelLarge?.copyWith(
                    color: regions[index].color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AoVivoTab extends StatelessWidget {
  const _AoVivoTab({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final events = [
      _LiveEvent('Carlos Mendes', '+1.697 votos', 'Região Norte'),
      _LiveEvent('Ana Silva', '+1.322 votos', 'Região Nordeste'),
      _LiveEvent('Daniel Pereira', '+2.602 votos', 'Região Sul'),
      _LiveEvent('Beatriz Costa', '+5.768 votos', 'Região Nordeste'),
      _LiveEvent('Ana Silva', '+5.189 votos', 'Região Centro Oeste'),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: events.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) => AppCard(
        child: Row(
          children: [
            Container(
              width: 10,
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.success,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    events[index].name,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${events[index].votes} • ${events[index].region}',
                    style: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const Icon(Icons.schedule_rounded, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _ResultItem {
  const _ResultItem(
    this.initials,
    this.name,
    this.party,
    this.percent,
    this.totalVotes,
    this.color,
    this.delta,
  );

  final String initials;
  final String name;
  final String party;
  final double percent;
  final String totalVotes;
  final Color color;
  final String delta;
}

class _BarItem {
  const _BarItem(this.label, this.value, this.color);

  final String label;
  final double value;
  final Color color;
}

class _RegionItem {
  const _RegionItem(
    this.name,
    this.electors,
    this.progress,
    this.winner,
    this.color,
  );

  final String name;
  final String electors;
  final double progress;
  final String winner;
  final Color color;
}

class _LiveEvent {
  const _LiveEvent(this.name, this.votes, this.region);

  final String name;
  final String votes;
  final String region;
}
