# ApurAqui Mobile Integration Design

## Goal

Integrate the useful collaborator work into Rafael's feature-based Flutter structure without importing branch pollution, duplicate models, or unsupported platforms.

## Supported Platforms

- Android
- iOS

Flutter scaffolding for web and desktop is intentionally removed.

## User Flow

1. The app starts on the login screen.
2. Invalid login input stays on the login screen and shows field validation.
3. Valid mock login opens the Rafael home shell.
4. The home shell exposes candidates, checklist, news, and santinhos through bottom navigation.
5. Proposal comparison reuses the candidate profile domain and is reachable from the product flow.

## Domain Contract

`CandidateProfile` is the source of truth for candidate identity and government proposals. The comparator must consume `candidatesMock` and `GovernmentPlanItem`; it must not define a second candidate model or proposal list.

## Shared UI Contract

- Rawline is the global application font.
- GOV.BR-DS semantic tokens provide the foundation.
- Figma defines component composition, especially for santinhos.
- Shared loading, empty, offline, and server-error states live outside feature-specific folders.
- Layout must remain usable on narrow mobile screens without text overflow.

## Selective Import Policy

Import Rafael's Flutter features, assets, and required Flutter dependencies. Do not import `node_modules`, `.codex`, editor configuration, or Node tooling.

Bring Alex's login and comparator behavior into `lib/features/auth/` and `lib/features/comparador/`. Bring Luiz's exception screens into a shared state-view component. Ignore empty files.

## Verification

- Login validation and mock navigation.
- Home navigation across Rafael features.
- Candidate card layout without overflow.
- Comparator based on profile domain mocks.
- Shared retry callback behavior.
- Formatting, analyzer, tests, diff checks, and Android debug build.
