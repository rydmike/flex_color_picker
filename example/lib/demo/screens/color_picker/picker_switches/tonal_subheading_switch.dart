import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class TonalSubheadingSwitch extends ConsumerWidget {
  const TonalSubheadingSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Tonal palette subheading'),
      subtitle: const Text('You can provide your own tonal palette subheading '
          ' widget, if it is null there is no tonal subheading.'),
      value: ref.watch(showTonalSubheadingPod),
      onChanged: (bool value) =>
          ref.read(showTonalSubheadingPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: ref.read(showTonalSubheadingPod)
          ? "ColorPicker(tonalSubheading: Text('Material 3 tonal palette'))"
          : 'ColorPicker(tonalSubheading: null)',
    );
  }
}
