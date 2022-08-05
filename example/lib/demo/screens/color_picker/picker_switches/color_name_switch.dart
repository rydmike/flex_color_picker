import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ColorNameSwitch extends ConsumerWidget {
  const ColorNameSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Name that color'),
      subtitle: const Text('Give selected color a name based on closest '
          'matching color in a lookup with 1566 color names.'),
      value: ref.watch(showColorNamePod),
      onChanged: (bool value) => ref.read(showColorNamePod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(showColorName: '
          '${ref.read(showColorNamePod)})',
    );
  }
}
