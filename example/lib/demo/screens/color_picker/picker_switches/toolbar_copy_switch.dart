import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class ToolbarCopySwitch extends ConsumerWidget {
  const ToolbarCopySwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable toolbar COPY action button'),
      value: ref.watch(copyButtonPod),
      onChanged: (bool value) => ref.read(copyButtonPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(copyButton: '
          '${ref.read(copyButtonPod)}))',
    );
  }
}
