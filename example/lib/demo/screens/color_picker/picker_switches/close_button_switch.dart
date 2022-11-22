import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class CloseButtonSwitch extends ConsumerWidget {
  const CloseButtonSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Dialog toolbar has CLOSE button'),
      subtitle: const Text('Use API to change icon and theme the button.'),
      value: ref.watch(closeButtonPod),
      onChanged: (bool value) =>
          ref.read(closeButtonPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(closeButton: '
          '${ref.read(closeButtonPod)}))',
    );
  }
}
