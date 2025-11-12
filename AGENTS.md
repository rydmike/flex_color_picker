# Repository Guidelines

## Project Structure & Module Organization
FlexColorPicker ships as a Flutter package. Core widgets, theming utilities, and helpers live under `lib/`, while renderer-specific resources (icons, tone charts, demo screenshots) are in `assets/` and `resources/`. Integration and showcase code is under `example/`, with the interactive demo in `example/lib/demo`. Tests reside in `test/` and mirror the `lib/` layout; keep new fixtures beside the code they cover. Generated artifacts (`build/`, `coverage/`) should stay untracked unless explicitly requested.

## Build, Test, and Development Commands
- `flutter pub get` — sync dependencies; run in the repo root and again inside `example/` when its pubspec changes.
- `flutter analyze` — static analysis enforced by `analysis_options.yaml`; treat warnings as blockers.
- `dart format lib test example` — formats affected files with 2-space indentation and trailing commas.
- `flutter test` — runs the package test suite; add `--coverage` to refresh `coverage/lcov.info`.
- `flutter run example/lib/main.dart` — launches the sample app for manual QA; pass `-d chrome` or `-d macos` when targeting specific platforms.

## Coding Style & Naming Conventions
The repo follows `RydMike` lint set v2.5.0. Prefer `const` constructors, `final` locals, and guard clauses over nested conditionals. Public APIs require `///` doc comments and meaningful parameter names (`pickerType`, `tonalPalette`). Use lowerCamelCase for variables/functions, UpperCamelCase for classes, and prefix test-only helpers with `_test`. Keep import sections ordered: Dart SDK, Flutter, packages, relative paths.

## Testing Guidelines
Add or update `*_test.dart` files next to the feature they exercise. Widget tests should assert both color-selection behavior and semantic labels; data utilities belong in pure Dart tests. Maintain code coverage near the current Codecov baseline; when coverage dips, explain why in the PR and justify via manual QA steps. Snapshot assets belong under `test/golden/` with stable device metrics.

## Commit & Pull Request Guidelines
Follow the lightweight `Type: Summary` style seen in history (`Add:`, `FIX:`, `Chore:`). Limit subject lines to 72 characters, with additional detail in the body if behavior changes. Each PR must describe user-visible effects, link related issues, and include before/after screenshots when UI diffs occur. Confirm `flutter analyze`, `dart format`, and `flutter test` outputs in the PR description before requesting review.
