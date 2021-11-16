import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'conditionals/dart_io_conditional.dart' as folder;
import 'pods/pods.dart';
import 'pods/pods_observer.dart';
import 'screens/home/home_screen.dart';
import 'store/hive_store.dart';
import 'utils/theme.dart';

/// Extensive web and desktop demo of FlexColorPicker.
///
/// Published as a live web demo here: https://rydmike.com/flexcolorpicker
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Register custom Hive data adapters.
  registerHiveAdapters();
  // Get platform compatible folder for the Hive box.
  final String appDataDir = await folder.getAppDataDir();
  Hive.init(appDataDir);
  // Open the Hive box, we just keep it open all the time in this demo app.
  await Hive.openBox<dynamic>(kHiveBox);
  runApp(
    ProviderScope(
      observers: <ProviderObserver>[PodsObserver()],
      child: const PickerDemoApp(),
    ),
  );
  // Note:
  // We never close the Hive box. This is on purpose in this version.
  // Hive is fine even if it is not closed.
  //
  // If we make a StatefulWidget of the PickerDemoApp and use a Consumer to
  // build the MaterialApp, we can call close in the dispose method, but
  // when you kill a Web browser tab, desktop windowed app, or even an Android
  // app by swiping it away, I did not see dispose for the 'PickerDemoApp'
  // called in tests, thus keeping this as simple ConsumerWidget, since it
  // did not seem to matter. Maybe it does, feel free to convince me otherwise.
  // Until then, this looks simpler and cleaner.
}

class PickerDemoApp extends ConsumerWidget {
  const PickerDemoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      checkerboardRasterCacheImages: false,
      title: 'FlexColorPicker',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ref.watch(themeModePod),
      home: const HomeScreen(),
    );
  }
}
