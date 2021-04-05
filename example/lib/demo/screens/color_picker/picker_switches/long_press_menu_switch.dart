import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class LongPressMenuSwitch extends ConsumerWidget {
  const LongPressMenuSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Long press COPY-PASTE menu'),
      value: watch(longPressMenuPod).state,
      onChanged: (bool value) => context.read(longPressMenuPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(longPressMenu: '
          '${context.read(longPressMenuPod).state}))',
    );
  }
}
