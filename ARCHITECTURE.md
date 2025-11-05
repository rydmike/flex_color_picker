# FlexColorPicker - Codebase Architecture and Development Patterns

## Project Overview

**FlexColorPicker** is a comprehensive, customizable Flutter color picker package that supports multiple color selection modes including Material Design colors, custom color swatches, HSV color wheel, and Material Design 3 tonal palettes.

- **Version**: 3.7.2
- **SDK Requirements**: Dart 3.0+, Flutter 3.35+
- **License**: BSD 3-Clause
- **Key Dependency**: flex_seed_scheme (v3.5.0) for Material Design 3 color utilities

### Project Statistics
- Main library: 25 Dart files (~7,100 lines of code)
- Tests: 21 test files
- Example app: 100+ Dart files
- Well-organized modular structure with clear separation of concerns

---

## Directory Structure

```
lib/src/
├── color_picker.dart                 # Main ColorPicker widget (StatefulWidget, ~3,300 lines)
├── color_picker_extensions.dart      # Extensions for Color and String utilities
├── color_indicator.dart              # Color indicator widget (reusable selector)
├── color_wheel_picker.dart           # HSV wheel color picker
├── color_tools.dart                  # Static color utility functions
├── show_color_picker_dialog.dart      # Dialog wrapper and function (part file)
│
├── models/
│   ├── color_picker_type.dart        # Enum: primary, accent, bw, custom, customSecondary, wheel
│   ├── color_picker_action_buttons.dart  # Dialog button configuration and styling
│   └── color_picker_copy_paste_behavior.dart  # Copy-paste modes and formats
│
├── widgets/                          # Composable UI components
│   ├── color_code_field.dart         # Hex color input/display field
│   ├── color_picker_toolbar.dart     # Action buttons toolbar
│   ├── copy_paste_handler.dart       # Copy-paste event handler
│   ├── context_copy_paste_menu.dart  # Right-click context menu
│   ├── main_colors.dart              # Primary/accent color grid display
│   ├── shade_colors.dart             # Color shade selector
│   ├── recent_colors.dart            # Recently selected colors display
│   ├── picker_selector.dart          # CupertinoSegmentedControl for picker type
│   ├── tonal_palette_colors.dart     # Material 3 tonal palette display
│   └── opacity/
│       ├── opacity_slider.dart       # Opacity control slider
│       ├── opacity_slider_track.dart # Custom painted slider track
│       └── opacity_slider_thumb.dart # Custom painted slider thumb
│
├── universal_widgets/                # Reusable utility widgets (private)
│   ├── if_wrapper.dart               # Conditional widget wrapping
│   ├── dry_intrinsic.dart            # Workaround for Flutter issue #71687
│   └── context_popup_menu.dart       # Cross-platform context menu
│
└── functions/
    └── picker_functions.dart         # Internal utility functions (not exported)

example/lib/demo/
├── main.dart                         # App entry point
├── screens/
│   └── color_picker/
│       ├── color_picker_screen.dart  # Main demo screen
│       ├── color_picker_dialog.dart  # Dialog example
│       ├── color_picker_card.dart    # Card-based picker example
│       ├── about.dart                # About screen
│       ├── all_control_widgets.dart  # Widget control reference
│       └── picker_indicators/        # Various color indicator types
├── store/
│   └── hive_store.dart               # Persistent state management (Hive)
├── pods/
│   └── *.dart                        # Riverpod state management
└── widgets/
    └── Various UI components
```

---

## Core Architecture Patterns

### 1. **Stateful Widget Pattern**
The main `ColorPicker` widget is a `StatefulWidget` with extensive configuration options (50+ parameters). The state manages:
- Current color selection
- Picker type selection
- Opacity value
- Recent colors history
- Focus and keyboard navigation

### 2. **Composition over Inheritance**
The picker uses a composition approach with specialized sub-widgets:
- `MainColors` - displays main color swatches
- `ShadeColors` - displays shades of selected color
- `OpacitySlider` - handles opacity adjustment
- `ColorCodeField` - manages hex code input/display
- Each sub-widget is independently testable and reusable

