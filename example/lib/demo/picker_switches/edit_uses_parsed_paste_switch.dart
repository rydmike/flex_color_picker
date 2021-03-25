import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class EditUsesParsedPasteSwitch extends ConsumerWidget {
  const EditUsesParsedPasteSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Color code entry field uses paste parser'),
      subtitle: const Text('Turn OFF to use normal text field paste. '
          'This feature only applies to desktop keyboard shortcuts.'),
      value: watch(editUsesParsedPastePod).state,
      onChanged: (bool value) =>
          context.read(editUsesParsedPastePod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(editUsesParsedPaste: '
          '${context.read(editUsesParsedPastePod).state}))',
    );
  }
}
