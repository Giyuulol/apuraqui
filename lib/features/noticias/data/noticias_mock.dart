import '../models/fake_news_item.dart';
import '../models/news_item.dart';

const newsItemsMock = <NewsItem>[
  NewsItem(
    id: '1',
    source: 'Jornal Nacional de Credibilidade',
    timeAgo: 'Há 2 horas',
    title: 'Candidato A lidera intenções de voto no sudeste',
    actionLabel: 'Ler matéria',
  ),
  NewsItem(
    id: '2',
    source: 'Portal Brasil Notícias',
    timeAgo: 'Há 5 horas',
    title: 'Debate presidencial: confira os principais momentos',
    actionLabel: 'Ler matéria',
  ),
];

const fakeNewsItemsMock = <FakeNewsItem>[
  FakeNewsItem(
    id: '1',
    rumor: '"Urnas eletrônicas foram fraudadas na seção 42 de SP"',
    status: 'FALSO',
    truth:
        'O TRE-SP confirmou que não houve nenhuma irregularidade. A urna apresentou falha mecânica e foi substituída.',
  ),
  FakeNewsItem(
    id: '2',
    rumor: '"Candidato B vai confiscar poupanças se eleito"',
    status: 'FALSO',
    truth:
        'Não há propostas ou declarações oficiais do candidato neste sentido. Boato antigo requentado.',
  ),
];
