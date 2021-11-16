import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class OpacitySubheadingSwitch extends ConsumerWidget {
  const OpacitySubheadingSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Opacity slider subheading'),
      subtitle: const Text('You can provide your own subheading widget, if '
          'it is null there is no sub heading.'),
      value: ref.watch(showOpacitySubheadingPod),
      onChanged: (bool value) =>
          ref.read(showOpacitySubheadingPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: ref.read(showOpacitySubheadingPod)
          ? '"ColorPicker(opacitySubheading: '
              "Text('Select opacity subheading shade'))"
          : 'ColorPicker(opacitySubheading: null)',
    );
  }
}
