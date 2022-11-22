import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class CloseIsLastSwitch extends ConsumerWidget {
  const CloseIsLastSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Dialog toolbar CLOSE is last button'),
      subtitle: const Text('The CLOSE button is last, turn OFF to make OK '
          'button the last one in the toolbar.'),
      value: ref.watch(closeIsLastPod),
      onChanged: (bool value) =>
          ref.read(closeIsLastPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(closeIsLast: '
          '${ref.read(closeIsLastPod)}))',
    );
  }
}
