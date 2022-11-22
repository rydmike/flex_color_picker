import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class TonalSwitch extends ConsumerWidget {
  const TonalSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable tonal palette'),
      subtitle: const Text('Turn ON to to show Material 3 tonal palette '
          'for selected color and enable color tone selection.'),
      value: ref.watch(enableTonesSelectionPod),
      onChanged: (bool value) =>
          ref.read(enableTonesSelectionPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(enableTonalPalette: '
          '${ref.read(enableTonesSelectionPod)})',
    );
  }
}
