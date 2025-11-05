# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**FlexColorPicker** is a customizable Flutter color picker package supporting multiple selection modes:
- Material Design primary/accent colors with shades
- Black & white color selection
- Custom color swatches
- HSV color wheel picker
- Material Design 3 tonal palettes

**Key Details:**
- **Version**: 3.7.2
- **SDK**: Dart 3.0+, Flutter 3.35+
- **License**: BSD 3-Clause
- **Main Dependency**: `flex_seed_scheme` v3.5.0 (Material Design 3 color utilities)

## Development Commands

### Testing
```bash
# Run all tests with coverage
flutter test --coverage

# Run a single test file
flutter test test/color_picker_test.dart

# Run tests matching a pattern
flutter test test/*_test.dart

# Run patrol tests (UI integration tests)
flutter test test/color_picker_patrol_test.dart
```

### Code Analysis
```bash
# Run static analysis
flutter analyze

# The project uses RydMike's strict lint rules (all_lint_rules.yaml)
# with strict-casts, strict-inference, and strict-raw-types enabled
```

### Building
```bash
# Get dependencies
flutter pub get

# Build example app (Web)
cd example
flutter build web

# Build example app (other platforms)
flutter build macos
flutter build windows
flutter build linux
flutter build apk
flutter build ios
```

### Example App
```bash
# Run the example/demo app
cd example
flutter run

# The example app demonstrates all picker features and configurations
# It uses Riverpod for state management and Hive for persistence
```

## Architecture Overview

### Core Widget Pattern
The main `ColorPicker` widget (`lib/src/color_picker.dart`, ~3,300 lines) is a large `StatefulWidget` with 50+ configuration parameters. It follows a **composition-based architecture** where functionality is split into specialized sub-widgets rather than using inheritance.

### Key Sub-Widgets (lib/src/widgets/)
- **MainColors**: Displays primary/accent color swatches
- **ShadeColors**: Shows shades of selected color
- **OpacitySlider**: Custom-painted opacity control with track and thumb
- **ColorCodeField**: Hex color input/display with validation
- **ColorPickerToolbar**: Copy-paste action buttons
- **RecentColors**: Recently selected colors display
- **TonalPaletteColors**: Material 3 tonal palette display
- **ColorWheelPicker**: HSV-based arbitrary color selection

### Data Models (lib/src/models/)
- **ColorPickerType** enum: `primary`, `accent`, `both`, `bw`, `custom`, `customSecondary`, `wheel`
- **ColorPickerActionButtons**: Dialog button configuration and styling
- **ColorPickerCopyPasteBehavior**: Defines copy-paste modes and color code formats

### Callback Architecture
Heavy use of `ValueChanged<Color>` callbacks for reactive state management:
- `onColorChanged`: Main color selection callback (required)
- `onColorChangeStart`/`onColorChangeEnd`: Lifecycle callbacks
- `onRecentColorsChanged`: Recent colors list updates

### Universal Widgets (lib/src/universal_widgets/)
Private, reusable utility widgets not exported from the package:
- **ContextPopupMenu**: Cross-platform context menu implementation
- **IfWrapper**: Conditional widget wrapping helper
- **DryIntrinsic**: Workaround for Flutter issue #71687

### Extensions (lib/src/color_picker_extensions.dart)
- `Color` extensions: `.alpha256`, `.alphaBlend()`, `.brighten()`, etc.
- `String` extensions: `.toColor()` for hex parsing
- These provide convenient color manipulation utilities

## Code Quality Standards

### Linting
The project uses **RydMike's strict lint rules** (v2.5.0) with all lint rules enabled, then selectively disabled. Key characteristics:

- **Strict type checking**: `always_specify_types` is enabled (unlike most Flutter projects)
- **Immutability**: All public widget classes marked `@immutable`
- **Documentation**: `public_member_api_docs` enforced for the package
- **Single quotes**: `prefer_single_quotes` over double quotes
- **No unsafe casts**: Use type checks (`is`) instead of `as` casts
- **Variance safety**: Private fields for contravariant generic types (see `unsafe_variance` lint)

### Type Safety Critical Rules
```yaml
strict-casts: true
strict-inference: true
strict-raw-types: true
```

### Common Lint Patterns
- **Always specify types** explicitly, even for local variables
- Use `is` checks instead of `as` casts (avoids `unsafe_variance` issues)
- Document all public APIs with `///` doc comments
- Follow Flutter repo style for constructors (default first, then properties, then named constructors)

