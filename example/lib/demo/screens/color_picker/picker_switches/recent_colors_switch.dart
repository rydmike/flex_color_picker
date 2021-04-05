import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class RecentColorsSwitch extends ConsumerWidget {
  const RecentColorsSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Recent colors'),
      subtitle: const Text('Show a list of recently selected colors. You '
          'can also control how many colors are kept with the API.'),
      value: watch(showRecentColorsPod).state,
      onChanged: (bool value) =>
          context.read(showRecentColorsPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(showRecentColors: '
          '${context.read(showRecentColorsPod).state})',
    );
  }
}
