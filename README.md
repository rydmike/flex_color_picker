# Flex ColorPicker

**NOTE:** This is a development preview release. The package is still under development. The API may still be modified before its first official release.

Flex ColorPicker is a customizable color picker for Flutter. The `ColorPicker` can show six different types of color pickers, three of which are used for the standard Flutter Material colors and their shades. The size and style used for the pick items can be customized.

![ColorPicker variations upper](/resources/ColorPickerAllSize50-upper.png)

#### The different types of available pickers are

1. Material primary colors and its shades. `ColorPickerType.primary`
2. Material accent colors and its shades. `ColorPickerType.accent`
3. Both primary and accent colors and their shades, in the same color picker. `ColorPickerType.both`
4. Black and white colors, including near black and near white shades. `ColorPickerType.bw`
5. Custom material like colors and their shades, that you define and name. `ColorPickerType.custom`
6. A HSV color wheel picker, that allows you to select any color. Material primary color like shades for the selected color are computed automatically. `ColorPickerType.wheel`

When you show more than one color picker, a segmented sliding control allows you to select which one to use. You can configure the `ColorPicker` to include any of the above color pickers. Showing pickers 1 and 2, together with picker 3 is not very useful, they are available as optional ways of showing and selecting the standard Material primary and accent colors.

You provide the color picker with its heading and sub headings, typically Text widgets with appropriate style. You also define if the Material shades can be selected or not and if the selected color names and values are shown in the picker. If the color HEX RGB code is shown, the picker includes a button that allows you to copy the selected color code to the clipboard.

The shape, size and spacing of the color picker items can be modified. There is a built in dialog that can be used to show and use the `ColorPicker` in a pre-made dialog. You can of course also make your own dialog and just use the color picker widget in your own custom dialog.

![ColorPicker variations upper](/resources/ColorPickerAllSize50-lower.png)


## Getting Started

In the `pubspec.yaml` of your **Flutter** project, add the following dependency:

```yaml
dependencies:
  ...
  flex_color_picker:
```

In your library file add the following import:

```dart
import 'package:flex_color_picker/flex_color_picker.dart';
```

### Example Application

To try a basic example of the ColorPicker on a device or simulator, clone the flex color picker repository and run the example:

```bash
cd example/
flutter run --release
```

The result is a default color picker with only the primary and accent color pickers available. Plus another picker that opens up in a dialog, with all pickers enabled, except 3 `ColorPickerType.both` and 4 `ColorPickerType.bw`.

![ColorPicker Basic](/resources/ColorPickerSimpleDemo.png)

### Live Web Example

