import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class SecondaryDesktopLongWebDeviceSwitch extends ConsumerWidget {
  const SecondaryDesktopLongWebDeviceSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Long press COPY-PASTE menu on Android/iOS/Web, '
          'right click on desktops'),
      value: watch(secondaryDesktopWebLongPod).state,
      onChanged: (bool value) =>
          context.read(secondaryDesktopWebLongPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(\n'
          '    secondaryOnDesktopLongOnDeviceAndWeb: '
          '${context.read(secondaryDesktopWebLongPod).state}))',
    );
  }
}
