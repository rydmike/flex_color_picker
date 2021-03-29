import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_screen.dart';
import 'pods.dart';
import 'theme.dart';

// More extensive demo of the ColorPicker, also published as a live web demo
// here: https://rydmike.com/flexcolorpicker
void main() {
  runApp(const ProviderScope(child: FlexColorPickerDemoApp()));
}

class FlexColorPickerDemoApp extends ConsumerWidget {
  const FlexColorPickerDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      checkerboardRasterCacheImages: false,
      title: 'FlexColorPicker',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: watch(themeModePod).state,
      // Use annotated region to style the status bar when there is no
      // AppBar and also style system navigation bar.
      home: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness:
              context.read(themeModePod).state == ThemeMode.light
                  ? Brightness.light
                  : Brightness.dark,
          statusBarIconBrightness:
              context.read(themeModePod).state == ThemeMode.light
                  ? Brightness.dark
                  : Brightness.light,
          systemNavigationBarColor:
              context.read(themeModePod).state == ThemeMode.light
                  ? const Color(0xFFFDFDFD)
                  : const Color(0xFF121212),
          systemNavigationBarIconBrightness:
              watch(themeModePod).state == ThemeMode.light
                  ? Brightness.dark
                  : Brightness.light,
        ),
        //
        child: const HomeScreen(),
      ),
    );
  }
}
