class SantinhoItem {
  const SantinhoItem({
    required this.id,
    required this.candidateId,
    required this.accentColorValue,
    required this.imageAsset,
  });

  final String id;
  final String candidateId;
  final int accentColorValue;

  // O santinho possui composição própria; os dados eleitorais vêm do perfil.
  final String imageAsset;
}
