# Design System Flutter

Esta camada adapta os fundamentos do GOV.BR-DS para widgets Flutter locais.

## Regra De Uso

- Use os tokens do GOV.BR-DS para cores, tipografia, espacamento e radius.
- Use o Figma do ApurAqui para composicao visual e componentes de dominio.
- Preserve acessibilidade, estados e comportamento definidos pelo GOV.BR-DS.
- Prefira imports de `core/design_system` em novas features.

Os arquivos antigos em `core/theme` e `core/widgets` sao adapters temporarios
para permitir a migracao gradual das telas existentes.
