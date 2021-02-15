import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

void main() => runApp(const ColorPickerDemo());

class ColorPickerDemo extends StatefulWidget {
  const ColorPickerDemo({Key key}) : super(key: key);

  @override
  _ColorPickerDemoState createState() => _ColorPickerDemoState();
}

class _ColorPickerDemoState extends State<ColorPickerDemo> {
  ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    themeMode = ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ColorPicker',
      theme: ThemeData.from(colorScheme: const ColorScheme.highContrastLight())
          .copyWith(scaffoldBackgroundColor: Colors.grey[50]),
      darkTheme:
          ThemeData.from(colorScheme: const ColorScheme.highContrastDark()),
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
  const ColorPickerPage({Key key, this.themeMode}) : super(key: key);
  final ValueChanged<ThemeMode> themeMode;

  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  Color screenPickerColor;
  Color dialogPickerColor;
  bool isDark;

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
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Pick color in a dialog.
              ListTile(
                title: const Text('Click this color to change it in a dialog'),
                subtitle: Text(
                  '${ColorTools.materialNameAndCode(dialogPickerColor, colorSwatchNameMap: colorsNameMap)} '
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

              // Theme mode toggle
              SwitchListTile.adaptive(
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
        ),
      ),
    );
  }

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
}