### 3. **Callback-Driven Architecture**
Heavy use of `ValueChanged<Color>` callbacks for state management:
- `onColorChanged` - main color selection callback
- `onColorChangeStart/End` - lifecycle callbacks
- `onRecentColorsChanged` - recent colors tracking
- `onEditFocused` - focus management

### 4. **Extension-Based Utilities**
Multiple extension types provide utility functionality without polluting the global namespace:
- `FlexPickerNoNullColorExtensions` on Color
- `FlexPickerNoNullStringExtensions` on String
- `FlexPickerNullableStringExtensions` on String?
- `FlexPickerColorExtensions` on Color (lighten/darken)

### 5. **Configuration Objects Pattern**
Instead of many constructor parameters, complex configurations use dedicated objects:
- `ColorPickerActionButtons` - dialog button styling
- `ColorPickerCopyPasteBehavior` - copy-paste settings
- Both are `@immutable` with comprehensive Diagnosticable support

### 6. **Enum-Based Type System**
`ColorPickerType` enum defines picker modes:
- `both`, `primary`, `accent`, `bw`, `custom`, `customSecondary`, `wheel`
- Enables runtime feature selection and polymorphic behavior
- Used with Map<ColorPickerType, bool> for feature toggling

---

## Key Design Decisions

### 1. **Part File for Dialog**
- `show_color_picker_dialog.dart` is a `part of 'color_picker.dart'`
- Keeps dialog functionality with main widget while maintaining readability
- Allows access to private ColorPickerState

### 2. **Custom Painting for Wheel Picker**
- `ColorWheelPicker` uses custom `CustomPainter` for HSV wheel
- Provides mathematical accuracy and performance
- Handles both wheel and saturation/value rectangle

### 3. **Platform-Aware Copy-Paste**
- Detects platform (Windows/Mac/Linux/Mobile)
- Uses CTRL on Windows/Linux, CMD on macOS
- Long-press menu on mobile, right-click on desktop
- Support for multiple color formats (HEX, ARGB, Dart syntax)

### 4. **Material 3 Tonal Palette Integration**
- Uses `flex_seed_scheme` for CAM16/HCT color space
- Generates 13-color tonal palettes from any color
- Can optionally show alongside Material swatches

### 5. **Dynamic Color Name Translation**
- Static strings in `ColorTools` for all Material color names
- Developers can override at app startup for i18n
- Fallback naming algorithm for custom colors

### 6. **Focus and Keyboard Navigation**
- Extensive FocusNode management
- Keyboard shortcuts (CTRL-C/V for copy-paste)
- Focus handling for accessibility

---

## Component Relationships

```
ColorPicker (Main Widget)
├── PrimaryState Management
│   ├── current color
│   ├── picker type selection
│   ├── opacity
│   └── recent colors
│
├── Sub-widgets (Composed)
│   ├── PickerSelector (CupertinoSegmentedControl)
│   ├── MainColors (Grid)
│   ├── ShadeColors (Grid)
│   ├── TonalPaletteColors (Grid)
│   ├── RecentColors (Grid)
│   ├── ColorWheelPicker (Custom Paint)
│   ├── OpacitySlider (Custom Widget)
│   │   ├── OpacitySliderTrack (Custom Paint)
│   │   └── OpacitySliderThumb (Custom Paint)
│   ├── ColorCodeField (TextField)
│   ├── ColorPickerToolbar (Icon Buttons)
│   └── Universal Widgets
│       ├── IfWrapper (Conditional)
│       ├── DryIntrinsicWidth/Height (Layout)
│       └── ContextPopupMenu
│
└── Dialog Wrapper (showColorPickerDialog function)
    └── Configured with ColorPickerActionButtons
```

### ColorIndicator Relationships
- Used independently or as selector items
- Manages its own FocusNode
- Provides visual feedback (focus, selected states)
- Brightness-aware icon coloring (black on light, white on dark)

