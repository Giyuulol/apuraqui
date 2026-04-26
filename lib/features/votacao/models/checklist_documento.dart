class ChecklistDocumento {
  const ChecklistDocumento({
    required this.id,
    required this.titulo,
    required this.descricao,
    this.obrigatorio = false,
  });

  final String id;
  final String titulo;
  final String descricao;
  final bool obrigatorio;
}
