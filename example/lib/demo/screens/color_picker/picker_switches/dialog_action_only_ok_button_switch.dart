import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class DialogActionOnlyOkButtonSwitch extends ConsumerWidget {
  const DialogActionOnlyOkButtonSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Dialog has only OK button'),
      subtitle: const Text('Turn ON to remove the dialog bottom Cancel button'),
      value: ref.watch(dialogActionOnlyOkButtonPod),
      onChanged: (bool value) =>
          ref.read(dialogActionOnlyOkButtonPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(dialogActionOnlyOkButton: '
          '${ref.read(dialogActionOnlyOkButtonPod)}))',
    );
  }
}
