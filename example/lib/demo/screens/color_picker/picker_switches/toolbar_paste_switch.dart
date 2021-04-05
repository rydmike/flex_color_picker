import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ToolbarPasteSwitch extends ConsumerWidget {
  const ToolbarPasteSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Enable toolbar PASTE action button'),
      value: watch(pasteButtonPod).state,
      onChanged: (bool value) => context.read(pasteButtonPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(pasteButton: '
          '${context.read(pasteButtonPod).state}))',
    );
  }
}
