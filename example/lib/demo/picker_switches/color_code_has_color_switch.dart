import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class ColorCodeHasColorSwitch extends ConsumerWidget {
  const ColorCodeHasColorSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Color code display and entry is colored'),
      subtitle: const Text('Turn ON to use selected color as field '
          'background color.'),
      value: watch(colorCodeHasColorPod).state,
      onChanged: (bool value) =>
          context.read(colorCodeHasColorPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(colorCodeHasColor: '
          '${context.read(colorCodeHasColorPod).state})',
    );
  }
}