### Handling `unsafe_variance`
When a generic type parameter appears in a contravariant position (like `ValueChanged<T>`), use this pattern:
```dart
class MyWidget<T> extends StatefulWidget {
  const MyWidget({required ValueChanged<T> onChanged}) : _onChanged = onChanged;
  final Function _onChanged; // Store as Function, not ValueChanged<T>

  // Cast at call site:
  void _handleChange(T value) {
    (_onChanged as ValueChanged<T>)(value);
  }
}
```

## Testing Patterns

### Test Structure (test/)
- Each source file has a corresponding `*_test.dart` file
- Tests use `flutter_test` and `patrol_finders` for UI testing
- Widget tests follow Flutter testing best practices
- Comprehensive coverage across all public APIs

### Running Specific Tests
```bash
# Test a specific widget
flutter test test/color_picker_test.dart

# Test color utilities
flutter test test/flex_color_tools_test.dart

# Test extensions
flutter test test/flex_color_extensions_test.dart
```

## Important Conventions

### File Organization
- **Main widget**: `lib/src/color_picker.dart` contains the core `ColorPicker` widget
- **Exports**: Only `lib/flex_color_picker.dart` is exported; all else is private
- **Part files**: `show_color_picker_dialog.dart` is a part file, not independently importable
- **Universal widgets**: Not exported, internal use only

### Import Style
The project uses **relative imports** (`prefer_relative_imports`), not package imports:
```dart
// Correct
import '../models/color_picker_type.dart';

// Incorrect
import 'package:flex_color_picker/src/models/color_picker_type.dart';
```

### Constructor Pattern
```dart
class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.property1,
    this.property2 = defaultValue,
  });

  final Type property1;
  final Type property2;

  // Then other methods...
}
```

### Desktop & Web Support
The picker is fully desktop and web compatible:
- Uses platform-aware keyboard shortcuts (Ctrl/Cmd+C/V)
- Context menus support secondary click (right-click)
- Focus handling for keyboard navigation
- Adaptive UI for different input methods

## Example App Architecture

The `example/` directory contains a comprehensive demo app:

### State Management
- **Riverpod** for reactive state (`example/lib/demo/pods/`)
- **Hive** for persistent storage (`example/lib/demo/store/hive_store.dart`)

### Key Example Files
- `example/lib/demo/screens/color_picker/color_picker_screen.dart`: Main demo
- `example/lib/demo/screens/color_picker/color_picker_dialog.dart`: Dialog examples
- `example/lib/demo/screens/color_picker/picker_indicators/`: Various indicator patterns

## Common Development Tasks

### Adding a New Picker Feature
1. Update `ColorPicker` widget parameters in `lib/src/color_picker.dart`
2. Create sub-widget in `lib/src/widgets/` if needed
3. Add corresponding enum values to `lib/src/models/` if applicable
4. Update tests in `test/`
5. Update example app to demonstrate the feature
6. Document with `///` doc comments

### Modifying Color Utilities
- Color manipulation: `lib/src/color_tools.dart` (static methods)
- Color extensions: `lib/src/color_picker_extensions.dart`
- Ensure backward compatibility for public APIs

### Working with Opacity
The opacity slider is custom-painted for performance:
- `OpacitySlider`: Main widget wrapper
- `OpacitySliderTrack`: Custom painter for gradient track
- `OpacitySliderThumb`: Custom painter for thumb with border

### Copy-Paste Functionality
Three implementation layers:
1. **Keyboard shortcuts**: `CopyPasteHandler` widget
2. **Toolbar buttons**: `ColorPickerToolbar` widget
3. **Context menu**: `ContextCopyPasteMenu` widget

All coordinate through `ColorPickerCopyPasteBehavior` configuration.

## Material Design 3 Integration

The picker integrates with Material 3 color system via `flex_seed_scheme`:
- Generates tonal palettes from any selected color
- Displays core, neutral, and variant palettes
- Supports HCT color space conversions
- See `TonalPaletteColors` widget for implementation

## Debugging Tips

### Common Issues
- **Type errors with generics**: Check for `unsafe_variance` lint violations
- **Context menu not showing**: Verify `useSecondaryOnDesktopLongOnDeviceAndWeb` setting
- **Color not updating**: Ensure `onColorChanged` callback updates parent state
- **Opacity slider issues**: Check that `enableOpacity: true` is set

### Example App Testing
The example app is the best way to test changes interactively:
```bash
cd example
flutter run -d chrome  # For web
flutter run -d macos   # For desktop
```

## References

- **Main README**: Comprehensive API documentation and usage examples
- **ARCHITECTURE.md**: Detailed architectural analysis (if available)
- **Package Documentation**: https://pub.dev/packages/flex_color_picker
- **Repository**: https://github.com/rydmike/flex_color_picker
- **Material 3 Colors**: https://m3.material.io/styles/color/the-color-system/key-colors-tones
