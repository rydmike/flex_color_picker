import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class TransparencySwitch extends ConsumerWidget {
  const TransparencySwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable custom colors transparency'),
      subtitle: const Text('Enable transparent colors on color values '
          'in custom color palettes'),
      value: ref.watch(enableTransparencyPod),
      onChanged: (bool value) =>
          ref.read(enableTransparencyPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(enableTransparentCustomColors: '
          '${ref.read(enableTransparencyPod)})',
    );
  }
}
