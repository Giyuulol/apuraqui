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
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppHeader(
        onMenuPressed: onMenuPressed,
        onLogoutPressed: onLogout,
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Faixa Superior de Métricas com o Degradê Identidade do ApurAqui
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF12A150), // Verde
                      Color(0xFFFFD600), // Amarelo
                      Color(0xFF0B4B9A), // Azul
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        value: '10.000',
                        label: 'Total de Votos',
                        icon: Icons.how_to_vote_rounded,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _StatCard(
                        value: '4',
                        label: 'Candidatos',
                        icon: Icons.people_alt_rounded,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _StatCard(
                        value: '78.4%',
                        label: 'Participação',
                        icon: Icons.trending_up_rounded,
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: _StatCard(
                        value: '85.2%',
                        label: 'Urnas Apuradas',
                        icon: Icons.analytics_rounded,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Custom TabBar com Ícones do Design
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xFFE7E7E7)),
                  ),
                  child: TabBar(
                    isScrollable: false,
                    labelColor: AppColors.success,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: AppColors.success.withValues(alpha: 0.08),
                    ),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.check_box_outlined, size: 20),
                        text: 'Resultados',
                        iconMargin: EdgeInsets.only(bottom: 2),
                      ),
                      Tab(
                        icon: Icon(
                          Icons.insert_chart_outlined_rounded,
                          size: 20,
                        ),
                        text: 'Gráficos',
                        iconMargin: EdgeInsets.only(bottom: 2),
                      ),
                      Tab(
                        icon: Icon(Icons.map_outlined, size: 20),
                        text: 'Regiões',
                        iconMargin: EdgeInsets.only(bottom: 2),
                      ),
                      Tab(
                        icon: Icon(Icons.sensors_rounded, size: 20),
                        text: 'Ao Vivo',
                        iconMargin: EdgeInsets.only(bottom: 2),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Título Seção Interna
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Candidatos',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ),
              const SizedBox(height: 12),

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

// ─────────────────────────────────────────────────────────────────────────────
// Stat Card — Frosted Glass sobre o gradiente
// ─────────────────────────────────────────────────────────────────────────────
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15), // Frosted Glass
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab Resultados
// ─────────────────────────────────────────────────────────────────────────────
class _ResultadosTab extends StatelessWidget {
  const _ResultadosTab({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    const candidates = [
      _ResultItem(
        'AS',
        'Ana Silva',
        'Partido Progressista',
        30.71,
        '3.345.329',
        Color(0xFF1DB954),
        '+2.477',
        1,
      ),
      _ResultItem(
        'CM',
        'Carlos Mendes',
        'Movimento Democrático',
        28.06,
        '3.056.606',
        Color(0xFF0B4B9A),
        '+5.973',
        2,
      ),
      _ResultItem(
        'BC',
        'Beatriz Costa',
        'União Nacional',
        23.83,
        '2.595.683',
        Color(0xFFFFD600),
        '+2.249',
        3,
      ),
      _ResultItem(
        'DP',
        'Daniel Pereira',
        'Frente Popular',
        17.40,
        '1.895.891',
        Color(0xFFFF8A00),
        '+2.602',
        4,
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: candidates.length,
      separatorBuilder: (_, _) => const SizedBox(height: 14),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar + Badge de posição
              Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: item.color,
                    child: Text(
                      item.initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: item.position == 1
                            ? const Color(0xFFFFB800)
                            : const Color(0xFF94A3B8),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: Text(
                        '${item.position}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.party,
                      style: textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.trending_up_rounded,
                          size: 14,
                          color: Color(0xFF12A150),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.delta,
                          style: textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF12A150),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Text(
                '${item.percent.toStringAsFixed(2)}%',
                style: textTheme.titleLarge?.copyWith(
                  color: item.color,
                  fontWeight: FontWeight.w900,
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
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: AlwaysStoppedAnimation<Color>(item.color),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total de votos',
                style: textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF64748B),
                ),
              ),
              Text(
                item.totalVotes,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ],
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
    this.position,
  );

  final String initials;
  final String name;
  final String party;
  final double percent;
  final String totalVotes;
  final Color color;
  final String delta;
  final int position;
}

// ─────────────────────────────────────────────────────────────────────────────
// Tab Gráficos
// ─────────────────────────────────────────────────────────────────────────────
class _GraficosTab extends StatelessWidget {
  const _GraficosTab({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    const candidates = [
      _ResultItem('AS', 'Ana Silva', '', 30.71, '', Color(0xFF1DB954), '', 1),
      _ResultItem(
        'CM',
        'Carlos Mendes',
        '',
        28.06,
        '',
        Color(0xFF0B4B9A),
        '',
        2,
      ),
      _ResultItem(
        'BC',
        'Beatriz Costa',
        '',
        23.83,
        '',
        Color(0xFFFFD600),
        '',
        3,
      ),
      _ResultItem(
        'DP',
        'Daniel Pereira',
        '',
        17.40,
        '',
        Color(0xFFFF8A00),
        '',
        4,
      ),
    ];
    const maxPercent = 30.71;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Distribuição de Votos',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 220,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    for (final c in candidates)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              '${c.percent.toStringAsFixed(1)}%',
                              style: textTheme.labelSmall?.copyWith(
                                color: c.color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              width: 36,
                              height: 180 * (c.percent / maxPercent),
                              decoration: BoxDecoration(
                                color: c.color,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              c.initials,
                              style: textTheme.labelSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
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

// ─────────────────────────────────────────────────────────────────────────────
// Tab Regiões
// ─────────────────────────────────────────────────────────────────────────────
class _RegioesTab extends StatelessWidget {
  const _RegioesTab({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    const regions = [
      _RegionItem(
        'Sudeste',
        '36.5M eleitores',
        0.82,
        'Ana Silva',
        Color(0xFF1DB954),
      ),
      _RegionItem(
        'Nordeste',
        '28.1M eleitores',
        0.74,
        'Carlos Mendes',
        Color(0xFF0B4B9A),
      ),
      _RegionItem(
        'Sul',
        '15.2M eleitores',
        0.91,
        'Ana Silva',
        Color(0xFF1DB954),
      ),
      _RegionItem(
        'Centro-Oeste',
        '9.8M eleitores',
        0.67,
        'Beatriz Costa',
        Color(0xFFFFD600),
      ),
      _RegionItem(
        'Norte',
        '8.3M eleitores',
        0.55,
        'Daniel Pereira',
        Color(0xFFFF8A00),
      ),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: regions.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final r = regions[index];
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                r.name,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                r.electors,
                style: textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  minHeight: 6,
                  value: r.progress,
                  backgroundColor: const Color(0xFFE9EEF6),
                  valueColor: AlwaysStoppedAnimation<Color>(r.color),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: r.color.withValues(alpha: 0.12),
                    child: Text(
                      r.winner.substring(0, 2).toUpperCase(),
                      style: TextStyle(
                        color: r.color,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    r.winner,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${(r.progress * 100).round()}% apurado',
                    style: textTheme.labelLarge?.copyWith(color: r.color),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
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

// ─────────────────────────────────────────────────────────────────────────────
// Tab Ao Vivo
// ─────────────────────────────────────────────────────────────────────────────
class _AoVivoTab extends StatelessWidget {
  const _AoVivoTab({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    const events = [
      _LiveEvent('Ana Silva', '124.500 votos', 'Sudeste', '14:32'),
      _LiveEvent('Carlos Mendes', '98.200 votos', 'Nordeste', '14:28'),
      _LiveEvent('Ana Silva', '87.100 votos', 'Sul', '14:21'),
      _LiveEvent('Beatriz Costa', '72.400 votos', 'Centro-Oeste', '14:15'),
      _LiveEvent('Daniel Pereira', '61.300 votos', 'Norte', '14:09'),
    ];

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: events.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final e = events[index];
        return AppCard(
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
                      e.name,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${e.votes} • ${e.region}',
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.schedule_rounded,
                    size: 14,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    e.time,
                    style: textTheme.labelSmall?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LiveEvent {
  const _LiveEvent(this.name, this.votes, this.region, this.time);

  final String name;
  final String votes;
  final String region;
  final String time;
}
