import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ColorCodeHasColorSwitch extends ConsumerWidget {
  const ColorCodeHasColorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Color code display and entry is colored'),
      subtitle: const Text('Turn ON to use selected color as field '
          'background color.'),
      value: ref.watch(colorCodeHasColorPod),
      onChanged: (bool value) =>
          ref.read(colorCodeHasColorPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(colorCodeHasColor: '
          '${ref.read(colorCodeHasColorPod)})',
    );
  }
}
