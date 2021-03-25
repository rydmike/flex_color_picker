import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class ControlCopySwitch extends ConsumerWidget {
  const ControlCopySwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Enable keyboard COPY shortcut'),
      subtitle: const Text('CMD-C on Apple, CTRL-C on other'),
      value: watch(ctrlCPod).state,
      onChanged: (bool value) => context.read(ctrlCPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(ctrlC: '
          '${context.read(ctrlCPod).state}))',
    );
  }
}
