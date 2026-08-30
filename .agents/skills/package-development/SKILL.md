---
name: package-development
description: Develop and maintain FlexColorPicker: public ColorPicker API, tests, 100% package coverage, example apps, material_ui/cupertino_ui. Use when editing this package's source, tests, example, or CI.
---

# Package development

Maintain FlexColorPicker as a public Flutter package. Consumer usage belongs in [.agents/skills/flex-color-picker/SKILL.md](../flex-color-picker/SKILL.md). Documentation and review conventions are separate skills. Widget hierarchy and data flow: [docs/guides/architecture.md](../../../docs/guides/architecture.md).

## Public vs internal

Barrel [`lib/flex_color_picker.dart`](../../../lib/flex_color_picker.dart) exports:

- `ColorPicker`, `showColorPickerDialog`
- `ColorIndicator`, `ColorWheelPicker`, `ColorCodeField`
- `ColorTools` and color/string extensions (`color_tools.dart`, `color_picker_extensions.dart`)
- Models: `ColorPickerType`, `ColorPickerActionButtons`, `ColorPickerCopyPasteBehavior`, and related enums

Not barrel-exported (dartdoc “Not library exposed”, not `@internal`):

- `lib/src/widgets/` except `ColorCodeField`
- `lib/src/universal_widgets/`
- `lib/src/functions/picker_functions.dart`

Do not expand the barrel without discussion. Tests may import `package:flex_color_picker/src/...`; apps must not.

`show_color_picker_dialog.dart` is `part of 'color_picker.dart'`. Never import the part file alone.

## Flutter 3.47 UI packages

Material and Cupertino widgets come from `package:material_ui/material_ui.dart` and `package:cupertino_ui/cupertino_ui.dart`. Do not rewrite those imports to `package:flutter/material.dart`.

Leave the multiple `show Color` imports in [`color_picker_extensions.dart`](../../../lib/src/color_picker_extensions.dart) alone — they exist so extensions resolve across the design packages.

Persist and compare `Color` with `value32bit` / `alpha8bit` / `red8bit` / `green8bit` / `blue8bit`. Do not reintroduce deprecated `Color.value` or `.red`.

## FlexSeedScheme in this package

Used only to build the optional tonal row (`Cam16.fromInt` + `FlexTonalPalette.of` in [`picker_functions.dart`](../../../lib/src/functions/picker_functions.dart)). This package does not generate `ColorScheme`s. Do not add `SeedColorScheme` call sites here.

## Do not edit without intent

- Wheel `CustomPainter`s in `color_wheel_picker.dart`
- Opacity track/thumb painters and [`assets/opacity.png`](../../../assets/opacity.png) (runtime `AssetImage(..., package: 'flex_color_picker')`)
- `ColorTools` Material name table and `nameThatColor` data
- Copy-paste platform flags in `ColorPickerCopyPasteBehavior` / `CopyPasteHandler`
- `coverage/`, `build/`, `.dart_tool/`
- Generated Claude mirrors (`CLAUDE.md`, `.claude/skills/`) — regenerate with `./scripts/sync_claude_code_config.sh`

## File map

| Task                      | Where                                                                                                     |
| ------------------------- | --------------------------------------------------------------------------------------------------------- |
| Orchestration, 50+ params | [`color_picker.dart`](../../../lib/src/color_picker.dart)                                                 |
| Dialog APIs               | [`show_color_picker_dialog.dart`](../../../lib/src/show_color_picker_dialog.dart) (`part of`)             |
| Copy format / paste parse | `models/color_picker_copy_paste_behavior.dart`, `copy_paste_handler.dart`, `color_picker_extensions.dart` |
| Opacity                   | `widgets/opacity/`                                                                                        |
| Tonal palettes            | `picker_functions.dart` `getTonalColors`, `widgets/tonal_palette_colors.dart`                             |
| Material names / swatches | [`color_tools.dart`](../../../lib/src/color_tools.dart)                                                   |
| HSV wheel                 | [`color_wheel_picker.dart`](../../../lib/src/color_wheel_picker.dart)                                     |

## Testing

