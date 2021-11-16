import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class RecentSubheadingSwitch extends ConsumerWidget {
  const RecentSubheadingSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Recent colors subheading'),
      subtitle: const Text('You can provide your own subheading widget, if '
          'it is null there is no sub heading.'),
      value: ref.watch(showRecentSubheadingPod),
      onChanged: (bool value) =>
          ref.read(showRecentSubheadingPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: ref.read(showRecentSubheadingPod)
          ? "ColorPicker(recentColorsSubheading: Text('Recent colors'))"
          : 'ColorPicker(recentColorsSubheading: null)',
    );
  }
}
