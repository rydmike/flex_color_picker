import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class OkButtonSwitch extends ConsumerWidget {
  const OkButtonSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Dialog toolbar has OK button'),
      subtitle: const Text('Use API to change icon and theme the button.'),
      value: watch(okButtonPod).state,
      onChanged: (bool value) => context.read(okButtonPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(okButton: '
          '${context.read(okButtonPod).state}))',
    );
  }
}
