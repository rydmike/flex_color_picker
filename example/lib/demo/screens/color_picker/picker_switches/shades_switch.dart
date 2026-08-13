import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ShadesSwitch extends ConsumerWidget {
  const ShadesSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Enable color shades'),
      subtitle: const Text('Turn OFF to only use the main '
          'color in a Material color swatch. Typically left ON.'),
      value: ref.watch(enableShadesSelectionPod),
      onChanged: (bool value) =>
          ref.read(enableShadesSelectionPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(enableShadesSelection: '
          '${ref.read(enableShadesSelectionPod)})',
    );
  }
}
