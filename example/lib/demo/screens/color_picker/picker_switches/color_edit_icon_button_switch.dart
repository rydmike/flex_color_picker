import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class ColorEditIconButtonSwitch extends ConsumerWidget {
  const ColorEditIconButtonSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Show edit icon button'),
      subtitle: const Text(
        'An edit icon button is shown before the color '
        'indicator and entry field when it can be edited. If tapped, '
        'the edit field is focused.',
      ),
      value: ref.watch(showEditIconButtonPod),
      onChanged: (bool value) => ref.read(showEditIconButtonPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(showEditIconButton: '
          '${ref.read(showEditIconButtonPod)})',
    );
  }
}
