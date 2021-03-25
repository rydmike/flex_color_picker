import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class SecondaryDesktopLongDeviceSwitch extends ConsumerWidget {
  const SecondaryDesktopLongDeviceSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Long press COPY-PASTE menu on Android/iOS, '
          'right click on desktops'),
      value: watch(secondaryOnDesktopLongOnDevicePod).state,
      onChanged: (bool value) =>
          context.read(secondaryOnDesktopLongOnDevicePod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(\n'
          '    secondaryOnDesktopLongOnDevice: '
          '${context.read(secondaryOnDesktopLongOnDevicePod).state}))',
    );
  }
}
