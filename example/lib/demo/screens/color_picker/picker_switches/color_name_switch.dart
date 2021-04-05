import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ColorNameSwitch extends ConsumerWidget {
  const ColorNameSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Name that color'),
      subtitle: const Text('Give selected color a name based on closest '
          'matching color in a lookup with 1566 color names.'),
      value: watch(showColorNamePod).state,
      onChanged: (bool value) => context.read(showColorNamePod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(showColorName: '
          '${context.read(showColorNamePod).state})',
    );
  }
}
