import 'package:flutter/material.dart';
import 'package:color_picker/color_picker.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material Color Picker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.blueGrey[50],
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        // Make a prettier button theme that is based on same color as
        // the primary color, otherwise buttons are grey and ugly.
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

  static final Map<ColorPickerSwatch, bool> swatchesAvailable =
      <ColorPickerSwatch, bool>{
    ColorPickerSwatch.both: false,
    ColorPickerSwatch.material: true,
    ColorPickerSwatch.accent: true,
    ColorPickerSwatch.bw: false,
    ColorPickerSwatch.custom: true,
    ColorPickerSwatch.any: true,
  };

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

  @override
  void initState() {
    super.initState();
    // To get a color show up as selected by default when calling the picker
    // start with a given color in a Swatch, not just with a Swatch, like
    // Colors.blue or Colors.red, the color will not get pre-selected in the
    // picker then.
    screenPickerColor = Colors.blue[500];
    dialogPickerColor = Colors.red[700];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text('Color Picker Simple Demo'),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Color picker demo in a raised card
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Card(
                    elevation: 2,
                    child: ColorPicker(
                      size: 44,
                      borderRadius: 22,
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
                  ),
                ),
              ),

              // Show the selected color.
              ListTile(
                title: const Text('Select color above to change this color'),
                subtitle: Text(
                  ColorTools.colorNameAndHexCode(
                    screenPickerColor,
                    colorSwatchNameMap: colorsNameMap,
                  ),
                ),
                trailing: ColorIndicator(
                  height: 44,
                  width: 44,
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
}
