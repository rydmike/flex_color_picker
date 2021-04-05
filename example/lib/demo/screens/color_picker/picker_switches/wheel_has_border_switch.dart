import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class WheelHasBorderSwitch extends ConsumerWidget {
  const WheelHasBorderSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Border around color wheel'),
      subtitle: const Text('With the API you can also adjust the '
          'border color'),
      value: watch(wheelHasBorderPod).state,
      onChanged: (bool value) => context.read(wheelHasBorderPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(wheelHasBorder: '
          '${context.read(wheelHasBorderPod).state})',
    );
  }
}
