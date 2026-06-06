# Fundacao GOV.BR-DS para Flutter

## Objetivo

Criar uma camada local de design system para o aplicativo Flutter. O GOV.BR-DS
define tokens semanticos, acessibilidade e comportamento. O prototipo do Figma
define composicao visual e componentes especificos do ApurAqui.

## Decisoes

- Implementar widgets Flutter locais. Os componentes oficiais GOV.BR-DS sao
  voltados para web e nao devem ser incorporados diretamente ao app mobile.
- Centralizar tokens em `lib/core/design_system/tokens`.
- Centralizar o `ThemeData` em `lib/core/design_system/theme`.
- Centralizar componentes reutilizaveis em `lib/core/design_system/components`.
- Preservar temporariamente os imports antigos em `lib/core/theme` e
  `lib/core/widgets` por meio de adapters que exportam a nova implementacao.
- Migrar telas gradualmente. Esta etapa nao altera composicao visual nem fluxo
  de navegacao.

## Contratos

### Tokens

- `AppColors`: cores semanticas para superficies, leitura, interacao e feedback.
- `AppTypography`: familia Rawline, pesos e escala tipografica.
- `AppSpacing`: escala de espacamento de 4 a 48 pixels.
- `AppRadius`: escala de bordas arredondadas para controles, cards e superficies.

### Tema

- `AppTheme.lightTheme`: tema Material 3 configurado com tokens semanticos.

### Componentes

- `AppCard`: card reutilizavel com padding e margin configuraveis.
- `AppInfoAlert`: alerta informacional acessivel com trecho opcional em destaque.

## Compatibilidade

Imports existentes continuam validos:

```dart
import 'core/theme/app_theme.dart';
import 'core/widgets/app_card.dart';
```

Novas features devem preferir:

```dart
import 'core/design_system/theme/app_theme.dart';
import 'core/design_system/components/app_card.dart';
```

## Testes

- Validar os principais tokens da escala.
- Validar que o tema usa Rawline e Material 3.
- Validar que os adapters antigos exportam as mesmas classes da nova camada.

## Fora De Escopo

- Integrar branches divergentes.
- Migrar estilos literais das telas existentes.
- Criar widgets sem uso atual, como input e button wrappers.
- Escolher banco de dados ou adicionar Riverpod.
