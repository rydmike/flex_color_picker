import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ControlCopySwitch extends ConsumerWidget {
  const ControlCopySwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable keyboard COPY shortcut'),
      subtitle: const Text('CMD-C on Apple, CTRL-C on other'),
      value: ref.watch(ctrlCPod),
      onChanged: (bool value) => ref.read(ctrlCPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(ctrlC: '
          '${ref.read(ctrlCPod)}))',
    );
  }
}
