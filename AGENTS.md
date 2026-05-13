# Project Instructions for Codex

## Communication

- Respond to the user in Portuguese.
- Keep technical terms in English when they are standard in software engineering, such as dependency injection, interface segregation, repository, controller, service, use case, adapter, and event-driven architecture.
- Be direct, technical, and structured.
- Explain reasoning before implementation when the task involves design, architecture, or non-trivial code changes.

## Learning-Oriented Workflow

For implementation, architecture, or debugging tasks, follow this structure:

1. Problem understanding: restate what needs to be solved and why it matters.
2. Reasoning and decisions: explain the main design choices before applying them.
3. Step-by-step execution: build the solution incrementally.
4. Commented implementation: include comments that explain design decisions, not obvious syntax.
5. Critical review: explain trade-offs, simplifications, risks, and possible improvements.

## Spec-Driven Development

Prefer Spec-Driven Development before implementation:

1. Define the expected behavior.
2. Define contracts, interfaces, types, input/output shapes, or function signatures.
3. Define use cases and edge cases.
4. Implement only after the contract is clear.
5. Suggest or add tests aligned with the specification.

## Architecture Principles

- Prefer maintainable, testable, and scalable designs.
- Use SOLID principles when relevant, and explicitly name the principle being applied.
- Prefer dependency inversion when business rules depend on external systems, frameworks, databases, APIs, or UI layers.
- Keep business rules independent from infrastructure details.
- Favor small, focused modules with clear responsibilities.
- Avoid unnecessary abstractions; introduce abstractions only when they reduce coupling, improve testability, or model a stable domain concept.

## Design Patterns

- Name relevant design patterns when they are used, such as Strategy, Factory, Adapter, Repository, Observer, Command, or Dependency Injection.
- Justify why the pattern fits the current problem.
- Mention trade-offs when a pattern adds complexity.
- Avoid applying patterns mechanically when a simpler solution is enough.

## Code Quality

- Prefer complete, working code over isolated snippets.
- Preserve the existing style and architecture of the project.
- Keep changes scoped to the requested task.
- Identify code smells and anti-patterns when they appear.
- Suggest refactorings with technical justification.
- Do not rewrite large areas of code without first explaining the reason.

## Testing

- Suggest tests for the main use cases, edge cases, and failure paths.
- Prefer tests that verify behavior instead of implementation details.
- When possible, align test cases with the previously defined specification.
- Mention remaining test gaps if full coverage is not practical.

## Review Style

When reviewing code:

1. List issues first, ordered by severity.
2. Explain why each issue matters.
3. Suggest targeted refactorings.
4. Only then provide a refactored version when useful.

## System Design Expectations

When discussing system design or architecture:

- Mention relevant architectural styles, such as MVC, Clean Architecture, Hexagonal Architecture, layered architecture, event-driven architecture, or microservices.
- Consider scalability, maintainability, testability, observability, and operational complexity.
- Explain trade-offs clearly.
- Prefer simple architecture until there is a concrete reason to add distributed complexity.

## vexp <!-- vexp v2.0.12 -->

**MANDATORY: use `run_pipeline` — do NOT grep or glob the codebase.**
vexp returns pre-indexed, graph-ranked context in a single call.

### Workflow
1. `run_pipeline` with your task description — ALWAYS FIRST (replaces all other tools)
2. Make targeted changes based on the context returned
3. `run_pipeline` again only if you need more context

### Available MCP tools
- `run_pipeline` — **PRIMARY TOOL**. Runs capsule + impact + memory in 1 call.
  Auto-detects intent. Includes file content. Example: `run_pipeline({ "task": "fix auth bug" })`
- `get_skeleton` — compact file structure
- `index_status` — indexing status
- `expand_vexp_ref` — expand V-REF placeholders in v2 output

### Agentic search
- Do NOT use built-in file search, grep, or codebase indexing — always call `run_pipeline` first
- If you spawn sub-agents or background tasks, pass them the context from `run_pipeline`
  rather than letting them search the codebase independently

### Smart Features
Intent auto-detection, hybrid ranking, session memory, auto-expanding budget.

### Multi-Repo
`run_pipeline` auto-queries all indexed repos. Use `repos: ["alias"]` to scope. Run `index_status` to see aliases.
<!-- /vexp -->