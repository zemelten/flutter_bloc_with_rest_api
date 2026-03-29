## Contributing to flutter_bloc_with_rest_api

Thank you for considering contributing! This document outlines how to set up your environment, the preferred workflow, coding standards, and how to submit changes.

---

## Table of Contents
- Getting Started
- Development Workflow
- Branching Strategy
- Commit Messages
- Code Style and Quality
- Testing
- Pull Requests
- Issue Reporting
- Security
- License

---

## Getting Started
1. Fork the repository and clone your fork.
2. Ensure you have Flutter installed and on a stable channel compatible with Dart `^3.9.2`.
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Configure the API base URL if needed:
   - Update `lib/core/network/api_provider.dart` (`baseUrl`, endpoints).
5. Run the app:
   ```bash
   flutter run
   ```

Optional: If you wire the app to boot the DI + Auth flow, make sure `initDependencies()` is invoked before `runApp(...)`.

---

## Development Workflow
- Open or create an issue describing the change you want to make.
- Create a feature branch from `main`:
  ```bash
  git checkout -b feat/short-descriptor
  ```
- Make your changes in small, logically separated commits.
- Keep PRs focused and scoped; avoid unrelated refactors.

---

## Branching Strategy
- `main`: always green; must pass CI; reviewed and approved changes only.
- Feature branches: `feat/*`
- Bug fixes: `fix/*`
- Chores or tooling: `chore/*`
- Docs: `docs/*`

Examples:
- `feat/auth-login-form-validation`
- `fix/dio-timeout-handling`
- `docs/readme-setup-section`

---

## Commit Messages
Use Conventional Commits to make history readable and automatable:
- `feat: add login use case`
- `fix: handle 401 error in remote datasource`
- `docs: update API configuration section`
- `chore: bump flutter_bloc to 9.1.1`
- `refactor: extract dio client header builder`
- `test: add auth bloc happy-path test`

Scope is optional but recommended: `feat(auth): persist token in shared preferences`.

---

## Code Style and Quality
- Follow Flutter/Dart best practices and the existing style in the repository.
- Run formatters and linters before committing:
  ```bash
  dart format .
  flutter analyze
  ```
- Prefer readable, descriptive names and small, focused functions.
- Keep comments minimal and meaningful (why over what).
- Avoid catching exceptions without meaningful handling.
- Respect the Clean Architecture layering already present:
  - Presentation (BLoC, pages, widgets)
  - Domain (entities, repositories, use cases)
  - Data (datasources, models, repository impl)
  - Core (network, error handling, utilities)
- For DI, register new services in the appropriate module under `lib/injection/modules/`.

---

## Testing
- Add or update tests when changing behavior.
- Run all tests locally:
  ```bash
  flutter test
  ```
- Prefer testing:
  - Use cases (pure domain logic)
  - Repositories (with mocked datasources)
  - BLoCs (state transitions for events)

---

## Pull Requests
Before opening a PR:
- Ensure the app builds and runs.
- Ensure `dart format .` results in no changes.
- Ensure `flutter analyze` is clean.
- Ensure `flutter test` passes.
- Update documentation if needed (README or inline docs).

PR checklist:
- Clear title using Conventional Commit style.
- Linked issue (if applicable).
- Brief description of the change and reasoning.
- Screenshots/GIFs for UI-affecting changes.

---

## Issue Reporting
When filing an issue, include:
- Expected vs. actual behavior
- Steps to reproduce
- Flutter and Dart versions (`flutter --version`)
- Logs or error messages
- Screenshots for UI issues

Feature requests:
- Describe the problem and the proposed solution or alternatives.
- Explain how it fits the project’s scope (Flutter + BLoC + REST + Clean Architecture).

---

## Security
If you discover a security vulnerability, please avoid filing a public issue. Instead, contact the maintainer directly or use a private channel to disclose responsibly.

---

## License
By contributing, you agree that your contributions will be licensed under the project’s MIT license.

