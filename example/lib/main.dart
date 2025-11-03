import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import 'demo/utils/app_scroll_behavior.dart';

void main() => runApp(const ColorPickerDemo());

class ColorPickerDemo extends StatefulWidget {
  const ColorPickerDemo({super.key});

  @override
  State<ColorPickerDemo> createState() => _ColorPickerDemoState();
}

class _ColorPickerDemoState extends State<ColorPickerDemo> {
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    themeMode = ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
      title: 'ColorPicker',
      theme: ThemeData(useMaterial3: true),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: themeMode,
      home: ColorPickerPage(
        themeMode: (ThemeMode mode) {
          setState(() {
            themeMode = mode;
          });
        },
      ),
    );
  }
}

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({super.key, required this.themeMode});
  final ValueChanged<ThemeMode> themeMode;

  @override
  State<ColorPickerPage> createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  late Color screenPickerColor; // Color for picker shown in Card on the screen.
  late Color dialogPickerColor; // Color for picker in dialog using onChanged
  late Color dialogSelectColor; // Color for picker using color select dialog.
  late bool isDark;

  // Define some custom colors for the custom picker segment.
  // The 'guide' color values are from
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

  @override
  void initState() {
    screenPickerColor = Colors.blue;
    dialogPickerColor = Colors.red;
    dialogSelectColor = const Color(0xFFA239CA);
    isDark = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('ColorPicker Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        children: <Widget>[
          const SizedBox(height: 16),
          // Pick color in a dialog.
          ListTile(
            title: const Text('Click this color to modify it in a dialog. '
                'The color is modified while dialog is open, but returns '
                'to previous value if dialog is cancelled'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(dialogPickerColor, colorSwatchNameMap: colorsNameMap)} '
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
          ListTile(
            title: const Text('Click to select a new color from a dialog '
                'that uses custom open/close animation. The color is only '
                'modified after dialog is closed with OK'),
            subtitle: Text(
              // ignore: lines_longer_than_80_chars
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
                    // If no style is specified, the default is used, which
                    // is Theme.of(context).textTheme.titleLarge for the title
                    // as in a Material 3 default for an AppBar.
                    title: const Text(
                      'ColorPicker with very long title',
                      // Use another TextStyle if you so prefer:
                      // style: Theme.of(context).textTheme.titleSmall,
                    ),
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
                    constraints: const BoxConstraints(
                        minHeight: 480, minWidth: 550, maxWidth: 550),
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

          // Show the color picker in sized box in a raised card.
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Card(
                elevation: 2,
                child: ColorPicker(
                  // Use the screenPickerColor as color.
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ),

          // Theme mode toggle
          SwitchListTile(
            title: const Text('Turn ON for dark mode'),
            subtitle: const Text('Turn OFF for light mode'),
            value: isDark,
            onChanged: (bool value) {
              setState(() {
                isDark = value;
                widget.themeMode(isDark ? ThemeMode.dark : ThemeMode.light);
              });
            },
          )
        ],
      ),
    );
  }

  Future<bool> colorPickerDialog() {
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
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
      colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
      selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
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
      actionsPadding: const EdgeInsets.all(16),
      constraints:
          const BoxConstraints(minHeight: 480, minWidth: 300, maxWidth: 320),
    );
  }
}
