import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

// Just a simple way to leave a trace of what version you built a Flutter
// Web demo with inside the app. You can also show it in the demo,
// like in this example, so people testing it don't have to ask.
const String kFlutterVersion = 'dev 1.27.0-1.0.pre';
const String kColorPickerVersion = '2.0.0-nullsafety.0';

// Max width of the body content when used on a wide screen.
const double kMaxBodyWidth = 2000;
const double kMinColumnWidth = 450;

// More extensive demo of the ColorPicker, also published as a live web demo
// here: https://rydmike.com/democolorpicker
void main() => runApp(const DemoApp());

class DemoApp extends StatefulWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  late ThemeMode themeMode;

  @override
  void initState() {
    themeMode = ThemeMode.light;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Make status bar transparent in Android, results in an iPhone like look
    // when used in combination with the AppBar theme further below.
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
      title: 'FlexColorPicker',
      //
      // Make a light theme, based on well known blue brand colors.
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light().copyWith(
          primary: const Color(0xFF3B5998),
          primaryVariant: const Color(0xFF3F729B),
          secondary: const Color(0xFF55ACEE),
          secondaryVariant: const Color(0xFFA2D1F6),
        ),
      ).copyWith(
        scaffoldBackgroundColor: const Color(0xFFFDFDFD),
        toggleableActiveColor: const Color(0xFF55ACEE),
        appBarTheme: AppBarTheme(
          brightness: Brightness.light,
          color: Colors.white.withOpacity(0.9),
          iconTheme: const IconThemeData(color: Colors.black),
          textTheme: Theme.of(context).textTheme,
          elevation: 0.5,
        ),
      ),
      //
      // Make a dark theme, based on well known blue brand colors.
      darkTheme: ThemeData.from(
        colorScheme: const ColorScheme.dark().copyWith(
          primary: const Color(0xFF8B9DC3),
          primaryVariant: const Color(0xFF799CB9),
          secondary: const Color(0xFFA0D1F5),
          secondaryVariant: const Color(0xFF607D93),
        ),
      ).copyWith(
        toggleableActiveColor: const Color(0xFFA0D1F5),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
          color: Colors.black.withOpacity(0.9),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0.5,
        ),
      ),
      themeMode: themeMode,
      home: HomeScreen(
        themeMode: (ThemeMode mode) {
          setState(() {
            themeMode = mode;
          });
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.themeMode}) : super(key: key);
  final ValueChanged<ThemeMode> themeMode;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isDark;

  @override
  void initState() {
    isDark = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).padding.top),
          const Spacer(),
          Text(
            'FlexColorPicker',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 8,
                elevation: 4,
                color: Colors.blueAccent[200]!,
                isSelected: true,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                color: Colors.blue[100]!,
                hasBorder: true,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 30,
                elevation: 8,
                color: Colors.indigo[600]!,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 30,
                elevation: 9,
                color: Colors.red[800]!,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 0,
                color: Colors.redAccent[100]!,
                hasBorder: true,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 16,
                elevation: 5,
                color: Colors.pink[800]!,
                isSelected: true,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 4,
                elevation: 1,
                color: Colors.amber[400]!,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                borderRadius: 30,
                elevation: 1,
                color: Colors.orange[300]!,
                isSelected: true,
              ),
              const SizedBox(width: 16),
              ColorIndicator(
                height: 65,
                width: 65,
                color: Colors.amber[800]!,
              ),
            ],
          ),
          const SizedBox(height: 40),
          OutlinedButton(
            onPressed: () {
              Navigator.push<Object>(
                context,
                MaterialPageRoute<Object>(
                  builder: (BuildContext context) => const ColorPickerPage(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Try the color picker...',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Theme mode toggle
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 270),
            child: SwitchListTile.adaptive(
              title: const Text('Turn ON for dark mode'),
              subtitle: const Text('Turn OFF for light mode'),
              value: isDark,
              onChanged: (bool value) {
                setState(() {
                  isDark = value;
                  widget.themeMode(isDark ? ThemeMode.dark : ThemeMode.light);
                });
              },
            ),
          ),

          const Spacer(),
          Text(
            'Using flex_color_picker version $kColorPickerVersion',
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            'Built with Flutter $kFlutterVersion',
            style: Theme.of(context).textTheme.caption,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class ColorPickerPage extends StatefulWidget {
  const ColorPickerPage({Key? key}) : super(key: key);

  @override
  _ColorPickerPageState createState() => _ColorPickerPageState();
}

class _ColorPickerPageState extends State<ColorPickerPage> {
  late bool enableShadesSelection;
  late bool showMaterialName;
  late bool showColorName;
  late bool showColorCode;
  late bool showColorValue;
  late bool hasBorder;
  late bool wheelHasBorder;
  late bool centerContent;
  late bool showHeading;
  late bool showSubheading;
  late bool includeIndex850;
  late double size;
  late double elevation;
  late double borderRadius;
  late double spacing;
  late double runSpacing;
  late double padding;
  late double columnSpacing;
  late double wheelDiameter;
  late double wheelWidth;
  late Color screenPickerColor;
  late Color dialogPickerColor;
  late List<Widget> column1 = <Widget>[];
  late List<Widget> column2 = <Widget>[];
  late List<Widget> column3 = <Widget>[];
  late List<Widget> column4 = <Widget>[];

  final double sizeMin = 20;
  final double sizeMax = 60;

  static Map<ColorPickerType, bool> pickersEnabled = <ColorPickerType, bool>{
    ColorPickerType.both: false,
    ColorPickerType.primary: true,
    ColorPickerType.accent: true,
    ColorPickerType.bw: false,
    ColorPickerType.custom: true,
    ColorPickerType.wheel: true,
  };

  static const double kToggleFontSize = 11;
  static const List<Widget> toggleButtons = <Widget>[
    Text('Primary &\nAccent',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: kToggleFontSize)),
    Text('Primary', style: TextStyle(fontSize: kToggleFontSize)),
    Text('Accent', style: TextStyle(fontSize: kToggleFontSize)),
    Text('Black &\nWhite',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: kToggleFontSize)),
    Text('Custom ', style: TextStyle(fontSize: kToggleFontSize)),
    Text('Wheel', style: TextStyle(fontSize: kToggleFontSize)),
  ];

  final List<bool> toggleButtonIsSelected = pickersEnabled.values.toList();

  // Define some custom colors to be used in the custom segment.
  static const Color guideNewPrimary = Color(0xFF6200EE);
  static const Color guideNewPrimaryVariant = Color(0xFF3700B3);
  static const Color guideNewSecondary = Color(0xFF03DAC6);
  static const Color guideNewSecondaryVariant = Color(0xFF018786);
  static const Color guideNewError = Color(0xFFB00020);
  static const Color guideNewErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);
  static const Color clearBlue = Color(0xFF3db5e0);
  static const Color darkPink = Color(0xFFa33e94);
  static const Color redWine = Color(0xFFad0c1c);
  static const Color grassGreen = Color(0xFF3bb87f);
  static const Color moneyGreen = Color(0xFF869962);
  static const Color mandarinOrange = Color(0xFFdb7a25);
  static const Color brightOrange = Color(0xFFff5319);
  static const Color brightGreen = Color(0xFF00ab25);
  static const Color blueJean = Color(0xFF4f75b8);
  static const Color deepBlueSea = Color(0xFF132b80);

  // Make a custom color swatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guideNewPrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guideNewPrimaryVariant):
        'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideNewSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideNewSecondaryVariant):
        'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideNewError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideNewErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
    ColorTools.createPrimarySwatch(clearBlue): 'Clear blue',
    ColorTools.createPrimarySwatch(darkPink): 'Dark pink',
    ColorTools.createPrimarySwatch(redWine): 'Red wine',
    ColorTools.createPrimarySwatch(grassGreen): 'Grass green',
    ColorTools.createPrimarySwatch(moneyGreen): 'Money green',
    ColorTools.createPrimarySwatch(mandarinOrange): 'Mandarin orange',
    ColorTools.createPrimarySwatch(brightOrange): 'Bright orange',
    ColorTools.createPrimarySwatch(brightGreen): 'Bright green',
    ColorTools.createPrimarySwatch(blueJean): 'Washed jean blue',
    ColorTools.createPrimarySwatch(deepBlueSea): 'Deep blue sea',
  };

  @override
  void didUpdateWidget(covariant ColorPickerPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ********************************************************************
    // COLUMN 1 - Content
    // ********************************************************************

    column1 = <Widget>[
      const Divider(),
      // Show the selected color in a dialog
      ListTile(
        title: const Text('Click this color to change it in a dialog'),
        subtitle: Text(
          '${ColorTools.materialNameAndCode(dialogPickerColor, colorSwatchNameMap: colorsNameMap)} '
          'aka ${ColorTools.nameThatColor(dialogPickerColor)}',
        ),
        trailing: ColorIndicator(
          height: size,
          width: size,
          borderRadius: borderRadius,
          elevation: elevation,
          color: dialogPickerColor,
          hasBorder: hasBorder,
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
      // Show the color selected in the picker below
      ListTile(
        title: const Text('Select color below to change this color'),
        subtitle: Text(
            '${ColorTools.materialNameAndCode(screenPickerColor, colorSwatchNameMap: colorsNameMap)} '
            'aka ${ColorTools.nameThatColor(screenPickerColor)}'),
        trailing: ColorIndicator(
          height: size,
          width: size,
          borderRadius: borderRadius,
          elevation: elevation,
          color: screenPickerColor,
          hasBorder: hasBorder,
        ),
      ),
      // Color picker demo in a raised card
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Card(
            elevation: 4,
            child: ColorPicker(
              color: screenPickerColor,
              onColorChanged: (Color color) =>
                  setState(() => screenPickerColor = color),
              crossAxisAlignment: centerContent
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              padding: EdgeInsets.all(padding),
              enableShadesSelection: enableShadesSelection,
              includeIndex850: includeIndex850,
              width: size,
              height: size,
              spacing: spacing,
              runSpacing: runSpacing,
              elevation: elevation,
              hasBorder: hasBorder,
              borderRadius: borderRadius,
              columnSpacing: columnSpacing,
              wheelDiameter: wheelDiameter,
              wheelWidth: wheelWidth,
              wheelHasBorder: wheelHasBorder,
              pickersEnabled: pickersEnabled,
              heading: showHeading
                  ? Text(
                      'Select color',
                      style: Theme.of(context).textTheme.headline5,
                    )
                  : null,
              subheading: showSubheading
                  ? Text(
                      'Select color shade',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : null,
              wheelSubheading: showSubheading
                  ? Text(
                      'Selected color and its color swatch',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : null,
              showMaterialName: showMaterialName,
              showColorName: showColorName,
              showColorCode: showColorCode,
              showColorValue: showColorValue,
              // The name map is used to give the custom colors names
              customColorSwatchesAndNames: colorsNameMap,
            ),
          ),
        ),
      ),
    ];

    // ********************************************************************
    // COLUMN 2 - Content
    // ********************************************************************
    column2 = <Widget>[
      const Divider(),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
        child: Text(
          'Customize the Color Picker',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      ListTile(
        title: const Text('Select enabled pickers'),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ToggleButtons(
                constraints: const BoxConstraints(minWidth: 60, minHeight: 45),
                // renderBorder: false,
                onPressed: (int index) {
                  // Copy the currently enabled pickers map.
                  final Map<ColorPickerType, bool> pEnabled =
                      <ColorPickerType, bool>{...pickersEnabled};
                  // Set enabled pickers based on toggle buttons
                  // custom logic by mutating the copy of enabled
                  // pickers.
                  toggleButtonIsSelected[index] =
                      !toggleButtonIsSelected[index];
                  if (index == 0) {
                    pEnabled[ColorPickerType.both] =
                        toggleButtonIsSelected[index];
                    // If 'Both' on then primary & Accent are off
                    if (pEnabled[ColorPickerType.both]!) {
                      toggleButtonIsSelected[1] = false;
                      pEnabled[ColorPickerType.primary] = false;
                      toggleButtonIsSelected[2] = false;
                      pEnabled[ColorPickerType.accent] = false;
                    }
                  }
                  if (index == 1) {
                    pEnabled[ColorPickerType.primary] =
                        toggleButtonIsSelected[index];
                    // If we turned on 'primary', we turn of 'Both'
                    if (pEnabled[ColorPickerType.primary]!) {
                      toggleButtonIsSelected[0] = false;
                      pEnabled[ColorPickerType.both] = false;
                    }
                  }
                  if (index == 2) {
                    pEnabled[ColorPickerType.accent] =
                        toggleButtonIsSelected[index];
                    // If we turned on 'accent', we turn of 'Both'
                    if (pEnabled[ColorPickerType.accent]!) {
                      toggleButtonIsSelected[0] = false;
                      pEnabled[ColorPickerType.both] = false;
                    }
                  }
                  if (index == 3) {
                    pEnabled[ColorPickerType.bw] =
                        toggleButtonIsSelected[index];
                  }
                  if (index == 4) {
                    pEnabled[ColorPickerType.custom] =
                        toggleButtonIsSelected[index];
                  }
                  if (index == 5) {
                    pEnabled[ColorPickerType.wheel] =
                        toggleButtonIsSelected[index];
                  }
                  setState(() {
                    // Copy the enabled pickers from the mutated
                    // copy. If we mutate the pickersEnabled map
                    // directly the didUpdateWidget will be called,
                    // but the old and new values will be same
                    // since we mutated the widget input. Doing it
                    // this way, the didUpdateWidget function of the
                    // StatefulWidget sees the changed values of
                    // pickersEnabled. We need that for dynamically
                    // changing the enabled pickers correctly.
                    // Normally you would just define the pickers
                    // you want when you instantiate it and not
                    // change it, so you would not need to do this.
                    pickersEnabled = <ColorPickerType, bool>{...pEnabled};
                    didChangeDependencies();
                  });
                },
                isSelected: toggleButtonIsSelected,
                color: Theme.of(context).colorScheme.primary,
                selectedColor: Theme.of(context).colorScheme.onPrimary,
                fillColor: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(4),
                borderWidth: 1.5,
                borderColor: Theme.of(context).colorScheme.primary,
                selectedBorderColor: Theme.of(context).colorScheme.primary,
                hoverColor: Theme.of(context).colorScheme.secondaryVariant,
                children: toggleButtons,
              ),
            ),
          ],
        ),
      ),
      SwitchListTile.adaptive(
        title: const Text('Enable shades selection'),
        subtitle: const Text('Turn OFF to only be able to select the main '
            'color in a color swatch.'),
        value: enableShadesSelection,
        onChanged: (bool value) => setState(() {
          enableShadesSelection = value;
          // didChangeDependencies();
        }),
      ),
      const Divider(),
      // Color picker size
      ListTile(
        title: const Text('Color picker item size'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider.adaptive(
              min: sizeMin,
              max: sizeMax,
              divisions: (sizeMax - sizeMin).floor(),
              label: size.floor().toString(),
              value: size,
              onChanged: (double value) {
                if (value / 2 < borderRadius) {
                  borderRadius = value / 2;
                }
                setState(() => size = value);
              },
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'px',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                size.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      // Border radius
      ListTile(
        title: const Text('Color picker item border radius'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider.adaptive(
              max: size / 2,
              divisions: (size / 2).floor(),
              label: borderRadius.floor().toString(),
              value: borderRadius,
              onChanged: (double value) => setState(() => borderRadius = value),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'dp',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                borderRadius.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      // Spacing of color pick items
      ListTile(
        title: const Text('Color picker item spacing'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider.adaptive(
              max: 25,
              divisions: 25,
              label: spacing.floor().toString(),
              value: spacing,
              onChanged: (double value) => setState(() => spacing = value),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'dp',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                spacing.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      // Run spacing of color pick items
      ListTile(
        title: const Text('Color picker item run spacing'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider.adaptive(
              max: 25,
              divisions: 25,
              label: runSpacing.floor().toString(),
              value: runSpacing,
              onChanged: (double value) => setState(() => runSpacing = value),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'dp',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                runSpacing.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      // Elevation of color pick item
      ListTile(
        title: const Text('Color picker item elevation'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider.adaptive(
              max: 16,
              divisions: 16,
              label: elevation.floor().toString(),
              value: elevation,
              onChanged: (double value) => setState(() => elevation = value),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'dp',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                elevation.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    ];

    // ********************************************************************
    // COLUMN 3 - Content
    // ********************************************************************
    column3 = <Widget>[
      const Divider(),
      SwitchListTile.adaptive(
        title: const Text('Show Material color name'),
        subtitle:
            const Text('If the color has a Material name, it is shown along '
                'with its shade index.'),
        value: showMaterialName,
        onChanged: (bool value) => setState(() => showMaterialName = value),
      ),
      SwitchListTile.adaptive(
        title: const Text('Show color name'),
        subtitle:
            const Text('Shows a general English color name for any selected '
                'color.'),
        value: showColorName,
        onChanged: (bool value) => setState(() => showColorName = value),
      ),
      SwitchListTile.adaptive(
        title: const Text('Show selected color code'),
        subtitle:
            const Text('Show the Flutter style HEX RGB value of the selected '
                'color. On the wheel picker you can also enter a HEX '
                'RGB value.'),
        value: showColorCode,
        onChanged: (bool value) => setState(() => showColorCode = value),
      ),
      SwitchListTile.adaptive(
        title: const Text('Show integer color value'),
        subtitle: const Text(
            'Show the integer value of the selected color. The value '
            'can be selected and copied.'),
        value: showColorValue,
        onChanged: (bool value) => setState(() => showColorValue = value),
      ),
      const Divider(),
      SwitchListTile.adaptive(
        title: const Text('Show heading text'),
        subtitle: const Text('You can provide your own heading widget, if '
            'it is null there is no heading.'),
        value: showHeading,
        onChanged: (bool value) => setState(() => showHeading = value),
      ),
      SwitchListTile.adaptive(
        title: const Text('Show subheading text'),
        subtitle: const Text('You can provide your own subheading widget, if '
            'it is null there is no sub heading.'),
        value: showSubheading,
        onChanged: (bool value) => setState(() => showSubheading = value),
      ),
      SwitchListTile.adaptive(
        title: const Text('Border around color pick items'),
        subtitle: const Text('With the API you can also adjust the '
            'border color.'),
        value: hasBorder,
        onChanged: (bool value) => setState(() => hasBorder = value),
      ),
    ];

    // ********************************************************************
    // COLUMN 4 - Content
    // ********************************************************************
    column4 = <Widget>[
      const Divider(),
      SwitchListTile.adaptive(
        title: const Text('Border around color wheel'),
        subtitle: const Text('With the API you can also adjust the '
            'border color'),
        value: wheelHasBorder,
        onChanged: (bool value) => setState(() => wheelHasBorder = value),
      ),
      // Wheel size selector
      ListTile(
        title: const Text('Color wheel size'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider.adaptive(
              min: 150,
              max: 500,
              divisions: 40,
              label: wheelDiameter.floor().toString(),
              value: wheelDiameter,
              onChanged: (double value) =>
                  setState(() => wheelDiameter = value),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'px',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                wheelDiameter.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      // Wheel width selector
      ListTile(
        title: const Text('Color wheel width'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider.adaptive(
              min: 4,
              max: 50,
              label: wheelWidth.floor().toString(),
              value: wheelWidth,
              onChanged: (double value) => setState(() => wheelWidth = value),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'px',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                wheelWidth.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      const Divider(),
      SwitchListTile.adaptive(
        title: const Text('Include grey color index 850'),
        subtitle: const Text('To include the not so well known 850 color in '
            'the Grey swatch, turn this ON.'),
        value: includeIndex850,
        onChanged: (bool value) => setState(() => includeIndex850 = value),
      ),
      SwitchListTile.adaptive(
        title: const Text('Center content'),
        subtitle: const Text('Keep OFF for left aligned.'),
        value: centerContent,
        onChanged: (bool value) => setState(() => centerContent = value),
      ),
      // Vertical space between items in the color picker
      ListTile(
        title: const Text('Color picker row space'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider.adaptive(
              max: 40,
              divisions: 40,
              label: columnSpacing.floor().toString(),
              value: columnSpacing,
              onChanged: (double value) =>
                  setState(() => columnSpacing = value),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'dp',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                columnSpacing.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
      // Padding around all the content in the picker
      ListTile(
        title: const Text('Color picker content padding'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Slider.adaptive(
              max: 40,
              divisions: 40,
              label: padding.floor().toString(),
              value: padding,
              onChanged: (double value) => setState(() => padding = value),
            ),
          ],
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'dp',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                padding.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();

    enableShadesSelection = true;
    showMaterialName = true;
    showColorName = true;
    showColorCode = true;
    showColorValue = false;
    hasBorder = false;
    wheelHasBorder = false;
    centerContent = true;
    showHeading = true;
    showSubheading = true;
    includeIndex850 = false;
    size = 40;
    elevation = 0;
    borderRadius = 4;
    spacing = 4;
    runSpacing = 4;
    padding = 10;
    columnSpacing = 8;
    wheelDiameter = 190;
    wheelWidth = 16;
    screenPickerColor = Colors.blue;
    dialogPickerColor = Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    // We are going to make simple responsive layout ...
    final double width = MediaQuery.of(context).size.width;

    // That can have 1 to max 4 columns
    int columns = width ~/ kMinColumnWidth;
    if (columns < 1) columns = 1;
    if (columns > 4) columns = 4;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FlexColorPicker Web Demo'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxBodyWidth),
          child: Row(
            // The Row is adjusted to contain 1 to 4 ListViews, each
            // in an Expanded
            children: <Widget>[
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).padding.top +
                              kToolbarHeight),
                      // Show the selected color in a dialog
                      ...column1,
                      if (columns < 3) ...column2,
                      if (columns < 2) ...column3,
                      if (columns < 2) ...column4,
                    ],
                  ),
                ),
              ),
              if (columns > 1)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        // Show the selected color in a dialog
                        if (columns == 3 || columns == 4) ...column2,
                        if (columns < 3) ...column3,
                        if (columns < 3) ...column4,
                      ],
                    ),
                  ),
                ),
              if (columns > 2)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        // Show the selected color in a dialog
                        ...column3,
                        if (columns < 4) ...column4,
                      ],
                    ),
                  ),
                ),
              if (columns > 3)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        ...column4,
                      ],
                    ),
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
      crossAxisAlignment:
          centerContent ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      padding: EdgeInsets.all(padding),
      enableShadesSelection: enableShadesSelection,
      includeIndex850: includeIndex850,
      width: size,
      height: size,
      spacing: spacing,
      runSpacing: runSpacing,
      elevation: elevation,
      hasBorder: hasBorder,
      borderRadius: borderRadius,
      columnSpacing: columnSpacing,
      wheelDiameter: wheelDiameter,
      wheelWidth: wheelWidth,
      wheelHasBorder: wheelHasBorder,
      pickersEnabled: pickersEnabled,
      heading: showHeading
          ? Text(
              'Select color',
              style: Theme.of(context).textTheme.headline5,
            )
          : null,
      subheading: showSubheading
          ? Text(
              'Select color shade',
              style: Theme.of(context).textTheme.subtitle1,
            )
          : null,
      wheelSubheading: showSubheading
          ? Text(
              'Selected color and its color swatch',
              style: Theme.of(context).textTheme.subtitle1,
            )
          : null,
      showMaterialName: showMaterialName,
      showColorName: showColorName,
      showColorCode: showColorCode,
      showColorValue: showColorValue,
      // The name map is used to give the custom colors names
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 475, minWidth: 480, maxWidth: 480),
    );
  }
}

class ColumnTwo extends StatelessWidget {
  const ColumnTwo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
