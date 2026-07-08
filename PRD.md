# PRD — ApurAqui para Produção

**Status:** Proposto para execução  
**Versão:** 1.0  
**Plataformas:** Android e iOS  
**Mercado inicial:** Paraíba, Brasil  
**Público principal:** Eleitores brasileiros

## 1. Visão do produto

O ApurAqui é um aplicativo mobile de apoio ao eleitor que centraliza informações eleitorais verificáveis, preparação para o voto e acompanhamento do processo eleitoral.

O produto resolve três problemas recorrentes: dificuldade em localizar informações eleitorais confiáveis, baixa transparência sobre a origem e atualização dos dados e falta de uma jornada única para preparar-se para o dia da votação.

O diferencial do ApurAqui é a **transparência de dados**. Toda informação eleitoral publicada deverá informar, de forma compreensível, sua fonte oficial, horário de atualização, cobertura e estado de confiabilidade. Dados ausentes, expirados ou indisponíveis não podem aparentar ser atuais.

## 2. Objetivos e métricas

### Objetivos de produto

- Permitir que o eleitor encontre e compare informações eleitorais confiáveis em um único aplicativo.
- Apoiar a preparação para o voto, incluindo documentos e local de votação.
- Exibir dados eleitorais com proveniência e atualização rastreáveis.
- Validar o produto em um piloto cobrindo todo o estado da Paraíba antes de expandir para novas regiões.

### Métrica norte

**Alcance informacional verificável:** número de usuários que consultam conteúdo eleitoral com fonte e data de atualização identificadas.

Uma consulta verificável deve registrar uma visualização de conteúdo eleitoral que exiba, ou ofereça acesso imediato a, metadados de proveniência.

### Métricas de apoio

| Métrica | Definição | Finalidade |
| --- | --- | --- |
| Usuários ativos eleitorais | Usuários que realizam ao menos uma consulta verificável no período | Medir alcance útil, não apenas instalações |
| Cobertura com proveniência | Percentual de itens publicados com fonte, data de atualização e cobertura | Garantir a proposta de transparência |
| Frescor dos dados | Percentual de itens dentro da janela de atualização definida por tipo de dado | Detectar informação potencialmente desatualizada |
| Conclusão de preparação | Percentual de usuários que consultam local e concluem o checklist | Medir utilidade antes da votação |
| SLA de moderação | Tempo entre envio e decisão para relatos colaborativos | Controlar segurança e operação |
| Taxa de remoção por denúncia | Relatos removidos após publicação sobre relatos aprovados | Monitorar qualidade da pré-moderação |

As metas numéricas, a janela de atualização e o SLA serão definidos com o parceiro institucional antes do piloto; não devem ser inventados pela implementação.

## 3. Público e contexto de uso

### Público primário — eleitor na Paraíba

Pessoa apta a votar que precisa se informar antes e durante o período eleitoral. Pode acessar o app sem conta e espera conteúdo simples, confiável e acessível em dispositivo mobile.

### Público secundário — operação editorial

Equipe do parceiro institucional responsável por validar fontes oficiais, aprovar ou rejeitar relatos colaborativos e responder por políticas editoriais e de moderação.

### Jornada principal

1. O eleitor acessa o aplicativo sem autenticação obrigatória.
2. Consulta candidatos, propostas, notícias, local de votação ou apuração.
3. Confere a origem, o horário de atualização e a cobertura do dado em “Por que confiar?”.
4. Salva candidatos, preferências ou alertas; uma conta opcional poderá sincronizar esses dados entre dispositivos.
5. Antes da votação, conclui o checklist e consulta o local.
6. Durante a votação, pode enviar um relato estruturado sobre fila ou acessibilidade; o relato permanece pendente até a pré-moderação.

## 4. Estado atual e lacunas para produção

O repositório contém um protótipo Flutter funcional para Android e iOS, com Riverpod para estado e dependency injection, Drift/SQLite para persistência local e fonte Rawline/GOV.BR-DS como base visual.

| Capacidade atual | Estado | Condição para produção |
| --- | --- | --- |
| Login demo e telefone por Firebase Authentication | Implementado | Tornar a conta opcional, separar ambientes, obter consentimento e configurar políticas de privacidade |
| Santinhos salvos e checklist | Persistência local implementada | Definir sincronização opcional, exclusão de dados e comportamento entre dispositivos |
| Perfis, propostas e comparador | Dados mockados | Substituir mocks por fontes oficiais com metadados de proveniência |
| Notícias e verificação de fake news | Dados/resultados simulados | Definir fontes oficiais, política editorial e processo de correção |
| Local de votação e monitor de fila | Consulta e fila simuladas | Integrar dados oficiais e implementar relatos moderados |
| Dashboard de apuração | Dados mockados | Integrar fonte oficial, indicar latência/cobertura e suportar indisponibilidade |
| Design system e estados assíncronos | Parcialmente implementados | Auditar acessibilidade, escalonamento de texto e estados de erro/offline |

