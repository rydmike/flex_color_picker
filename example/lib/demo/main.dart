import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'pods/pods.dart';
import 'pods/pods_observer.dart';
import 'screens/home/home_screen.dart';
import 'utils/hive_adapters.dart';
import 'utils/store.dart';
import 'utils/theme.dart';

// More extensive demo of the ColorPicker, also published as a live web demo
// here: https://rydmike.com/flexcolorpicker
Future<void> main() async {
  // Register Hive adapters.
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(ColorPickerTypeAdapter());
  Hive.registerAdapter(CrossAxisAlignmentAdapter());
  Hive.registerAdapter(ThemeModeAdapter());
  Hive.registerAdapter(ColorPickerCopyFormatAdapter());

  // final Directory appDocDir = await getApplicationDocumentsDirectory();
  const String appDocPath = r'C:\Users\mryds\AppData\Local\FlexColorPicker';
  // debugPrint('appDocPath: $appDocPath');
  // await Hive.initFlutter(HiveKeys.folder);
  Hive.init(appDocPath);
  await Hive.openBox<dynamic>(Store.box);
  runApp(
    ProviderScope(
      observers: <ProviderObserver>[PodsObserver()],
      child: const FlexColorPickerDemoApp(),
    ),
  );
//   debugPrint('Close hive!');
//   await Hive.close();
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
        value: AppTheme.overlayStyle(context.read(themeModePod).state),
        child: const HomeScreen(),
      ),
    );
  }
}
