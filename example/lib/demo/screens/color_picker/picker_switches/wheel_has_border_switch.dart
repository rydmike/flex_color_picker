import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class WheelHasBorderSwitch extends ConsumerWidget {
  const WheelHasBorderSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Border around color wheel'),
      subtitle: const Text(
        'With the API you can also adjust the '
        'border color',
      ),
      value: ref.watch(wheelHasBorderPod),
      onChanged: (bool value) => ref.read(wheelHasBorderPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(wheelHasBorder: '
          '${ref.read(wheelHasBorderPod)})',
    );
  }
}