Hold package `lib/` coverage at **100%** of instrumented lines. New branches need tests, including both sides of conditions so IDE/branch coverage stays green. Document `coverage:ignore` only when the code cannot run (compile-time-false `_debug` prints, unused private constructors) or Dart omits lines from the hitmap (super-initializer constructors, trivial null-returns). An unexplained dip is a defect. `fvm flutter test --coverage` at the repo root; do not include `example/`.

- `flutter_test` widget tests; numbered groups: `group('CPI1: In App With ColorPicker', …)`, `PAT1` (Patrol), `CWP1`, `FCE5`, `CPAB1`, …
- Large interaction flows: [`test/color_picker_patrol_test.dart`](../../../test/color_picker_patrol_test.dart) with `patrol_finders`
- Clipboard: [`test/clipboard_utils.dart`](../../../test/clipboard_utils.dart)
- Prefer a braced `if` body over `if (cond) return;` so lcov and the IDE both record the taken branch. If Dart still omits a trivial null-return from the hitmap (the lines never appear in lcov), wrap it in a documented `coverage:ignore` and keep a test that exercises the path.
- No golden/`test/golden/` suite. Do not add screenshot goldens unless the maintainers ask.
- Tests importing `src/` are fine. Prefer public barrel imports when testing exported API.

`example/test/widget_test.dart` is smoke only. It does not replace package unit tests.

| Change                          | Tests                                                                                         |
| ------------------------------- | --------------------------------------------------------------------------------------------- |
| `ColorPicker` param / lifecycle | `color_picker_test.dart` (`CPI1` / `CPI2`), `color_picker_coverage_test.dart` (`CPI3`–`CPI8`) |
| Dialog APIs                     | `show_color_picker_dialog_test.dart`                                                          |
| Copy-paste                      | `copy_paste_handler_test.dart`, behavior tests                                                |
| Wheel / opacity painters        | matching `color_wheel_*` / `opacity_slider_*` tests                                           |
| `ColorTools` / extensions       | `flex_color_tools_test.dart`, extension tests                                                 |

## Example

Two entry points (separate package, `publish_to: none`):

- [`example/lib/main.dart`](../../../example/lib/main.dart) — small embedded + dialog demo
- [`example/lib/demo/main.dart`](../../../example/lib/demo/main.dart) — full playground (Riverpod 2, Hive CE persistence). Live demo: https://rydmike.com/flexcolorpicker

User-facing picker behavior must show up in the demo (toggles live under `example/lib/demo/screens/color_picker/` and `pods/`). iOS and macOS are Swift Package Manager only — do not add CocoaPods.

On macOS, `example/lib/demo/pods/` is Dart Riverpod state, not CocoaPods. Keep `.gitignore` from using a generic `**/Pods/` rule that case-folds over that folder.

## Example and release

- CHANGELOG tags: `BREAKING`, `FIX`, `CHANGE`, `NEW`, `TESTS`, `CHORE` (also `PACKAGE`, `WEB DEMO` when those apply).
- Web demo deploys from `.github/workflows/deploy.yml` on GitHub **release**, not from `dart pub publish`. Publishing to pub.dev is manual.
- CI (pull requests and pushes to `master`): `dart analyze`, `dart format --output=none --set-exit-if-changed .`, `flutter test --coverage` → Codecov. Release deploys also upload coverage with `override_branch: master`.

## Lint config is published externally

[analysis_options.yaml](../../../analysis_options.yaml) is the versioned "RydMike LINTER Preferences" file (see its version header), publicly shared as a gist: https://gist.github.com/rydmike/fdb53ddd933c37d20e6f3188a936cd4c. [all_lint_rules.yaml](../../../all_lint_rules.yaml) is its companion all-rules list, manually maintained from https://dart.dev/tools/linter-rules/all.

When either file changes (rule toggled, severity changed, formatter setting, version bump):

1. Bump/update the version header comment in `analysis_options.yaml` when the change is a rule or config change (not for pure comment fixes).
2. Add a CHANGELOG `CHORE` note describing the rule change.
3. Remind the user to post the updated `analysis_options.yaml` to the gist — the gist is updated manually by the user and must stay in sync with rule changes here.

## Style reminders

Package imports, `dart format`, `public_member_api_docs` on `lib/`. Unresolved dartdoc `[Type]` fails CI. Details: [AGENTS.md](../../../AGENTS.md) and [.agents/skills/code-documentation/SKILL.md](../code-documentation/SKILL.md).
