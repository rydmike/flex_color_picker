---
name: flex-color-picker
description: Use FlexColorPicker to embed or dialog a Material/custom/wheel color picker with optional tonal palettes, opacity, and copy-paste. Use when adding ColorPicker, showColorPickerDialog, ColorIndicator, ColorTools, or ColorPickerCopyPasteBehavior.
---

# Using FlexColorPicker

Copy this skill into a consuming app’s `.agents/skills/` or `.cursor/skills/`. It does not depend on this repository’s `AGENTS.md`.

Galleries and longer prose: [pub.dev/packages/flex_color_picker](https://pub.dev/packages/flex_color_picker). Live demo: https://rydmike.com/flexcolorpicker

```yaml
dependencies:
  flex_color_picker: ^4.0.0
```

Import the barrel only:

```dart
import 'package:flex_color_picker/flex_color_picker.dart';
```

Do not import `package:flex_color_picker/src/...` from an app.

## Entry points

| API                            | Returns                      | When                                                              |
| ------------------------------ | ---------------------------- | ----------------------------------------------------------------- |
| `ColorPicker` widget           | paints in place              | Embedded in a page, card, or drawer                               |
| `ColorPicker.showPickerDialog` | `Future<bool>` (OK / cancel) | You already have a configured `ColorPicker`                       |
| `showColorPickerDialog`        | `Future<Color>`              | Convenience dialog; **cancel or dismiss returns the start color** |

`onColorChanged` is required. The picker does not own the selected color — the parent must `setState` (or equivalent). Await dialog calls.

```dart
ColorPicker(
  color: currentColor,
  onColorChanged: (Color color) => setState(() => currentColor = color),
)
```

```dart
final Color result = await showColorPickerDialog(context, currentColor);
```

## Which pickers show

`pickersEnabled` is a `Map<ColorPickerType, bool>`. Omitted keys keep their **defaults**. Types not enabled do not appear.

Default: `primary` and `accent` on; `both`, `bw`, `custom`, `customSecondary`, `wheel` off.

```dart
pickersEnabled: const <ColorPickerType, bool>{
  ColorPickerType.wheel: true, // others keep defaults
},
```

`ColorPickerType.custom` / `customSecondary` also need a non-empty `customColorSwatchesAndNames` (or the secondary map). An enabled custom picker with an empty map is hidden.

Shades of a selected swatch: `enableShadesSelection` (default **true**). Grey index 850: `includeIndex850` (default false).

## Tonal, opacity, wheel

These are **picker features**, not FlexSeedScheme `ColorScheme` generation. Do not call `SeedColorScheme.fromSeeds` to drive this widget.

- `enableTonalPalette` (default **false**) — Material 3 HCT tonal row from the selected color.
- `enableOpacity` (default **false**) — alpha slider. Copy strings omit alpha when `copyFormat` has no alpha channel.
- Wheel: enable `ColorPickerType.wheel`. Tune `wheelDiameter` (100–500), `wheelWidth`, square padding/radius.

## Copy-paste

Configure with `ColorPickerCopyPasteBehavior`. Keyboard shortcuts use Ctrl on Windows/Linux and Command on macOS (`ctrlC` / `ctrlV`, default true). Toolbar copy/paste buttons default **off**. Long-press vs secondary-click menus are off until you set the platform flags (`longPressMenu`, `secondaryMenu`, `secondaryOnDesktopLongOnDevice`, `secondaryOnDesktopLongOnDeviceAndWeb`).

`copyFormat` (`ColorPickerCopyFormat`) is copy-only. Paste parses **all** formats, plus 3-char `#RGB` when `parseShortHexCode` is true.

The copy icon on the code field is `ColorPickerCopyPasteBehavior.copyIcon`. The old `colorCodeIcon` parameter was removed in 4.0.0.

## Recent colors, names, code field

- `showRecentColors` (default false) — parent must keep `recentColors` and handle `onRecentColorsChanged`. `maxRecentColors` is 2–20 (default 5).
- `showMaterialName` / `showColorName` / `showColorCode` default false.
- `ColorTools` static English names can be overwritten at startup for i18n (`ColorTools.redName = 'Röd'`).

## Other exported widgets

- `ColorIndicator` — tappable color chip (also used inside the picker).
- `ColorWheelPicker` — standalone HSV wheel.
- `ColorCodeField` — hex edit field.
- Extensions: `Color.hex` / `hexAlpha`; `String.toColorShort`; `value32bit` / `*8bit` channels on `Color` (use these to persist a `Color`, not deprecated `Color.value`).

## Do not

- Import `src/` or construct internal widgets (`MainColors`, `CopyPasteHandler`, …)
- Skip `onColorChanged` or forget to update parent state
- Enable `custom` without swatch maps
- Use `showColorPickerDialog` without `await`
- Treat a tonal row as a `ColorScheme` seed pipeline
