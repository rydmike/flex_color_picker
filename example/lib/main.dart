import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:color_picker/color_picker.dart';

void main() => runApp(const DemoApp());

class DemoApp extends StatelessWidget {
  const DemoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Make status bar transparent in Android, results in an iPhone like look
    // when used in combination with the AppBar theme below
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material Color Picker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[50],
        // This AppBarTheme setup is part of emulating the light iPhone
        // appbar look on both Android and iOS, when using Material AppBar
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          // Using a barely transparent white appbar, it is not a frosted
          // glass effect, but much cheaper to render than such a filter effect
          color: Colors.white.withOpacity(0.9),
          iconTheme: const IconThemeData(color: Colors.black),
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
  final Color startColor = Colors.blue;
  final Color startColorDialog = Colors.red;
  Color screenPickerColor;
  Color dialogPickerColor;
  // Color dialogPickerColor2;

  static final Map<ColorPickerSwatch, bool> _swatchAvailable =
      <ColorPickerSwatch, bool>{
    ColorPickerSwatch.both: false,
    ColorPickerSwatch.material: true,
    ColorPickerSwatch.accent: true,
    ColorPickerSwatch.bw: false,
    ColorPickerSwatch.custom: true,
    ColorPickerSwatch.any: true,
  };

  // Define some custom colors, that we will convert to ColorSwatch:es
  // and set in a list. The first ones below are by the way the new colors
  // Google used in the Material spec as default colors in the guide.
  static const Color _googleNewPrimary = Color(0xFF6200EE);
  static const Color _googleNewPrimaryVariant = Color(0xFF3700B3);
  static const Color _googleNewSecondary = Color(0xFF03DAC6);
  static const Color _googleNewSecondaryVariant = Color(0xFF018786);
  static const Color _googleNewError = Color(0xFFB00020);
  static const Color _googleNewErrorDark = Color(0xFFCF6679);
  static const Color _mrBlue = Color(0xFF174378);

  // Make a custom color swatch to name map from the above custom colors
  final Map<ColorSwatch<Object>, String> _customColorNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimaryColor(_googleNewPrimary): 'G Purple',
    ColorTools.createPrimaryColor(_googleNewPrimaryVariant): 'G Purple Variant',
    ColorTools.createAccentColor(_googleNewSecondary): 'G Teal',
    ColorTools.createAccentColor(_googleNewSecondaryVariant): 'G Teal Variant',
    ColorTools.createPrimaryColor(_googleNewError): 'G Error',
    ColorTools.createPrimaryColor(_googleNewErrorDark): 'G Error Dark',
    ColorTools.createPrimaryColor(_mrBlue): 'MrBlue',
  };

  @override
  void initState() {
    super.initState();
    screenPickerColor ??= startColor;
    dialogPickerColor ??= startColorDialog;
    // dialogPickerColor2 ??= startColorDialog;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        title: const Text(
          'Color Picker Simple Demo',
          style: TextStyle(color: Colors.black),
        ),
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
                      subWheelHeading: Text(
                        'Selected color and its material shades',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      swatchAvailable: _swatchAvailable,
                      colorSwatchNameMap: _customColorNameMap,
                    ),
                  ),
                ),
              ),

              // Show the selected color
              ListTile(
                title: const Text('Select color above to change this color'),
                subtitle: Text(
                  ColorTools.colorNameAndHexCode(
                    screenPickerColor,
                    colorSwatchNameMap: _customColorNameMap,
                  ),
                ),
                trailing: const ColorIndicator(
                  height: 44,
                  width: 44,
                  borderRadius: 22,
                ),
              ),

              // Show the selected color
              ListTile(
                title: const Text('Click this color to change it in a dialog'),
                subtitle: Text(
                  ColorTools.colorNameAndHexCode(
                    dialogPickerColor,
                    colorSwatchNameMap: _customColorNameMap,
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
        'Selected color and its Material like shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      swatchAvailable: _swatchAvailable,
      colorSwatchNameMap: _customColorNameMap,
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 475, minWidth: 480, maxWidth: 480),
    );
  }
}
