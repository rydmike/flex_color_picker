import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class DialogActionIconsSwitch extends ConsumerWidget {
  const DialogActionIconsSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Dialog action buttons have icons'),
      subtitle: const Text('Use API to also customize button and icon.'),
      value: ref.watch(dialogActionIconsPod),
      onChanged: (bool value) => ref.read(dialogActionIconsPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(dialogActionIcons: '
          '${ref.read(dialogActionIconsPod)}))',
    );
  }
}
