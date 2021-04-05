import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class OpacitySwitch extends ConsumerWidget {
  const OpacitySwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Enable opacity'),
      subtitle: const Text('Use a slider to adjust color opacity.'),
      value: watch(enableOpacityPod).state,
      onChanged: (bool value) => context.read(enableOpacityPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip:
          'ColorPicker(enableOpacity: ${context.read(enableOpacityPod).state})',
    );
  }
}
