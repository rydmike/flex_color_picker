import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class EditFieldCopySwitch extends ConsumerWidget {
  const EditFieldCopySwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable color code field COPY button'),
      value: ref.watch(editFieldCopyButtonPod),
      onChanged: (bool value) =>
          ref.read(editFieldCopyButtonPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(editFieldCopyButton: '
          '${ref.read(editFieldCopyButtonPod)}))',
    );
  }
}
