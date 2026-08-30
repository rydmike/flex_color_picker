---
name: release
description: Release FlexColorPicker to pub.dev and deploy the web demo. Use when publishing a new version, making a dev/prerelease, bumping the version, tagging a release, or verifying release readiness.
---

# Release

Releases are manual and ordered. Publishing to pub.dev does NOT deploy the web demo — publishing a **GitHub release** does, via [.github/workflows/deploy.yml](../../../.github/workflows/deploy.yml).

## Versioning

- `version:` lives in [pubspec.yaml](../../../pubspec.yaml). CHANGELOG top section heading must match it, with a `**Mon DD, YYYY**` date line.
- Prereleases for testing on pub use `-dev.N` (example: `4.0.1-dev.1`), released with a `chore:` commit. The final version gets its own CHANGELOG heading; fold the dev-release notes into it.
- Flutter's guidance: a bump of the required Flutter SDK is a **major** release even with no API changes — state that explicitly in the CHANGELOG (see 4.0.0).

## Pre-flight (all must pass)

```bash
fvm flutter pub get
(cd example && fvm flutter pub get)
fvm dart analyze
fvm dart format --output=none --set-exit-if-changed .
fvm flutter test --coverage
dart pub publish --dry-run
```

Also verify:

- CHANGELOG top section: correct version, date, and tags (`BREAKING`, `FIX`, `CHANGE`, `NEW`, `TESTS`, `CHORE`; `PACKAGE`, `WEB DEMO` when they apply).
- Package `lib/` coverage is **100%** of instrumented lines (`fvm flutter test --coverage`, example excluded). Do not publish with a dip unless it is only documented `coverage:ignore` for code that cannot run or that Dart omits from the hitmap.
- README and `example/` updated for any user-facing change; README web-demo links point at https://rydmike.com/flexcolorpicker (`/flexcolorpicker/` on GitHub Pages).
- No dry-run warnings you cannot explain, and review the dry-run archive file tree. A **multi-MB jump** means `resources/` or other internal docs leaked in. Expect a small archive: package + example + the five pubspec-declared screenshots, plus `assets/opacity.png`.

## Publishing contents — .pubignore

The root [.pubignore](../../../.pubignore) controls what is published:

- A `.pubignore` REPLACES the `.gitignore` in the same directory for publishing decisions. When adding publishing-relevant rules to the root `.gitignore`, mirror them in `.pubignore` — otherwise gitignored files reappear in the archive.
- It excludes internal content from the archive: `AGENTS.md`, `docs/`, `scripts/`, and `resources/` (README images load from GitHub blob/`raw=true` URLs; pub.dev does not need them). Excluding `docs/` also avoids pub's "rename docs to doc" layout warning.
- **Never exclude `assets/`**: `assets/opacity.png` is a runtime asset (`AssetImage(..., package: 'flex_color_picker')`).
- **Never exclude `example/screenshots/`**: those files are declared in the pubspec `screenshots:` section and MUST be in the archive. The pub.dev SERVER rejects the upload if one is missing ("Screenshot ... is missing from archive") — the local dry run does NOT check this. Server-only checks like this are what "The server may enforce additional checks" means; a clean dry run is necessary but not sufficient.
- Hidden dot-directories (`.agents/`, `.github/`, `.claude/`, …) are always excluded by pub; they need no rules.
- The Flutter tool generated example platform files (`generated_plugin_registrant.*`, `generated_plugins.cmake`, `GeneratedPluginRegistrant.swift`) and `coverage/lcov.info` are deliberately untracked. `flutter pub get` regenerates the example files. Do not re-add them to git — pub warns (and dry-run fails) on checked-in files that `.gitignore` also ignores.

## Publish

1. Commit and push; PR to `master` if not already there. CI (test.yml) must be green.
2. `dart pub publish` — manual, interactive; the user runs it or explicitly asks for it.
3. Tag `X.Y.Z` and publish a **GitHub release** with the CHANGELOG section as body.
4. The GitHub release triggers deploy.yml: analyze → format check → tests → Codecov → `flutter build web --base-href "/flexcolorpicker/" --release --target=lib/demo/main.dart` → push to `rydmike/rydmike.github.io` (`flexcolorpicker` folder). A new demo path needs deploy.yml **and** README links updated together. Test deploys use `/flexcolorpickertest/` via `deploy_test.yml`.

## Post-release

- Check the pub.dev page: version, score, changelog rendering, screenshots.
- Check https://rydmike.com/flexcolorpicker serves the new build.

## Do not

- Publish with failing/red CI or package `lib/` coverage below 100% of instrumented lines (except documented `coverage:ignore` for code that cannot run or that Dart omits from the hitmap).
- Create the GitHub release before pub publish succeeded (the demo would advertise an unpublished version).
- Edit released CHANGELOG sections later — corrections get a new entry.
- Exclude `assets/` or `example/screenshots/` from `.pubignore`.
