class SantinhoItem {
  const SantinhoItem({
    required this.id,
    required this.candidateName,
    required this.officeLabel,
    required this.partyLabel,
    required this.number,
    required this.accentColorValue,
    required this.imageAsset,
  });

  final String id;
  final String candidateName;
  final String officeLabel;
  final String partyLabel;
  final String number;
  final int accentColorValue;

  // Campo explícito para você adicionar a imagem real do candidato depois.
  // Exemplo: "assets/images/candidates/maria_silva.png"
  final String imageAsset;
}
