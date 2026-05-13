class GovernmentPlanItem {
  const GovernmentPlanItem({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.icone,
    required this.iconeCor,
    required this.iconeFundo,
  });

  final String id;
  final String titulo;
  final String descricao;
  final String icone;
  final int iconeCor;
  final int iconeFundo;
}
