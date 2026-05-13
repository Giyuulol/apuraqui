import '../models/candidate_profile.dart';
import '../models/government_plan_item.dart';

const candidatesMock = <CandidateProfile>[
  CandidateProfile(
    id: 'maria',
    nome: 'Maria Silva',
    foto: 'assets/images/image_candidate1.png',
    cargo: 'Presidente',
    numero: '12',
    partido: 'Partido Renovação (PR)',
    sobre:
        'Sobre: Professora universitária com 20 anos de experiência em gestão pública e foco em educação, saúde e inclusão social.',
    propostas: [
      GovernmentPlanItem(
        id: 'educacao',
        titulo: 'Educação',
        descricao:
            'Ampliação de escolas em tempo integral e valorização docente com formação continuada.',
        icone: 'school',
        iconeCor: 0xFF155DFC,
        iconeFundo: 0xFFEFF6FF,
      ),
      GovernmentPlanItem(
        id: 'economia',
        titulo: 'Economia',
        descricao:
            'Reforma tributária progressiva, incentivo a pequenos negócios e geração de empregos.',
        icone: 'payments',
        iconeCor: 0xFF009966,
        iconeFundo: 0xFFECFDF5,
      ),
      GovernmentPlanItem(
        id: 'saude',
        titulo: 'Saúde Pública',
        descricao:
            "Criação do programa 'Médico na Escola' e ampliação da atenção básica nas periferias.",
        icone: 'local_hospital',
        iconeCor: 0xFFE7000B,
        iconeFundo: 0xFFFEF2F2,
      ),
      GovernmentPlanItem(
        id: 'seguranca',
        titulo: 'Segurança',
        descricao:
            'Investimento em inteligência, tecnologia e integração entre forças de segurança.',
        icone: 'security',
        iconeCor: 0xFF314158,
        iconeFundo: 0xFFF1F5F9,
      ),
      GovernmentPlanItem(
        id: 'ambiente',
        titulo: 'Meio Ambiente',
        descricao:
            'Transição energética acelerada e proteção de biomas com fiscalização efetiva.',
        icone: 'park',
        iconeCor: 0xFF00A63E,
        iconeFundo: 0xFFF0FDF4,
      ),
    ],
  ),
  CandidateProfile(
    id: 'joao',
    nome: 'João Santos',
    foto: 'assets/images/image_candidate2.png',
    cargo: 'Presidente',
    numero: '45',
    partido: 'Partido do Povo (PP)',
    sobre: 'Empresário e gestor público. Defende a geração acelerada de empregos, forte atração de investimentos privados e a desburocratização da máquina do estado.',
    propostas: [
      GovernmentPlanItem(
        id: 'educacao',
        titulo: 'Educação',
        descricao:
            'Foco intensivo no ensino técnico e profissionalizante em parceria direta com indústrias locais para jovens aprendizes.',
        icone: 'school',
        iconeCor: 0xFF155DFC,
        iconeFundo: 0xFFEFF6FF,
      ),
      GovernmentPlanItem(
        id: 'economia',
        titulo: 'Economia',
        descricao:
            'Redução drástica de impostos para pequenas e médias empresas como estímulo à geração rápida de novos empregos.',
        icone: 'payments',
        iconeCor: 0xFF009966,
        iconeFundo: 0xFFECFDF5,
      ),
      GovernmentPlanItem(
        id: 'saude',
        titulo: 'Saúde Pública',
        descricao:
            'Parceria forte com a rede privada por meio de vouchers estatais para zerar a fila de exames e cirurgias do SUS.',
        icone: 'local_hospital',
        iconeCor: 0xFFE7000B,
        iconeFundo: 0xFFFEF2F2,
      ),
      GovernmentPlanItem(
        id: 'seguranca',
        titulo: 'Segurança',
        descricao:
            'Aumento do policiamento ostensivo nas ruas e endurecimento severo das penas para crimes contra o patrimônio.',
        icone: 'security',
        iconeCor: 0xFF314158,
        iconeFundo: 0xFFF1F5F9,
      ),
      GovernmentPlanItem(
        id: 'ambiente',
        titulo: 'Meio Ambiente',
        descricao:
            'Regularização fundiária rápida e flexibilização de licenças ambientais para impulsionar o agronegócio responsável.',
        icone: 'park',
        iconeCor: 0xFF00A63E,
        iconeFundo: 0xFFF0FDF4,
      ),
    ],
  ),
  CandidateProfile(
    id: 'ana',
    nome: 'Ana Oliveira',
    foto: 'assets/images/image_candidate3.png',
    cargo: 'Presidente',
    numero: '77',
    partido: 'Partido Verde (PV)',
    sobre: 'Ambientalista premiada internacionalmente e advogada. Trabalha pela construção de uma economia verde aliada a um forte investimento em tecnologia e inovação social.',
    propostas: [
      GovernmentPlanItem(
        id: 'educacao',
        titulo: 'Educação',
        descricao:
            'Inclusão digital com tablets e internet para todos os alunos da rede pública e currículo focado em programação e sustentabilidade.',
        icone: 'school',
        iconeCor: 0xFF155DFC,
        iconeFundo: 0xFFEFF6FF,
      ),
      GovernmentPlanItem(
        id: 'economia',
        titulo: 'Economia',
        descricao:
            'Fomento à "Economia Verde" com fortes incentivos fiscais para startups, cooperativas e empresas de energia limpa.',
        icone: 'payments',
        iconeCor: 0xFF009966,
        iconeFundo: 0xFFECFDF5,
      ),
      GovernmentPlanItem(
        id: 'saude',
        titulo: 'Saúde Pública',
        descricao:
            'Digitalização total do SUS com ampliação da telemedicina e criação de novos centros de apoio à saúde mental.',
        icone: 'local_hospital',
        iconeCor: 0xFFE7000B,
        iconeFundo: 0xFFFEF2F2,
      ),
      GovernmentPlanItem(
        id: 'seguranca',
        titulo: 'Segurança',
        descricao:
            'Iluminação pública inteligente em 100% das vias e uso de análise de dados para prever e mapear manchas criminais.',
        icone: 'security',
        iconeCor: 0xFF314158,
        iconeFundo: 0xFFF1F5F9,
      ),
      GovernmentPlanItem(
        id: 'ambiente',
        titulo: 'Meio Ambiente',
        descricao:
            'Reflorestamento em massa de áreas degradadas e transição gradual para frota de transporte público 100% elétrica.',
        icone: 'park',
        iconeCor: 0xFF00A63E,
        iconeFundo: 0xFFF0FDF4,
      ),
    ],
  ),
];
