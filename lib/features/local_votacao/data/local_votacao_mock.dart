const locaisVotacaoMock = <LocalVotacaoDemo>[
  LocalVotacaoDemo(
    documentKey: '12345678901',
    schoolName: 'Escola Estadual Professor Silva',
    address: 'Rua das Flores, 123 • Centro\nSão Paulo - SP • 01234-567',
    zone: '123',
    section: '456',
    queueStatus: QueueStatus.medium,
  ),
  LocalVotacaoDemo(
    documentKey: '98765432100',
    schoolName: 'Colégio Municipal Ana Néri',
    address: 'Av. Brasil, 900 • Jardim América\nSão Paulo - SP • 04567-000',
    zone: '248',
    section: '102',
    queueStatus: QueueStatus.fast,
  ),
  LocalVotacaoDemo(
    documentKey: '123456789012',
    schoolName: 'Liceu Paraibano',
    address: 'Av. Getúlio Vargas, s/n • Centro\nJoão Pessoa - PB • 58013-240',
    zone: '071',
    section: '090',
    queueStatus: QueueStatus.slow,
  ),
  LocalVotacaoDemo(
    documentKey: '11111111111',
    schoolName: 'Instituto de Educação da Paraíba (IEP)',
    address:
        'Av. Duarte da Silveira, s/n • Centro\nJoão Pessoa - PB • 58013-280',
    zone: '070',
    section: '045',
    queueStatus: QueueStatus.fast,
  ),
];

class LocalVotacaoDemo {
  const LocalVotacaoDemo({
    required this.documentKey,
    required this.schoolName,
    required this.address,
    required this.zone,
    required this.section,
    required this.queueStatus,
  });

  final String documentKey;
  final String schoolName;
  final String address;
  final String zone;
  final String section;
  final QueueStatus queueStatus;
}

enum QueueStatus {
  fast('rápida', 'Fila rápida informada pela comunidade', 'Até 15 min'),
  medium('média', 'Fila média informada pela comunidade', 'Até 30 min'),
  slow('demorada', 'Fila demorada informada pela comunidade', 'Mais de 40 min');

  const QueueStatus(this.label, this.description, this.estimate);

  final String label;
  final String description;
  final String estimate;
}
