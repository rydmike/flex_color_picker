import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_screen.dart';

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
          onPrimary: Colors.white,
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
