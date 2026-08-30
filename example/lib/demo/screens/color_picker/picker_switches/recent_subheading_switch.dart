import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class RecentSubheadingSwitch extends ConsumerWidget {
  const RecentSubheadingSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Recent colors subheading'),
      subtitle: const Text(
        'You can provide your own subheading widget, if '
        'it is null there is no sub heading.',
      ),
      value: ref.watch(showRecentSubheadingPod),
      onChanged: (bool value) => ref.read(showRecentSubheadingPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: ref.read(showRecentSubheadingPod)
          ? "ColorPicker(recentColorsSubheading: Text('Recent colors'))"
          : 'ColorPicker(recentColorsSubheading: null)',
    );
  }
}
