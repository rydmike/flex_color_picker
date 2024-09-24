import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class TonalLegacySwitch extends ConsumerWidget {
  const TonalLegacySwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Use legacy fixed min chroma tonal palette'),
      subtitle: const Text('Turn ON for same tonal palette as before '
          'version 3.6.0. Prefer keeping this OFF for better tonals'),
      value: ref.watch(tonalPaletteFixedMinChromaPod),
      onChanged: (bool value) =>
          ref.read(tonalPaletteFixedMinChromaPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(tonalPaletteFixedMinChroma: '
          '${ref.read(tonalPaletteFixedMinChromaPod)})',
    );
  }
}
