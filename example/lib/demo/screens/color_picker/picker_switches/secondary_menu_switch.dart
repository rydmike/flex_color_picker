import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class SecondaryMenuSwitch extends ConsumerWidget {
  const SecondaryMenuSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Secondary click COPY-PASTE menu'),
      subtitle: const Text('Typically mouse right click.'),
      value: ref.watch(secondaryMenuPod),
      onChanged: (bool value) => ref.read(secondaryMenuPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(secondaryMenu: '
          '${ref.read(secondaryMenuPod)}))',
    );
  }
}
