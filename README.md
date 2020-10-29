# ColorPicker

ColorPicker is a highly configurable color picker for Flutter. The ColorPicker can show anywhere
from 1 to 6 different color tools to pick colors from.

1. Material primary colors and its shades.
2. Material accent colors and its shades.
3. Material primary and accent colors and their shades in the same color picker.
4. Black and White colors, including near black and near white shades.
5. Custom material like colors and their shades, that you define and name.
6. A HSV color wheel picker that allows you to select any color. Material primary color like shades for the selected color are computed as well.

When you show more than one color selection tool, there is slider that allows you to select which one to use. You can configure the color picker to include any of the above pickers. Showing 1 and 2, together with 3 is not very logical, they are available as optional ways of showing the Material primary and accent colors.

If the picker's headings, sub headings and if Material shades are used or not can be configured and you can provide your own heading and sub-heading widget. Usually it is a Text widget with appropriate style.

The shape, size and spacing of the color picker items can be customized. There is built in dialog that can be used to show the ColorPicker in a pre-made dialog, but you can also make your own dialog and just use the ColorPicker in your own custom dialog. The example below show some variations of the ColorPicker.

![ColorPicker variations](/resources/ColorPickerAllSize50.png)


## Getting started

In the `pubspec.yaml` of your flutter project, add the following dependency:

```yaml
dependencies:
  ...
  color_picker:
```

In your library add the following import:

```dart
import 'package:color_picker/color_picker.dart';
```

### Simple example app

To try a basic example of ColorPicker on a device or simulator, clone the ColorPicker repository and run the example:

```bash
cd example/
flutter run --release
```

The result is a basic default picker on the canvas and one picker that opens in the provided dialog, which is configured to have a few more options present.

![ColorPicker Basic](/resources/ColorPickerSimpleDemo.png)

### Live Web example

