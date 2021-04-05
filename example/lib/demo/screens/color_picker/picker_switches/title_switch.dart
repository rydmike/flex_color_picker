import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class TitleSwitch extends ConsumerWidget {
  const TitleSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Toolbar title'),
      subtitle: const Text('You can provide your own picker toolbar title, if '
          'it is null there is no title.'),
      value: watch(showTitlePod).state,
      onChanged: (bool value) => context.read(showTitlePod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: context.read(showTitlePod).state
          ? "ColorPicker(title: Text('Color Picker'))"
          : 'ColorPicker(title: null)',
    );
  }
}
