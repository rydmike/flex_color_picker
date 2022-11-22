import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class EditUsesParsedPasteSwitch extends ConsumerWidget {
  const EditUsesParsedPasteSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Color code entry field uses paste parser'),
      subtitle: const Text('Turn OFF to use normal text field paste. '
          'This feature only applies to desktop keyboard shortcuts.'),
      value: ref.watch(editUsesParsedPastePod),
      onChanged: (bool value) =>
          ref.read(editUsesParsedPastePod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(editUsesParsedPaste: '
          '${ref.read(editUsesParsedPastePod)}))',
    );
  }
}
