import 'package:flutter/material.dart';

/// Modelo de dados para um Candidato
class Candidato {
  final String id;
  final String nome;
  final String partido;
  final String numero;
  final String fotoUrl;
  final Map<String, String> propostas; // Categoria -> Texto da Proposta

  Candidato({
    required this.id,
    required this.nome,
    required this.partido,
    required this.numero,
    required this.fotoUrl,
    required this.propostas,
  });
}

/// Tela Principal do Comparador de Propostas
class ComparadorPropostasScreen extends StatefulWidget {
  const ComparadorPropostasScreen({super.key});

  @override
  State<ComparadorPropostasScreen> createState() =>
      _ComparadorPropostasScreenState();
}

class _ComparadorPropostasScreenState extends State<ComparadorPropostasScreen> {
  // Dados simulados baseados nas imagens fornecidas
  final List<Candidato> _candidatos = [
    Candidato(
      id: '1',
      nome: 'Maria Silva',
      numero: '12',
      partido: 'Partido Renovação (PR)',
      fotoUrl: 'assets/images/maria.png',
      propostas: {
        'Educação':
            'Ampliação de escolas em tempo integral e valorização dos professores com piso salarial nacional atualizado anualmente.',
        'Economia':
            'Reforma tributária progressiva, cobrando mais de quem ganha mais e isentando itens essenciais da cesta básica.',
        'Saúde Pública':
            'Criação do programa "Médico na Escola" e ampliação das equipes de Saúde da Família nos bairros mais periféricos.',
        'Segurança':
            'Investimento massivo em inteligência artificial e câmeras corporais para todo o efetivo policial, focando em prevenção.',
        'Meio Ambiente':
            'Transição energética acelerada com subsídios para energia solar residencial e tolerância zero com o desmatamento ilegal.',
      },
    ),
    Candidato(
      id: '2',
      nome: 'Ana Oliveira',
      numero: '77',
      partido: 'Partido Verde (PV)',
      fotoUrl: 'assets/images/ana.png',
      propostas: {
        'Educação':
            'Inclusão digital com tablets e internet para todos os alunos da rede pública e currículo focado em programação e sustentabilidade.',
        'Economia':
            'Fomento à "Economia Verde" com fortes incentivos fiscais para startups, cooperativas e empresas de energia limpa.',
        'Saúde Pública':
            'Digitalização total do SUS com ampliação da telemedicina e criação de novos centros de apoio à saúde mental.',
        'Segurança':
            'Iluminação pública inteligente em 100% das vias e uso de análise de dados para prever e mapear manchas criminais.',
        'Meio Ambiente':
            'Reflorestamento em massa de áreas degradadas e transição gradual para frota de transporte público 100% elétrica.',
      },
    ),
    Candidato(
      id: '3',
      nome: 'João Santos',
      numero: '45',
      partido: 'Partido do Povo (PP)',
      fotoUrl: 'assets/images/joao.png',
      propostas: {
        'Educação':
            'Foco intensivo no ensino técnico e profissionalizante em parceria direta com indústrias locais para jovens aprendizes.',
        'Economia':
            'Redução drástica de impostos para pequenas e médias empresas como estímulo à geração rápida de novos empregos.',
        'Saúde Pública':
            'Parceria forte com a rede privada por meio de vouchers estatais para zerar a fila de exames e cirurgias do SUS.',
        'Segurança':
            'Aumento do policiamento ostensivo nas ruas e endurecimento severo das penas para crimes contra o patrimônio.',
        'Meio Ambiente':
            'Regularização fundiária rápida e flexibilização de licenças ambientais para impulsionar o agronegócio responsável.',
      },
    ),
  ];

  late Candidato _candidato1;
  late Candidato _candidato2;

  @override
  void initState() {
    super.initState();
    // Inicializa com Maria Silva e Ana Oliveira como padrão conforme a primeira imagem
    _candidato1 = _candidatos[0];
    _candidato2 = _candidatos[1];
  }