You can also try a live web example of the ColorPicker [here](https://rydmike.com/democolorpicker). With the web demo you can modify many of the ColorPicker's API values and use it as a tool to find settings and a style that fits your application.

The source code for the Web demo, which is a slightly more elaborate example than the basic sample bundled with the package, is available separately [here](https://github.com/rydmike/color_picker_demo).

![ColorPicker WEB demo](/resources/WebDemo.png)

## Introduction to the ColorPicker

As an introduction to the ColorPicker we will go through the example application. The example uses a StatefulWidget where we define a `Color` variable and give it a start value in the `StatefulWidget`'s `initState()`.

```dart
class _ColorPickerPageState extends State<ColorPickerPage> {
  Color screenPickerColor;

@override
void initState() {
  super.initState();
  screenPickerColor = Colors.blue;
}
```

Add the `ColorPicker` to the build method, could for example be in a `ListView` or `Column`. Give it the defined starting color, a `heading` and `subHeading`, plus the required `onColorChanged` callback function. Use the color from the callback in a `setState()` to modify the `screenPickerColor` to the color value returned by the callback. The callback in the ColorPicker is called whenever you select a new color in the `ColorPicker`.

```dart
ColorPicker(
  color: screenPickerColor,
  onColorChanged: (Color color) =>
    setState(() => screenPickerColor = color),
  heading: Text(
    'Select color',
    style: Theme.of(context).textTheme.subtitle1,
  ),
  subheading: Text(
    'Select color shade',
    style: Theme.of(context).textTheme.subtitle1,
  ),
),
```

The result will look like this:

![ColorPicker default](/resources/ColorPicker01.png)

Change the pick item style, by giving it a defined size and let's make it circular:

```dart
ColorPicker(
  color: screenPickerColor,
  onColorChanged: (Color color) =>
    setState(() => screenPickerColor = color),
  width: 44,
  height: 44,
  borderRadius: 22,
 :
),
```

You can use same the `ColorIndicator` Widget that the `ColorPicker` uses internally as a color indicator. Here we use it in a `ListTile` as its trailing property to show the selected color. The `ColorPicker` also includes `ColorTools`, a set of statical helper functions, that you can use to display names of the standard material colors and their shade index value, as well as an optional Flutter style Hex color code. Below we use it in a `ListTile` `subtitle` property to describe the selected color.

```dart
ListTile(
  title: const Text('Select color above to change this color'),
  subtitle: Text(ColorTools.colorNameAndHexCode(screenPickerColor)),
  trailing: ColorIndicator(
    width: 44,
    height: 44,
    borderRadius: 22,
    color: screenPickerColor,
  ),
),
```

This gives us round color pick items and an indicator for the selected color:

![ColorPicker round with indicator](/resources/ColorPicker02.png)

## ColorPicker as a Dialog

A common use case for a color picker is to show a color selection widget and allow the user to select a new color in a dialog. The `ColorPicker` comes with a built in dialog that can be used for this. Alternatively you can use the `ColorPicker` widget to build your own dialog based on it.

For the dialog example we will show all the built in picker color selection options, except the one that shows both primary and accent colors in the same picker and we also add custom colors to the **Custom** colors section of the `ColorPicker`.

First we define our custom colors and from our single color definitions we create primary and accent color swatches, by using `ColorTools.createPrimaryColor` or alternatively `ColorTools.createAccentColor` for accent color swatches. We add these color swatches to a `ColorSwatch` Map, that we map to our own custom names for our custom color swatches. You don't have to use the `ColorTools` to create the color swatches from a given single color, you can just as well define and use your own custom hand tuned `ColorSwatch` swatches, but the functions are convenient helpers that can make Material like color swatches from a single color.

```dart
  // Define custom colors.
  static const Color googlePrimary = Color(0xFF6200EE);
  static const Color googlePrimaryVariant = Color(0xFF3700B3);
  static const Color googleSecondary = Color(0xFF03DAC6);
  static const Color googleSecondaryVariant = Color(0xFF018786);
  static const Color googleError = Color(0xFFB00020);
  static const Color googleErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom color swatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimaryColor(googlePrimary): 'G Purple',
    ColorTools.createPrimaryColor(googlePrimaryVariant): 'G Purple Variant',
    ColorTools.createAccentColor(googleSecondary): 'G Teal',
    ColorTools.createAccentColor(googleSecondaryVariant): 'G Teal Variant',
    ColorTools.createPrimaryColor(googleError): 'G Error',
    ColorTools.createPrimaryColor(googleErrorDark): 'G Error Dark',
    ColorTools.createPrimaryColor(blueBlues): 'Blue blues',
  };
```

Then add a variable for the dialog picked color `dialogPickerColor` and set a start value for it as well.

```dart
class _ColorPickerPageState extends State<ColorPickerPage> {
  Color screenPickerColor;
  Color dialogPickerColor;

@override
void initState() {
  super.initState();
  screenPickerColor = Colors.blue;
  dialogPickerColor = Colors.red;
}
```

We use another `ListTile` to display a `ColorIndicator`, that we style a bit differently for this example. We also use its `onSelect` callback to open a dialog with another `ColorPicker`. Before we open the dialog we store the current `dialogPickerColor`'s color value. This way we can restore this color value if the user cancels the dialog.

```dart
  ListTile(
    title: const Text('Click this color to change it in a dialog'),
    subtitle: Text(
      ColorTools.colorNameAndHexCode(
        dialogPickerColor,
        colorSwatchNameMap: colorsNameMap,
      ),
    ),
    trailing: ColorIndicator(
      width: 44,
      height: 44,
      borderRadius: 3,
      color: dialogPickerColor,
      onSelect: () async {
        final Color colorBeforeDialog = dialogPickerColor;
        if (!(await colorPickerDialog())) {
          setState(() {
            dialogPickerColor = colorBeforeDialog;
          });
        }
      },
    ),
  ),
```

Create a method to show the dialog. The `colorPickerDialog` is an asynchronous bool function, that returns `true` if the user closed the dialog picker with the **Select** button. If **Cancel** was selected or user dismissed the dialog by clicking outside of it, `false` is returned.

The `pickerEnabled` takes a map with `ColorPickerType` enum keys to a boolean values. It defines which color pickers we want to enable and use in the `ColorPicker`. In the example below we included Material primary, accent and the above custom colors, plus the HSV color wheel that allows us to select any color. We did not include the picker that combines the primary and accent colors in the same picker, nor the black and white shades picker.


```dart
  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      showNameSelected: true,
      width: 40,
      height: 40,
      borderRadius: 3,
      hasBorder: true,
      spacing: 3,
      runSpacing: 3,
      wheelDiameter: 160,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subWheelHeading: Text(
        'Selected color and its material like shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
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
      constraints:
          const BoxConstraints(minHeight: 445, minWidth: 400, maxWidth: 400),
    );
  }
```

The above example uses a few more styling properties, but most importantly it uses the `showPickerDialog` method to show the defined `ColorPicker` in a dialog. The dialog needs a context, so we pass it along to it.

We also define size constraints for the dialog. If you do not define size constraints, it will auto size to fit the dialog content. Using constraints allows the dialog to keep the same size when the content size changes slightly as you switch between the different color selection tools you enabled. It looks better if the dialog size does not change when you switch picker type with the selector. The color wheel picker in particular will often require a bit more space. The wheel size can be customized as well, it does however become more difficult to operate if it is made very small. In this example it is on purposes of the lower side of still usable size.

The end result of the above setup is a `ListTile` where the trailing color indicator widget can be clicked to open a dialog to select a new color for the trailing `ColorIndicator` color.

As the `dialogPickerColor` color is changed in the dialog, the `ColorIndicator`'s color also changes interactively. If the selection is cancelled the `ColorIndicator`'s original color is restored.

![ColorPicker dialog demo](/resources/ColorPickerSimpleDemo.gif)

As an extra exercise, and to better see this interactive change of the color when it is modified in the dialog, try connecting the `dialogPickerColor` value to the `AppBar`'s `backgroundColor` property. Did you manage to do it? What happened?

```dart
:
appBar: AppBar(
  backgroundColor: dialogPickerColor,
  elevation: 1,
  centerTitle: true,
  title: const Text('Color Picker Simple Demo'),
),
```

As can be seen below, now the selected color in the dialog changes the `AppBar`'s color as you select color in the dialog and cancelling it restores the `AppBar`'s color as well, **pretty cool!**

You can connect the color to theme colors and modify your application's theme color values interactively as well, but that goes beyond the scope of this example.

![ColorPicker appbar demo](/resources/ColorPickerSimpleDemoAppBar.gif)

## Going deeper

The above introduction was a walk through of the bundled example, please see the example section for the complete source code.

There are more configuration options available for the `ColorPicker`. Use the API reference guide for additional information. You can also study the more complete [live web example](https://rydmike.com/democolorpicker/) and its [source code](https://github.com/rydmike/color_picker_demo).

Happy color picking!
