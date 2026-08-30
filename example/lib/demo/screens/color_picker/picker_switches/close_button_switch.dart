import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class CloseButtonSwitch extends ConsumerWidget {
  const CloseButtonSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Dialog toolbar has CLOSE button'),
      subtitle: const Text('Use API to change icon and theme the button.'),
      value: ref.watch(closeButtonPod),
      onChanged: (bool value) => ref.read(closeButtonPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(closeButton: '
          '${ref.read(closeButtonPod)}))',
    );
  }
}
