import '../models/checklist_documento.dart';

const checklistDocumentosMock = <ChecklistDocumento>[
  ChecklistDocumento(
    id: 'documento-oficial-foto',
    titulo: 'Documento oficial com foto',
    descricao: 'RG, CNH, passaporte ou outro documento oficial válido.',
    obrigatorio: true,
  ),
  ChecklistDocumento(
    id: 'titulo-eleitor',
    titulo: 'Título de eleitor',
    descricao:
        'Ajuda na conferência dos dados, mas pode ser substituído pelo e-Título.',
  ),
  ChecklistDocumento(
    id: 'local-votacao',
    titulo: 'Comprovante do local de votação',
    descricao: 'Use para conferir zona, seção e endereço antes de sair.',
  ),
  ChecklistDocumento(
    id: 'e-titulo',
    titulo: 'Celular com e-Título instalado',
    descricao:
        'Verifique bateria e acesso ao aplicativo antes do dia da votação.',
  ),
];