---

## Key Features and Their Implementation

### 1. **Six Picker Types**
- **Primary/Accent/Both**: Pre-defined Material swatches with shades
- **B&W**: Black, white, and near-black/white shades
- **Custom/CustomSecondary**: Developer-provided color swatches
- **Wheel**: HSV color wheel for arbitrary color selection

### 2. **Copy-Paste Functionality**
Multiple interaction patterns:
- Toolbar copy/paste buttons
- Right-click context menu (desktop)
- Long-press menu (mobile)
- Keyboard shortcuts (CTRL-C/V)
- Copy button in color code field

Copy formats supported:
- Dart: `0xAARRGGBB`
- Web: `#RRGGBB` or `#AARRGGBB`
- Plain hex: `RRGGBB` or `AARRGGBB`

### 3. **Opacity Support**
- Optional opacity slider with custom painting
- HSV color wheel with opacity
- Separate opacity display/control
- Integration with color code (shows alpha)

### 4. **Color Code Editing**
- Hex input field with validation
- Prefix styling support
- Read-only mode option
- Copy button with custom behavior
- Colored background option (color preview)

### 5. **Recent Colors**
- Configurable max count (2-20)
- Persisted via callbacks (parent responsibility)
- Optional display
- Selectable like main colors

### 6. **Tonal Palette**
- Material 3 color system support
- 13 predefined tones
- Generated from any selected color
- Optional fixed minimum chroma mode

---

## Testing Strategy

### Test Organization (21 test files)
- **Widget Tests**: `color_picker_test.dart`, `color_wheel_picker_test.dart`
- **Functional Tests**: `picker_functions_test.dart`
- **Extension Tests**: `flex_color_extensions_test.dart`, `color_picker_extensions_test.dart`
- **Component Tests**: 
  - `color_indicator_test.dart`
  - `color_code_field_test.dart`
  - `opacity_slider_test.dart` (and track/thumb variants)
- **Feature Tests**:
  - `color_picker_action_buttons_test.dart`
  - `copy_paste_handler_test.dart`
  - `context_popup_menu_test.dart`
- **Integration Tests**: `color_picker_patrol_test.dart` (Patrol framework)
- **Dialog Tests**: `show_color_picker_dialog_test.dart`

### Test Patterns
- Heavy use of `TestWidget` wrapper (custom test harness)
- Widget predicates for verification
- Mock context/clipboard for isolated testing
- Platform override for cross-platform testing

### Clipboard Testing Utilities
- `clipboard_utils.dart` - helper for clipboard mocking
- Enables testing copy-paste without real clipboard

---

## Code Quality and Conventions

### Linting Standards
- **Framework**: RydMike's custom linter preferences (v2.5.0)
- **Strictness**: 
  - `strict-casts: true`
  - `strict-inference: true`
  - `strict-raw-types: true`
- **Error handling**:
  - `missing_required_param: error`
  - `missing_return: error`
- **Ignored patterns**: Generated files (*.g.dart, *.freezed.dart)

### Code Style Conventions
- Extensive use of `@immutable` annotation
- `with Diagnosticable` for debug output
- Null safety throughout (no nullable types without reason)
- Private classes prefixed with underscore
- Part files used for large classes (ColorPicker + dialog)
- Debug flag pattern: `const bool _debug = !kReleaseMode && false;`

### Documentation
- Comprehensive dartdoc on all public classes and methods
- README.md with extensive examples (94KB)
- Clear API guide with usage patterns
- Inline comments for complex algorithms

---

## Build and Development Workflow

### Build Configuration
- **pubspec.yaml**:
  - Single dependency: `flex_seed_scheme: ^3.5.0`
  - Dev dependencies: test, flutter_test, coverage, patrol_finders
