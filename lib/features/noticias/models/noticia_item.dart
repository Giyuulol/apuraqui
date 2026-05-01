class NoticiaItem {
  const NoticiaItem({
    required this.id,
    required this.titulo,
    required this.resumo,
    required this.fonte,
    required this.categoria,
    required this.dataPublicacao,
    required this.confiavel,
  });

  final String id;
  final String titulo;
  final String resumo;
  final String fonte;
  final String categoria;
  final String dataPublicacao;
  final bool confiavel;
}
