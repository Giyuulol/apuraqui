# Rastreabilidade — PRD ↔ Backlog

Este documento liga os requisitos do [`PRD.md`](../PRD.md) (fonte estratégica) aos
itens do [`feature_list.json`](../feature_list.json) (backlog derivado e executável).

- **Fonte de verdade estratégica:** `PRD.md` (versão 1.0).
- **Backlog derivado:** `feature_list.json` — cada item traz um campo `requirements`
  apontando para os requisitos do PRD que ele atende.
- Ao mudar o PRD, atualize o backlog e esta matriz.

**Legenda de status:** ✅ done · 🔵 planned · ⛔ blocked · 🟡 in_progress

## Requisitos funcionais (RF)

| RF | Requisito (PRD §6) | Itens do backlog | Situação |
| --- | --- | --- | --- |
| RF-01 | Consulta pública e conta opcional | AUTH-001 ✅, UX-003 ✅, AUTH-002 🔵, SEC-003 🔵, UX-004 🔵, DATA-002 ⛔, PLT-002 ⛔ | Login existe; consulta sem login e conta opcional pendentes |
| RF-02 | Proveniência e confiabilidade de dados | DATA-001 🔵, DATA-004 🔵, PLT-002 ⛔ | **Pilar prioritário — ainda não implementado** |
| RF-03 | Perfis, propostas, santinhos e comparador | FEAT-003 ✅, FEAT-004 ✅, FEAT-005 ✅, DATA-003 🔵 | UI pronta com mocks; falta fonte oficial |
| RF-04 | Preparação e local de votação | FEAT-009 ✅, FEAT-007 ✅, DATA-003 🔵 | Checklist e local prontos com mocks |
| RF-05 | Notícias, verificação e apuração | FEAT-006 ✅, FEAT-002 ✅, OPS-001 🔵, DATA-003 🔵 | Telas com mocks; falta fonte oficial e operação editorial |
| RF-06 | Alertas configuráveis | FEAT-010 🔵 | Capacidade nova, não iniciada |
| RF-07 | Relatos de fila e acessibilidade | FEAT-011 🔵, OPS-001 🔵, PLT-002 ⛔ | Capacidade nova; depende de moderação humana |

## Requisitos não-funcionais (RNF, PRD §7)

| RNF | Tema | Itens do backlog | Situação |
| --- | --- | --- | --- |
| RNF-ARQ | Arquitetura e escalabilidade | DATA-003 🔵, DATA-004 🔵 | Repository Pattern / Dependency Inversion nas integrações |
| RNF-SEG | Segurança e privacidade | SEC-001 🔵, SEC-002 🔵, SEC-003 🔵, SEC-004 🔵, SEC-005 🔵, DATA-002 ⛔, UX-004 🔵, PLT-002 ⛔ | Nenhum item concluído; pré-requisito de gate |
| RNF-A11Y | Acessibilidade e experiência | UX-001 ✅, UX-002 ✅, DATA-004 🔵, PLT-002 ⛔ | Base de a11y e estados async entregue |
| RNF-OBS | Disponibilidade e observabilidade | UX-002 ✅, SEC-004 🔵, PLT-001 🔵, PLT-002 ⛔ | Estados de falha prontos; falta monitoramento de produção |

## Gate de lançamento do piloto (PRD §10)

`PLT-002` (⛔ blocked) agrega o checklist de gate e depende de:

| Pré-condição do gate | Item | Situação |
| --- | --- | --- |
| Fontes oficiais e contratos validados | DATA-001 | 🔵 |
| Proveniência completa nos dados publicados | DATA-004 | 🔵 |
| Ambientes/segredos separados | SEC-001 | 🔵 |
| Privacidade, consentimento e exclusão | SEC-003 | 🔵 |
| Operação editorial e pré-moderação | OPS-001 | 🔵 |
| Acessibilidade nos fluxos principais | UX-001 | ✅ |

## Cobertura e lacunas

- **Todos os 7 RFs têm ao menos um item** no backlog.
- **RF-02 (proveniência)** é o pilar escolhido para começar: `DATA-004` modela
  fonte/atualização/cobertura/frescor no domínio e a ação "Por que confiar?" na UI,
  destravando a substituição de mocks (`DATA-003`) das demais features.
- **Capacidades novas trazidas pelo PRD e ainda não iniciadas:** RF-06 (alertas),
  RF-07 (relatos moderados) e a operação editorial (`OPS-001`).
- **Fora de escopo inicial (PRD §11):** Web/desktop, credencial demo em produção,
  dados sem fonte rastreável e sincronização sem backend/autorização definidos.
