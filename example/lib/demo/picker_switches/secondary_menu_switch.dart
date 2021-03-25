import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class SecondaryMenuSwitch extends ConsumerWidget {
  const SecondaryMenuSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Secondary click COPY-PASTE menu'),
      subtitle: const Text('Typically mouse right click.'),
      value: watch(secondaryMenuPod).state,
      onChanged: (bool value) => context.read(secondaryMenuPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(secondaryMenu: '
          '${context.read(secondaryMenuPod).state}))',
    );
  }
}
