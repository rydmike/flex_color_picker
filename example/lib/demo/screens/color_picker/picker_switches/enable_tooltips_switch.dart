import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class EnableTooltipsSwitch extends ConsumerWidget {
  const EnableTooltipsSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable tooltips'),
      subtitle: const Text('Turn OFF to disable all tooltips in the picker.'
          '\n(Also enables and disables API tooltips in this demo, all '
          'except this one.)'),
      value: ref.watch(enableTooltipsPod),
      onChanged: (bool value) =>
          ref.read(enableTooltipsPod.notifier).state = value,
      tooltipEnabled: true,
      tooltip: 'ColorPicker(enableTooltips: '
          '${ref.watch(enableTooltipsPod)})',
    );
  }
}
