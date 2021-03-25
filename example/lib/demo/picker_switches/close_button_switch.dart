import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class CloseButtonSwitch extends ConsumerWidget {
  const CloseButtonSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Dialog toolbar has CLOSE button'),
      subtitle: const Text('Use API to change icon and theme the button.'),
      value: watch(closeButtonPod).state,
      onChanged: (bool value) => context.read(closeButtonPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(closeButton: '
          '${context.read(closeButtonPod).state}))',
    );
  }
}
