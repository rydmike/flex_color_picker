import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class SubheadingSwitch extends ConsumerWidget {
  const SubheadingSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Shades selection subheading'),
      subtitle: const Text('You can provide your own subheading widget, if '
          'it is null there is no sub heading.'),
      value: ref.watch(showSubheadingPod),
      onChanged: (bool value) =>
          ref.read(showSubheadingPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: ref.read(showSubheadingPod)
          ? "ColorPicker(subheading: Text('Select color shade'))"
          : 'ColorPicker(subheading: null)',
    );
  }
}
