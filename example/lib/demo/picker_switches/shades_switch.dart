import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class ShadesSwitch extends ConsumerWidget {
  const ShadesSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Enable color shades'),
      subtitle: const Text('Turn OFF to only use the main '
          'color in a Material color swatch. Typically left ON.'),
      value: watch(enableShadesSelectionPod).state,
      onChanged: (bool value) =>
          context.read(enableShadesSelectionPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(enableShadesSelection: '
          '${context.read(enableShadesSelectionPod).state})',
    );
  }
}
