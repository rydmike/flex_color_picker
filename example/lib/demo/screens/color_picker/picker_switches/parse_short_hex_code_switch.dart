import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ParseShortHexCodeSwitch extends ConsumerWidget {
  const ParseShortHexCodeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Parse 3-char code as WEB 3-char hex RGB format'),
      subtitle: const Text('Applies to both paste action and color '
          'code entry.'),
      value: ref.watch(parseShortHexCodePod),
      onChanged: (bool value) =>
          ref.read(parseShortHexCodePod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(parseShortHexCode: '
          '${ref.read(parseShortHexCodePod)}))',
    );
  }
}
