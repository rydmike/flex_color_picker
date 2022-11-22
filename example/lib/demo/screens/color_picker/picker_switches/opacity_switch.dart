import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class OpacitySwitch extends ConsumerWidget {
  const OpacitySwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable opacity'),
      subtitle: const Text('Use a slider to adjust color opacity.'),
      value: ref.watch(enableOpacityPod),
      onChanged: (bool value) =>
          ref.read(enableOpacityPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(enableOpacity: ${ref.read(enableOpacityPod)})',
    );
  }
}
