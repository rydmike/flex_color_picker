import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';
import 'theme.dart';

// More extensive demo of the ColorPicker, also published as a live web demo
// here: https://rydmike.com/flexcolorpicker
void main() {
  translateMaterialColorPickerColors();
  runApp(const FlexColorPickerDemoApp());
}

class FlexColorPickerDemoApp extends StatefulWidget {
  const FlexColorPickerDemoApp({Key? key}) : super(key: key);

  @override
  _FlexColorPickerDemoAppState createState() => _FlexColorPickerDemoAppState();
}

class _FlexColorPickerDemoAppState extends State<FlexColorPickerDemoApp> {
  late ThemeMode themeMode;

  @override
  void initState() {
    themeMode = ThemeMode.light;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      checkerboardRasterCacheImages: false,
      title: 'FlexColorPicker',
      //
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      //
      // Use annotated region to style the status bar when there is no
      // AppBar and also style system navigation bar.
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness:
              themeMode == ThemeMode.light ? Brightness.light : Brightness.dark,
          statusBarIconBrightness:
              themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
          systemNavigationBarColor: themeMode == ThemeMode.light
              ? const Color(0xFFFDFDFD)
              : const Color(0xFF121212),
          systemNavigationBarIconBrightness:
              themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
        ),
        //
        child: HomeScreen(
          themeMode: (ThemeMode mode) {
            setState(() {
              themeMode = mode;
            });
          },
        ),
      ),
    );
  }
}

// TODO For doc only, remove before publish.
void translateMaterialColorPickerColors() {
  ColorTools.redName = 'Röd';
  ColorTools.redAccentName = 'Röd accent';
  ColorTools.blueName = 'Blå';
  ColorTools.blueName = 'Blå accent';
  ColorTools.greenName = 'Grön';
  ColorTools.greenAccentName = 'Grön accent';
}
