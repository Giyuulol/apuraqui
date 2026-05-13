import '../models/checklist_documento.dart';

const checklistDocumentosMock = <ChecklistDocumento>[
  ChecklistDocumento(
    id: 'documento-oficial-foto',
    titulo: 'Documento oficial com foto',
    descricao: 'RG, CNH, Passaporte, Carteira de Trabalho ou Certificado de Reservista.',
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
    descricao: 'Anotar os números é essencial. O celular fica retido com o mesário!',
  ),
  ChecklistDocumento(
    id: 'local-votacao',
    titulo: 'Local de votação confirmado',
    descricao:
        'Verifique sua Zona e Seção para evitar imprevistos de última hora.',
  ),
];
