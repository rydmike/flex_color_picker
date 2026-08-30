---
name: code-documentation
description: Update Dart documentation for completeness and helpfulness in FlexColorPicker. Use when the user asks for documentation, and when creating or updating public API, comments, README, or CHANGELOG.
---

# Code Documentation

Document intent and purpose so humans and agents can maintain this package. The user may request a scope: file(s), folder(s), a selected change, or uncommitted work.

**Never** document the entire repository in one pass.

## Existing comments

- Do not remove or shorten comments unless the user asks, or the comment is stale, wrong, or refers to removed APIs.
- When you touch a comment, leave it more accurate than before.

## Completeness

- Public classes, enums, constructors, and members in `lib/` need `///` dartdoc. `public_member_api_docs` is enforced on the package; the example app turns it off.
- Private helpers use `//`. Terse is fine when the code is obvious; add more when the logic is not (HSV wheel math, paste parsing, tonal HCT, FocusNode lifetime).
- Explain purpose, defaults, and how parameters interact. Usage tutorials belong in README and [.agents/skills/flex-color-picker/SKILL.md](../flex-color-picker/SKILL.md), not in every member doc.

### Dartdoc references

- **`//` comments:** Do not use `[Type]` or `[member]`. Dartdoc does not resolve them there. Use ASCII backticks.
- **`///` comments:** Use `[Type]` / `[member]` only when the symbol is in dartdoc scope (same rules as analyzer unresolved-identifier warnings). If it is not in scope, use backticks. Do not add imports only to bring a symbol into doc scope.
- Unresolved references in `///` produce analyzer info-level issues that fail CI.

### Language

- Use simple, direct language. Avoid jargon that does not help.
- Short `dart` snippets on `ColorPicker`, dialogs, and `pickersEnabled` are welcome when they show a default, an interaction, or a migration. Do not paste the README.

### Magic numbers

- Prefer a named local or static constant when a number is reused or its meaning is not obvious from context.
- Document what the value is, what it does, and how it was chosen when that is known (Material shade index, wheel diameter clamp, recent-color limits).

## Verify claims against code

Any doc comment stating a number (default, count, range, version) must be verified against its source of truth before you write or keep it. Sources of truth:

- `ColorPicker` constructor defaults in [color_picker.dart](../../../lib/src/color_picker.dart) — `enableOpacity` **false**, `enableTonalPalette` **false**, `enableShadesSelection` **true**, `showColorCode` / `showRecentColors` **false**, `maxRecentColors` **5** (assert 2–20), `wheelDiameter` **190**
- `pickersEnabled` default map in the same constructor — `primary` and `accent` true; `both`, `bw`, `custom`, `customSecondary`, `wheel` false. Missing keys in a caller map keep these defaults.
- `ColorPickerCopyPasteBehavior` defaults in [color_picker_copy_paste_behavior.dart](../../../lib/src/models/color_picker_copy_paste_behavior.dart) — `ctrlC`/`ctrlV` true; toolbar copy/paste buttons false; `copyFormat` `dartCode`; menus false
- Dialog return types: `ColorPicker.showPickerDialog` → `Future<bool>`; `showColorPickerDialog` → `Future<Color>` (start color if cancelled)

Historic traps — claims that keep resurfacing stale:

- `colorCodeIcon` was **removed** in 4.0.0 (deprecated since 2.0.0). Copy icon is `copyPasteBehavior.copyIcon` / `ColorPickerCopyPasteBehavior.copyIcon`.
- Relative imports / `always_specify_types`: lint v3.0 uses **package imports** and `always_specify_types` is **off**.
- Material/Cupertino widgets come from `material_ui` / `cupertino_ui` (Flutter 3.47), not `package:flutter/material.dart`.
- FlexSeedScheme is a **tonal-palette** dependency, not a `ColorScheme.fromSeed` replacement inside this package.
- Coverage is a **~93% baseline**, not a 100% requirement.

## Public API docs

On `ColorPicker`, `showColorPickerDialog`, `ColorPickerCopyPasteBehavior`, and `ColorTools`, cover:

- What the API is for and when to choose it (embedded vs dialog vs convenience dialog)
- Defaults and interactions (`pickersEnabled` sparse maps; custom types need swatch maps; opacity vs copy format alpha)
- Breaking or default-flip history when it still affects callers (`colorCodeIcon`, SDK-decoupled Material)

## On-demand extras

Only when the user asks, or when the change is user-facing:

- Update README and CHANGELOG for behavior or API that consumers will notice
- Keep comments in `example/` accurate, especially `example/lib/demo/` and `example/lib/main.dart`

Do not create per-folder README files under `lib/`.
