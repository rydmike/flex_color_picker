# FlexColorPicker

FlexColorPicker (FCP) is a published Flutter color picker: Material primary/accent/custom swatches, an HSV wheel, optional Material 3 tonal palettes, opacity, and desktop-aware copy-paste. Breaking public API changes need discussion. Documentation quality and tests are required. Package `lib/` coverage (example excluded) must stay at **100%** of instrumented lines.

SDK constraints live in `pubspec.yaml`. Use `fvm flutter` locally (`.fvmrc` tracks `stable`).

## Agent configuration

`AGENTS.md` is the only instruction master. Skills live in `.agents/skills/`.

Claude Code uses generated `CLAUDE.md` and a generated skills mirror. Recreate them after master edits:

```bash
./scripts/sync_claude_code_config.sh
```

The script rewrites skill paths for Claude. Optional teardown: `./scripts/delete_claude_code_config.sh`. Never hand-edit generated Claude files. Cursor: keep **Include third-party Plugins, Skills, and other configs** off so the generated mirror is not loaded twice. Details: [scripts/README.md](scripts/README.md).

## Skills

Load the matching skill; do not paste their contents into this file.

| Skill                                                                                      | When                                                         |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------ |
| [.agents/skills/package-development/SKILL.md](.agents/skills/package-development/SKILL.md) | Changing `lib/`, `test/`, `example/`, or CI                  |
| [.agents/skills/flex-color-picker/SKILL.md](.agents/skills/flex-color-picker/SKILL.md)     | Using the package (`example/`, or copy into a consuming app) |
| [.agents/skills/code-documentation/SKILL.md](.agents/skills/code-documentation/SKILL.md)   | Writing or updating dartdoc and comments                     |
| [.agents/skills/code-review/SKILL.md](.agents/skills/code-review/SKILL.md)                 | Reviewing a branch, PR, or uncommitted diff                  |
| [.agents/skills/release/SKILL.md](.agents/skills/release/SKILL.md)                         | Publishing to pub.dev, tagging, web demo deploy              |

## Commands

`example/` is a separate package, not a pub workspace.

```bash
fvm flutter pub get
(cd example && fvm flutter pub get)
fvm dart format lib test example
fvm dart analyze
fvm flutter test --coverage
```

`dart format --fix` no longer exists in Dart 3.13; use plain `dart format` (lint fixes: `dart fix --apply`). Prefer the `fvm dart` / `fvm flutter` prefix so the pinned SDK is used.

CI also runs `dart format --output=none --set-exit-if-changed .`. Optional local HTML: `genhtml coverage/lcov.info -o coverage/html`. Never hand-edit `coverage/` or `build/`.

## Layout

- `lib/flex_color_picker.dart` — public barrel
- `lib/src/color_picker.dart` — main `ColorPicker` widget; `show_color_picker_dialog.dart` is a `part of` that file
- `lib/src/widgets/`, `lib/src/models/`, `lib/src/universal_widgets/`, `lib/src/functions/` — composed UI, config objects, private helpers
- `assets/opacity.png` — runtime asset for the opacity slider (must stay in the published package)
- `test/` — package tests (`flutter_test` + `patrol_finders`); no golden suite
- `example/` — simple `lib/main.dart` plus the full playground at `lib/demo/` (Riverpod + Hive)
- `resources/` — README images hosted from GitHub; not published
- `docs/guides/` — architecture and worktree notes

## Quality bar

- **Coverage:** keep package `lib/` at **100%** of instrumented lines (`fvm flutter test --coverage`, example excluded). Cover new branches, including both sides of conditions (IDE/branch coverage). Use documented `coverage:ignore` only for code that cannot run (compile-time-false `_debug` prints, unused private constructors) or that Dart omits from the hitmap (super-initializer constructors, trivial null-returns). An unexplained dip is a defect.
- **Docs:** `public_member_api_docs` is on for `lib/`. Unresolved dartdoc `[Type]` references fail CI. Explain *why* and how parameters interact; usage tutorials belong in README and the consume skill.
- **API:** no breaking public API without discussion. See [CONTRIBUTING.md](CONTRIBUTING.md). Do not expand the barrel without intent.
- **User-facing changes:** update `example/` (especially `example/lib/demo/`) and README. CHANGELOG sections: `BREAKING`, `FIX`, `CHANGE`, `NEW`, `TESTS`, `CHORE`.

## Style

`dart format` owns layout (`page_width: 120`, trailing commas preserved). Use package imports (`always_use_package_imports`). `always_specify_types` is **off**. PascalCase types, lowerCamelCase members, `_` for private. Match file names to the primary type (`color_picker.dart`, `color_tools.dart`).

Material and Cupertino widgets come from `package:material_ui/material_ui.dart` and `package:cupertino_ui/cupertino_ui.dart`, not `package:flutter/material.dart`. Persist `Color` with `value32bit` / `*8bit` channel extensions — never deprecated `Color.value` or `.red`.

`///` on public API; `//` on private helpers. In `//`, wrap names in backticks — never `[Type]`. In `///`, use `[Type]` only when the symbol is in dartdoc scope.

## Formatting Scope

- Do not run `dart format .` — it does not honor `.gitignore` or `analyzer: exclude` and may fail inside `build/` (see [dart-lang/dart_style#1840](https://github.com/dart-lang/dart_style/issues/1840)).
- Do not run formatting across the entire repo unless explicitly requested.
- Prefer formatting only the files you changed to keep diffs reviewable.

## Markdown Style

Applies to every markdown file in this repo (skills, `docs/`, README files) and to issue, PR, and review text you write:
- Use US English.
- Never insert line breaks inside a paragraph or a bullet item. One paragraph = one line. One bullet = one line.
- Let the IDE, GitHub, Slack, and agent previews wrap to the viewport; do not hard-wrap at 80/100 columns.
- Never reflow fenced code blocks, tables, or headings — the rule is about prose lines only.
- Avoid wide tables in anything rendered on GitHub; prefer compact lists. Tables are fine for short enumerable facts.

## Tests

Suites use numbered group names (`CPI1`, `PAT1`, `CWP1`, `FCE5`, …). Widget tests use `flutter_test`; large UI flows use `patrol_finders`. Tests may import `package:flex_color_picker/src/...` — that is existing practice, not a public API. Keep `lib/` at 100% instrumented coverage. Recipes: [package-development](.agents/skills/package-development/SKILL.md).

## Git and PRs

Tagged imperative messages (`FIX:`, `ADD:`, `CHORE:`, or existing `fix:` / `chore:` / `test:`), optional `#issue`. PRs target `master`. Summarize motivation, functional changes, example screenshots if UI, analyzer + test results, and any API or behavior risk.

## Worktrees

Cursor and Codex run `bash scripts/setup_worktree.sh` automatically. Claude Code does not — run it before the first `pub get`, test, or example run. Guide: [docs/guides/using-worktrees-guidance.md](docs/guides/using-worktrees-guidance.md).
