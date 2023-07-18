import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class TonalSameSizeSwitch extends ConsumerWidget {
  const TonalSameSizeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Tonal color items same size'),
      subtitle: const Text('When OFF tonal color items are smaller and same '
          'width as the items making up a Material swatch color palette.'),
      value: ref.watch(tonalSameSizePod),
      onChanged: (bool value) =>
          ref.read(tonalSameSizePod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(tonalColorSameSize: '
          '${ref.read(tonalSameSizePod)})',
    );
  }
}
