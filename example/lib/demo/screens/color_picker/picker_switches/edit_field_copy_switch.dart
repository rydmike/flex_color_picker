import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class EditFieldCopySwitch extends ConsumerWidget {
  const EditFieldCopySwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Enable color code field COPY button'),
      value: watch(editFieldCopyButtonPod).state,
      onChanged: (bool value) =>
          context.read(editFieldCopyButtonPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(editFieldCopyButton: '
          '${context.read(editFieldCopyButtonPod).state}))',
    );
  }
}
