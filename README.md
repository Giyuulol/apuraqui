# ApurAqui

Aplicativo Flutter mobile para apoiar eleitores com informações de candidatos, checklist para o dia da votação, notícias verificadas e santinhos digitais.

Projeto acadêmico da disciplina de Desenvolvimento Mobile do UNIPÊ.

## Plataformas

- Android
- iOS

O projeto não mantém scaffolding para web ou desktop.

## Funcionalidades Disponíveis

- Login simulado com validação de formulário.
- Perfis de candidatos e planos de governo.
- Comparador de propostas com dados compartilhados da feature de perfil.
- Checklist de documentos para votação.
- Central de notícias e verificação de fake news com mocks.
- Santinhos digitais com ações de salvar, compartilhar e visualizar propostas.
- Estados compartilhados para falta de conexão, erro de servidor e lista vazia.

## Design System

O app usa uma adaptação do GOV.BR-DS para Flutter:

- Rawline como fonte global.
- Tokens semânticos de cores, tipografia, espaçamento e radius.
- Componentes compartilhados em `lib/core/design_system/`.
- Composição visual baseada no protótipo do Figma.

## Estrutura

```text
lib/
├── core/
│   ├── design_system/
│   ├── navigation/
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

- Definir persistência local e gerenciamento de estado com Riverpod.
- Integrar fontes oficiais e APIs públicas quando os contratos estiverem definidos.
- Substituir ações de protótipo por integrações reais.
