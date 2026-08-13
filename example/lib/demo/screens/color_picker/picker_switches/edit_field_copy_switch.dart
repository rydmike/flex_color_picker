import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class EditFieldCopySwitch extends ConsumerWidget {
  const EditFieldCopySwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable color code field COPY button'),
      value: ref.watch(editFieldCopyButtonPod),
      onChanged: (bool value) =>
          ref.read(editFieldCopyButtonPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(editFieldCopyButton: '
          '${ref.read(editFieldCopyButtonPod)}))',
    );
  }
}
