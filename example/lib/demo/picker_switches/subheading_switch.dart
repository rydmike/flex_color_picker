import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class SubheadingSwitch extends ConsumerWidget {
  const SubheadingSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Shades selection subheading'),
      subtitle: const Text('You can provide your own subheading widget, if '
          'it is null there is no sub heading.'),
      value: watch(showSubheadingPod).state,
      onChanged: (bool value) => context.read(showSubheadingPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: context.read(showSubheadingPod).state
          ? "ColorPicker(subheading: Text('Select color shade'))"
          : 'ColorPicker(subheading: null)',
    );
  }
}
