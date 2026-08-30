import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class ColorValueSwitch extends ConsumerWidget {
  const ColorValueSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Color code integer value'),
      subtitle: const Text(
        'Show color integer value, that can be painted and '
        'copied. Typically OFF, usable as a dev feature.',
      ),
      value: ref.watch(showColorValuePod),
      onChanged: (bool value) => ref.read(showColorValuePod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(showColorValue: '
          '${ref.read(showColorValuePod)})',
    );
  }
}