- **analysis_options.yaml**: Comprehensive linting configuration
- **assets/**: Contains image resources for documentation

### Platform Support
- Flutter Web (canvaskit)
- Windows Desktop
- macOS Desktop
- Linux Desktop
- iOS/Android (mobile-optimized UI)

### Example App Structure
- **Architecture**: 
  - Riverpod for state management
  - Hive for persistence
  - Flutter Material 3 theming
- **Features Demonstrated**:
  - All 6 picker types
  - Dialog and inline usage
  - Custom colors
  - Opacity handling
  - Copy-paste features
  - Recent colors
  - Tonal palette
  - Theme switching (light/dark)

---

## Public API Surface

### Main Exports (lib/flex_color_picker.dart)
```dart
export 'src/color_indicator.dart' show ColorIndicator;
export 'src/color_picker.dart' show ColorPicker, showColorPickerDialog;
export 'src/color_picker_extensions.dart';
export 'src/color_tools.dart';
export 'src/color_wheel_picker.dart' show ColorWheelPicker;
export 'src/models/color_picker_action_buttons.dart';
export 'src/models/color_picker_copy_paste_behavior.dart';
export 'src/models/color_picker_type.dart';
export 'src/widgets/color_code_field.dart';
```

### ColorPicker Constructor Parameters (50+)
- **Core**: color, onColorChanged, onColorChangeStart/End
- **Types**: pickersEnabled, enableShadesSelection, enableTonalPalette
- **Layout**: mainAxisSize, crossAxisAlignment, padding, spacing
- **Styling**: width, height, elevation, borderRadius, wheelDiameter
- **Opacity**: enableOpacity, opacityTrackHeight, opacityThumbRadius
- **Display**: showMaterialName, showColorCode, showRecentColors
- **Interaction**: actionButtons, copyPasteBehavior, selectedColorIcon

---

## Special Patterns and Conventions

### 1. **Conditional Widget Wrapping**
The `IfWrapper` pattern is used throughout:
```dart
IfWrapper(
  condition: widget.showRecentColors,
  builder: (context, child) => Column(children: [..., child]),
  child: mainPicker,
)
```

### 2. **Debug Print Pattern**
```dart
const bool _debug = !kReleaseMode && false;
// Then use: if (_debug) debugPrint('...');
// Automatically stripped in release builds
```

### 3. **Static Color Names Translation**
```dart
// In ColorTools
static String redName = 'Red'; // Can be overridden at startup
```

### 4. **Custom Painter for Performance**
- HSV wheel uses `CustomPainter` for efficiency
- Opacity slider track and thumb also custom-painted
- Math calculations in HSV/HSL color space

### 5. **Focus Management Pattern**
Multiple focus strategies:
- FocusNode per interactive widget
- Focus delegation to children
- Focus request on state changes
- Platform-aware focus behavior

### 6. **Platform Detection**
```dart
bool isDesktop(TargetPlatform platform) { ... }
String platformControlKey(TargetPlatform platform, String key) { ... }
```

---

## Notable Implementation Details

### Color Parsing Robustness
The `toColorShort()` extension handles:
- Missing # or 0x prefixes
- Short 3-char RGB codes
- Mixed case hex
- Whitespace tolerance
- Over-length strings (right truncated)
- Invalid input (returns black)

### Material Color Swatch Handling
- Includes Grey color (not in Colors.primaries)
- Special handling for Grey's index 850
- Dynamic swatch lookup for custom colors
- Shade detection across all picker types

### Tonal Palette Generation
- Uses CAM16 color space via flex_seed_scheme
- Configurable fixed minimum chroma (for compatibility)
- 13 tones matching Material 3 standard
- Automatic palette generation per color

### Focus and Accessibility
- Full keyboard navigation support
- Focus preservation across picker changes
- Accessible icon sizing based on container
- High contrast icon coloring

---

## Dependencies and Integrations

### Direct Dependencies
- `flutter` (SDK)
- `flex_seed_scheme: ^3.5.0` (Material 3 color utilities)

### Dev/Example Dependencies
- `test` (unit testing)
- `flutter_test` (widget testing)
- `coverage` (code coverage analysis)
- `patrol_finders` (integration testing)
- `flutter_riverpod` (example app state management)
- `hive_ce` (example app persistence)
- `google_fonts` (example app styling)
- `url_launcher` (example app links)
- `path_provider` (example app file access)

---

## Common Development Tasks

### Adding a New Picker Type
1. Add variant to `ColorPickerType` enum
2. Create color swatches list in `ColorTools`
3. Add names in `ColorTools` static strings
4. Implement display widget (similar to MainColors)
5. Add to `typeToSwatchMap` in ColorPicker
6. Update tests

### Adding Copy-Paste Format
1. Add to `ColorPickerCopyFormat` enum
2. Update copy logic in `ColorCodeField`
3. Update paste parsing in `copy_paste_handler.dart`
4. Test with various format combinations
5. Update example app demonstrations

### Customizing UI Appearance
- Use ColorPicker's 15+ styling parameters
- Override theme via `ColorPickerActionButtons`
- Use `copyPasteBehavior` for menu customization
- Leverage custom fonts via GoogleFonts in example

### Testing New Features
- Write unit tests in `test/` directory
- Use `TestWidget` wrapper for Flutter context
- Mock clipboard with `clipboard_utils.dart`
- Override platform with `debugDefaultTargetPlatformOverride`
- Add widget tests and functional tests

---

## Performance Considerations

### Optimization Techniques
1. **Custom Painting**: Wheel and slider use CustomPainter for efficiency
2. **Immutability**: All public classes marked @immutable
3. **Lazy Rendering**: IfWrapper prevents unnecessary widget tree
4. **Focus Management**: Efficient focus tracking without full rebuilds
5. **Extension Methods**: Zero-cost abstractions for utilities

### Layout Efficiency
- Intrinsic sizing for flexible layouts
- Custom DryIntrinsic* classes for TextField compatibility
- Minimal rebuilds through state segmentation

---

## Future Enhancement Areas

Based on the codebase structure, potential enhancements could include:
1. Additional picker types (Gradient selector, Palette browser)
2. Color harmony rules (complementary, triadic, etc.)
3. Persistent color swatches (save/load custom collections)
4. Color difference calculations (Delta-E)
5. Advanced color space conversions (LAB, LCH)
6. Undo/Redo functionality
7. Color preview modes (patterns, text simulation)
8. Integration with Material ColorScheme builder

---

## Useful References

- **Repository**: https://github.com/rydmike/flex_color_picker
- **Pub.dev**: https://pub.dev/packages/flex_color_picker
- **Material 3 Color System**: https://m3.material.io/styles/color/the-color-system
- **CAM16/HCT Color Space**: Technical documentation in flex_seed_scheme
- **Flutter CustomPainter**: https://api.flutter.dev/flutter/rendering/CustomPainter-class.html

---

## Summary for Future Claude Instances

The FlexColorPicker codebase is a well-architected, production-ready Flutter package with:

1. **Clear Separation of Concerns**: Models, widgets, utilities, and functions cleanly separated
2. **Extensive Customization**: 50+ configuration options without complexity
3. **Multi-Platform Support**: Desktop (Windows/Mac/Linux) and mobile optimized
4. **Modern Flutter Patterns**: StatefulWidget, callbacks, extensions, composition
5. **High Code Quality**: Comprehensive linting, testing, and documentation
6. **Accessibility Ready**: Keyboard navigation, focus management, screen reader support
7. **Material 3 Ready**: Full support for tonal palettes and HCT color space
8. **Performance Optimized**: Custom painting, efficient layouts, immutable design

Key files to understand any modification:
- `color_picker.dart` - Main widget and architecture
- `color_tools.dart` - Color utilities and constants
- `functions/picker_functions.dart` - Core algorithms
- `models/*.dart` - Configuration objects
- `widgets/*` - UI components
- Test files - Understanding expected behavior

When extending: maintain immutability, use callbacks for state, add both tests and example code.
