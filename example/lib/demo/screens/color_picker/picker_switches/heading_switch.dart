import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class HeadingSwitch extends ConsumerWidget {
  const HeadingSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Heading'),
      subtitle: const Text('You can provide your own heading widget, if '
          'it is null there is no heading.'),
      value: ref.watch(showHeadingPod),
      onChanged: (bool value) => ref.read(showHeadingPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: ref.read(showHeadingPod)
          ? "ColorPicker(heading: Text('Select color'))"
          : 'ColorPicker(heading: null)',
    );
  }
}
