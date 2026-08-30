import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class ColorCodeHasColorSwitch extends ConsumerWidget {
  const ColorCodeHasColorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Color code display and entry is colored'),
      subtitle: const Text(
        'Turn ON to use selected color as field '
        'background color.',
      ),
      value: ref.watch(colorCodeHasColorPod),
      onChanged: (bool value) => ref.read(colorCodeHasColorPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(colorCodeHasColor: '
          '${ref.read(colorCodeHasColorPod)})',
    );
  }
}
