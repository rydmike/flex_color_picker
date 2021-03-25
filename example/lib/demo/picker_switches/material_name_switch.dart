import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class MaterialNameSwitch extends ConsumerWidget {
  const MaterialNameSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Material color name'),
      subtitle: const Text('If selected color is a standard Material color, '
          'its name is shown together with its shade index.'),
      value: watch(showMaterialNamePod).state,
      onChanged: (bool value) =>
          context.read(showMaterialNamePod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(showMaterialName: '
          '${context.read(showMaterialNamePod).state})',
    );
  }
}
