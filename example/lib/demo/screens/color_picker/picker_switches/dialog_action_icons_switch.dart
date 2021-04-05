import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class DialogActionIconsSwitch extends ConsumerWidget {
  const DialogActionIconsSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Dialog action buttons have icons'),
      subtitle: const Text('Use API to also customize button and icon.'),
      value: watch(dialogActionIconsPod).state,
      onChanged: (bool value) =>
          context.read(dialogActionIconsPod).state = value,
      tooltipEnabled: watch(dialogActionIconsPod).state,
      tooltip: 'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(dialogActionIcons: '
          '${context.read(dialogActionIconsPod).state}))',
    );
  }
}
