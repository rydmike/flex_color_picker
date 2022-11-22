import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class SecondaryDesktopLongWebDeviceSwitch extends ConsumerWidget {
  const SecondaryDesktopLongWebDeviceSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Long press COPY-PASTE menu on Android/iOS/Web, '
          'right click on desktops'),
      value: ref.watch(secondaryDesktopWebLongPod),
      onChanged: (bool value) =>
          ref.read(secondaryDesktopWebLongPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(\n'
          '    secondaryOnDesktopLongOnDeviceAndWeb: '
          '${ref.read(secondaryDesktopWebLongPod)}))',
    );
  }
}
