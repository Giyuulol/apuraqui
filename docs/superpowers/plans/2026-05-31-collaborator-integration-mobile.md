# ApurAqui Collaborator Integration Plan

## Objective

Build a clean Android+iOS Flutter integration using Rafael's feature architecture, Alex's useful flows, Luiz's shared states, GOV.BR-DS tokens, and Rawline typography.

## Tasks

1. Refine repository instructions and remove unsupported platform scaffolding.
2. Add behavior tests for login, home navigation, candidate responsiveness, comparator domain reuse, and shared state callbacks.
3. Selectively import Rafael's feature folders, icons, images, and `flutter_svg` dependency.
4. Move login into `features/auth` and route successful mock authentication to the home shell.
5. Move comparator into `features/comparador` and consume `CandidateProfile`, `GovernmentPlanItem`, and `candidatesMock`.
6. Refactor Luiz's exception screens into shared state views.
7. Fix Rafael's candidate selector overflow and wire visible proposal actions.
8. Remove legacy duplicate paths and update project documentation.
9. Format and verify the mobile project.
