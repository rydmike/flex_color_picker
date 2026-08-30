[![Pub Version](https://img.shields.io/pub/v/flex_color_picker?label=flex_color_picker&labelColor=333940&logo=dart)](https://pub.dev/packages/flex_color_picker) ![Test](https://github.com/rydmike/flex_color_picker/workflows/Test/badge.svg) [![codecov](https://codecov.io/gh/rydmike/flex_color_picker/branch/master/graph/badge.svg?token=6GEGK5XEOP)](https://codecov.io/gh/rydmike/flex_color_picker) [![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

# FlexColorPicker

FlexColorPicker is a customizable color picker for Flutter. The `ColorPicker` can show seven picker types: Material primary, accent, combined primary+accent, near black and white, one or two custom swatch pages, and an HSV wheel for any color. The size and style of the pick items can be customized.

You can optionally generate Material 3 tonal palettes from the selected color as a key color, then pick a tone from that row. See the [Material 3 color system](https://m3.material.io/styles/color/the-color-system/key-colors-tones) for how key colors and tonal palettes work.

The picker works on Android, iOS, Web, Windows, macOS and Linux. It has desktop focus handling, plus optional menus and buttons for copy-paste of colors, including platform-aware keyboard shortcuts.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerAllSize50-upper.png?raw=true" alt="ColorPicker variations upper"/>

## Contents

- [FlexColorPicker](#flexcolorpicker)
  - [Contents](#contents)
  - [What's new in 4.0](#whats-new-in-40)
  - [Color picker types](#color-picker-types)
  - [Getting started](#getting-started)
    - [Default example application](#default-example-application)
    - [Live web demo](#live-web-demo)
  - [Tutorial](#tutorial)
    - [Color indicator](#color-indicator)
    - [Screen ColorPicker](#screen-colorpicker)
    - [Dialog ColorPicker method](#dialog-colorpicker-method)
    - [Dialog ColorPicker function](#dialog-colorpicker-function)
  - [API guide](#api-guide)
    - [Elements of the picker](#elements-of-the-picker)
      - [Enabled color pickers](#enabled-color-pickers)
      - [Enable shades selection](#enable-shades-selection)
      - [Tonal palette](#tonal-palette)
      - [Custom color swatches](#custom-color-swatches)
      - [Customized labels](#customized-labels)
      - [Enable opacity](#enable-opacity)
      - [Show color names](#show-color-names)
        - [Translate Material color names](#translate-material-color-names)
      - [Show color code](#show-color-code)
      - [Show recent colors](#show-recent-colors)
      - [Title and heading widgets](#title-and-heading-widgets)
    - [Picker design](#picker-design)
      - [Color picker items](#color-picker-items)
      - [Wheel diameter, width and border](#wheel-diameter-width-and-border)
      - [Opacity slider height, width and thumb radius](#opacity-slider-height-width-and-thumb-radius)
    - [Picker layout](#picker-layout)
      - [Tooltips](#tooltips)
    - [Dialog action buttons](#dialog-action-buttons)
    - [Copy-paste actions and behavior](#copy-paste-actions-and-behavior)
      - [Code field copy button](#code-field-copy-button)
      - [Keyboard shortcuts](#keyboard-shortcuts)
      - [Toolbar buttons](#toolbar-buttons)
      - [Context menu](#context-menu)
      - [Color code formats and paste parsing](#color-code-formats-and-paste-parsing)
    - [onChange callbacks](#onchange-callbacks)
    - [Dialogs](#dialogs)
      - [ColorPicker showPickerDialog method](#colorpicker-showpickerdialog-method)
      - [Function showColorPickerDialog](#function-showcolorpickerdialog)
  - [Desktop and web](#desktop-and-web)
  - [Additional resources](#additional-resources)

---

## What's new in 4.0

Version **4.0.0** requires **Flutter 3.47.0** or later and **Dart 3.13.0**. It uses Flutter's standalone [`material_ui`](https://pub.dev/packages/material_ui) and [`cupertino_ui`](https://pub.dev/packages/cupertino_ui) packages: Material and Cupertino are decoupled from the Flutter SDK and versioned on pub.dev.

This is a **major** release because Flutter [recommends a major version](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui) when a package moves to those libraries. Use FlexColorPicker 4.x only with Flutter 3.47+. If your app still imports `package:flutter/material.dart` or `package:flutter/cupertino.dart`, follow that migration guide so widget types stay aligned with this package.

The deprecated `colorCodeIcon` property is **removed**. It had no effect since 2.0.0. Use `copyPasteBehavior.copyIcon` / `ColorPickerCopyPasteBehavior.copyIcon` instead.

## Color picker types

The available picker types are:

1. Material primary colors and their shades. `ColorPickerType.primary`
2. Material accent colors and their shades. `ColorPickerType.accent`
3. Both primary and accent colors and their shades, in one picker. `ColorPickerType.both`
4. Black and white colors, including very near black and white shades. `ColorPickerType.bw`
5. Custom color swatches and their shades, that you define and name. `ColorPickerType.custom`
6. A second custom swatch page, with its own map of named swatches. `ColorPickerType.customSecondary`
7. HSV color-wheel picker, so you can select or enter any color. `ColorPickerType.wheel`

When more than one picker is enabled, a segmented control switches between them. You can enable any combination. Showing pickers 1 and 2 together with picker 3 is rarely useful; they are alternative ways to present the same Material primary and accent colors.

You can give the picker a heading and a subheading for shades, typically `Text` widgets. Decide whether Material shades can be selected, and whether the selected color name and RGB code are visible. If the HEX RGB code is visible, the picker can include a button that copies the selected color to the clipboard. On the wheel picker you can enter a HEX RGB code; the wheel moves to that color and builds a swatch for it.

The shape, size and spacing of the color items can be modified. There is a built-in dialog for the `ColorPicker`. You can also put the widget in your own dialog or overlay.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerAllSize50-lower.png?raw=true" alt="ColorPicker variations lower"/>

## Getting started

Requires Flutter 3.47.0 or later. Add the package:

```bash
flutter pub add flex_color_picker
```

Import it:

```dart
import 'package:flex_color_picker/flex_color_picker.dart';
```

On Flutter 3.47+, Material widgets typically come from `package:material_ui/material_ui.dart`. The default example uses that import. See [What's new in 4.0](#whats-new-in-40).

### Default example application

To try the default example on a device or simulator, clone the **FlexColorPicker** [GitHub repository](https://github.com/rydmike/flex_color_picker) and run:

```bash
cd example/
flutter run --release
```

That shows a default color picker in a `Card` on the screen, with only the Material primary and accent pickers enabled. It also has two dialog pickers with different styles and enabled types. The [tutorial](#tutorial) walks through this example in detail.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerSimpleDemo.png?raw=true" alt="ColorPicker Basic"/>

### Live web demo

Try a live web demo of [**FlexColorPicker here**](https://rydmike.com/flexcolorpicker). You can change most of the picker's API values and use it as a tool to find a style that fits your app.

The source is in `example/lib/demo`. The demo uses a responsive layout of up to four scrollable columns of controls. On a 1080p desktop you can see most settings next to the picker and watch them take effect as you change them.

Each setting control has a tooltip with the API name and current value, so you can configure a style and read back the properties you used. The same toggle that turns off tooltips in the color picker also turns off those API tooltips in the demo. Tooltips are on by default.

The demo persists settings in the same browser on the same device. You can also reset them to the start defaults.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/web_color_picker_v2.gif?raw=true" alt="ColorPicker WEB demo"/>

## Tutorial

This chapter uses the bundled default example as an introduction to **FlexColorPicker**. We create three pickers, with different configurations, and use `ColorPicker` in three ways.

The example uses a `StatefulWidget` as its main page, `ColorPickerPage`, with three `Color` values in local state, initialized in `initState()`. Those colors are the current selection for each example and the start color for each picker.

```dart
class _ColorPickerPageState extends State<ColorPickerPage> {
  // Color for the picker shown in Card on the screen.
  late Color screenPickerColor;
  // Color for the picker in a dialog using onChanged.
  late Color dialogPickerColor;
  // Color for picker using the color select dialog.
  late Color dialogSelectColor; 

@override
void initState() {
  super.initState();
  screenPickerColor = Colors.blue;  // Material blue.
  dialogPickerColor = Colors.red;   // Material red.
  dialogSelectColor = const Color(0xFFA239CA); // A purple color.
}
```

### Color indicator

We can use the `ColorIndicator` widget, which `ColorPicker` also uses internally, to show and select a color. You can also use a custom widget for this. Here we put `ColorIndicator` in a `ListTile` as its `trailing` property.

The package also includes `ColorTools`, helpers that can show names of the standard Material colors, shade index, and an optional Flutter-style HEX color code. We use `ColorTools.materialNameAndCode` in the `ListTile` `subtitle` to describe the selected color.

We also use `ColorTools.nameThatColor`, which names any color from the closest match in a list of **1566** English color names.

Add this `ListTile` to a `ListView` in the `Scaffold` body.

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: const Text('FlexColorPicker Demo'),
    ),
    body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      children: <Widget>[
        // Show the selected color.
        ListTile(
          title: const Text('Select color below to change this color'),
          subtitle:
            Text('${ColorTools.materialNameAndCode(screenPickerColor)} '
                 'aka ${ColorTools.nameThatColor(screenPickerColor)}'),
          trailing: ColorIndicator(
            width: 44,
            height: 44,
            borderRadius: 22,
            color: screenPickerColor,
          ),
        ),
   ...
```

### Screen ColorPicker

Next we add the `ColorPicker` widget to the `ListView`. We pass `screenPickerColor` as `color`, give the picker a `heading` and `subheading`, and the required `onColorChanged` callback.

In the callback we `setState` so `screenPickerColor` becomes the selected color. `onColorChanged` runs whenever you select a new color. This example also wraps the picker in a `Card`.

```dart
  // Show the color picker in sized box in a raised card.
  SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Card(
        elevation: 2,
        child: ColorPicker(
          // Use the screenPickerColor as start and active color.
          color: screenPickerColor,
          // Update the screenPickerColor using the callback.
          onColorChanged: (Color color) =>
            setState(() => screenPickerColor = color),
          width: 44,
          height: 44,
          borderRadius: 22,
          heading: Text(
            'Select color',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          subheading: Text(
            'Select color shade',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    ),
  ),
```

This gives round color pick items, and a round color indicator above the picker:

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPicker02.png?raw=true" alt="ColorPicker round with indicator" width="300"/>

### Dialog ColorPicker method

A common use case is to pick a color in a dialog. `ColorPicker` has a built-in dialog. You can also put the widget in your own dialog.

For the first dialog example, we show all built-in picker types except the combined primary+accent picker and the near black and white picker. We add custom colors for the **Custom** section.

First define the custom colors and build primary and accent swatches with `ColorTools.createPrimarySwatch` and `ColorTools.createAccentSwatch`. Map those swatches to your own names. You do not have to use `ColorTools`; you can define hand-tuned `ColorSwatch` values with `MaterialColor` or `MaterialAccentColor`, as shown in [custom color swatches](#custom-color-swatches). The helpers are a convenient way to make Material-like swatches from a single color.

```dart
  // Define custom colors. The 'guide' color values are from
  // https://material.io/design/color/the-color-system.html#color-theme-creation
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };
```

Use another `ListTile` with a differently styled `ColorIndicator`. Its `onSelect` callback opens a dialog. The start color is `dialogPickerColor`.

Store the current `dialogPickerColor` before opening the dialog so you can restore it if the user cancels. Put this `ListTile` first in the list so it is not hidden by the dialog on smaller phones.

```dart
  // Pick color in a dialog.
  ListTile(
    title: const Text('Click this color to change it in a dialog'),
    subtitle: Text(
      '${ColorTools.materialNameAndCode(dialogPickerColor, '
      'colorSwatchNameMap: colorsNameMap)} '
      'aka ${ColorTools.nameThatColor(dialogPickerColor)}',
    ),
    trailing: ColorIndicator(
      width: 44,
      height: 44,
      borderRadius: 4,
      color: dialogPickerColor,
      onSelectFocus: false,
      onSelect: () async {
        // Store current color before we open the dialog.
        final Color colorBeforeDialog = dialogPickerColor;
        // Wait for the picker to close, if dialog was dismissed, 
        // then restore the color we had before it was opened.
        if (!(await colorPickerDialog())) {
          setState(() {
            dialogPickerColor = colorBeforeDialog;
          });
        }
      },
    ),
  ),
```

> [!NOTE]
> `onSelectFocus` tells `ColorIndicator` not to keep focus after you click it on desktop and Web. On those platforms it gets focus when clicked to open the dialog. If it keeps focus while the dialog is open and after it closes, the focus overlay distorts the shown color. This property unfocuses the indicator after the click.

Next, a helper that shows a `ColorPicker` via the built-in `showPickerDialog` method. That method returns `Future<bool>`: `true` if the user closed the dialog with **OK** or **Select**, `false` if they used **Cancel/Close** or dismissed the dialog by clicking outside it.

`pickersEnabled` is a map from `ColorPickerType` to `bool`. You only need to include keys you want to change; omitted keys keep their defaults.

Below we enable Material **primary**, **accent**, the **custom** colors defined above, and the HSV **wheel**. We omit the combined primary+accent picker and the near black/white picker.

Pass `colorsNameMap` to `customColorSwatchesAndNames`. If that map is empty and `ColorPickerType.custom` is enabled, the custom picker is not shown.

```dart
  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start and active color.
      color: dialogPickerColor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      // Custom open/close transitions.
      transitionBuilder: (BuildContext context,
          Animation<double> a1,
          Animation<double> a2,
          Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(
              0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
```

This example is more compact and shows the general color name via `showColorName`, plus the HEX code via `showColorCode`. The code field can copy the color with its suffix copy icon. On the wheel picker you can also enter a HEX RGB value; the HSV indicators move to match it.

`copyPasteBehavior` with `longPressMenu: true` enables a long-press copy-paste menu.

`showPickerDialog` needs a `BuildContext`. Size `constraints` keep the dialog the same size when you switch picker types. Without constraints it auto-sizes to content, which can jump when you change type. The wheel often needs more space; it becomes hard to use if it is too small. This example uses a still-usable smaller wheel.

The result is a `ListTile` whose trailing `ColorIndicator` opens a dialog. As `dialogPickerColor` changes, the indicator updates. If the dialog is canceled, the original color is restored.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerSimpleDemo.gif?raw=true" alt="ColorPicker dialog demo" width="300"/>

The custom `transitionBuilder` and `transitionDuration` are not in the screen recording below. Build the default example locally to see them.

**Bonus exercise — not included in the example code**

To see the interactive change more clearly, connect `dialogPickerColor` to the `AppBar` `backgroundColor`:

```dart
:
appBar: AppBar(
  // To do this, just add this row to the AppBar in the example.
  backgroundColor: dialogPickerColor,
  elevation: 1,
  centerTitle: true,
  title: const Text('ColorPicker Demo'),
),
```

The selected color in the dialog then changes the `AppBar` as you pick. Confirm keeps it; cancel restores the `AppBar` color as well.

You can use the same idea to drive theme colors while the app is running. Full theme wiring is beyond this tutorial, but it is essentially the same as this `AppBar` example.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerSimpleDemoAppBar.gif?raw=true" alt="ColorPicker appbar demo" width="300"/>

### Dialog ColorPicker function

If you do not need to update colors interactively from the dialog via a callback, use the simpler async `showColorPickerDialog` function. It opens with a start color and returns the selected color on **OK**, or the color you opened it with on **Cancel**.

Call it from an `onTap` or `onSelect` callback. Make the callback `async` and await the returned `Color`.

Add another `ListTile` with a trailing `ColorIndicator`, last of the tiles before the in-page picker. Use `dialogSelectColor`. That start color is not in the default Material primary or accent palettes, so the picker opens on the **Wheel** and shows it there.

```dart
ListTile(
  title: const Text('Click to select a new color from a dialog'),
  subtitle: Text(
    '${ColorTools.materialNameAndCode(dialogSelectColor, colorSwatchNameMap: colorsNameMap)} '
    'aka ${ColorTools.nameThatColor(dialogSelectColor)}',
  ),
  trailing: ColorIndicator(
      width: 40,
      height: 40,
      borderRadius: 0,
      color: dialogSelectColor,
      elevation: 1,
      onSelectFocus: false,
      onSelect: () async {
        // Wait for the dialog to return color selection result.
        final Color newColor = await showColorPickerDialog(
          // The dialog needs a context, we pass it in.
          context,
          // We use the dialogSelectColor, as its starting color.
          dialogSelectColor,
          title: Text('ColorPicker',
              style: Theme.of(context).textTheme.titleLarge),
          width: 40,
          height: 40,
          spacing: 0,
          runSpacing: 0,
          borderRadius: 0,
          wheelDiameter: 165,
          enableOpacity: true,
          showColorCode: true,
          colorCodeHasColor: true,
          pickersEnabled: <ColorPickerType, bool>{
            ColorPickerType.wheel: true,
          },
          copyPasteBehavior: const ColorPickerCopyPasteBehavior(
            copyButton: true,
            pasteButton: true,
            longPressMenu: true,
          ),
          actionButtons: const ColorPickerActionButtons(
            okButton: true,
            closeButton: true,
            dialogActionButtons: false,
          ),
          constraints: const BoxConstraints(
              minHeight: 480, minWidth: 320, maxWidth: 320),
        );
        // We update the dialogSelectColor, to the returned result
        // color. If the dialog was dismissed it actually returns
        // the color we started with. The extra update for that
        // below does not really matter, but if you want you can
        // check if they are equal and skip the update below.
        setState(() {
          dialogSelectColor = newColor;
        });
      }),
),
```

This example uses a `title` widget instead of a `heading`. The title is more like an `AppBar` title. Subheadings are omitted for a more compact picker.

`copyPasteBehavior` enables copy and paste icon buttons in the top toolbar (`copyButton` and `pasteButton`), and keeps the long-press menu.

`actionButtons` sets `dialogActionButtons: false` to hide the bottom **CANCEL** and **OK** buttons, and `okButton: true` plus `closeButton: true` for a check-mark OK and an x Close in the top toolbar.

`enableOpacity: true` shows the opacity slider (0% to 100%). `colorCodeHasColor: true` paints the code field with the current color, including opacity. The slider has a checkered background so you can see how opaque the value is over other content.

Below is this setup, including copy-paste between pickers. You can also copy-paste between the picker and other apps. Desktop builds support keyboard copy-paste shortcuts. See [copy-paste actions and behavior](#copy-paste-actions-and-behavior).

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/color_picker_copy_paste_demo.gif?raw=true" alt="ColorPicker copy-paste demo" width="300"/>

`showColorPickerDialog` uses the same `ColorPicker` and `showPickerDialog` under the hood. It bundles `ColorPicker` properties, `showPickerDialog` parameters, `AlertDialog`, and `showDialog` into one function. You rarely need most of those parameters; defaults are usually enough.

The default example also has a light/dark theme toggle so you can try the picker in both modes.

## API guide

In addition to the [tutorial](#tutorial), **FlexColorPicker** has many more options. Direct properties plus `ColorPickerActionButtons` and `ColorPickerCopyPasteBehavior` cover most customization.

This guide walks through the main APIs and links to the reference docs.

### Elements of the picker

This chapter covers the visible parts of the picker you can enable, disable, or add as extra widgets.

In the [tutorial](#tutorial), a `Color` is passed to `color`. That is the pre-selected color. If the widget is rebuilt with a new `color`, it shows that color. `color` is optional and defaults to `Colors.blue`; you normally pass the color you want to edit.

The other core property is `onColorChanged`, a required `ValueChanged<Color>` called whenever a new color is selected. What you do with it depends on your app. In the tutorial we `setState` and show the color on an indicator. In one dialog example it also drove the `AppBar` color. You can drive any theme or widget color the same way.

**The two core properties of the ColorPicker:**

```dart
ColorPicker(
  color: myColor,
  onColorChanged: (Color color) => setState(() => myColor = color),
),
```

To update the picker from outside, assign a new value to the state that you pass as `color` and call `setState`. The [live web demo](https://rydmike.com/flexcolorpicker/) shows updating the picker from other widgets, remote control, and mirroring from another **FlexColorPicker** in a dialog.

#### Enabled color pickers

API reference: [pickersEnabled](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/pickersEnabled.html)

By default, Material **primary** and **accent** pickers are enabled. Pass a `ColorPickerType` to `bool` map to `pickersEnabled`. You only need pairs you want to change; omitted keys keep their defaults (`both`, `bw`, `custom`, `customSecondary` and `wheel` are off unless you enable them).

If only one picker is enabled, the sliding segment is hidden. If every picker is disabled, the Material primary picker is shown.

If other features are left at defaults, disabling only the accent picker gives a compact **minimum picker** of Material primary main colors:

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-1.png?raw=true" alt="Pickers 1"/>

Normally you enable a few more. Below, primary, accent, near black and white, and the wheel are enabled. With more than one picker, the selector appears:

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-2.png?raw=true" alt="Pickers 2"/>

To show primary and accent in one page, enable `ColorPickerType.both` and usually disable `primary` and `accent`, which would duplicate those colors. The live web demo treats those as exclusive. Showing all three is possible but not useful.

#### Enable shades selection

API reference: [enableShadesSelection](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/enableShadesSelection.html)

By default, selecting a Material primary or accent **swatch shade** after the main color is **enabled**. In the compact example above, `enableShadesSelection` was turned off on purpose.

Below, shade selection is on. That is the default, so you usually omit this property. Set `enableShadesSelection` to `false` only when you want to hide shades.

Grey in Flutter has an extra index **850**. Set `includeIndex850` to `true` to include it (default `false`).

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-4.png?raw=true" alt="Pickers 4"/>

#### Tonal palette

API reference: [enableTonalPalette](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/enableTonalPalette.html), [tonalColorSameSize](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/tonalColorSameSize.html), [tonalPaletteFixedMinChroma](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/tonalPaletteFixedMinChroma.html)

By default, the Material 3 tonal palette is off. Set `enableTonalPalette` to `true` to show it.

When it is on, a **15-tone** palette is generated from the selected color (tone 0 black through tone 100 white). The selected color is used as a seed; it may not itself appear in the row. Click any tone to pick it.

Picking a tone selects that color only; it does not rebuild the palette. Selecting a color from the other picker sources uses that color as the new seed.

Palettes are built with [FlexSeedScheme](https://pub.dev/packages/flex_seed_scheme) (`Cam16` and `FlexTonalPalette`). This package does not generate `ColorScheme`s. See the [Material 3 color system](https://m3.material.io/styles/color/the-color-system/key-colors-tones).

By default the palette uses the hue and chroma of the selected color. Set `tonalPaletteFixedMinChroma` to `true` to use a minimum chroma of 48 for all tones (the older Flutter `ColorScheme.fromSeed` primary-palette behavior).

Tonal items are drawn at 10/13 of `width` and `height` so the row can sit closer in width to the 10-color Material primary swatch. Set `tonalColorSameSize: true` to use the same item size as the other indicators.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-tonal-4.png?raw=true" alt="Tonal pickers 4"/>

#### Custom color swatches

API reference: [customColorSwatchesAndNames](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/customColorSwatchesAndNames.html), [customSecondaryColorSwatchesAndNames](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/customSecondaryColorSwatchesAndNames.html)

To use the custom swatch picker, pass your own `ColorSwatch` colors to `customColorSwatchesAndNames`. There are no custom colors by default. If you enable `ColorPickerType.custom` with an empty map, that page is hidden.

A second custom page is available as `ColorPickerType.customSecondary` with `customSecondaryColorSwatchesAndNames`. Same rule: enable it and provide a non-empty map, or it stays hidden. The default segment label is **Option**; override it with `pickerTypeLabels`.

You can build swatches with `MaterialColor` or `MaterialAccentColor`, or with `ColorTools.createPrimarySwatch(color)` and `ColorTools.createAccentSwatch(color)` from a single color. `createPrimarySwatch` uses the color as index `[500]`; `createAccentSwatch` uses it as index `[200]`. Other shades are computed.

> These helpers only produce lighter and darker shades of the given color. If you pass a built-in Material primary `[500]` color into `createPrimarySwatch`, you will not get the same swatch as the SDK primary swatch.

Define a map of swatches to names, then pass it to the picker:

```dart
final Map<ColorSwatch<Object>, String> customSwatches =
<ColorSwatch<Object>, String>{
  const MaterialColor(0xFFfae738, <int, Color>{
    50: Color(0xFFfffee9),
    100: Color(0xFFfff9c6),
    200: Color(0xFFfff59f),
    300: Color(0xFFfff178),
    400: Color(0xFFfdec59),
    500: Color(0xFFfae738),
    600: Color(0xFFf3dd3d),
    700: Color(0xFFdfc735),
    800: Color(0xFFcbb02f),
    900: Color(0xFFab8923),
  }): 'Alpine',
  ColorTools.createPrimarySwatch(const Color(0xFFBC350F)): 'Rust',
  ColorTools.createAccentSwatch(const Color(0xFFB062DB)): 'Lavender',
};
```

```dart
ColorPicker(
  color: myColor,
  onColorChanged: (Color color) => setState(() => myColor = color),
  pickersEnabled: const <ColorPickerType, bool>{
    ColorPickerType.both: false,
    ColorPickerType.primary: true,
    ColorPickerType.accent: true,
    ColorPickerType.bw: false,
    ColorPickerType.custom: true,
    ColorPickerType.wheel: true,
  },
  customColorSwatchesAndNames: customSwatches, // Our custom swatch colors.
```

This creates three custom swatches named Alpine, Rust and Lavender on the **Custom** page.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-6.png?raw=true" alt="Picker 6"/>

#### Customized labels

API reference: [pickerTypeLabels](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/pickerTypeLabels.html)

Picker labels default to English. Override or translate them with a `ColorPickerType` to `String` map on `pickerTypeLabels`. Omit keys you want to leave as default.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-3.png?raw=true" alt="Pickers 3"/>

#### Enable opacity

API reference: [enableOpacity](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/enableOpacity.html)

Set `enableOpacity` to `true` for an opacity slider from 100% opaque to 0% transparent. The checkered track and the selected color's gradient show the result. The thumb sits over the resulting opacity on that background.

The thumb label steps in 1% increments. The slider has 255 steps, one per alpha value. If the color code format includes alpha, you can see single-step alpha changes there.

You cannot pass opacity separately. If the start color has alpha and `enableOpacity` is true, that alpha is used. If opacity is off, alpha in the start color or in a pasted color is ignored and treated as `#FF` opaque.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-5.png?raw=true" alt="Picker 5"/>

#### Show color names

API reference: [showMaterialName](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showMaterialName.html), [materialNameTextStyle](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/materialNameTextStyle.html), [showColorName](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showColorName.html), [colorNameTextStyle](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/colorNameTextStyle.html)

The picker can show the Material color name and shade index, and a general name from `ColorTools.nameThatColor` (closest match in **1566** named codes). You can set text styles for those labels. If omitted they default to `Theme.of(context).textTheme.bodyMedium`.

`ColorTools` also exposes `value32bit`, `alpha8bit`, `red8bit`, `green8bit` and `blue8bit` on `Color` as non-deprecated replacements for `Color.value` and the old 8-bit channel getters. `Color.hex` / `hexAlpha` and `String.toColorShort` help with HEX strings.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-7.png?raw=true" alt="Picker 7"/>

##### Translate Material color names

API reference: [Static color names](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorTools-class.html#static-properties)

Material color names are English statics on `ColorTools`. Assign new strings once at startup, or whenever the locale changes, for example `ColorTools.redName = 'Röd'`.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-8.png?raw=true" alt="Picker 8"/>

> [!NOTE]
> The "name that color" lookup from 1566 names is English only and cannot be translated.

#### Show color code

API reference: [showColorCode](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showColorCode.html), [colorCodeHasColor](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/colorCodeHasColor.html), [showColorValue](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showColorValue.html), [colorCodeTextStyle](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/colorCodeTextStyle.html), [colorCodePrefixStyle](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/colorCodePrefixStyle.html)

The color code field shows the RGB value of the selected color. On the **Wheel** it is also a HEX RGB **entry** field. The wheel indicators move as you type or delete characters.

By default the field has a grey background. You can paint it with the selected color instead. A copy suffix button is **on by default**. Copy-paste options and the prefix format are covered in [copy-paste actions and behavior](#copy-paste-actions-and-behavior).

Set `colorCodeReadOnly` to `true` to prevent editing even on the wheel. `showEditIconButton` (default `false`) shows an edit icon before the field when the wheel is active and the field is editable; `editIcon` defaults to `Icons.edit`. If `colorCodeHasColor` is on, `focusedEditHasNoColor` (default `false`) clears the field color while it has focus so editing is easier. `showColorValue` shows the integer color value next to the HEX field.

`colorCodeTextStyle` defaults to `Theme.of(context).textTheme.bodyMedium`. `colorCodePrefixStyle` defaults to the same style as `colorCodeTextStyle`.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-9.png?raw=true" alt="Picker 9"/>

#### Show recent colors

API reference: [showRecentColors](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showRecentColors.html), [maxRecentColors](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/maxRecentColors.html), [recentColors](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/recentColors.html), [onRecentColorsChanged](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/onRecentColorsChanged.html)

When `showRecentColors` is on, recently selected colors appear in a list at the bottom. The list is first-in, first-out, from 2 to 20 colors (default 5). Change the cap with `maxRecentColors`.

Selecting a recent color moves the picker to the page that contains it and selects it again. If opacity is enabled, the opacity stored with that recent color is applied. While picking new colors with opacity on, the slider value is kept; recent-color selection is the exception.

Selecting a color already on the list does not move it to the front or add a duplicate. The current color is added only when you select a different current color.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-10.png?raw=true" alt="Picker 10"/>

`onRecentColorsChanged` is called every time a color is added, with the full current list. Use it to save and restore recents. Pass a start list with `recentColors` — in-memory for the session, or persisted from a previous one. The live web demo persists recent colors and all other settings.

`showColorPickerDialog` can take a starting `recentColors` list. It does not expose `onRecentColorsChanged`; that callback is on the `ColorPicker` widget.

#### Title and heading widgets

API reference: [title](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/title.html), [heading](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/heading.html), [subheading](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/subheading.html), [tonalSubheading](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/tonalSubheading.html), [wheelSubheading](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/wheelSubheading.html), [opacitySubheading](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/opacitySubheading.html), [recentColorsSubheading](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/recentColorsSubheading.html)

You can pass heading widgets for the toolbar `title`, main `heading`, shade `subheading`, tonal `tonalSubheading`, `wheelSubheading`, opacity `opacitySubheading`, and recent-colors `recentColorsSubheading`. A `null` heading is omitted. Any widget is allowed; typically a `Text` with a suitable style.

`tonalSubheading` sits below the shade `subheading` and is equivalent to it for the tonal row. It is not shown in the example image below.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-11.png?raw=true" alt="Picker 11"/>

### Picker design

These APIs control size, shape and spacing of the color indicators, plus wheel and opacity slider sizing.

[ColorIndicator](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorIndicator-class.html) can also be used outside the picker, as in the default example, to show the selected color and open a dialog.

#### Color picker items

API reference: [height](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/height.html), [width](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/width.html), [borderRadius](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/borderRadius.html), [hasBorder](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/hasBorder.html), [borderColor](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/borderColor.html), [elevation](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/elevation.html), [spacing](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/spacing.html), [runSpacing](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/runSpacing.html)

You can change item `height`, `width`, `borderRadius`, `elevation`, `hasBorder`, and `borderColor` (defaults to the divider theme). `spacing` is the gap between items; `runSpacing` is the gap when they wrap. Material, accent, B&W, custom, shade, and recent-color items use a `Wrap`.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-13.png?raw=true" alt="Picker 13"/>

#### Wheel diameter, width and border

API reference: [wheelDiameter](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/wheelDiameter.html), [wheelWidth](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/wheelWidth.html), [wheelHasBorder](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/wheelHasBorder.html), [borderColor](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/borderColor.html)

The wheel's `wheelDiameter`, `wheelWidth` and border can be changed. `borderColor` is shared with the color items; the wheel has its own `wheelHasBorder` (default false). Wheel width must be 4–50 dp (default 16). Diameter must be 100–500 dp (default 190).

`wheelSquarePadding` (default 0) insets the saturation/value square inside the wheel. `wheelSquareBorderRadius` (default 4) rounds that square.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-15.png?raw=true" alt="Picker 15"/>

#### Opacity slider height, width and thumb radius

API reference: [opacityTrackHeight](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/opacityTrackHeight.html), [opacityTrackWidth](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/opacityTrackWidth.html), [opacityThumbRadius](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/opacityThumbRadius.html)

The opacity slider's `opacityTrackHeight`, `opacityTrackWidth` and `opacityThumbRadius` can be adjusted:

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-16.png?raw=true" alt="Picker 16"/>

If width is not set, the slider expands to the picker width. Minimum width is 150 dp. Height must be 8–50 dp; thumb radius 12–30 dp.

### Picker layout

API reference: [crossAxisAlignment](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/crossAxisAlignment.html), [padding](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/padding.html), [columnSpacing](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/columnSpacing.html), [mainAxisSize](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/mainAxisSize.html)

Use `crossAxisAlignment`, `padding` and `columnSpacing` to adjust the picker column. `columnSpacing` is extra vertical space between column children. `padding` and `crossAxisAlignment` work as in Flutter.

`mainAxisSize` controls whether the picker's column takes `MainAxisSize.max` (default) or `min` on the vertical axis. `toolbarSpacing` and `shadesSpacing` override `columnSpacing` below the toolbar and after the Material swatch row; if null they use `columnSpacing`.

The `title` is not in the body `Column` and is not affected by `crossAxisAlignment`. Treat it like an app bar title: start-aligned, with room for one to four optional action buttons at the end.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-12.png?raw=true" alt="Picker 12"/>

#### Tooltips

API reference: [enableTooltips](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/enableTooltips.html)

`enableTooltips` defaults to true. Set it to `false` to turn all picker tooltips off. You can expose the same toggle in your app for a global tooltip setting; **FlexColorPicker** uses this property for its own tooltips.

Tooltip strings use Flutter Material localizations by default, so they follow the locale for languages Flutter ships. You can still override the labels.

| Usage         | English tooltip | Used MaterialLocalizations.of(context) |
| ------------- | --------------- | -------------------------------------- |
| Copy button   | Copy            | copyButtonLabel                        |
| Paste button  | Paste           | pasteButtonLabel                       |
| OK button     | OK              | okButtonLabel                          |
| Cancel button | Cancel          | cancelButtonLabel                      |
| Close button  | Close           | closeButtonLabel                       |

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-14.png?raw=true" alt="Picker 14" width="500"/>

When keyboard copy/paste shortcuts are enabled, Copy and Paste tooltips also get platform shortcut text: on macOS ` (CMD-C)` / ` (CMD-V)`, elsewhere ` (CTRL-C)` / ` (CTRL-V)`.

### Dialog action buttons

API reference: [ColorPickerActionButtons](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerActionButtons-class.html)

Two configuration classes keep less-used options off the main `ColorPicker` constructor. The first is `ColorPickerActionButtons`, for OK/Cancel actions and their style in the built-in dialogs.

Pass it to `actionButtons`:

```dart
ColorPicker(
  actionButtons: const ColorPickerActionButtons(...),
); 
```

You can put **OK** and **Close** on the top toolbar, or only in the dialog bottom actions. Toolbar buttons are icon-only. Bottom buttons can be `TextButton`, `OutlinedButton`, `ElevatedButton`, `FilledButton`, or `FilledButton.tonal` (`ColorPickerActionButtonType`). Set `dialogActionOnlyOkButton` to show only OK at the bottom.

Icons and tooltips are customizable. Bottom labels default to Material localizations. Bottom buttons can use the same OK/Cancel icons as prefix icons; those icons are shared with the toolbar.

Prefer **either** top **or** bottom actions, not both. The API allows both or a mix. A useful mix is bottom Cancel and OK plus an x Close in the top end, which also cancels. An OK check icon in the toolbar at the same time as a bottom OK is unusual. Without that, toolbar OK and Close are a compact alternative.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-17.png?raw=true" alt="Picker 17"/>

Bottom buttons follow the ambient theme. You can change OK/Cancel order or make it platform adaptive (OK is on the right by default). Style them with `dialogOkButtonStyle` and `dialogCancelButtonStyle`. See the [ColorPickerActionButtons API reference](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerActionButtons-class.html) for the rest.

### Copy-paste actions and behavior

API reference: [ColorPickerCopyPasteBehavior](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior-class.html)

`ColorPickerCopyPasteBehavior` configures copy-paste. Pass it to `copyPasteBehavior`:

```dart
ColorPicker(
  copyPasteBehavior: const ColorPickerCopyPasteBehavior(...),
); 
```

You can control:

* Copy and paste action buttons in the top toolbar.
* Long press and/or right-click copy-paste context menu.
* Ctrl-C and Ctrl-V keyboard shortcuts, including when the edit field is not focused. Shortcuts use Command instead of Ctrl on macOS.
* A copy color action button on the code entry field.

You can also:

* Set the default RGB string format for copy.
* Set icons and an icon theme for copy and paste.
* Set paste parse-error feedback type and message.
* Change copy and paste tooltips.

Paste accepts all RGB string formats in [ColorPickerCopyFormat](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyFormat-class.html). Copy uses only the selected `copyFormat`.

#### Code field copy button

API reference: [editFieldCopyButton](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/editFieldCopyButton.html)

The color code field suffix **copy icon** is enabled by default. Set `ColorPickerCopyPasteBehavior.editFieldCopyButton` to `false` to hide it. The icon itself is `ColorPickerCopyPasteBehavior.copyIcon`.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-18.png?raw=true" alt="Picker 18"/>

#### Keyboard shortcuts

API reference: [ctrlC](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/ctrlC.html), [ctrlV](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/ctrlV.html)

When `ctrlC` and `ctrlV` are `true` (the default), CTRL/CMD-C copies the selected color's RGB code, and CTRL/CMD-V pastes clipboard text. The picker parses it as a color and switches to the most suitable page. Ctrl is used on Windows and Linux; Command on macOS and iOS.

Shortcuts work when one of the picker's focusable widgets has focus: indicators, color field, buttons, picker selector, wheel, and opacity slider. In a modal dialog, one of those typically has focus. On a page with other focused widgets, shortcuts work only after a picker control is focused.

When shortcuts are on, Copy and Paste tooltips include the platform shortcut text, as in the next chapter.

#### Toolbar buttons

API reference: [copyButton](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/copyButton.html), [copyIcon](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/copyIcon.html), [copyTooltip](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/copyTooltip.html), [pasteButton](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/pasteButton.html), [pasteIcon](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/pasteIcon.html), [pasteTooltip](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/pasteTooltip.html)

Set `copyButton` and `pasteButton` to `true` for copy and paste icons at the toolbar end. Defaults are `Icons.copy` and `Icons.paste`; override with `copyIcon` and `pasteIcon`. Tooltips are overridable.

`copyTooltip` defaults to `MaterialLocalizations.of(context).copyButtonLabel`, plus ` (CTRL-C)` or ` (CMD-C)` when keyboard copy is enabled. `pasteTooltip` uses `pasteButtonLabel` plus ` (CTRL-V)` or ` (CMD-V)`.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-19.png?raw=true" alt="Picker 19"/>

#### Context menu

API reference: [secondaryMenu](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/secondaryMenu.html), [longPressMenu](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/longPressMenu.html), [secondaryOnDesktopLongOnDevice](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/secondaryOnDesktopLongOnDevice.html)

The picker can show a copy-paste menu from a long press or a secondary click (usually right mouse button).

Secondary click works well on Windows and Linux desktops, and sometimes in desktop browsers. Browser right-click menus often appear as well and can block the picker's menu. On touch devices, long press is usually better.

* `secondaryMenu` (default false) — secondary click anywhere in the picker opens the menu.
* `longPressMenu` (default false) — long press anywhere opens the menu.
* `secondaryOnDesktopLongOnDevice` (default false) — long press on iOS and Android; secondary click on Windows, macOS, Linux, and desktop web.
* `secondaryOnDesktopLongOnDeviceAndWeb` (default false) — long press on Web, iOS and Android; secondary click on Windows, macOS and Linux, but **not** on desktop web.

> Desktop browsers often steal the secondary-click menu, so `secondaryOnDesktopLongOnDevice` may be a poor fit for desktop web. `secondaryOnDesktopLongOnDeviceAndWeb` prefers long press on web as well.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-20.png?raw=true" alt="Picker 20"/>

Style the popup with [menuThemeData](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/menuThemeData.html), [menuWidth](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/menuWidth.html), [menuItemHeight](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/menuItemHeight.html), and [menuIconThemeData](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/menuIconThemeData.html).

#### Color code formats and paste parsing

API reference: [copyFormat](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/copyFormat.html), [parseShortHexCode](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/parseShortHexCode.html), [editUsesParsedPaste](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/editUsesParsedPaste.html), [snackBarParseError](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/snackBarParseError.html), [snackBarMessage](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/snackBarMessage.html), [snackBarDuration](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/snackBarDuration.html), [feedbackParseError](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior/feedbackParseError.html)

**copyFormat** The code field can show five formats via [ColorPickerCopyFormat](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyFormat-class.html). `copyFormat` also sets the string produced by **any** copy action. Default is `ColorPickerCopyFormat.dartCode`.

| ColorPickerCopyFormat | Resulting format                                                |
| --------------------- | --------------------------------------------------------------- |
| dartCode              | Flutter Hex RGB format '0xAARRGGBB' (**default**)               |
| hexRRGGBB             | Hex RGB format with no alpha 'RRGGBB'                           |
| hexAARRGGBB           | Hex RGB format with alpha 'AARRGGBB'                            |
| numHexRRGGBB          | Web Hex RGB format with a leading # sign and no alpha '#RRGGBB' |
| numHexAARRGGBB        | Web Hex RGB format with a leading # sign and alpha '#AARRGGBB'  |

Paste accepts any of those formats.

The paste parser strips characters that are not HEX-related and truncates from the right to the max length of those formats. Partial values such as `0`, `aC`, `#334` and `0xFF34` are allowed and treated as right-aligned in the full 8-character hex code.

If a pasted string has no alpha, alpha is set to `FF`. If it includes alpha but [enableOpacity](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/enableOpacity.html) is false, that alpha is replaced with `FF`.

**parseShortHexCode** Set `parseShortHexCode` to `true` (default false) to accept CSS/WEB 3-character hex, so `123`, `ABC`, `F0C` and `5D1` become `112233`, `AABBCC`, `FF00CC` and `55DD11`.

**editUsesParsedPaste** Set `editUsesParsedPaste` to `true` (this is the **default**) so the color code field uses the same paste parser as the other paste actions. A paste then replaces the field with the parsed color, converted back to a string, instead of inserting raw clipboard text. The field still only accepts HEX characters (`0–9`, `A–F`).

When `false`, keyboard paste into the focused field behaves like a normal text field, aside from HEX filtering. That matches very old 1.x field paste behavior and is rarely what you want. This setting currently affects CTRL-V / CMD-V on desktops; Android and iOS paste into the field is not intercepted when it is `true`.

**snackBarParseError** Set `snackBarParseError` to `true` to show a snack bar when a paste cannot be parsed as a color.

**snackBarMessage** Label for that snack bar. If null, it uses Material localizations `pasteButtonLabel`: `invalidDateFormatLabel` — in English, **Paste: Invalid format**. The `SnackBar` uses the nearest `SnackBarThemeData`.

Example of `copyFormat`, `parseShortHexCode`, `editUsesParsedPaste` and `snackBarParseError`:

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-21.png?raw=true" alt="Picker 21"/>

**snackBarDuration** How long the parse-error snack bar stays up. Default `const Duration(milliseconds: 1800)`.

**feedbackParseError** If `true`, the device may vibrate or play a click/alert on a paste parse error. Support in Flutter is limited. This package does not add plugins for sound. Defaults to `false`.

### onChange callbacks

API reference: [onColorChanged](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/onColorChanged.html), [onColorChangeStart](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/onColorChangeStart.html), [onColorChangeEnd](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/onColorChangeEnd.html), [onRecentColorsChanged](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/onRecentColorsChanged.html)

These callbacks report selection as it happens. Only `onColorChanged` is required; omit the others if you do not need them. Null callbacks are not called.

**onColorChanged** Required `ValueChanged<Color>`. Called whenever the color changes: a click on a color item, wheel or opacity thumb movement, or a character in the code field. Changing which picker type is visible does not call it until a color on that page is selected.

**onColorChangeStart** Optional. Called when the user starts a selection, with the color **before** the new value is applied. For a click on a swatch item, that is the previous color. It also fires with the current color when interaction starts on the wheel or opacity slider.

**onColorChangeEnd** Optional. Called when the user finishes, with the new color. A click on a color item ends immediately, so this returns the clicked color at once. On the wheel and opacity slider it fires when the gesture ends. `onColorChanged` and `onColorChangeEnd` then agree on the final color; `onColorChangeEnd` is only the end of wheel/slider interaction.

If you log state, use **start** and **end** to record the color when a change begins and store the result only if it differed. That avoids logging every `onColorChanged` tick from the wheel and slider. [`showColorPickerDialog`](#function-showcolorpickerdialog) is another way to avoid intermediate values when you only need the color after the dialog closes.

Keyboard entry in the code field changes the color per character, so start and end fire for every character, like clicking items or pasting.

The [live web demo](https://rydmike.com/flexcolorpicker/#/) includes trackers so you can watch these callbacks.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-22.png?raw=true" alt="Picker 22"/>

**onRecentColorsChanged** Optional `ValueChanged<List<Color>>`. Called whenever a color is added to the recent list, with the full list. Pass a start list via `recentColors` to restore recents for the session or from persistence.

### Dialogs

**FlexColorPicker** has two built-in dialogs. You can also put `ColorPicker()` in your own dialog or overlay. Both built-in dialogs share the same dialog under the hood; they target different use cases.

#### ColorPicker showPickerDialog method

API reference: [showPickerDialog](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showPickerDialog.html)

This dialog lets you listen to **onChange** callbacks while it is open, so you can update widgets or the theme as the user drags the wheel and sliders.

The default example [earlier](#dialog-colorpicker-method) shows [ColorPicker(...).showPickerDialog](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showPickerDialog.html).

You must keep the color in your own state: store it before opening, and restore it if the dialog is canceled. That is more work than the convenience function, but it is how live updates work.

#### Function showColorPickerDialog

API reference: [showColorPickerDialog](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/showColorPickerDialog.html)

`showColorPickerDialog` is often simpler. Pass a `BuildContext` and the start color, plus any picker and dialog setup, and `await` the `Color`. Cancel or dismiss returns the start color.

It cannot update the UI behind the dialog while it is open, and it does not expose `onRecentColorsChanged`. You can still pass a starting `recentColors` list.

For "open a dialog, pick a color, move on", this is the smaller API. It wraps `ColorPicker` and `showPickerDialog`, so it shares their other properties.

The default example [earlier](#dialog-colorpicker-function) shows [showColorPickerDialog](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/showColorPickerDialog.html).

`elevation` and `title` on `ColorPicker` would clash with the same names on the dialog, so in `showColorPickerDialog` the dialog's elevation and title are `dialogElevation` and `dialogTitle`.

## Desktop and web

**FlexColorPicker** works on all Flutter platforms: Android, iOS, Web, Windows, macOS and Linux. Below is the demo on Windows.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerEnterCode.gif?raw=true" alt="ColorPicker on Windows" width="350"/>

The live [web demo](https://rydmike.com/flexcolorpicker/) is a web build. The opacity slider uses `ImageShader`, which current Flutter web renderers support.

Pick-item focusing behaves as you would expect. The picker supports keyboard navigation and activation, especially in a dialog where other controls do not steal the focus order. If configured, copy-paste shortcuts adapt to the desktop platform.

The wheel cannot be operated with the keyboard alone; it needs a mouse or touch. The opacity slider can be operated from the keyboard.

The picker-type control is a `CupertinoSlidingSegmentedControl` and does not support keyboard control.

## Additional resources

There are more `ColorPicker` options than this guide covers. See the [API reference](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/flex_color_picker-library.html). The barrel also exports `ColorIndicator`, `ColorWheelPicker` and `ColorCodeField` for use on their own.

The live web example source is in `example/lib/demo`. Its setting controls show API names in tooltips, which is a quick way to look up properties while you try them.

**Happy color picking!**
