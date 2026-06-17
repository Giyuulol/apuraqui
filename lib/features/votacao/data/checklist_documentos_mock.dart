import '../models/checklist_documento.dart';

const checklistDocumentosMock = <ChecklistDocumento>[
  ChecklistDocumento(
    id: 'documento-oficial-foto',
    titulo: 'Documento oficial com foto',
    descricao:
        'RG, CNH, Passaporte, Carteira de Trabalho ou Certificado de Reservista.',
    obrigatorio: true,
  ),
  ChecklistDocumento(
    id: 'e-titulo',
    titulo: 'e-Título ou Título Físico',
    descricao:
        'Se o seu e-Título tiver foto, ele já serve como documento oficial.',
  ),
  ChecklistDocumento(
    id: 'papel-cola',
    titulo: 'Colinha em papel preenchida',
    descricao:
        'Anotar os números é essencial. O celular fica retido com o mesário!',
  ),
  ChecklistDocumento(
    id: 'local-votacao',
    titulo: 'Local de votação confirmado',
    descricao:
        'Verifique sua Zona e Seção para evitar imprevistos de última hora.',
  ),
];

const candidateChecklistMock = <ChecklistDocumento>[
  ChecklistDocumento(
    id: 'candidato-perfil',
    titulo: 'Perfil completo cadastrado',
    descricao:
        'Foto, biografia, propostas e experiência profissional atualizadas no sistema.',
  ),
  ChecklistDocumento(
    id: 'candidato-material',
    titulo: 'Material de campanha aprovado',
    descricao:
        'Santinhos, banners e materiais gráficos validados pela Justiça Eleitoral.',
  ),
  ChecklistDocumento(
    id: 'candidato-equipe',
    titulo: 'Equipe de campanha organizada',
    descricao:
        'Coordenadores, cabos eleitorais e voluntários com tarefas definidas.',
  ),
  ChecklistDocumento(
    id: 'candidato-agenda',
    titulo: 'Agenda de eventos confirmada',
    descricao: 'Comícios, debates, lives e visitas agendadas e divulgadas.',
  ),
  ChecklistDocumento(
    id: 'candidato-redes',
    titulo: 'Redes sociais ativas',
    descricao:
        'Perfis criados e com conteúdo regular sobre propostas e campanha.',
  ),
  ChecklistDocumento(
    id: 'candidato-doacoes',
    titulo: 'Registro de doações regularizado',
    descricao: 'Todas as doações registradas e prestação de contas em dia.',
  ),
];
