# Project Instructions for Codex

## Communication

- Respond to the user in Portuguese.
- Keep standard software engineering terms in English when appropriate.
- Be direct, technical, and structured.
- Explain architectural decisions before non-trivial implementation changes.

## Product Scope

- ApurAqui is a Flutter mobile app.
- Support only Android and iOS.
- Do not add `web/`, `linux/`, `macos/`, or `windows/` scaffolding unless the user explicitly changes the product scope.
- Keep the app simple while the backend is not defined: use mocks behind clear boundaries and avoid speculative infrastructure.

## Architecture

- Preserve the feature-based structure established in `lib/features/`.
- Put shared visual foundations in `lib/core/design_system/`.
- Put shared non-domain widgets in `lib/core/widgets/` only when they do not belong to a single feature.
- Keep domain models close to their owning feature.
- Reuse a single domain model and mock source across screens. Do not duplicate candidate or proposal data in profile, comparator, or santinho flows.
- Prefer dependency inversion when business rules depend on storage, APIs, or platform integrations.
- Introduce abstractions only when they reduce coupling, improve testability, or represent a stable domain concept.

## Design System

- Use the GOV.BR-DS adaptation as the visual foundation and the Figma prototype as the composition reference.
- Apply the Rawline font family globally through `AppTheme`. All screens and components must inherit Rawline.
- Prefer semantic tokens from `lib/core/design_system/tokens/` for colors, spacing, radius, and typography.
- Avoid raw colors, spacing, radius, and typography literals in shared components when an existing token expresses the same meaning.
- Model feature-specific candidate accent colors explicitly when they communicate candidate identity.
- Keep mobile layouts responsive. Avoid rigid heights around text when they can cause overflow under text scaling or narrow viewports.
- Keep touch targets accessible, provide labels or tooltips for icon-only actions, and preserve readable contrast.
- Use the Figma santinho hierarchy: candidate image as the main visual, clear identity overlay, highlighted official number, primary save action, and secondary outlined proposal action.
- Visible actions must work or be explicitly documented as prototype mocks.

## Workflow

1. Restate expected behavior and why it matters.
2. Define contracts, inputs, outputs, and edge cases before implementation.
3. Inspect the current implementation and preserve relevant collaborator work.
4. Add or update behavior-focused tests.
5. Implement incrementally with scoped changes.
6. Run formatting, static analysis, tests, and relevant mobile build validation.
7. Report trade-offs, remaining mocks, and test gaps.

## Code Quality

- Preserve the current architecture and code style unless a targeted refactor has a clear justification.
- Prefer small modules with focused responsibilities.
- Explain design decisions in comments only when the code cannot communicate them clearly.
- Remove dead code, empty files, duplicate models, and unused scaffolding.
- Do not import branch content blindly. Selectively bring code, assets, and dependencies that belong to the Flutter mobile app.

## Git Hygiene

- Do not commit `node_modules/`, `.codex/`, editor-local configuration, or Node tooling added only for local experimentation.
- Do not discard existing user changes.
- When a collaborator branch contains generated or local-only files, import the useful Flutter files selectively.
- Do not run `flutter clean` or remove `.dart_tool/` while a developer session is using `flutter run`; it breaks hot reload until `flutter pub get` regenerates package metadata.

## Testing

- Prefer tests that verify behavior instead of implementation details.
- Cover the main flow, validation errors, navigation, responsive layout regressions, and callback behavior.
- Run at minimum:

```bash
dart format --set-exit-if-changed .
flutter analyze
flutter test
git diff --check
git diff --cached --check
```

## Optional Tooling

- If the `run_pipeline` MCP tool is available, prefer it for indexed repository context.
- If it is unavailable, continue with local Git and filesystem tools and state the fallback. Optional tooling must not block repository work.
