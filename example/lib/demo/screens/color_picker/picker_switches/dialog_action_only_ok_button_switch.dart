import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class DialogActionOnlyOkButtonSwitch extends ConsumerWidget {
  const DialogActionOnlyOkButtonSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Dialog has only OK button'),
      subtitle: const Text('Turn ON to remove the dialog bottom Cancel button'),
      value: ref.watch(dialogActionOnlyOkButtonPod),
      onChanged: (bool value) => ref.read(dialogActionOnlyOkButtonPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(dialogActionOnlyOkButton: '
          '${ref.read(dialogActionOnlyOkButtonPod)}))',
    );
  }
}
