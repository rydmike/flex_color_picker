import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class SecondaryDesktopLongDeviceSwitch extends ConsumerWidget {
  const SecondaryDesktopLongDeviceSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Long press COPY-PASTE menu on Android/iOS, '
          'right click on desktops and web desktop'),
      value: ref.watch(secondaryDesktopOtherLongPod),
      onChanged: (bool value) =>
          ref.read(secondaryDesktopOtherLongPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(\n'
          '    secondaryOnDesktopLongOnDevice: '
          '${ref.read(secondaryDesktopOtherLongPod)}))',
    );
  }
}
