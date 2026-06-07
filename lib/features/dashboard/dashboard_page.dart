import 'package:flutter/material.dart';

import '../../core/design_system/components/app_card.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../../core/widgets/app_header.dart';
import 'data/dashboard_mock.dart';

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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: _DemoStatusHeader(textTheme: textTheme),
              ),
              SizedBox(
                height: 176,
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dashboardMock.stats.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 2.9,
                  ),
                  itemBuilder: (context, index) =>
                      _StatCard(stat: dashboardMock.stats[index]),
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

class _DemoStatusHeader extends StatelessWidget {
  const _DemoStatusHeader({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: AppColors.info, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dashboardMock.disclaimer,
                  style: textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  dashboardMock.lastUpdatedLabel,
                  style: textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat});

  final DashboardStat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: stat.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.bar_chart_rounded, size: 18, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stat.value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  stat.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.92),
                  ),
                ),
              ],
            ),
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
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: dashboardMock.results.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) =>
          _ResultCard(item: dashboardMock.results[index], textTheme: textTheme),
    );
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({required this.item, required this.textTheme});

  final DashboardResult item;
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
    final maxPercent = dashboardMock.results
        .map((result) => result.percent)
        .reduce((a, b) => a > b ? a : b);

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
                    for (final result in dashboardMock.results)
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 48,
                              height: 200 * (result.percent / maxPercent),
                              decoration: BoxDecoration(
                                color: result.color,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              result.name.split(' ').first,
                              style: textTheme.labelSmall,
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

class _RegioesTab extends StatelessWidget {
  const _RegioesTab({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: dashboardMock.regions.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final region = dashboardMock.regions[index];
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                region.name,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                region.electors,
                style: textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(
                  minHeight: 6,
                  value: region.progress,
                  backgroundColor: const Color(0xFFE9EEF6),
                  valueColor: AlwaysStoppedAnimation<Color>(region.color),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: region.color.withValues(alpha: 0.12),
                    child: Text(
                      region.winner.substring(0, 2).toUpperCase(),
                      style: TextStyle(
                        color: region.color,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    region.winner,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${(region.progress * 100).round()}%',
                    style: textTheme.labelLarge?.copyWith(color: region.color),
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

class _AoVivoTab extends StatelessWidget {
  const _AoVivoTab({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemCount: dashboardMock.liveEvents.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final event = dashboardMock.liveEvents[index];
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
                      event.name,
                      style: textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${event.votes} • ${event.region}',
                      style: textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.schedule_rounded, size: 16, color: Colors.grey),
            ],
          ),
        );
      },
    );
  }
}
