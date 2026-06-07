import 'package:flutter/material.dart';

import '../../../core/design_system/tokens/app_colors.dart';

const dashboardMock = DashboardMock(
  lastUpdatedLabel: 'Atualizado há 2 min',
  disclaimer: 'Dados simulados para demonstração acadêmica',
  stats: [
    DashboardStat(
      value: '10.000',
      label: 'Total de Votos',
      colors: [Color(0xFF1DB954), Color(0xFFE3F5E1)],
    ),
    DashboardStat(
      value: '3',
      label: 'Candidatos',
      colors: [Color(0xFFFFC84D), Color(0xFFFFF2C2)],
    ),
    DashboardStat(
      value: '78.4%',
      label: 'Participação',
      colors: [Color(0xFF0B4B9A), Color(0xFFD8E4FF)],
    ),
    DashboardStat(
      value: '85.2%',
      label: 'Urnas aptas',
      colors: [Color(0xFF12A150), Color(0xFFCFF6DD)],
    ),
  ],
  results: [
    DashboardResult(
      initials: 'MS',
      name: 'Maria Silva',
      party: 'Partido Renovação (PR)',
      percent: 35.42,
      totalVotes: '3.542',
      color: AppColors.success,
      delta: '+ 247 votos',
    ),
    DashboardResult(
      initials: 'JS',
      name: 'João Santos',
      party: 'Partido do Povo (PP)',
      percent: 32.18,
      totalVotes: '3.218',
      color: AppColors.interactionOnLight,
      delta: '+ 195 votos',
    ),
    DashboardResult(
      initials: 'AO',
      name: 'Ana Oliveira',
      party: 'Partido Verde (PV)',
      percent: 28.75,
      totalVotes: '2.875',
      color: Color(0xFFF5B800),
      delta: '+ 168 votos',
    ),
  ],
  regions: [
    DashboardRegion(
      name: 'Zona Norte',
      electors: '19.000 eleitores',
      progress: 0.75,
      winner: 'Maria Silva',
      color: AppColors.success,
    ),
    DashboardRegion(
      name: 'Zona Sul',
      electors: '23.000 eleitores',
      progress: 0.85,
      winner: 'João Santos',
      color: AppColors.interactionOnLight,
    ),
    DashboardRegion(
      name: 'Zona Leste',
      electors: '18.000 eleitores',
      progress: 0.69,
      winner: 'Ana Oliveira',
      color: Color(0xFFF5B800),
    ),
  ],
  liveEvents: [
    DashboardLiveEvent('Maria Silva', '+247 votos', 'Zona Norte'),
    DashboardLiveEvent('João Santos', '+195 votos', 'Zona Sul'),
    DashboardLiveEvent('Ana Oliveira', '+168 votos', 'Zona Leste'),
    DashboardLiveEvent('Maria Silva', '+132 votos', 'Zona Centro'),
  ],
);

class DashboardMock {
  const DashboardMock({
    required this.lastUpdatedLabel,
    required this.disclaimer,
    required this.stats,
    required this.results,
    required this.regions,
    required this.liveEvents,
  });

  final String lastUpdatedLabel;
  final String disclaimer;
  final List<DashboardStat> stats;
  final List<DashboardResult> results;
  final List<DashboardRegion> regions;
  final List<DashboardLiveEvent> liveEvents;
}

class DashboardStat {
  const DashboardStat({
    required this.value,
    required this.label,
    required this.colors,
  });

  final String value;
  final String label;
  final List<Color> colors;
}

class DashboardResult {
  const DashboardResult({
    required this.initials,
    required this.name,
    required this.party,
    required this.percent,
    required this.totalVotes,
    required this.color,
    required this.delta,
  });

  final String initials;
  final String name;
  final String party;
  final double percent;
  final String totalVotes;
  final Color color;
  final String delta;
}

class DashboardRegion {
  const DashboardRegion({
    required this.name,
    required this.electors,
    required this.progress,
    required this.winner,
    required this.color,
  });

  final String name;
  final String electors;
  final double progress;
  final String winner;
  final Color color;
}

class DashboardLiveEvent {
  const DashboardLiveEvent(this.name, this.votes, this.region);

  final String name;
  final String votes;
  final String region;
}
