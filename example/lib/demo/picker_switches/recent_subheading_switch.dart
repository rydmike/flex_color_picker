import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class RecentSubheadingSwitch extends ConsumerWidget {
  const RecentSubheadingSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Recent colors subheading'),
      subtitle: const Text('You can provide your own subheading widget, if '
          'it is null there is no sub heading.'),
      value: watch(showRecentSubheadingPod).state,
      onChanged: (bool value) =>
          context.read(showRecentSubheadingPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: context.read(showRecentSubheadingPod).state
          ? "ColorPicker(recentColorsSubheading: Text('Recent colors'))"
          : 'ColorPicker(recentColorsSubheading: null)',
    );
  }
}
