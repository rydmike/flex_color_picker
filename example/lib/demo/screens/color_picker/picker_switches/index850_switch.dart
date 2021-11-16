import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class Index850Switch extends ConsumerWidget {
  const Index850Switch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Include grey color index 850'),
      subtitle: const Text('To include the not so well known 850 color in '
          'the Grey swatch, turn this ON. Typically kept OFF.'),
      value: ref.watch(includeIndex850Pod),
      onChanged: (bool value) =>
          ref.read(includeIndex850Pod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(includeIndex850: '
          '${ref.read(includeIndex850Pod)})',
    );
  }
}
