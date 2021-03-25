import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';
import '../switch_tile_tooltip.dart';

@immutable
class Index850Switch extends ConsumerWidget {
  const Index850Switch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Include grey color index 850'),
      subtitle: const Text('To include the not so well known 850 color in '
          'the Grey swatch, turn this ON. Typically kept OFF.'),
      value: watch(includeIndex850Pod).state,
      onChanged: (bool value) => context.read(includeIndex850Pod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(includeIndex850: '
          '${context.read(includeIndex850Pod).state})',
    );
  }
}
