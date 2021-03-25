import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class DialogActionsButtonsSwitch extends ConsumerWidget {
  const DialogActionsButtonsSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Dialog has bottom CANCEL OK buttons'),
      subtitle: const Text('Turn OFF to remove bottom action buttons.'),
      value: watch(dialogActionButtonsPod).state,
      onChanged: (bool value) =>
          context.read(dialogActionButtonsPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(dialogActionButtons: '
          '${context.read(dialogActionButtonsPod).state}))',
    );
  }
}