Os mocks atuais são úteis como adapters de desenvolvimento, mas não são fonte de verdade e não podem alimentar uma release pública.

## 5. Escopo por horizonte

### Horizonte 1 — Fundação para produção

Construir as capacidades que tornam os fluxos confiáveis e operáveis:

- Contratos de dados oficiais e modelo de proveniência.
- Backend ou serviços gerenciados para dados por usuário, somente após definição de autorização e LGPD.
- Separação de ambientes, segurança de configurações, observabilidade e monitoramento de falhas.
- Política de privacidade, consentimento para telefone e mecanismo de exclusão de dados.
- Acessibilidade nos fluxos principais, incluindo leitor de tela, contraste, foco e texto ampliado.
- Operação editorial com parceiro institucional, fila de moderação e trilha de auditoria.

### Horizonte 2 — Fluxos eleitorais confiáveis

Evoluir as capacidades já visíveis no protótipo para dados de produção:

- Perfis de candidatos, planos de governo e comparador de propostas.
- Santinhos digitais e itens salvos.
- Checklist de votação e consulta de local de votação.
- Notícias eleitorais e verificação de informações, respeitando a política editorial.
- Dashboard de apuração e atualizações ao vivo, quando houver dados oficiais disponíveis.

### Horizonte 3 — Retenção e transparência avançada

Adicionar recursos que reforçam uso recorrente sem comprometer confiabilidade:

- Histórico de alterações de dados e explicação de cobertura.
- Alertas configuráveis para candidatos acompanhados, atualizações de apuração e etapas eleitorais.
- Relatos estruturados sobre fila e acessibilidade, com pré-moderação humana.
- Indicadores agregados de relatos aprovados; conteúdo individual só será exibido conforme política editorial aprovada.

## 6. Requisitos funcionais

### RF-01 — Consulta pública e conta opcional

**Caso de uso:** o eleitor acessa conteúdo público sem criar uma conta e, se desejar, autentica-se para sincronizar dados pessoais permitidos.

**Regras:**

- A consulta de conteúdo eleitoral público não exige login.
- Login por telefone e credencial demo não definem a política de identidade de produção; a credencial demo não estará disponível em release pública.
- Itens salvos, preferências e alertas devem continuar funcionais localmente sem conta.
- A sincronização exige consentimento explícito e uma política definida de retenção e exclusão.

**Critérios de aceite:**

- Um usuário não autenticado consulta todos os conteúdos públicos do escopo.
- Um usuário autenticado entende quais dados serão sincronizados antes de confirmar a ação.
- O usuário consegue encerrar a sessão e solicitar a remoção dos dados sob responsabilidade do produto.

### RF-02 — Proveniência e confiabilidade de dados

**Caso de uso:** ao consultar qualquer dado eleitoral, o eleitor entende de onde ele veio e se ainda é confiável.

**Regras:**

- Todo item eleitoral publicado deve possuir identificador de fonte, origem oficial, data/hora de coleta ou publicação, data/hora de atualização e cobertura geográfica.
- A interface deve oferecer a ação “Por que confiar?” no contexto do item ou da tela que o exibe.
- O estado de desatualização, indisponibilidade ou ausência de fonte deve ser visível e não depender apenas de cor.
- Informações sem proveniência válida não podem ser publicadas como dado eleitoral factual.

**Critérios de aceite:**

- Perfis, propostas, local, notícias e apuração exibem metadados de proveniência.
- Um dado fora da janela de frescor aparece como desatualizado e informa a última atualização conhecida.
- Falha de fonte apresenta estado de indisponibilidade com tentativa de atualização, sem substituir o dado por valor fictício.

### RF-03 — Perfis, propostas, santinhos e comparador

**Caso de uso:** o eleitor encontra candidatos, consulta suas propostas e compara dois candidatos por tema.

**Regras:**

- Candidato, partido, número e propostas devem consumir o mesmo modelo de domínio, evitando duplicação entre perfil, comparador e santinho.
- O comparador deve identificar a fonte e a atualização de cada proposta, não apenas do candidato.
- Salvar um santinho é uma preferência do usuário; sua persistência deve respeitar o modo local ou sincronizado escolhido.

**Critérios de aceite:**

