---
name: code-review
description: Review FlexColorPicker changes for correctness, API stability, coverage, and conventions. Use when reviewing a pull request, branch, or uncommitted diff, or when the user asks for a code review.
---

# Code Review

Review the requested scope: current branch, given files or folders, a specific change, or all uncommitted work.

When reviewing the **entire current branch**, start from its real base (usually `master`). Do not review merge commits from other branches. Limit the review to work actually done on this branch.

## Summary

First explain intent: what changed, why, and how it is implemented. Call out user benefit and impact on the published API. Use a mermaid flowchart only when a new picker path is hard to follow in prose.

## Principles

Find issues automated review bots would flag, before they do.

### Structure

- Number findings by **major**, **medium**, **minor**.
- Say what is good as well as what is bad.
- Be direct and polite.

### Complexity

Prefer simple, clear code. Flag over-engineering that does not add value. Suggest simplifications that keep behavior unchanged. Prefer a config object or sub-widget over adding more `ColorPicker` constructor parameters when the surface is already large.

### Dead code

Unused variables, functions, classes, consts, and commented-out blocks.

### Logging, documentation, tests

- This package has no app logging stack. Do not ask for log statements. The `_debug` flag in `ColorPicker` (`const bool _debug = !kReleaseMode && false`) is intentional; do not turn it on in commits.
- Documentation: public `///` on `lib/` API; comments on non-obvious paths. Path moves must update imports, comments, README, and example — not only Dart imports.
- Testing: package `lib/` must stay at **100%** instrumented coverage. Flag missing branches (both sides of conditions, IDE-visible hits). See [.agents/skills/package-development/SKILL.md](../package-development/SKILL.md).

Ignore generated file churn (`coverage/`, `build/`, `.dart_tool/`).

## Package review checks

Classify by real impact (major / medium / minor).

### API stability

- New required parameters, renamed public symbols, or default flips. `colorCodeIcon` removal in 4.0.0 is the cautionary case — replacements must be documented (`copyPasteBehavior.copyIcon`).
- Expanding [`lib/flex_color_picker.dart`](../../../lib/flex_color_picker.dart) needs demand and a stability review.
- Dialog return types must stay as documented: `showPickerDialog` → `bool`; `showColorPickerDialog` → `Color` (start color on cancel).

### Coverage

- New public and private branches should be tested. Package `lib/` coverage must stay at **100%** of instrumented lines; an unexplained drop is major. Documented `coverage:ignore` is acceptable only for code that cannot execute (compile-time-false `_debug`, unused private constructors) or that Dart omits from the hitmap (super-initializer constructors, trivial null-returns). Cover both sides of conditions so IDE/branch coverage matches lcov.
- Unexplained churn in wheel/opacity painters or the `ColorTools` named-color table is major.

### Flutter 3.47 / color values

- Material/Cupertino widgets stay on `material_ui` / `cupertino_ui`. Rewriting to `package:flutter/material.dart` is major.
- Do not reintroduce deprecated `Color.value` or `.red` / `.green` / `.blue` / `.alpha`. Use `value32bit` / `*8bit`.

### Widgets and platform

- `FocusNode`s created by the picker or `ColorIndicator` must be disposed.
- Copy-paste: Ctrl vs Command, long-press vs secondary-click flags, and parse-all-formats on paste. Changing defaults of `ColorPickerCopyPasteBehavior` is user-visible.
- Wheel `shouldRepaint` / `shouldUpdate` must stay correct; casual painter refactors without tests are major.

### Docs and example

- README, dartdoc, and `example/lib/demo/` stay aligned for user-facing behavior. The simple `example/lib/main.dart` should still compile.
- CHANGELOG section tags when the change will ship.

### Analyzer and format

- `dart format` and `dart analyze` clean. New `// ignore:` needs a reason that survives being read aloud.
  
## Reporting

Use GitHub-friendly markdown: `#` / `##` / `###` headings, numbered lists. Follow [AGENTS.md](../../../AGENTS.md) Markdown Style (one paragraph or bullet per line; do not hard-wrap prose). Do **not** use wide tables or `::code-comment` fences (GitHub cannot parse the latter).

### Implementation analysis

If a simpler approach would reach the same outcome, show it with a snippet. If the change is sound, do not invent noise.

### Fix suggestions

For each numbered finding, give an adoptable snippet and any extra tests (numbered `CPI*` / `PAT*` groups or util tests) that should land with the fix.

## Summary counts

- Issues by level: major, medium, minor
- Fix suggestions
- Additional tests suggested
