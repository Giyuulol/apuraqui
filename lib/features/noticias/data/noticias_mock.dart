import '../models/noticia_item.dart';

const noticiasMock = <NoticiaItem>[
  NoticiaItem(
    id: 'n1',
    titulo: 'TSE divulga novas orientações para o dia da votação',
    resumo:
        'As orientações reforçam documentos aceitos, horários de votação e regras dentro da cabine.',
    fonte: 'Portal do TSE',
    categoria: 'Eleições',
    dataPublicacao: '01/05/2026',
    confiavel: true,
  ),
  NoticiaItem(
    id: 'n2',
    titulo: 'Boato sobre cancelamento de títulos volta a circular',
    resumo:
        'Mensagem em redes sociais afirma bloqueio em massa sem comprovação oficial.',
    fonte: 'Monitor de Boatos',
    categoria: 'Verificação',
    dataPublicacao: '30/04/2026',
    confiavel: false,
  ),
  NoticiaItem(
    id: 'n3',
    titulo: 'Justiça Eleitoral amplia campanha de combate à desinformação',
    resumo:
        'A ação inclui materiais educativos e canais oficiais para consulta rápida.',
    fonte: 'Agência Brasil',
    categoria: 'Cidadania',
    dataPublicacao: '29/04/2026',
    confiavel: true,
  ),
  NoticiaItem(id: 'n3',
   titulo: 'É falso que 811 mil chineses poderão votar nas eleições brasileiras', 
   resumo: 'Estrangeiros não podem participar da votação, a não ser que tenham se naturalizado; desde 2023, apenas 274 chineses adquiriram cidadania brasileira', 
   fonte: 'Estadão', 
   categoria: 'Imigração', 
   dataPublicacao: '16/04/2026', 
   confiavel: true,
   ),
];
