# FlexColorPicker - Quick Reference Guide

## File Organization Quick Map

### Core Files (Read These First)
- `lib/src/color_picker.dart` - Main widget (start here)
- `lib/src/show_color_picker_dialog.dart` - Dialog implementation
- `lib/src/color_tools.dart` - Color utilities and Material color definitions
- `lib/src/models/` - Configuration objects (3 files)

### Widget Components
- `lib/src/widgets/color_code_field.dart` - Hex input field
- `lib/src/widgets/opacity_slider.dart` - Opacity control
- `lib/src/widgets/picker_selector.dart` - Picker type selector
- `lib/src/widgets/main_colors.dart` - Primary/accent grid
- `lib/src/color_wheel_picker.dart` - HSV wheel

### Utilities and Helpers
- `lib/src/color_picker_extensions.dart` - Color/String extensions
- `lib/src/functions/picker_functions.dart` - Internal algorithms
- `lib/src/universal_widgets/` - Reusable UI helpers
- `lib/src/color_indicator.dart` - Reusable color selector button

## Common Tasks and Where to Find Code

### Understanding Color Selection Flow
1. User taps ColorIndicator in MainColors widget
2. onSelect callback triggered in color_picker.dart state
3. onColorChanged callback fires to parent
4. Parent rebuilds with new color

### Finding Copy-Paste Logic
- **Copy format definitions**: `models/color_picker_copy_paste_behavior.dart`
- **Copy implementation**: `widgets/color_code_field.dart` (line ~200)
- **Paste handling**: `widgets/copy_paste_handler.dart`
- **Format conversion**: `color_picker_extensions.dart` (hex/String extensions)

### Understanding Opacity Control
- Model: `OpacitySlider` in `widgets/opacity/opacity_slider.dart`
- Track painter: `widgets/opacity/opacity_slider_track.dart`
- Thumb painter: `widgets/opacity/opacity_slider_thumb.dart`
- Integration: Main color_picker.dart state

### Finding Material Color Data
- List: `ColorTools.primaryColors` constant
- Names: `ColorTools` static string fields (redName, blueName, etc.)
- Shades: `functions/picker_functions.dart` getMaterialColorShades()

### Understanding Tonal Palette
- Generation: `functions/picker_functions.dart` getTonalColors()
- Display: `widgets/tonal_palette_colors.dart`
- Configuration: `enableTonalPalette` in ColorPicker constructor
- Chroma mode: `tonalPaletteFixedMinChroma` parameter

## Key Classes at a Glance

### Models (Configuration Objects)
```
ColorPickerType {
  primary, accent, both, bw, custom, customSecondary, wheel
}

ColorPickerActionButtons {
  okButton, closeButton, dialogActionButtons,
  dialogActionOrder, dialogActionIcons,
  dialogOkButtonType, dialogCancelButtonType
}

ColorPickerCopyPasteBehavior {
  ctrlC, ctrlV, copyButton, pasteButton,
  copyFormat, longPressMenu, secondaryMenu,
  parseShortHexCode, editUsesParsedPaste
}

ColorPickerCopyFormat {
  dartCode, hexRRGGBB, hexAARRGGBB,
  numHexRRGGBB, numHexAARRGGBB
}
```

### Main Widgets
```
ColorPicker (StatefulWidget)
  - 50+ configuration parameters
  - Manages color, type, opacity, recent colors
  - Composes all sub-widgets

ColorIndicator (StatefulWidget)
  - Selectable color square with icon
  - FocusNode management
  - Brightness-aware coloring

ColorWheelPicker (StatefulWidget)
  - HSV color wheel + saturation/value rectangle
  - Custom painters for efficiency
  - Gesture handling (wheel drag)

ColorCodeField (StatefulWidget)
  - Hex color input/display
  - TextField integration
  - Copy button optional
```

### Utility Widgets
```
IfWrapper - Conditional wrapping (if/else builder)
DryIntrinsicWidth/Height - Layout workaround
ContextPopupMenu - Cross-platform menus
PickerSelector - CupertinoSegmentedControl wrapper
OpacitySlider - Custom slider with painters
```

## Extension Methods Quick Lookup

### On Color
```dart
Color.hexAlpha       // Returns '0xAARRGGBB' format
Color.hex            // Returns 'RRGGBB' format (no alpha)
Color.lighten(amt)   // Lightens by % (0-100)
Color.darken(amt)    // Darkens by % (0-100)
Color.value32bit     // Returns int color value
```

### On String
```dart
String.toColor           // Parses any hex format to Color (or black)
String.toColorMaybeNull  // Parses hex, returns null on error
String.capitalize        // Uppercase first letter
String.dotTail           // Returns part after last dot
```

### On String?
```dart
String?.toColorMaybeNull        // Null-safe version
String?.toColorShortMaybeNull   // With enableShortRGB param
String?.capitalizeMaybeNull     // Null returns null
String?.dotTailMaybeNull        // Null returns null
```

## Testing Quick Reference

### Test File Organization
- `color_picker_test.dart` - Main widget tests
- `color_wheel_picker*.dart` - 2 wheel picker tests
- `opacity_slider*.dart` - 3 opacity slider tests
- `color_code_field_test.dart` - Input field tests
- `copy_paste*.dart` - 2 copy-paste tests
- `color_*.dart` - Various component tests (7 files)
- `picker_functions_test.dart` - Algorithm tests
- `show_color_picker_dialog_test.dart` - Dialog tests

