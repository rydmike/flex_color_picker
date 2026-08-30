import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class OpacitySubheadingSwitch extends ConsumerWidget {
  const OpacitySubheadingSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Opacity slider subheading'),
      subtitle: const Text(
        'You can provide your own subheading widget, if '
        'it is null there is no sub heading.',
      ),
      value: ref.watch(showOpacitySubheadingPod),
      onChanged: (bool value) => ref.read(showOpacitySubheadingPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: ref.read(showOpacitySubheadingPod)
          ? '"ColorPicker(opacitySubheading: '
                "Text('Select opacity subheading shade'))"
          : 'ColorPicker(opacitySubheading: null)',
    );
  }
}
