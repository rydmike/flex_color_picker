import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class PickerAutoFocusSwitch extends ConsumerWidget {
  const PickerAutoFocusSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Picker uses auto focus'),
      subtitle: const Text('To make keyboard shortcuts work better, the '
          'picker tries to grab focus by default. Turn OFF this behavior if '
          'it is in the way. If both copy and paste keyboard shortcuts are '
          'disabled, this settings does not matter, the picker never tries '
          'to autofocus when they are not used.'),
      value: ref.watch(autoFocusPod),
      onChanged: (bool value) => ref.read(autoFocusPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(autoFocus: '
          '${ref.read(autoFocusPod)}))',
    );
  }
}
