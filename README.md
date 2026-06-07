# ApurAqui

Aplicativo Flutter mobile para apoiar eleitores com informações de candidatos, checklist para o dia da votação, notícias verificadas, santinhos digitais e consultas eleitorais simuladas.

Projeto acadêmico da disciplina de Desenvolvimento Mobile do UNIPÊ.

## Plataformas

- Android
- iOS

O projeto não mantém scaffolding para web ou desktop.

## Funcionalidades Disponíveis

- Login demo local com sessão persistida.
- Perfis de candidatos e planos de governo.
- Comparador de propostas com dados compartilhados da feature de perfil.
- Checklist de documentos para votação com persistência local.
- Central de notícias e verificação de fake news com mocks.
- Santinhos digitais persistidos com ações de salvar, compartilhar e visualizar propostas.
- Leitor de QR Code em modo demo, com resultado simulado e salvamento de santinho.
- Consulta simulada de local de votação, seção e monitor colaborativo de fila.
- Dashboard de apuração com dados mockados e aviso de demonstração acadêmica.
- Tela de exceções e inelegibilidade com casos simulados e estado vazio.
- Estados compartilhados para falta de conexão, erro de servidor e lista vazia.

## Escopo Atual

Esta fase é focada em front-end mobile funcional. O app não usa backend, API remota
ou fontes oficiais em tempo real. Dados de apuração, local de votação, notícias,
QR Code e inelegibilidade são simulados para demonstrar fluxos completos na
disciplina. As fronteiras de mock foram mantidas próximas às features para que
uma API futura possa substituir esses dados sem reescrever as telas.

## Design System

O app usa uma adaptação do GOV.BR-DS para Flutter:

- Rawline como fonte global.
- Tokens semânticos de cores, tipografia, espaçamento e radius.
- Componentes compartilhados em `lib/core/design_system/`.
- Composição visual baseada no protótipo do Figma.

## Persistência Local

O app usa Drift sobre SQLite e expõe estado reativo com Riverpod:

- sessão autenticada local;
- progresso do checklist;
- santinhos salvos;
- aba selecionada na navegação principal.

A credencial temporária de demonstração é:

```text
login: demo@apuraqui.app
senha: Apura@2026
```

A senha não é gravada no SQLite.

## Estrutura

```text
lib/
├── core/
│   ├── design_system/
│   ├── database/
│   ├── navigation/
│   ├── preferences/
│   ├── providers/
│   └── widgets/
├── features/
│   ├── auth/
│   ├── comparador/
│   ├── noticias/
│   ├── perfil/
│   ├── santinho/
│   └── votacao/
└── main.dart
```

## Como Executar

```bash
git clone https://github.com/Giyuulol/apuraqui.git
cd apuraqui
flutter pub get
dart run build_runner build
flutter run
```

## Verificação

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
flutter build apk --debug
```

## Próximos Passos

- Integrar fontes oficiais e APIs públicas quando os contratos estiverem definidos.
- Substituir ações de protótipo por integrações reais.