- A mesma identidade de candidato é apresentada de forma consistente em todas as telas.
- O comparador permite selecionar dois candidatos e apresentar propostas por categoria com suas evidências.
- Um santinho salvo permanece disponível offline quando já armazenado localmente.

### RF-04 — Preparação e local de votação

**Caso de uso:** antes de votar, o eleitor identifica documentos necessários e consulta seu local de votação.

**Regras:**

- O checklist mantém o progresso localmente e comunica o aviso sobre celular na seção eleitoral.
- A consulta de local deve identificar fonte, data de atualização e cobertura; dados pessoais de localização não podem ser retidos sem finalidade definida.
- Caso a fonte oficial esteja indisponível, o app deve informar a falha e manter apenas a última informação válida, devidamente marcada, quando existir.

**Critérios de aceite:**

- O progresso do checklist persiste após reiniciar o aplicativo.
- A tela de local não apresenta endereço simulado em produção.
- Usuários conseguem distinguir um local atualizado de um resultado em cache desatualizado.

### RF-05 — Notícias, verificação e apuração

**Caso de uso:** o eleitor acompanha conteúdo e resultados sem confundir dados oficiais, conteúdo editorial e informações indisponíveis.

**Regras:**

- Notícias, verificações e apuração devem indicar tipo de conteúdo, fonte, horário de atualização e responsável editorial quando aplicável.
- A apuração só exibe números quando a cobertura e o horário de atualização são conhecidos.
- Não haverá resultado de “fake news” automático ou simulado em produção sem fonte e metodologia editorial aprovadas.

**Critérios de aceite:**

- Cada conteúdo permite acessar seus dados de origem.
- A tela de apuração comunica cobertura, latência e última atualização.
- Correções editoriais preservam histórico e deixam a alteração identificável ao usuário.

### RF-06 — Alertas configuráveis

**Caso de uso:** o eleitor recebe avisos úteis sobre dados que escolheu acompanhar.

**Regras:**

- O usuário escolhe categorias de alerta e pode revogar cada uma separadamente.
- Alertas de candidatos, apuração e calendário dependem de dado com proveniência válida.
- O produto não envia alertas eleitorais promocionais ou partidários.

**Critérios de aceite:**

- O usuário configura e desativa cada categoria de alerta.
- Cada alerta apresenta fonte, horário e caminho para consultar o dado completo.
- A ausência de permissão de notificação não bloqueia o restante do aplicativo.

### RF-07 — Relatos de fila e acessibilidade

**Caso de uso:** o eleitor envia um relato estruturado sobre condições de votação; a operação avalia antes de qualquer publicação.

**Regras:**

- O relato deve usar categorias estruturadas, incluindo fila e acessibilidade; texto livre e mídia só serão adicionados após política específica.
- Todo relato começa como `pending` e não é público antes da decisão humana.
- A operação pode aprovar, rejeitar, ocultar ou remover relatos, sempre com registro de decisão e responsável.
- A interface pública deve priorizar indicadores agregados para reduzir exposição e risco de identificação de pessoas.

**Critérios de aceite:**

- Um relato enviado não aparece imediatamente para outros usuários.
- Moderadores conseguem decidir, registrar justificativa e auditar a decisão.
- Usuários podem denunciar um relato publicado e recebem confirmação da solicitação.

## 7. Requisitos não funcionais

### Arquitetura e escalabilidade

- O app continua limitado a Android e iOS.
- A arquitetura deve preservar fronteiras por feature: contratos e modelos em `domain`, adapters em `data`, orquestração Riverpod em `application` e UI em `widgets`/páginas.
- **Repository Pattern** e **Dependency Inversion** são obrigatórios nas integrações externas: widgets não acessam HTTP, Firebase ou SQLite diretamente.
- Dados remotos devem ter cache local, política de invalidação por tipo de dado e comportamento offline explícito.
- A evolução não pode duplicar modelos de candidatos ou propostas entre features.

### Segurança e privacidade

- Separar Firebase e demais integrações por ambientes de desenvolvimento e produção.
- Não versionar segredos, service accounts ou chaves de assinatura.
- Aplicar princípio de minimização de dados, consentimento informado, retenção definida e exclusão verificável, em conformidade com LGPD.
- Definir autorização por usuário antes de sincronizar dados pessoais entre dispositivos.
- Configurar proteção e observabilidade dos recursos remotos antes de expô-los em produção.

### Acessibilidade e experiência

- Aplicar a fonte Rawline e os tokens semânticos do design system em telas e componentes novos.
- Ações somente com ícone devem ter rótulo semântico ou tooltip.
- Fluxos principais devem suportar leitor de tela, contraste adequado, foco navegável e texto ampliado sem overflow.
- Estados de loading, erro, vazio, offline e dado desatualizado devem ser claros e acessíveis.

