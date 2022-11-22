import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class TitleSwitch extends ConsumerWidget {
  const TitleSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Toolbar title'),
      subtitle: const Text('You can provide your own picker toolbar title, if '
          'it is null there is no title.'),
      value: ref.watch(showTitlePod),
      onChanged: (bool value) => ref.read(showTitlePod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: ref.read(showTitlePod)
          ? "ColorPicker(title: Text('Color Picker'))"
          : 'ColorPicker(title: null)',
    );
  }
}