### Common Test Patterns
```dart
// Using TestWidget wrapper
await tester.pumpWidget(
  TestWidget(
    widget: ColorPicker(
      onColorChanged: (Color color) {},
    ),
  ),
);

// Finding widgets
expect(find.byKey(testKey), findsOneWidget);
expect(find.byType(ColorPicker), findsWidgets);

// Clipboard mocking
await testWidgetWithClipboard(
  tester,
  initialClipboard: '0xFF0000FF',
  // ...
);

// Platform override
debugDefaultTargetPlatformOverride = TargetPlatform.windows;
```

## Debugging Tips

### Enable Debug Prints
In any file with `const bool _debug = !kReleaseMode && false;`:
1. Change `false` to `true`
2. Rebuild
3. Prints show in debug mode only
4. Don't forget to set back to `false`

### Focus Issues
Check FocusNode management in:
- `color_indicator.dart` - _focusNode lifecycle
- `color_code_field.dart` - requestFocus usage
- `color_wheel_picker.dart` - Focus request logic

### Color Not Changing
Trace the flow:
1. Check `onColorChanged` callback is wired correctly
2. Verify `shouldUpdate` flag on wheel picker
3. Check state setState() calls in `_ColorPickerState`

### Copy-Paste Not Working
1. Check `copyPasteBehavior` configuration
2. Verify `ctrlC`/`ctrlV` enabled
3. Check platform detection (Windows vs Mac)
4. Test with `clipboard_utils.dart` in tests

## Configuration Cheat Sheet

### Minimal Configuration
```dart
ColorPicker(
  color: Colors.blue,
  onColorChanged: (color) {},
)
```

### Feature-Complete Configuration
```dart
ColorPicker(
  color: selectedColor,
  onColorChanged: (color) => setState(() => selectedColor = color),
  pickersEnabled: {
    ColorPickerType.both: false,
    ColorPickerType.primary: true,
    ColorPickerType.accent: true,
    ColorPickerType.bw: false,
    ColorPickerType.custom: false,
    ColorPickerType.customSecondary: false,
    ColorPickerType.wheel: true,
  },
  enableShadesSelection: true,
  enableOpacity: true,
  enableTonalPalette: true,
  showColorCode: true,
  showRecentColors: true,
  maxRecentColors: 10,
  recentColors: recentColors,
  onRecentColorsChanged: (colors) => updateRecent(colors),
  actionButtons: ColorPickerActionButtons(
    okButton: true,
    dialogActionButtons: true,
    dialogOkButtonType: ColorPickerActionButtonType.elevated,
  ),
  copyPasteBehavior: ColorPickerCopyPasteBehavior(
    ctrlC: true,
    ctrlV: true,
    copyButton: true,
    pasteButton: true,
    longPressMenu: true,
    copyFormat: ColorPickerCopyFormat.numHexRRGGBB,
  ),
)
```

### Using in a Dialog
```dart
final Color newColor = await showColorPickerDialog(
  context,
  Colors.blue,
  pickersEnabled: {ColorPickerType.wheel: true},
  enableOpacity: true,
  actionButtons: ColorPickerActionButtons(
    dialogOkButtonLabel: 'Select',
    dialogCancelButtonLabel: 'Cancel',
  ),
);
```

## Performance Checklist

When optimizing or debugging performance:
- [ ] Check if all widgets are marked @immutable
- [ ] Verify excessive rebuilds (use DevTools)
- [ ] Check for unnecessary setState() calls
- [ ] Ensure custom painters use shouldRepaint efficiently
- [ ] Verify focus handling doesn't cause full rebuilds
- [ ] Check grid layouts (MainColors, ShadeColors) for efficiency
- [ ] Profile on actual device (web can be slower)

## Common Pitfalls

1. **Forgetting onColorChanged callback** - Color won't update
2. **Not providing ColorPickerType in pickersEnabled** - Picker won't show
3. **Wrong recentColors type** - Should be List<Color>
4. **Not calling setState** in callback - UI won't update
5. **Using showColorPickerDialog without await** - Returns Future<Color>
6. **Not disposing FocusNodes** - Memory leak risk
7. **Custom colors not in swatches** - Wheel won't find them
8. **Opacity ignored in some formats** - Check copyFormat setting

## Branch and Version Info

- **Current Version**: 3.7.2
- **Main Branch**: master (used for PRs)
- **Dart SDK**: >= 3.0.0
- **Flutter SDK**: >= 3.35.0
- **Last Stable**: FV stable (commit 984085c)

## External Dependencies

- **flex_seed_scheme**: Material 3 color utilities (CAM16/HCT)
- **flutter**: Core framework
- **flutter_test**: Widget testing
- **test**: Unit testing
- **coverage**: Code coverage
- **patrol_finders**: Integration testing (for tests)

## Related Resources

- Main package: `/Users/rydmike/dev/code/flex_color_picker/lib/flex_color_picker.dart`
- Example app: `/Users/rydmike/dev/code/flex_color_picker/example/`
- Tests: `/Users/rydmike/dev/code/flex_color_picker/test/`
- Full architecture doc: `ARCHITECTURE.md` (in this repo)

---

*Last updated: 2025-11-05*
*For detailed architecture, see ARCHITECTURE.md*
