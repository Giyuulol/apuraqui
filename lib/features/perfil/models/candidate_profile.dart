import 'government_plan_item.dart';

class CandidateProfile {
  const CandidateProfile({
    required this.id,
    required this.nome,
    required this.foto,
    required this.cargo,
    required this.numero,
    required this.partido,
    required this.sobre,
    required this.propostas,
    this.cor = 0xFF009B3A,
  });

  final String id;
  final String nome;
  final String foto;
  final String cargo;
  final String numero;
  final String partido;
  final String sobre;
  final List<GovernmentPlanItem> propostas;
  final int cor;
}
