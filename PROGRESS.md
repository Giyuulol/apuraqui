# ApurAqui - Progresso do Produto

## Objetivo

Este documento registra o estado verificavel do produto e a ordem de evolucao.
O backlog detalhado e mantido em [`feature_list.json`](feature_list.json). Cada
item deve ter contrato, criterios de aceite, testes e uma decisao explicita
antes de entrar em implementacao.

## Estado Atual

| Area | Estado | Evidencia |
|---|---|---|
| Mobile | Concluido | App Flutter com suporte a Android e iOS. |
| Design system | Concluido | Tokens GOV.BR-DS e fonte Rawline aplicados globalmente. |
| Persistencia local | Concluido | Drift/SQLite para sessao demo, preferencias, checklist e santinhos. |
| Autenticacao demo | Concluido | Credenciais locais atras de `SessionRepository`. |
| Phone Auth | Concluido | Firebase Authentication, verificacao SMS e mapeamento de erros. |
| Dados eleitorais | Mock | Candidatos, noticias, apuracao e local de votacao ainda nao usam fontes oficiais. |
| Backend de produto | Nao iniciado | Nao ha API, banco remoto ou regras de acesso para dados por usuario. |
| App Check | Nao iniciado | Deve ser configurado antes de expor recursos Firebase alem do Auth. |

## Arquitetura Atual

O modulo `auth` usa **Repository Pattern** e **Dependency Inversion**:

```text
UI -> AuthController (Riverpod) -> SessionRepository
                                      |- DriftSessionRepository (demo)
                                      |- FirebaseAuthRepository (telefone)
```

Essa fronteira permite trocar adapters sem acoplar widgets ao SDK Firebase. O
proximo backend deve manter o mesmo criterio: contrato no `domain`, adapter em
`data` e orquestracao no `application`.

## Prioridades de Evolucao

### Marco 1 - Fundacao de Seguranca

1. `SEC-001`: separar ambientes Firebase de desenvolvimento e producao.
2. `SEC-002`: configurar Firebase App Check para os recursos que forem expostos.
3. `SEC-003`: definir aviso de privacidade e consentimento para numero telefonico.
4. `SEC-004`: automatizar analise de dependencias e revisao de configuracoes
   nativas antes de releases.

**Definition of Done:** configuracoes nao secretas versionadas ou injetadas por
ambiente; secrets fora do Git; regras de backend revisadas; evidencias de teste
em dispositivo real.

### Marco 2 - Usabilidade e Acessibilidade

1. `UX-001`: auditoria de acessibilidade de formularios e navegacao.
2. `UX-002`: padronizar estados de carregamento, erro, vazio e offline.
3. `UX-003`: tornar a entrada de telefone mais tolerante a formatacao e clara
   sobre o formato internacional.
4. `UX-004`: permitir que o usuario controle consentimentos e apague dados locais.

**Definition of Done:** fluxos principais testados com leitor de tela, escala de
fonte elevada e falha de rede; sem bloqueios de navegacao ou mensagens tecnicas
expostas ao usuario.

### Marco 3 - Dados Confiaveis

1. `DATA-001`: definir contratos de fontes oficiais e o modelo de proveniencia.
2. `DATA-002`: criar API/backend com autorizacao e regras de acesso antes de
   salvar dados pessoais na nuvem.
3. `DATA-003`: substituir gradualmente mocks por repositorios remotos com cache.

**Definition of Done:** cada dado exibido possui fonte, data de atualizacao e
estrategia de cache; dados por usuario sao isolados por `uid` e protegidos por
regras testadas.

## Regra de Priorizacao

1. Corrigir riscos de seguranca e privacidade antes de adicionar funcionalidades
   que armazenem ou publiquem dados.
2. Resolver bloqueios de usabilidade nos fluxos existentes antes de ampliar a
   navegacao.
3. Integrar dados externos somente apos definir contrato, ownership, atualizacao
   e comportamento offline.

## Como Atualizar

- Ao iniciar um item: altere seu `status` para `in_progress` no JSON e registre
  a decisao de arquitetura no PR ou issue correspondente.
- Ao concluir: valide todos os criterios de aceite, atualize o status para
  `done` e inclua testes de comportamento.
- Ao descobrir um risco: crie um item `SEC-*`, `UX-*`, `DATA-*` ou `PLT-*` com
  prioridade e dependencia explicitas.
