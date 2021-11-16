import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ToolbarCopySwitch extends ConsumerWidget {
  const ToolbarCopySwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable toolbar COPY action button'),
      value: ref.watch(copyButtonPod),
      onChanged: (bool value) => ref.read(copyButtonPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(copyButton: '
          '${ref.read(copyButtonPod)}))',
    );
  }
}
