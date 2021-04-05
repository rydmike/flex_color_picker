import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class EnableTooltipsSwitch extends ConsumerWidget {
  const EnableTooltipsSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Enable tooltips'),
      subtitle: const Text('Turn OFF to disable all tooltips in the picker.'
          '\n(Also enables and disables API tooltips in this demo, all '
          'except this one.)'),
      value: watch(enableTooltipsPod).state,
      onChanged: (bool value) => context.read(enableTooltipsPod).state = value,
      tooltipEnabled: true,
      tooltip: 'ColorPicker(enableTooltips: '
          '${watch(enableTooltipsPod).state})',
    );
  }
}
