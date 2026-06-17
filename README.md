# ApurAqui

Aplicativo Flutter mobile de apoio ao eleitor brasileiro, desenvolvido como projeto acadêmico da disciplina de Desenvolvimento Mobile do UNIPÊ.

O app oferece santinhos digitais, perfis de candidatos com planos de governo, comparador de propostas, checklist de preparação para o dia da votação, central de notícias com verificação de fake news, consulta simulada de local de votação e dashboard de apuração com dados mockados.

---

## Equipe

- Alex Dantas
- Francisco Serafim
- Handrey Kaleu
- Luiz Eduardo
- Rafael Luna

---

## Plataformas

| Plataforma | Suporte |
|---|---|
| Android | ✅ |
| iOS | ✅ |
| Web / Desktop | ❌ (fora do escopo) |

---

## Funcionalidades

### 🔐 Autenticação
- Tela de login com credencial de demonstração local.
- Cadastro de nova conta com validação de campos.
- Recuperação de senha (fluxo de protótipo).
- Sessão autenticada persistida localmente via Drift/SQLite.

> **Credencial demo:** `demo@apuraqui.app` / `Apura@2026`

### 📊 Dashboard de Apuração
- Faixa de métricas com gradiente identidade GOV.BR (verde → amarelo → azul).
- Quatro stat cards frosted-glass: Total de Votos, Candidatos, Participação e Urnas Apuradas.
- Abas: **Resultados** (cards de candidatos com barra de progresso e delta), **Gráficos** (gráfico de barras), **Regiões** (mapa de apuração por região) e **Ao Vivo** (feed de atualizações).

### 🗳️ Santinhos Digitais
- Listagem de santinhos salvos com foto, nome, número e partido.
- Ações: salvar santinho, compartilhar e navegar para o perfil completo do candidato.
- Persistência local via Drift.

### 📷 Leitor de QR Code
- Scanner em modo demo com animação de varredura.
- Resultado simulado vinculado a um candidato mock.
- Ao escanear: salva o santinho e oferece navegação direta ao perfil.

### 👤 Perfis dos Candidatos
- Seletor de candidato com foto e acento de cor identitária.
- Perfil completo: número eleitoral, partido, biografia e ações rápidas.
- Plano de governo com cards de propostas por área temática.
- Navegação direta a partir do santinho escaneado ou salvo.

### ⚖️ Comparador de Propostas
- Compara dois candidatos lado a lado.
- Seleção de candidato via modal com busca.
- Propostas exibidas por categoria com destaque visual.

### ✅ Checklist de Votação
- Lista de documentos e itens necessários para o dia da eleição.
- Dois modos: eleitor comum e candidato.
- Marcação de itens com persistência local (Drift).
- Aviso destacado sobre o uso de celular na seção eleitoral.

### 📰 Central de Notícias
- Feed de notícias eleitorais mockadas com imagens, fonte e data.
- Seção de verificação de fake news com resultado simulado.

### 📍 Local de Votação
- Consulta simulada de local de votação com endereço e seção.
- Monitor colaborativo de fila (protótipo).

---

## Stack Técnica

| Camada | Tecnologia |
|---|---|
| Framework | Flutter 3 (Dart 3) |
| Gerência de estado | Riverpod 3 (`flutter_riverpod`) |
| Persistência local | Drift 2 (SQLite) via `drift_flutter` |
| Geração de código | `build_runner` + `drift_dev` |
| Fonte global | Rawline (GOV.BR-DS) |
| Ícones | Material Icons + `flutter_svg` |
| Lint | `flutter_lints` |

---

## Design System

Adaptação do **GOV.BR-DS** para Flutter:

- Fonte **Rawline** aplicada globalmente via `AppTheme`.
- Tokens semânticos em `lib/core/design_system/tokens/`:
  - `AppColors` — paleta GOV.BR + estados semânticos
  - `AppTypography` — escala tipográfica Rawline
  - `AppSpacing` / `AppRadius` — espaçamentos e bordas
- Componentes compartilhados: `AppCard`, `AppHeader`, `AppStateView`.
- Composição visual baseada no protótipo do Figma.

---

## Estrutura do Projeto

```text
lib/
├── core/
│   ├── database/          # Drift — tabelas e repositórios
│   ├── design_system/     # Tokens, tema e componentes
│   ├── navigation/        # Rotas nomeadas
│   ├── preferences/       # Preferências de navegação (Drift)
│   ├── providers/         # Providers de infraestrutura
│   └── widgets/           # Widgets compartilhados (AppHeader, AppStateView)
├── features/
│   ├── auth/              # Login, cadastro, recuperação de senha
│   ├── comparador/        # Comparador de propostas
│   ├── dashboard/         # Dashboard de apuração
│   ├── leitor_qr/         # Leitor de QR Code
│   ├── local_votacao/     # Local de votação
│   ├── noticias/          # Central de notícias e fake news
│   ├── perfil/            # Perfis de candidatos
│   ├── santinho/          # Santinhos digitais
│   ├── splash/            # Splash screen
│   └── votacao/           # Checklist de votação
└── main.dart
```

---

## Como Executar

```bash
git clone https://github.com/Giyuulol/apuraqui.git
cd apuraqui
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

---

## Verificação de Qualidade

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
```

---

## Escopo e Limitações

Esta fase é focada em **front-end mobile funcional**. O app não usa backend, API remota ou fontes oficiais em tempo real. Dados de apuração, local de votação, notícias e QR Code são simulados para demonstrar os fluxos completos na disciplina. As fronteiras de mock estão próximas às features para que uma API futura possa substituí-los sem reescrever as telas.

---

## Próximos Passos

- Integrar fontes oficiais (TSE, APIs públicas) quando os contratos estiverem definidos.
- Substituir mocks por repositórios remotos com cache local.
- Implementar push notifications para atualizações de apuração ao vivo.
