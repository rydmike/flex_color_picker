import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class HeadingSwitch extends ConsumerWidget {
  const HeadingSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Heading'),
      subtitle: const Text('You can provide your own heading widget, if '
          'it is null there is no heading.'),
      value: watch(showHeadingPod).state,
      onChanged: (bool value) => context.read(showHeadingPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: context.read(showHeadingPod).state
          ? "ColorPicker(heading: Text('Select color'))"
          : 'ColorPicker(heading: null)',
    );
  }
}
