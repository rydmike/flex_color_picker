import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ToolbarCopySwitch extends ConsumerWidget {
  const ToolbarCopySwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Enable toolbar COPY action button'),
      value: watch(copyButtonPod).state,
      onChanged: (bool value) => context.read(copyButtonPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(copyButton: '
          '${context.read(copyButtonPod).state}))',
    );
  }
}
