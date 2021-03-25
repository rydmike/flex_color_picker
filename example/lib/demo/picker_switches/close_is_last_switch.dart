import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class CloseIsLastSwitch extends ConsumerWidget {
  const CloseIsLastSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Dialog toolbar CLOSE is last button'),
      subtitle: const Text('The CLOSE button is last, turn OFF to make OK '
          'button the last one in the toolbar.'),
      value: watch(closeIsLastPod).state,
      onChanged: (bool value) => context.read(closeIsLastPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(closeIsLast: '
          '${context.read(closeIsLastPod).state}))',
    );
  }
}
