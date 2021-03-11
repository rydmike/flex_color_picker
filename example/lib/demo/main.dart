import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';
import 'theme.dart';

// More extensive demo of the ColorPicker, also published as a live web demo
// here: https://rydmike.com/flexcolorpicker
void main() {
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
