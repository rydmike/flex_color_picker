import 'package:flutter/gestures.dart';
import 'package:material_ui/material_ui.dart';

/// Custom app scroll behavior class.
///
/// Enables mouse-drag scrolling on desktop and web, matching the older
/// Flutter pointer-device behavior from before desktop/web used mouse
/// wheel and trackpad as the primary scroll input.
///
/// Normally you would probably not use this scroll behavior in real
/// desktop/web apps, but I like it, so I use it when I can choose! :)
///
/// This is a Flutter class that only depends on the SDK and can be dropped
/// into any application.
class AppScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
  };
}
