import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ColorCodeReadOnlySwitch extends ConsumerWidget {
  const ColorCodeReadOnlySwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Color code display and entry is read only'),
      subtitle: const Text('Normally color code field can be edited on '
          'Wheel picker. Set this to ON to make it read only.'),
      value: watch(colorCodeReadOnlyPod).state,
      onChanged: (bool value) =>
          context.read(colorCodeReadOnlyPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(colorCodeReadOnly: '
          '${context.read(colorCodeReadOnlyPod).state})',
    );
  }
}
