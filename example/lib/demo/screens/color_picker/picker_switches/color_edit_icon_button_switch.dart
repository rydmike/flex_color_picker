import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ColorEditIconButtonSwitch extends ConsumerWidget {
  const ColorEditIconButtonSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Show edit icon button'),
      subtitle: const Text('An edit icon button is shown before the color '
          'indicator and entry field when it can be edited. If tapped, '
          'the edit field is focused.'),
      value: ref.watch(showEditIconButtonPod),
      onChanged: (bool value) =>
          ref.read(showEditIconButtonPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(showEditIconButton: '
          '${ref.read(showEditIconButtonPod)})',
    );
  }
}
