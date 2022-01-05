import 'package:flutter/material.dart';

/// An abstraction to build platform adaptive Widgets.
abstract class PlatformWidget extends StatelessWidget {
  const PlatformWidget({Key? key}) : super(key: key);

  Widget buildCupertinoWidget(BuildContext context);
  Widget buildMaterialWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    final TargetPlatform platform = Theme.of(context).platform;
    if (platform == TargetPlatform.iOS || platform == TargetPlatform.macOS) {
      return buildCupertinoWidget(context);
    } else {
      return buildMaterialWidget(context);
    }
  }
}
