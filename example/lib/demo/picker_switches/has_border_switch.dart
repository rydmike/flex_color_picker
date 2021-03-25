import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class HasBorderSwitch extends ConsumerWidget {
  const HasBorderSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Border around color pick items'),
      subtitle: const Text('With the API you can also adjust the '
          'border color.'),
      value: watch(hasBorderPod).state,
      onChanged: (bool value) => context.read(hasBorderPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(hasBorder: ${context.read(hasBorderPod).state})',
    );
  }
}
