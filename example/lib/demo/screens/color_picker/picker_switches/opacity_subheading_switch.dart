import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class OpacitySubheadingSwitch extends ConsumerWidget {
  const OpacitySubheadingSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Opacity slider subheading'),
      subtitle: const Text('You can provide your own subheading widget, if '
          'it is null there is no sub heading.'),
      value: watch(showOpacitySubheadingPod).state,
      onChanged: (bool value) =>
          context.read(showOpacitySubheadingPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: context.read(showOpacitySubheadingPod).state
          ? '"ColorPicker(opacitySubheading: '
              "Text('Select opacity subheading shade'))"
          : 'ColorPicker(opacitySubheading: null)',
    );
  }
}
