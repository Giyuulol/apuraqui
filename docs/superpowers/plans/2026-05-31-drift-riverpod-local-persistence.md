# Drift and Riverpod Local Persistence Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Persist session, checklist progress, saved santinhos, and navigation preference locally using Drift/SQLite with reactive Riverpod state.

**Architecture:** Add a shared Drift database under `core/database`, repository interfaces close to each owning domain, and Drift adapters in feature data folders. Expose repositories and reactive streams through Riverpod providers while keeping SQLite details outside widgets.

**Tech Stack:** Flutter, Drift, SQLite, drift_flutter, flutter_riverpod, build_runner, drift_dev.

---

### Task 1: Add persistence packages

**Files:**
- Modify: `pubspec.yaml`

- [ ] Add Drift, `drift_flutter`, and `flutter_riverpod` dependencies.
- [ ] Add `build_runner` and `drift_dev` development dependencies.
- [ ] Run `flutter pub get`.

### Task 2: Define and verify the database contract

**Files:**
- Create: `test/core/database/app_database_test.dart`
- Create: `lib/core/database/app_database.dart`
- Generate: `lib/core/database/app_database.g.dart`

- [ ] Write failing in-memory tests for session, checklist, santinho, and preference persistence.
- [ ] Run the database test and verify the missing implementation failure.
- [ ] Define Drift tables and reactive query methods.
- [ ] Run `dart run build_runner build`.
- [ ] Run the database test and verify it passes.

### Task 3: Add repository boundaries

**Files:**
- Create: `lib/features/auth/domain/auth_session.dart`
- Create: `lib/features/auth/domain/session_repository.dart`
- Create: `lib/features/auth/data/drift_session_repository.dart`
- Create: `lib/features/votacao/domain/checklist_progress_repository.dart`
- Create: `lib/features/votacao/data/drift_checklist_progress_repository.dart`
- Create: `lib/features/santinho/domain/saved_santinhos_repository.dart`
- Create: `lib/features/santinho/data/drift_saved_santinhos_repository.dart`
- Create: `lib/core/preferences/app_preferences_repository.dart`
- Create: `lib/core/preferences/drift_app_preferences_repository.dart`
- Create: `test/features/auth/drift_session_repository_test.dart`

- [ ] Write failing repository behavior tests.
- [ ] Run the repository tests and verify the missing implementation failure.
- [ ] Add interfaces and Drift adapters.
- [ ] Run repository tests and verify they pass.

### Task 4: Expose dependencies through Riverpod

**Files:**
- Create: `lib/core/providers/persistence_providers.dart`
- Create: `lib/features/auth/application/auth_providers.dart`
- Create: `lib/features/votacao/application/checklist_progress_providers.dart`
- Create: `lib/features/santinho/application/saved_santinhos_providers.dart`
- Create: `lib/core/preferences/app_preferences_providers.dart`

- [ ] Add a shared `AppDatabase` provider with disposal.
- [ ] Add repository providers.
- [ ] Add session stream and authentication controller.
- [ ] Add checklist, santinho, and navigation stream providers.

### Task 5: Connect session lifecycle

**Files:**
- Modify: `lib/main.dart`
- Modify: `lib/features/auth/login_screen.dart`
- Modify: `lib/core/widgets/app_header.dart`
- Modify: feature pages using `AppHeader`
- Modify: `test/widget_test.dart`

- [ ] Write failing widget tests for demo login, startup session restore, and logout.
- [ ] Wrap the application with `ProviderScope`.
- [ ] Add `AuthGate`.
- [ ] Replace simulated login delay with the authentication controller.
- [ ] Expose logout from the shared header.
- [ ] Run widget tests and verify they pass.

### Task 6: Connect feature persistence

**Files:**
- Modify: `lib/features/votacao/checklist_documentos_page.dart`
- Modify: `lib/features/santinho/santinhos_page.dart`
- Modify: `lib/features/santinho/widgets/santinho_card.dart`
- Modify: `lib/main.dart`
- Create: `test/features/votacao/checklist_persistence_test.dart`
- Create: `test/features/santinho/santinho_persistence_test.dart`

- [ ] Write failing widget tests for persisted checklist and saved santinhos.
- [ ] Convert widgets to Riverpod consumers.
- [ ] Persist bottom-navigation selection.
- [ ] Run feature tests and verify they pass.

### Task 7: Verify the mobile integration

- [ ] Run `dart format --set-exit-if-changed .`.
- [ ] Run `dart run build_runner build`.
- [ ] Run `flutter analyze`.
- [ ] Run `flutter test`.
- [ ] Run `git diff --check`.
- [ ] Run `git diff --cached --check`.
- [ ] Run `flutter build apk --debug`.
- [ ] Run `flutter build ios --simulator`.