You can also try a live web example of the ColorPicker [here](https://rydmike.com/democolorpicker). With the demo you can modify most of the ColorPicker's API settings and use it as a tool to find settings and a style that you like and that fit your application.

The source for this Web demo and slightly more elaborate example than the basic sample bundled with the package, is available [here](https://github.com/rydmike/color_picker_demo).

![ColorPicker WEB demo](/resources/ColorPickerWeb.gif)


## Using the ColorPicker - Introduction

Create a ColorPicker in stateful Widget and give it a color:

```dart
class _ColorPickerPageState extends State<ColorPickerPage> {
  Color screenPickerColor;

@override
void initState() {
  super.initState();
  screenPickerColor = Colors.blue[500];
}
```

Add the ColorPicker in your build method, give it the starting color, a heading and sub-heading if you like and the required onColorChanged callback function, that you can use to modify the provided color color to the selected color in the color picker.

```dart
ColorPicker(
  color: screenPickerColor,
  onColorChanged: (Color color) =>
    setState(() => screenPickerColor = color),
  heading: Text(
    'Select color',
    style: Theme.of(context).textTheme.subtitle1,
  ),
  subHeading: Text(
    'Select color shade',
    style: Theme.of(context).textTheme.subtitle1,
  ),
),
```

The result will look like this

![ColorPicker default](/resources/ColorPicker01.png)

If you like you can change the pick item style and size.

```dart
ColorPicker(
  size: 44,
  borderRadius: 22,
  color: screenPickerColor,
  onColorChanged: (Color color) =>
    setState(() => screenPickerColor = color),

 :

),
```

You can also use same the ColorIndicator Widget that the ColorPicker uses for selecting a color as a color indicator as well. In the demo it is used in a ListTile as its trailing property to show the selected color. The ColorPicker also includes some extra color tools that you can use to display names of the standard material colors and their shade index, plus optionally a Flutter style Hex color code.

```dart
ListTile(
  title: const Text('Select color above to change this color'),
  subtitle: Text(
    ColorTools.colorNameAndHexCode(screenPickerColor),
  ),
  trailing: ColorIndicator(
    height: 44,
    width: 44,
    borderRadius: 22,
    color: screenPickerColor,
  ),
),
```

Creating a round color pick item and a separate indicator for the selected color.
![ColorPicker round with indicator](/resources/ColorPicker02.png)

## ColorPicker - As a dialog

A common use case for a color picker is to show a color selection widget and allow the user to choose a new color in a dialog or cancel the color selection. The ColorPicker comes with a built in dialog that can be used for this. Alternatively you can just use the ColorPicker Widget to build you own dialog based on it.

For the dialog example we will show a few more of the built in picker options and also add some custom colors to the Custom colors section of the ColorPicker.

First we define some custom colors, and from the single color we create primary and accent color swatches, that we add to ColorSwatch Map that we map to a custom name for the swatch.

```dart
  // Define some custom colors.
  static const Color googlePrimary = Color(0xFF6200EE);
  static const Color googlePrimaryVariant = Color(0xFF3700B3);
  static const Color googleSecondary = Color(0xFF03DAC6);
  static const Color googleSecondaryVariant = Color(0xFF018786);
  static const Color googleError = Color(0xFFB00020);
  static const Color googleErrorDark = Color(0xFFCF6679);
  static const Color mrBlue = Color(0xFF174378);

  // Make a custom color swatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimaryColor(googlePrimary): 'G Purple',
    ColorTools.createPrimaryColor(googlePrimaryVariant): 'G Purple Variant',
    ColorTools.createAccentColor(googleSecondary): 'G Teal',
    ColorTools.createAccentColor(googleSecondaryVariant): 'G Teal Variant',
    ColorTools.createPrimaryColor(googleError): 'G Error',
    ColorTools.createPrimaryColor(googleErrorDark): 'G Error Dark',
    ColorTools.createPrimaryColor(mrBlue): 'MrBlue',
  };
```

Create a map from all the ColorPickerSwatch enum values to a boolean value, that defines witch swatches we want to include in the color picker. We will include material primary, accent the above custom colors and the HSV color wheel that allows us to select any color.

```dart
  static final Map<ColorPickerSwatch, bool> swatchesAvailable =
      <ColorPickerSwatch, bool>{
    ColorPickerSwatch.both: false,
    ColorPickerSwatch.material: true,
    ColorPickerSwatch.accent: true,
    ColorPickerSwatch.bw: false,
    ColorPickerSwatch.custom: true,
    ColorPickerSwatch.any: true,
  };
```

Add a variable for a our dialog picked color and start value for it.

```dart
class _ColorPickerPageState extends State<ColorPickerPage> {
  Color screenPickerColor;
  Color dialogPickerColor;

@override
void initState() {
  super.initState();
  screenPickerColor = Colors.blue[500];
  dialogPickerColor = Colors.red[700];
}
```

We use a ListTile to display a ColorIndicator, that we style a bit differently in this case. We also use its onSelect callback to open a dialog with the a ColorPicker. Before we open the dialog we store the current color we want to manipulate in the dialog.

```dart
  // Pick color in a dialog.
  ListTile(
    title: const Text('Click this color to change it in a dialog'),
    subtitle: Text(
      ColorTools.colorNameAndHexCode(
        dialogPickerColor,
        colorSwatchNameMap: colorsNameMap,
      ),
    ),
    trailing: ColorIndicator(
      height: 40,
      width: 40,
      borderRadius: 3,
      color: dialogPickerColor,
      onSelect: () async {
        final Color _colorBeforeDialog = dialogPickerColor;
        if (!(await colorPickerDialog())) {
          setState(() {
            dialogPickerColor = _colorBeforeDialog;
          });
        }
      },
    ),
  ),
```


The colorPickerDialog is asynchronous boolean function that returns true if the user closed the dialog picker with the Select button. If Cancel was selected or user dismissed the dialog by clicking outside of it, false is returned.


```dart
  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      showNameSelected: true,
      size: 40,
      borderRadius: 3,
      padding: 8,
      spacing: 3,
      runSpacing: 3,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subHeading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subWheelHeading: Text(
        'Selected color and its material like shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      swatchAvailable: swatchesAvailable,
      colorSwatchNameMap: colorsNameMap,
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 475, minWidth: 480, maxWidth: 480),
    );
  }
```

The above example uses a few more styling properties, but most importantly it uses the .showPickerDialog method to show the defined ColorPicker in a dialog. The dialog needs a context, so we pass it along to it. Here we also define size constraints for the dialog. If you do not define size constraints, it will auto size to fit the dialog content. The constraints will help the dialog to keep the same size when the contents changes as you switch between the different picker types you enabled. It looks better if the dialog size does not change when you switch picker styles, the color wheel picker in particular will often require a bit more space. The wheel size can be customized as well, it does however become more difficult to operate with touch and less accurate if it is made very small.

The end result of the above setup is a ListTile where the trailing color indicator widget can be clicked, to select a new color for the trailing ColorIndicator color. As the color is changed in the dialog the ColorIndicator's color also changes. If the selection is cancelled the ColorIndicator's original color is restored.

![ColorPicker dialog demo](/resources/ColorPickerSimpleDemo.gif)


As an extra exercise try connecting the dialogPickerColor value the AppBar's backgroundColor property. Did you manage to do it? What happened?

```dart
:
appBar: AppBar(
  backgroundColor: dialogPickerColor,
  elevation: 1,
  centerTitle: true,
  title: const Text('Color Picker Simple Demo'),
),
```

As shown below, now the selected color in the dialog changes the app bar color as you select color in the dialog and cancelling it restores the app bar color as well. Pretty cool! You can even connect the color to theme colors and modify your applications theme color values interactively, but that goes beyond this example.

![ColorPicker appbar demo](/resources/ColorPickerSimpleDemoAppBar.gif)


## Digging deeper

The above introduction was a walk through of the bundled example, please see the example section for its complete source code.

There are many more configuration options available for the ColorPicker, use the API reference guide for additional information. You can also study the more complete [live web example](https://rydmike.com/democolorpicke/) and its [source code](https://github.com/rydmike/color_picker_demo).
