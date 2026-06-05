import 'package:flutter/material.dart';

const Color _azul = Color(0xFF1A2A5E);
const Color _verde = Color(0xFF2E7D5E);

// ═══════════════════════════════════════════
//  MODELO DE DADOS — candidato inelegível
// ═══════════════════════════════════════════
class CandidatoInelegivel {
  final String nome;
  final String cargo;
  final String sigla;       // iniciais para o avatar
  final Color corAvatar;
  final String motivo;
  final String lei;
  final String dataDecisao;
  final bool fichaSuja;

  const CandidatoInelegivel({
    required this.nome,
    required this.cargo,
    required this.sigla,
    required this.corAvatar,
    required this.motivo,
    required this.lei,
    required this.dataDecisao,
    required this.fichaSuja,
  });
}

// Dados fictícios — substituir por API futuramente
final List<CandidatoInelegivel> _candidatos = [
  CandidatoInelegivel(
    nome: 'Roberto Alves',
    cargo: 'Deputado Federal',
    sigla: 'RA',
    corAvatar: const Color(0xFF1A2A5E),
    motivo: 'Condenação por improbidade administrativa',
    lei: 'Lei Complementar nº 135/2010 (Ficha Limpa)',
    dataDecisao: '12/03/2024',
    fichaSuja: true,
  ),
  CandidatoInelegivel(
    nome: 'Maria Fernanda',
    cargo: 'Vereadora',
    sigla: 'MF',
    corAvatar: const Color(0xFF6A1B9A),
    motivo: 'Abuso de poder econômico nas eleições anteriores',
    lei: 'Art. 22 da Lei nº 9.504/1997',
    dataDecisao: '05/07/2023',
    fichaSuja: false,
  ),
  CandidatoInelegivel(
    nome: 'João Carlos Silva',
    cargo: 'Senador',
    sigla: 'JC',
    corAvatar: const Color(0xFFBF360C),
    motivo: 'Renúncia ao cargo para evitar cassação',
    lei: 'Art. 1º, I, k da LC 64/1990',
    dataDecisao: '20/11/2022',
    fichaSuja: true,
  ),
  CandidatoInelegivel(
    nome: 'Ana Paula Ramos',
    cargo: 'Deputada Estadual',
    sigla: 'AP',
    corAvatar: const Color(0xFF00695C),
    motivo: 'Condenação criminal transitada em julgado',
    lei: 'Lei Complementar nº 135/2010 (Ficha Limpa)',
    dataDecisao: '08/02/2024',
    fichaSuja: true,
  ),
];

// ═══════════════════════════════════════════
//  TELA DE INELEGIBILIDADE
// ═══════════════════════════════════════════
class InelegibilidadeScreen extends StatefulWidget {
  const InelegibilidadeScreen({super.key});

  @override
  State<InelegibilidadeScreen> createState() => _InelegibilidadeScreenState();
}

class _InelegibilidadeScreenState extends State<InelegibilidadeScreen> {
  final TextEditingController _buscaController = TextEditingController();
  List<CandidatoInelegivel> _listaFiltrada = _candidatos;

  // filtra a lista conforme o usuário digita
  void _filtrar(String texto) {
    setState(() {
      _listaFiltrada = _candidatos
          .where((c) => c.nome.toLowerCase().contains(texto.toLowerCase()) ||
                        c.cargo.toLowerCase().contains(texto.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // AppBar com setinha de voltar automática
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: _azul,
        elevation: 0.5,
        title: const Text(
          'Inelegibilidade',
          style: TextStyle(
            color: _azul,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

      body: Column(
        children: [
          // ── Banner informativo ───────────────
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFFE082)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.info_outline,
                      color: Color(0xFFE65100), size: 22),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'O que é inelegibilidade?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE65100),
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Candidatos que não podem concorrer às eleições por decisão judicial ou enquadramento na Lei da Ficha Limpa.',
                        style: TextStyle(
                          color: Color(0xFFBF360C),
                          fontSize: 12,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Campo de busca ───────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _buscaController,
              onChanged: _filtrar,
              decoration: InputDecoration(
                hintText: 'Buscar por nome ou cargo...',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: _verde, width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── Contador de resultados ───────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${_listaFiltrada.length} candidato(s) encontrado(s)',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ── Lista ────────────────────────────
          Expanded(
            child: _listaFiltrada.isEmpty
                ? const _SemResultados()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _listaFiltrada.length,
                    itemBuilder: (context, index) {
                      return _CardCandidato(candidato: _listaFiltrada[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════
//  CARD de cada candidato
// ═══════════════════════════════════════════
class _CardCandidato extends StatelessWidget {
  final CandidatoInelegivel candidato;
  const _CardCandidato({required this.candidato});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Linha do topo: avatar + nome + badge ──
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: candidato.corAvatar,
                child: Text(
                  candidato.sigla,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidato.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: _azul,
                      ),
                    ),
                    Text(
                      candidato.cargo,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              // badge Ficha Suja (só aparece quando for true)
              if (candidato.fichaSuja)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.red[700],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'FICHA SUJA',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          const Divider(height: 20),

          // ── Detalhes ──
          _Detalhe(
            icone: Icons.gavel,
            label: 'Motivo',
            valor: candidato.motivo,
          ),
          const SizedBox(height: 8),
          _Detalhe(
            icone: Icons.menu_book_outlined,
            label: 'Legislação',
            valor: candidato.lei,
          ),
          const SizedBox(height: 8),
          _Detalhe(
            icone: Icons.calendar_today_outlined,
            label: 'Decisão em',
            valor: candidato.dataDecisao,
          ),
        ],
      ),
    );
  }
}

// ── Linha de detalhe: ícone + label + valor ──
class _Detalhe extends StatelessWidget {
  final IconData icone;
  final String label;
  final String valor;

  const _Detalhe({
    required this.icone,
    required this.label,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icone, size: 16, color: _verde),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: Colors.black87),
              children: [
                TextSpan(
                  text: '$label: ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: valor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Tela quando a busca não acha nada ──
class _SemResultados extends StatelessWidget {
  const _SemResultados();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 64, color: Colors.grey),
          SizedBox(height: 12),
          Text(
            'Nenhum candidato encontrado',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}