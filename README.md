# FlexColorPicker

FlexColorPicker is a customizable color picker for Flutter. The `ColorPicker` can show six different types of color 
pickers, three of which are used for the standard Flutter Material colors and their shades. The size and style used 
for the pick items can be customized.

The picker is also Windows, Mac, Linux and Web desktop compatible with focus handling, optional menus for handling
copy-paste of color from/to the picker, including desktop keyboard copy/paste shortcuts.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerAllSize50-upper.png?raw=true" alt="ColorPicker variations upper"/>

## Contents
- [FlexColorPicker](#flexcolorpicker)
    - [Contents](#contents)
    - [Picker Types](#picker-types)  
    - [Getting Started](#getting-started)
        - [Default Example Application](#default-example-application)
        - [Live Web Demo](#live-web-demo)
    - [Simple Example](#simple-example)
    - [Dialog Example](#dialog-example)
---

## Picker Types

The different types of available color pickers are:

1. Material primary colors and its shades. `ColorPickerType.primary`
2. Material accent colors and its shades. `ColorPickerType.accent`
3. Both primary and accent colors and their shades, in the same color picker. `ColorPickerType.both`
4. Black and white colors, including near black and near white shades. `ColorPickerType.bw`
5. Custom material like colors and their shades, that you define and name. `ColorPickerType.custom`
6. HSV color wheel picker, that allows you to select or enter any color. `ColorPickerType.wheel`

When you show more than one color picker, a segmented sliding control allows you to select which one to use. You can 
configure the `ColorPicker` to include any of the above color pickers. Showing pickers 1 and 2, together with picker 3 
is not very useful, they are available as optional ways of showing and selecting the standard Material primary and 
accent colors.

Give the `ColorPicker` a heading and a subheading for the color shades, typically Text widgets with appropriate style. 
Decide if the Material shades can be selected or not and if the selected color names and code are visible in the 
picker. If the color HEX RGB code is visible, the picker also includes a button that allows you to copy the selected 
color's code to the clipboard. On the wheel picker you can also enter a HEX RGB for the color to be selected.

The shape, size and spacing of the color picker items can be modified. There is a built-in dialog that can be used to
show and use the `ColorPicker` in a pre-made dialog. You can of course also make your own dialog and just use the color
picker widget in your own custom dialog.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerAllSize50-lower.png?raw=true" alt="ColorPicker variations lower"/>

## Getting Started

In the `pubspec.yaml` of your **Flutter** project, add the following dependency:

```yaml
dependencies:  
  flex_color_picker: ^2.0.0-nullsafety.5
```

In your library file add the following import:

```dart
import 'package:flex_color_picker/flex_color_picker.dart';
```

### Default Example Application

To try a basic example of the ColorPicker on a device or simulator, clone the flex color picker repository and run 
the example:

```bash
cd example/
flutter run --release
```

The result is a default color picker with only the primary and accent color pickers available. Plus another picker 
that opens up in a dialog, with all pickers enabled, except 3 `ColorPickerType.both` and 4 `ColorPickerType.bw`.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerSimpleDemo.png?raw=true" alt="ColorPicker Basic"/>

### Live Web Demo

You can also try a live web demo of the [**FlexColorPicker here**](https://rydmike.com/flexcolorpicker). With the Web
demo you can modify most of the color picker's settings, and use it as a tool to find a style that fits your 
application.

The source code for the Web demo, which is a bit more elaborate example than the default example, is also bundled with 
the package source code in "example/lib/demo/main.dart".

The WEB demo has a responsive view, the expands into maximum four separately scrollable columns. The columns contain
a massive amount of controls that you can use to adjust the picker's settings. On a normal 1080p desktop screen, you 
can see most of the settings at the same time as the adjusted picker, so you test and see their impact on the picker 
as you adjust them. 

The WEB demo also has tooltips on each control that show the name of the API it uses and its current value. 
With this feature you can use the web demo as a tool configure the color picker to desired style, and find the APIs 
and values that you used. The same toggle that is used to demo turning OFF the tooltips in the picker, also turns OFF
the API tooltips in the demo, in case they get in the way, by default they are ON, to show the used API and 
its value.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/web_color_picker_v2.gif?raw=true" alt="ColorPicker WEB demo"/>

## Simple Example

The default bundled example application is used as an introduction to the color picker. The example uses a 
StatefulWidget where we define a `Color` variable and give it a start value in the `StatefulWidget`'s `initState()`.

```dart
class _ColorPickerPageState extends State<ColorPickerPage> {
  late Color screenPickerColor;

@override
void initState() {
  super.initState();
  screenPickerColor = Colors.blue;
}
```

We can use the `ColorIndicator` Widget that the `ColorPicker` uses internally to show and select a new color. 
Alternatively you can make and use a custom for Widget for this purpose. Here we use the `ColorIndicator` in 
a `ListTile`, we add it above the `ColorPicker` and use the `ColorIndicator` as its trailing property to show the 
selected color.

The color picker also includes `ColorTools`, a set of helper functions, that you can use to display names of the 
standard material colors, and their shade index value, as well as an optional Flutter style Hex color code. Below 
we use `ColorTools.materialNameAndCode` in the `ListTile`'s `subtitle` property, to describe the selected color. 
We show its Material color name and index, as well as its Flutter style HEX code. We also use the 
`ColorTools.nameThatColor` function, that will name any color based on the closest matching color, from a list 
consisting of **1566** colors and their English names.

We begin by adding this ListTile to a ListView in the Scaffold body.

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: const Text('FlexColorPicker Demo'),
    ),
    body: Scrollbar(
      child: ListView(
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

Next we add the `ColorPicker` to the `ListView`. We give it the defined starting color, in this case 
`screenPickerColor`, a `heading` and `subHeading`, plus the required `onColorChanged` callback function. 

We use the color from the callback in a `setState()` to modify the `screenPickerColor` to the color returned by
the callback. The callback in the ColorPicker is called whenever you select a new color in the `ColorPicker`. In 
this example we have also wrapped the color picker in a `Card`.

```dart
  // Show the color picker in sized box in a raised card.
  SizedBox(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Card(
        elevation: 2,
        child: ColorPicker(
          color: screenPickerColor,
          onColorChanged: (Color color) =>
            setState(() => screenPickerColor = color),
          width: 44,
          height: 44,
          borderRadius: 22,
          heading: Text(
            'Select color',
            style: Theme.of(context).textTheme.headline5,
          ),
          subheading: Text(
            'Select color shade',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    ),
  ),
```

This gives us round color pick items and an indicator for the selected color:

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPicker02.png?raw=true" alt="ColorPicker round with indicator" width="300"/>

## Dialog Example

A common use case for a color picker is to show a color selection widget and allow users to select a new color in 
a dialog. The `ColorPicker` comes with a built-in dialog that can be used for this. Alternatively you can just use 
the `ColorPicker` widget and include it in your own custom dialog.

For the dialog example we will show all the built-in picker color selection options, except the combined primary and 
accent colors picker, and the black and white shades' picker. We will also add some custom colors for the **Custom** 
colors section of the `ColorPicker`.

First we define our custom colors and from our color definitions we create primary and accent color swatches by 
using `ColorTools.createPrimarySwatch` or `ColorTools.createAccentSwatch` for accent color swatches. 

We add these color swatches as keys to a `ColorSwatch` `Map`, that we map to our own custom `String` name values 
for our custom color swatches. You don't have to use the `ColorTools` functions to create the color swatches from 
a color, you can just as well define and use your own custom hand tuned `ColorSwatch` swatches. The `ColorTools`
functions are just convenient helpers that can be used to make Material like primary and accent color 
swatches from a single color.

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

Then add a `Color` object for the dialog picked color `dialogPickerColor` and set a start value for it as well, we use
red in this case.

```dart
class _ColorPickerPageState extends State<ColorPickerPage> {
  late Color screenPickerColor;
  late Color dialogPickerColor;

@override
void initState() {
  super.initState();
  screenPickerColor = Colors.blue;
  dialogPickerColor = Colors.red;
}
```

We use another `ListTile` to display a `ColorIndicator`, that we style a bit differently for this example. We also 
use its `onSelect` callback to open a dialog with another `ColorPicker`.

Before we open the dialog we store the current `dialogPickerColor`'s color value. This way we can restore this 
color value if the user cancels the dialog. We put this ListTile before the previous one, first in our list view. 
This will just ensure that it does not get hidden by the dialog on most phones.

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

Next we create a method to show a `ColorPicker` with the built-in dialog. The `colorPickerDialog` is an asynchronous
bool function, that returns `true` if the user closed the dialog picker with the **Select** button. If **Cancel** 
was selected or user dismissed the dialog by clicking outside it, `false` is returned.

The `pickersEnabled` takes a map with `ColorPickerType` enum keys to boolean values. The map defines which color 
pickers we want to enable and use in the `ColorPicker`. In the example below we included Material **primary**, 
**accent** colors, and the **custom** colors we defined, plus the HSV **color wheel** that allows us to select any 
color. We did not include the picker that combines the primary and accent colors in the same picker, nor the 
near black and near white color picker.

In the example below the custom colors we defined in `colorsNameMap` are given to the color picker's constructor 
property `customColorSwatchesAndNames`. If you leave `customColorSwatchesAndNames` without an entry and 
happen to have `ColorPickerType.custom: true` enabled, the custom picker will still not be shown.

```dart
  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
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
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.caption,
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
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
```

The above example uses a few more `ColorPicker` properties. It is styled to be more compact and to show the general 
color name, as well as the HEX color code of the selected color in the dialog. With the color code indicator you can 
also copy the color code with the copy icon button. When the wheel picker is active you can enter a hex color RGB 
value, the two wheel color HSV selection indicators will then move to the color selection matching the entered 
HEX RGB value.

Most importantly the above example uses the `showPickerDialog` method to show the defined `ColorPicker` in a 
pre-made dialog. The dialog also needs a build context, that we pass to it.

In this example we also define size constraints for the dialog. If you do not define size constraints, it will 
auto size to fit the dialog content. Using constraints allows the dialog to keep the same size when the content 
size changes slightly as you switch between the different color selection tools you enabled. 

It looks a bit better if the dialog size does not change when you switch picker type with the selector. The color 
wheel picker in particular will often require more space. The wheel size can be customized as well, it does 
however become more difficult to operate it, if it is made very small. In this example it is on purposes on the 
lower side of still usable size.

The end result of the above setup is a `ListTile` where the trailing color indicator widget can be clicked to 
open a dialog to select a new color for the trailing `ColorIndicator` color.

As the `dialogPickerColor` color changes in the dialog, the `ColorIndicator`'s color also changes via this
interaction. If the dialog is cancelled, the `ColorIndicator`'s original color is restored.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerSimpleDemo.gif?raw=true" alt="ColorPicker dialog demo" width="300"/>


As an extra exercise, and to better see this interactive change of the color when it is modified in the dialog, 
try connecting the `dialogPickerColor` value to the `AppBar`'s `backgroundColor` property. Did you manage to do it?
What happened?

```dart
:
appBar: AppBar(
  backgroundColor: dialogPickerColor,
  elevation: 1,
  centerTitle: true,
  title: const Text('Color Picker Simple Demo'),
),
```

As can be seen below, now the selected color in the dialog changes the `AppBar`'s color as you select color in 
the dialog and cancelling it restores the `AppBar`'s color as well, **pretty cool!**

You can connect the color picking interaction to theme colors and modify your application's theme color 
values interactively as well, but that goes beyond the scope of this example.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerSimpleDemoAppBar.gif?raw=true" alt="ColorPicker appbar demo" width="300"/>

The example also includes a light and dark theme mode toggle, so you can test the look and operation of the 
color picker with a dark theme.

**FlexColorPicker** works on all Flutter platforms, Android, iOS, Web, Windows, macOS and Linux.
Here is an example of the demo application running on Windows desktop.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/ColorPickerEnterCode.gif?raw=true" alt="ColorPicker on Windows" width="350"/>

# FlexColorPicker API Guide

The **FlexColorPicker** has a large amount of additional features. Its behavior can easily be modified with its direct
properties and two additional configuration property classes `ColorPickerActionButtons` and
`ColorPickerCopyPasteBehavior`, that can be configured and passed in for even more customization options.

This guide goes through the API settings, and provides links to API references.

>**NOTE**   
>In the first version of 2.0.0 reference links are not provided to all API. Newer API doc ref link will be 
> added in a +1 documentation update after 2.0.0 has been released, when the links can be obtained.

## Elements of the Picker

This chapter shows the different visible elements of the color picker that you can enable and disable, or show 
and hide by adding Widgets to the picker.

As shown in above example, at the core is a passed `Color(...)` object to the property `color` and a
`ValueChanged<Color>` callback `onColorChanged` that is called whenever a new color value is selected in the color 
picker. What you do with the callback depends on your use case, in the shown examples we typically just update the 
passed in color with `setState`. However, in the earlier dialog example it was also demonstrated how it interactively 
could be used to change the AppBar color of the app itself. You can of course use the picker to change any color in
your application theme.

```dart
ColorPicker(
  color: myColor,
  onColorChanged: (Color color) => setState(() => myColor = color),
),
```
Below we will explore other, both basic and more advanced features of the **FlexColorPicker**.

### Enabled Color Pickers

API reference: [pickersEnabled](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/pickersEnabled.html)

By default, the Material **primary** colors and **accent** colors pickers are enabled. To change the enabled pickers 
you provide a `ColorPickerType` key to `bool` value map, with the pickers you want enabled to the property
`pickersEnabled`. You only need to provide key-values pairs for picker keys you want to change. Key values that are not 
provided use their defaults. 

If you only have one picker enabled, there is no control shown that will allow you to switch between the pickers. 
If all pickers are disabled, the Material primary color picker is shown.

If all other features are disabled (by default they are not), the screenshot below represents an example of a 
bare-bones minimum picker, showing only the main colors of Material primary colors. If other defaults are OFF to enable
producing this picker style, only the following `pickersEnabled` setting to disable the accent color picker is needed 
to get the shown picker: 

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-1.png?raw=true" alt="Pickers 1"/>

Normally you would enable a few more pickers, here we enable the primary, secondary, near black and white and the wheel
pickers. Since more than one picker is enabled, the color picker selector automatically appears:

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-2.png?raw=true" alt="Pickers 2"/>

If you want to show both Material primary and accent colors in the same picker you can enable the 
`ColorPickerType.both` picker. In that case you usually want to disable `ColorPickerType.primary` and 
`ColorPickerType.accent`, as they then contain duplicates of already available color in the `both` picker. The live 
Web demo implements this as exclusive selections in its logic. It is of course possible to show all three pickers, but
it does not really make much sense.

#### Custom Color Swatches

API reference: [customColorSwatchesAndNames](https://pub.dev/documentation/flex_color_picker/2.0.0-nullsafety.4/flex_color_picker/ColorPicker/customColorSwatchesAndNames.html)

To use the custom color swatch picker you have to define your own custom `ColorSwatch` colors and pass them to the
picker via the `customColorSwatchesAndNames` property. By default, there are no custom colors defined. If you
enabled the `custom` picker and have not provided any custom color swatches, the picker will not be shown despite 
being enabled since it has no colors to show.

You can make `ColorSwatch` objects with the Flutter SDK `MaterialColor` or the `MaterialAccentColor` classes by 
providing swatch color shades for each index. Alternatively you can use the helpers 
`ColorTools.createPrimarySwatch(color)` and `ColorTools.createAccentSwatch(color)` by just giving it a single color 
value. For `createPrimarySwatch` the provided color will always be used as the base for [500] index and 
for `createAccentSwatch` for as color for index [200], the rest of the index are computed. 

> Please note that these helpers just produce lighter and darker shades of the provided color for lower and higher 
> swatch indexes. If you give e.g. the `createPrimarySwatch` the same color value as a built-in Material primary 
> color with index [500], you will not get the same swatch as the built-in hand tuned Material primary color swatch. 

First define a final Map with your custom `ColorSwatch` objects and their names. Here we make three, with the
different mentioned methods.

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
Then use the `customSwatches` map in your color picker.

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
This will create three custom swatches, using our "Alpine", "Rust" and "Lavender" custom names in the **Custom** 
swatch picker.
<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-6.png?raw=true" alt="Picker 6"/>

#### Customized labels 
API reference: [pickerTypeLabels](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/pickerTypeLabels.html)

The picker labels have default English labels, you can override them to customize or translate the labels. You set the
labels by providing a `ColorPickerType` key to `String` value map with the picker labels you want to change with the
property `pickerTypeLabels`. You only have to provide key-value pairs for the labels you want to change, omitted keys 
will keep their default labels.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-3.png?raw=true" alt="Pickers 3"/>

### Enable Shades Selection

API reference: [enableShadesSelection](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/enableShadesSelection.html)

By default, selection of the Material primary and Accent **color swatch shade color**, after selection of the main 
color is **enabled**. In the above example `enableShadesSelection` had on purpose been disabled to produce the above,
main only color picker example.

Below we enable the Material color swatch shades selection. You probably want to be able
to also select the Material shade colors, so typically, you would just keep the default enabled value.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-4.png?raw=true" alt="Pickers 4"/>

### Enable Opacity

API reference: [enableOpacity](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/enableOpacity.html)

You can enable a color opacity slider by setting `enableOpacity` to `true`. With the slider you can adjust the opacity
of the selected color. You can adjust opacity from fully opaque at 100%, to totally transparent at 0%. The selected
color and the impact of the opacity value on it, is visualized by the checkered gradient on the opacity slider, 
and the selected color's opacity gradient on the slider. The thumb's position visualize the resulting color's opacity 
when applied over a background.

The slider thumb only show opacity value changes in 1% increments, however the slider has 255 discrete steps,
so there is a step for every alpha value in the resulting ARGB color value. If the color code value is also enabled and
set to show alpha value, you can see that it can be adjusted in single steps as well.

You cannot pass in the opacity separately to the color picker to get a starting opacity value. If your passed in color
value has opacity in its alpha channel, it will automatically get used, but only if `enableOpacity` is true. If it
is false, any passed in opacity/alpha in the color value or in a color pasted into the picker, is ignored and used as
fully opaque by applying alpha value #FF to it.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-5.png?raw=true" alt="Picker 5"/>

### Show Color Names

API reference: [showMaterialName, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showMaterialName.html) 
[materialNameTextStyle, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/materialNameTextStyle.html) 
[showColorName, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showColorName.html) 
[colorNameTextStyle.](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/colorNameTextStyle.html)

The color picker can be configured to show the selected colors Material color name and its selected shade index number. 
It can also be configured to show a color name for any selected color based on `ColorTools.nameThatColor` function 
that uses a lookup list of 1566 color codes and their names. It finds the color that closest matches the selected 
color on the list and shows this as the selected color's name after the Material color name, if both options are 
enabled. You can also provide the text style for both these text labels. If not provided they default to
`Theme.of(context).textTheme.bodyText2`.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-enabled-7.png?raw=true" alt="Picker 7"/>

#### Translate Material Color Names

API reference: [Static color names](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorTools-class.html#static-properties)


The Material color names are defined as static values with English defaults for all Material colors in `ColorTools`. 
You can modify these values by directly changing their static string values. You could do this in function that you 
call just once, or every time your app changes its translated locale, and then in the custom function 
provide your own localized Material color names. For example:

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-8.png?raw=true" alt="Picker 8"/>

The name that color feature, using the lookup from 1566 color names, is only available in English and cannot be
translated in the current version. 

### Show Color Code

API reference: [showColorCode, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showColorCode.html)
[colorCodeHasColor, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/colorCodeHasColor.html)
[showColorValue, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showColorValue.html)
[colorCodeTextStyle, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/colorCodeTextStyle.html)
[colorCodePrefixStyle.](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/colorCodePrefixStyle.html)

The color code field shows the RGB color value of the selected color. On the Wheel picker the field also functions
as a HEX RGB color code entry field. The Wheel picker will move its indicators to show the color of the entered
color code, as the entry is done.

By default, the code field just has a grey background, but you can also configure it to use the current selected color
as its background color. The color code field can also have a copy button as a suffix. This is enabled by default, 
it allows you to copy the current color to the clipboard. There are different options for enabling copy-paste commands
in the FlexColorPicker and configuring the copy format also shown as prefix in the color code field. These features
are described in detail in the [copy-paste actions and behavior](#copy-paste-actions-and-behavior) chapter. 

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-9.png?raw=true" alt="Picker 9"/>

The `TextStyle` of the color code display and entry field can be changed with `colorCodeTextStyle`. It
defaults to Theme.of(context).textTheme.bodyText2, if not defined. There is also a separate style for the
color code prefix that can be changed with `colorCodePrefixStyle`, if not defined it defaults to the same style as
`colorCodeTextStyle`.


### Show Recent Colors

API reference: [showRecentColors, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showRecentColors.html)
[maxRecentColors, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/maxRecentColors.html)
[recentColors, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/recentColors.html)
[onRecentColorsChanged.](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/onRecentColorsChanged.html)

When `showRecentColors` is enabled, the color picker shows recently selected colors in a list at the bottom of the
color picker. The list uses first-in, first-out to keep min 2 to max 20 colors (defaults to 5) on the recently 
used colors list, the desired max value can be modified with `maxRecentColors`.

Selecting a recently used color moves the picker to picker where the color is located and selects it again. If opacity
is enabled, the opacity the color had when it was selected is also applied. Normally when selecting colors and opacity
is enabled, the value the opacity slider is at is kept. However, selecting a recently used color, will retain the 
opacity the color had when it was selected and added to the recently used colors list. Selecting a color on the
recently used colors will not move it first in the list, it will keep its current position. Selecting a color that is
already on the list, will not add it again. The currently selected color is not added to the list until you select a
new current color.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-10.png?raw=true" alt="Picker 10"/>

There is also an optional callback `onRecentColorsChanged`, that is called everytime a new color is added to the list 
with the complete current list of recently used colors. If the optional callback is not provided, then it is not called. 
You can use this callback to save and restore the recently used colors if so desired. To initialize the list when the
color picker is created give it a starting list with `recentColors`. This could be list kept just in state during
the current app session, or it could have been persisted and restored from a previous session.

### Title and Heading Widgets

API reference: [title, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/title.html)
[heading, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/heading.html)
[subheading, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/subheading.html)
[wheelSubheading, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/wheelSubheading.html)
[opacitySubheading, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/opacitySubheading.html)
[recentColorsSubheading.](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/recentColorsSubheading.html)


You can provide custom heading widgets for the picker toolbar `title`, main `heading`, shades selection color 
`subheading`, 
and the `wheelSubheading`, opacity slider `opacitySubheading` and subheading for the recently used colors list
`recentColorsSubheading`. If a heading is `null` it is omitted. The headings can be any Widget, 
but typically they would be `Text` widgets with a suitable style.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-11.png?raw=true" alt="Picker 11"/>

## Picker Design

The picker design APIs refers to properties that affect size, shape and spacing of the color indicator Widgets in 
the color picker, as well as the color wheel and opacity slider sizing. 

The `ColorIndicator` can also be used as a color indicator and selection widget outside the color picker. This is done 
in the default example where it is used to show the selected color and also to open a dialog to modify the color.

### Color Picker Items
API reference: [height, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/height.html)
[width, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/width.html)
[borderRadius, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/borderRadius.html)
[hasBorder, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/hasBorder.html)
[borderColor, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/borderColor.html)
[elevation, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/elevation.html)
[spacing, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/spacing.html)
[runSpacing.](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/runSpacing.html)

The color items that show the available colors can be modified, `height`, `width`, `borderRadius` their `elevation`
and if the have a border `hasBorder` and what color the border is `borderColor`, it defaults to divider theme. 

Additionally, the `spacing` between the color box items and their `runSpacing` when they wrap to more than one 
row can be adjusted. The color picker item for the Material, Accent, B&W and Custom colors are implemented 
with a `Wrap` widget, as are their shade colors, and the recently used colors list. 

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-13.png?raw=true" alt="Picker 13"/>

Please see the API reference for
defaults and allowed values.

### Wheel diameter, width and border
API reference: [wheelDiameter, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/wheelDiameter.html)
[wheelWidth, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/wheelWidth.html)
[wheelHasBorder, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/wheelHasBorder.html)
[borderColor.](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/borderColor.html)

The color picker `wheelDiameter`, `wheelWidth` and the wheel's border can be modified. The `borderColor` is defined 
by the same property as the color picker items, but it has its own enable/disable toggle `wheelHasBorder`. The 
color wheel width must be from 4 to 50 dp, and it defaults to 16 dp. The color wheel diameter 
must be from 100 to max 500 dp, and it defaults to 190 dp.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-15.png?raw=true" alt="Picker 15"/>

### Opacity slider height, width and thumb radius
API reference: [opacityTrackHeight, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/opacityTrackHeight.html)
[opacityTrackWidth, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/opacityTrackWidth.html)
[opacityThumbRadius.](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/opacityThumbRadius.html)

The opacity slider's height `opacityTrackHeight`, width `opacityTrackWidth` and radius `opacityThumbRadius` can be 
adjusted, below some examples:

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-16.png?raw=true" alt="Picker 16"/>

If the width is not defined (default) it expands to fill available width, it's minimum allowed width is 150 dp. The
slider height must be from 8 to 50 dp and thumb radius from 12 to 30 dp.

## Picker Layout

The picker layout APIs deal with spacing of the elements in the color picker, their alignment and padding.

API reference: [crossAxisAlignment, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/crossAxisAlignment.html)
[padding, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/padding.html)
[columnSpacing.](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/title.html)

Use the properties `crossAxisAlignment`, `padding` and `columnSpacing` to adjust the look of the color picker content.
The `columnSpacing` refers to the additional vertical spacing between each element visible the column used by the color 
picker layout for its layout. The `padding` and `crossAxisAlignment` are as is standard in Flutter. Please note that
`title`widget is not a part of the `Column` body layout of the color picker, and it is not affected by the
`crossAxisAlignment` property. The `title` is a bit like an app bar title, but it is always start aligned to leave
enough room for 1 to 4 action buttons, that can optionally be enabled for the title bar, and they always appear at
the end.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-12.png?raw=true" alt="Picker 12"/>

### Tooltips
API reference: [enableTooltips](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/enableTooltips.html)

The `enableTooltips` property defaults to true and enables all tooltips that are available in the color picker. If the
tooltips get in the way you can disable them all by setting this property to `false`. Why not consider providing a 
property in your app that allows users to turn ON and OFF the tooltips in the app? FlexColorPicker includes this 
toggle to make that easy to implement when it comes to its tooltip behavior.

The tooltip strings used in FlexColorPicker are all based on existing labels in Flutter and by default use
Material localizations and thus change with the locale, so they support all languages that Flutter does out of the box.
You can still override the tooltip labels if so required and provide your own tooltip labels.

The following tooltips exist, and have the default values shown in the table below.

| Usage | English tooltip | Used MaterialLocalizations.of(context) |
| --- | ---   | ---   |
| Copy button | Copy | copyButtonLabel |
| Paste button | Paste | pasteButtonLabel |
| OK button | OK | okButtonLabel |
| Cancel button | Cancel | cancelButtonLabel |
| Close button | Close | closeButtonLabel |


<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-14.png?raw=true" alt="Picker 14" width="500"/>

When the keyboard copy/paste shortcuts are enabled, the Copy and Paste tooltips automatically
also receive platform aware keyboard shortcut info after the localized tooltip label. On macOS
' (CMD-C)' is appended to the copy tooltip and ' (CMD-V)' is appended to the paste tooltip.
On other platforms ' (CTRL-C)' is appended to the copy tooltip and ' (CTRL-V)' to the paste tooltip.

## Dialog Action Buttons
API reference: [ColorPickerActionButtons](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerActionButtons-class.html)

The API surface of the color picker was getting very large, so two configuration classes were created to
group additional settings. The first one is the `ColorPickerActionButtons` used to define the color picker's 
OK and Cancel action buttons, and their style when it is used in the built-in dialogs.

You can define if OK and close action buttons are on a top toolbar or only in the dialog bottom. The top toolbar buttons
are plain icon only buttons. For the bottom Dialog buttons you can choose between `TextButton`, `OutlinedButton` and
`ElevatedButton`.  The used icons can be changed form default ones, as can used tooltips. The label's on the bottom
action buttons can be changed. By the default, they like the tooltips, use Material localizations, so they should
work well enough out of the box for most locales. The bottom action buttons can also use the default or
customized OK and Cancel icons as prefix icons to the labels. The icons are however always shared with the 
corresponding top toolbar icon buttons.

The recommendation is to not use the top and bottom action buttons at the same time, but rather select one of the 
two options. The API does however allow using both or even a mix and match. It is for example possible to 
show **Cancel** and **OK** actions at the bottom of the dialog, and also add just an 'x' icon in the upper end corner 
of the dialog that also cancel-closes the dialog as expected.

<img src="https://github.com/rydmike/flex_color_picker/blob/master/resources/FCP-17.png?raw=true" alt="Picker 17"/>

The bottom action buttons, and their style depend on their ambient theme. There are a few more dialog action
buttons design properties you can adjust, please se the [ColorPickerActionButtons API reference](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerActionButtons-class.html) for additional 
details.

## Copy-Paste Actions and Behavior
API reference: [ColorPickerCopyPasteBehavior](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyPasteBehavior-class.html)

The `ColorPickerCopyPasteBehavior` is the second configuration class group. It is used to configure the desired
copy-paste behavior of the color picker. You can control if the picker has:

* Copy and paste action buttons in the top toolbar.
* Long press and/or right click copy and paste context menu.
* Ctrl-C and Ctrl-V keyboard shortcuts, also when not in edit field.
  Keyboard shortcuts automatically uses Command instead of Ctrl on macOS.
* A copy color action button in the code entry and display field.

You can also:
* Define default result RGB string format of a copy command.
* Define icons for copy and paste action buttons.
* Define icon theme's for the copy and paste icons.
* Define paste color string parsing error feedback type and message if used.
* Modify the tooltips for copy and paste buttons.

Paste operation supports all RGB string formats defined by 
[ColorPickerCopyFormat](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPickerCopyFormat-class.html), 
but copy format is only in selected `copyFormat`.

### Keyboard shortcuts
*Add images and more text...*

### Toolbar buttons
*Add images and more text...*

### Code entry field
*Add images and more text...*

### Context menu
*Add images and more text...*

### Formats and paste parsing
API reference: [showColorCode, ](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/ColorPicker/showColorCode.html)

The color code value can be shown in five different formats, the displayed format also defines the received
string format of the copied RGB value.

*Add images and more text...*

## Dialogs

The FlexColorPicker comes with two built-in ready to use dialogs. You can also make your own by including the
`ColorPicker()` in your own dialog or overlays designs. In this chapter we will look at the two built in dialogs,
that are really the same dialog but designed for slightly different use cases.

### ColorPicker show dialog method

*Add images and more text...*

### Get picked color function 

*Add images and more text...*

## Desktop and Web Ready

The FlexColorPicker is Web and Desktop ready. For most parts focus behaves as expected, and it supports keyboard 
navigation and control. As shown above, if configured, it also has keyboard shortcuts for copy and paste commands. 
The wheel picker cannot be operated with just a keyboard, it needs a mouse or touch control, it will likely remain so.
The opacity slider can be operated via keyboard only. Future picker options will offer other color pickers using 
only sliders for custom color selection, this will enable them to use keyboard color selection as well.

The used color picker selector control is based on the `CupertinoSlidingSegmentedControl` widget. It does not support
keyboard control. A future version will include additional optional picker controls that have keyboard controls.


# Additional Resources

There are some more configuration options available for the `ColorPicker`, use the [API reference guide](https://pub.dev/documentation/flex_color_picker/latest/flex_color_picker/flex_color_picker-library.html) for additional information.

The source code of the [live Web example](https://rydmike.com/flexcolorpicker/) is included in the package example 
folder, in "example/lib/demo/main.dart". By studying it you can see practical examples of how to use all the features
it uses. The live Web demo also has tooltips showing the used API behind every demonstrated interactive control, this
can be used as quick reference and to find the actual used API-value as you interactively configure the Web example.

Happy color picking!
