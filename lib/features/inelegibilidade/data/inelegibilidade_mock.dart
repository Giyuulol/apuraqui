const inelegibilidadeMock = <InelegibilidadeCase>[
  InelegibilidadeCase(
    title: 'Candidatura indeferida',
    candidateName: 'Roberto Lima',
    status: 'Indeferida',
    reason:
        'Registro negado por pendência documental no prazo de regularização.',
  ),
  InelegibilidadeCase(
    title: 'Conta eleitoral em análise',
    candidateName: 'Patrícia Gomes',
    status: 'Em análise',
    reason:
        'Prestação de contas aguarda conferência simulada da Justiça Eleitoral.',
  ),
  InelegibilidadeCase(
    title: 'Exceção deferida',
    candidateName: 'Marcos Vieira',
    status: 'Regularizada',
    reason:
        'Documentação complementar aceita, mantendo candidatura apta no demo.',
  ),
];

class InelegibilidadeCase {
  const InelegibilidadeCase({
    required this.title,
    required this.candidateName,
    required this.status,
    required this.reason,
  });

  final String title;
  final String candidateName;
  final String status;
  final String reason;
}
