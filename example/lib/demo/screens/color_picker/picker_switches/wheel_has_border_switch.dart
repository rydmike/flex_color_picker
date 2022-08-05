import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class WheelHasBorderSwitch extends ConsumerWidget {
  const WheelHasBorderSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Border around color wheel'),
      subtitle: const Text('With the API you can also adjust the '
          'border color'),
      value: ref.watch(wheelHasBorderPod),
      onChanged: (bool value) =>
          ref.read(wheelHasBorderPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(wheelHasBorder: '
          '${ref.read(wheelHasBorderPod)})',
    );
  }
}
