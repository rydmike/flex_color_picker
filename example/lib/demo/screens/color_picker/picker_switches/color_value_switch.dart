import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ColorValueSwitch extends ConsumerWidget {
  const ColorValueSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Color code integer value'),
      subtitle: const Text('Show color integer value, that can be painted and '
          'copied. Typically OFF, usable as a dev feature.'),
      value: watch(showColorValuePod).state,
      onChanged: (bool value) => context.read(showColorValuePod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(showColorValue: '
          '${context.read(showColorValuePod).state})',
    );
  }
}