### Disponibilidade e observabilidade

- Monitorar erros de aplicação, falhas de fonte, latência, frescor dos dados e fila de moderação.
- Preservar a última informação válida em cache quando compatível com a política de atualização e identificá-la como tal.
- Nenhuma falha externa pode ser mascarada por dados mockados em produção.

## 8. Dependências e responsabilidades

| Dependência | Responsável | Condição de aceite |
| --- | --- | --- |
| Fontes oficiais de dados | Parceiro institucional + equipe ApurAqui | Origem, licença, atualização, cobertura e contrato validados |
| Política editorial e moderação | Parceiro institucional | Critérios de aprovação, correção, remoção e SLA documentados |
| Plataforma e integrações | Equipe ApurAqui | Arquitetura, segurança, observabilidade e testes entregues |
| Privacidade e LGPD | Equipe ApurAqui + parceiro institucional | Política, consentimentos, retenção e exclusão aprovados |
| Operação do piloto | Parceiro institucional | Moderadores, canal de escalonamento e capacidade operacional definidos |

O parceiro institucional é responsável pela operação completa de validação, moderação e atendimento editorial. A equipe ApurAqui mantém a plataforma e implementa os controles necessários para essa operação.

## 9. Riscos e mitigação

| Risco | Impacto | Mitigação |
| --- | --- | --- |
| Fonte oficial indisponível ou sem contrato de uso | Alto | Não publicar dado factual sem fonte; mostrar indisponibilidade e última informação válida marcada |
| Desinformação ou abuso em relatos | Alto | Pré-moderação, categorias estruturadas, denúncia, auditoria e política editorial |
| Dados pessoais tratados sem base adequada | Alto | Conta opcional, minimização, consentimento, retenção e exclusão definidos antes do lançamento |
| Dados desatualizados em período eleitoral | Alto | Janela de frescor por tipo, indicador visível e monitoramento de atualização |
| Capacidade insuficiente de moderação | Alto | Definir SLA, escala de operação e gatilho para suspender recebimento de relatos |
| Acoplamento da UI a fontes externas | Médio | Repository Pattern, contratos no domínio e adapters substituíveis |
| Baixa acessibilidade ou uso em rede instável | Médio | Testes com escala de texto, leitor de tela, cache e estados offline |

## 10. Gates de lançamento e expansão

### Lançamento do piloto na Paraíba

O piloto só pode ser lançado quando todos os pontos abaixo estiverem atendidos:

- As fontes oficiais e seus contratos de uso estiverem validados pelo parceiro institucional.
- Todo dado eleitoral publicado cumprir os requisitos de proveniência.
- A política de privacidade, os consentimentos e o processo de exclusão estiverem disponíveis.
- A operação editorial e a pré-moderação tiverem responsáveis, SLA e canal de escalonamento definidos.
- Os fluxos principais tiverem validação de acessibilidade, offline e falha de fonte.
- Ambientes, segredos, autorização e monitoramento de produção estiverem configurados.

### Expansão para outras regiões

A expansão não será orientada apenas por alcance. Ela exige evidência de qualidade e segurança no piloto:

- Cobertura de dados verificável para a nova região.
- Operação editorial e moderação capaz de atender o SLA acordado.
- Métricas de proveniência, frescor e falhas dentro dos limites definidos.
- Ausência de riscos críticos abertos de privacidade, segurança ou desinformação.

## 11. Fora de escopo inicial

- Publicação automática de relatos de usuários.
- Credencial demo em ambiente de produção.
- Exibição de dados eleitorais sem fonte oficial rastreável.
- Suporte a Web, Linux, macOS ou Windows.
- Promessa de integração com um órgão ou API específica antes de validar disponibilidade, licença, atualização e contrato.
- Sincronização de dados pessoais antes de haver backend, autorização e controles de privacidade definidos.

## 12. Diretrizes de implementação

Antes de substituir qualquer mock, a equipe deve definir o contrato do dado: campos de origem, atualização, cobertura, cache, falha e exibição na UI. Essa abordagem aplica **Spec Driven Development** e reduz retrabalho na troca de adapters.

O contrato de repository deve ser definido no domínio e implementado por adapters de mock, cache local e fonte remota. Essa separação aplica **Dependency Inversion**: a regra de negócio depende de abstrações estáveis, não do SDK, banco ou fornecedor de dados.

Cada mudança deve incluir testes orientados a comportamento para o fluxo principal, erro de fonte, offline, proveniência visível e acessibilidade relevante. Repositórios Drift devem ter testes de persistência com SQLite em memória.
