import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ColorCodeSwitch extends ConsumerWidget {
  const ColorCodeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Color code display and entry'),
      subtitle: const Text('Show hex RGB value of the selected color. On the '
          'wheel picker you can also enter a HEX RGB value.'),
      value: ref.watch(showColorCodePod),
      onChanged: (bool value) => ref.read(showColorCodePod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(showColorCode: '
          '${ref.read(showColorCodePod)})',
    );
  }
}
