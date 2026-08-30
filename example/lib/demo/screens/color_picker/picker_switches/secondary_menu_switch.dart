import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class SecondaryMenuSwitch extends ConsumerWidget {
  const SecondaryMenuSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Secondary click COPY-PASTE menu'),
      subtitle: const Text('Typically mouse right click.'),
      value: ref.watch(secondaryMenuPod),
      onChanged: (bool value) => ref.read(secondaryMenuPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(secondaryMenu: '
          '${ref.read(secondaryMenuPod)}))',
    );
  }
}
