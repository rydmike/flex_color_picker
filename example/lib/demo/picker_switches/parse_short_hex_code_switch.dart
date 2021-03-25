import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class ParseShortHexCodeSwitch extends ConsumerWidget {
  const ParseShortHexCodeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Parse 3-char code as WEB 3-char hex RGB format'),
      subtitle: const Text('Applies to both paste action and color '
          'code entry.'),
      value: watch(parseShortHexCodePod).state,
      onChanged: (bool value) =>
          context.read(parseShortHexCodePod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(parseShortHexCode: '
          '${context.read(parseShortHexCodePod).state}))',
    );
  }
}
