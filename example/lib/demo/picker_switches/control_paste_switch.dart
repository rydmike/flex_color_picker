import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class ControlPasteSwitch extends ConsumerWidget {
  const ControlPasteSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Enable keyboard PASTE shortcut'),
      subtitle: const Text('CMD-V on Apple, CTRL-V on other'),
      value: watch(ctrlVPod).state,
      onChanged: (bool value) => context.read(ctrlVPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(ctrlV: '
          '${context.read(ctrlVPod).state}))',
    );
  }
}
