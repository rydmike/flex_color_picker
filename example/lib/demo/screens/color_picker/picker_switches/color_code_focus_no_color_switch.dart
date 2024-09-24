import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class ColorCodeFocusNoColorSwitch extends ConsumerWidget {
  const ColorCodeFocusNoColorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Color code field has no color when focused'),
      subtitle: const Text('It can be more clear to enter a RGB color '
          'when the field look more like a normal text field, when '
          'otherwise using the using field as colored indicator.'),
      value: ref.watch(focusedEditHasNoColorPod),
      onChanged: (bool value) =>
          ref.read(focusedEditHasNoColorPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(focusedEditHasNoColor: '
          '${ref.read(focusedEditHasNoColorPod)})',
    );
  }
}
