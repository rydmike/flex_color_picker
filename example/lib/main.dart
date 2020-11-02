import 'package:flutter/material.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

void main() => runApp(const ColorPickerDemo());

class ColorPickerDemo extends StatelessWidget {
  const ColorPickerDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ColorPicker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.blueGrey[50],
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: const ColorPickerPage(),
    );
  }
}

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({Key key}) : super(key: key);

  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  Color screenPickerColor;
  Color dialogPickerColor;

  // Define some custom colors for the custom picker segment.
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

  @override
  void initState() {
    super.initState();
    screenPickerColor = Colors.blue;
    dialogPickerColor = Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('ColorPicker Demo'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      subheading: Text(
                        'Select color shade',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                ),
              ),

              // Show the selected color.
              ListTile(
                title: const Text('Select color above to change this color'),
                subtitle:
                    Text(ColorTools.colorNameAndHexCode(screenPickerColor)),
                trailing: ColorIndicator(
                  width: 44,
                  height: 44,
                  borderRadius: 22,
                  color: screenPickerColor,
                ),
              ),

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
      showColorNameCode: true,
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
      wheelSubheading: Text(
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
}
