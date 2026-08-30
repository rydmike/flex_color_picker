import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class DialogActionsButtonsSwitch extends ConsumerWidget {
  const DialogActionsButtonsSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Dialog has bottom CANCEL OK buttons'),
      subtitle: const Text('Turn OFF to remove bottom action buttons.'),
      value: ref.watch(dialogActionButtonsPod),
      onChanged: (bool value) => ref.read(dialogActionButtonsPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(dialogActionButtons: '
          '${ref.read(dialogActionButtonsPod)}))',
    );
  }
}
