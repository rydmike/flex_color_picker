import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ControlPasteSwitch extends ConsumerWidget {
  const ControlPasteSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable keyboard PASTE shortcut'),
      subtitle: const Text('CMD-V on Apple, CTRL-V on other'),
      value: ref.watch(ctrlVPod),
      onChanged: (bool value) => ref.read(ctrlVPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(ctrlV: '
          '${ref.read(ctrlVPod)}))',
    );
  }
}