  /// Abre a aba inferior (Modal Bottom Sheet) para trocar um candidato
  void _abrirSeletorCandidato({required int slotIndex}) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.fromLTRB(
            20, // left
            16, // top
            20, // right
            24, // bottom
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho do Modal
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trocar Candidato $slotIndex',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Selecione quem você quer comparar',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              // Lista de Candidatos Disponíveis
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: _candidatos.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final candidato = _candidatos[index];
                    final isSelected = (slotIndex == 1)
                        ? _candidato1.id == candidato.id
                        : _candidato2.id == candidato.id;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          // Função auxiliar para encontrar o próximo candidato disponível
                          Candidato obterProximoCandidato(
                            Candidato candidatoAtual,
                          ) {
                            int indexAtual = _candidatos.indexWhere(
                              (c) => c.id == candidatoAtual.id,
                            );
                            // Pega o próximo index de forma circular (se for o último, volta para o 0)
                            int proximoIndex =
                                (indexAtual + 1) % _candidatos.length;
                            return _candidatos[proximoIndex];
                          }

                          if (slotIndex == 1) {
                            _candidato1 = candidato;
                            // REGRA: Se ficou igual ao candidato 2, joga o candidato 2 para o próximo da lista
                            if (_candidato1.id == _candidato2.id) {
                              _candidato2 = obterProximoCandidato(_candidato2);
                            }
                          } else {
                            _candidato2 = candidato;
                            // REGRA: Se ficou igual ao candidato 1, joga o candidato 1 para o próximo da lista
                            if (_candidato2.id == _candidato1.id) {
                              _candidato1 = obterProximoCandidato(_candidato1);
                            }
                          }
                        });
                        Navigator.pop(context); // Fecha o modal
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFF0FDF4)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF22C55E)
                                : Colors.grey.shade200,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.amber.shade100,
                              // No app real, use AssetImage ou NetworkImage
                              child: const Icon(
                                Icons.person,
                                color: Colors.amber,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    candidato.nome,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${candidato.numero} • ${candidato.partido}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFF22C55E),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Categorias de propostas para renderizar dinamicamente
    final categorias = [
      'Educação',
      'Economia',
      'Saúde Pública',
      'Segurança',
      'Meio Ambiente',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'ApurAqui',
          style: TextStyle(
            color: Color(0xFF047857),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.menu, color: Color(0xFF1E293B)),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              children: [
                CircleAvatar(radius: 4, backgroundColor: Colors.red),
                SizedBox(width: 4),
                Text(
                  'AO VIVO',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Comparar Propostas',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    'Toque nos candidatos para alterar',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Widget de Seleção/Exibição Superior (Candidato 1 VS Candidato 2)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  // Card Candidato 1
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _abrirSeletorCandidato(slotIndex: 1),
                      child: _buildCandidatoCard(
                        _candidato1,
                        const Color(0xFF22C55E),
                      ),
                    ),
                  ),

                  // Divisor VS
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        'vs',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Card Candidato 2
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _abrirSeletorCandidato(slotIndex: 2),
                      child: _buildCandidatoCard(
                        _candidato2,
                        const Color(0xFF1D4ED8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Lista Dinâmica de Propostas por Categoria
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                final categoria = categorias[index];
                return _buildCategoriaBlock(categoria);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidatoCard(Candidato candidato, Color bordaColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: bordaColor.withValues(alpha: 0.18), width: 1),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: bordaColor.withValues(alpha: 0.14),
            child: Text(
              candidato.nome.split(' ').first.substring(0, 1),
              style: TextStyle(
                color: bordaColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            candidato.nome,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xFF1E293B),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            '${candidato.numero} • ${candidato.partido}',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: bordaColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropostaCard(
    Candidato candidato,
    String proposta,
    Color backgroundColor,
    Color accentColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: accentColor.withValues(alpha: 0.14), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 12,
                backgroundColor: accentColor,
                child: const Icon(Icons.person, size: 14, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(
                '${candidato.nome.split(' ').first.toUpperCase()} DEFENDE:',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: accentColor.withValues(alpha: 0.92),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            proposta,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF334155),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriaBlock(String categoria) {
    final proposta1 =
        _candidato1.propostas[categoria] ?? 'Sem proposta cadastrada.';
    final proposta2 =
        _candidato2.propostas[categoria] ?? 'Sem proposta cadastrada.';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  _getIconForCategoria(categoria),
                  color: const Color(0xFF1D4ED8),
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  categoria,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildPropostaCard(
            _candidato1,
            proposta1,
            const Color(0xFFF0FDF4),
            const Color(0xFF22C55E),
          ),
          const SizedBox(height: 12),
          _buildPropostaCard(
            _candidato2,
            proposta2,
            const Color(0xFFEFF6FF),
            const Color(0xFF1D4ED8),
          ),
        ],
      ),
    );
  }

  IconData _getIconForCategoria(String categoria) {
    switch (categoria) {
      case 'Educação':
        return Icons.menu_book;
      case 'Economia':
        return Icons.attach_money;
      case 'Saúde Pública':
        return Icons.favorite_border;
      case 'Segurança':
        return Icons.shield_outlined;
      case 'Meio Ambiente':
        return Icons.eco_outlined;
      default:
        return Icons.star_border;
    }
  }
}
