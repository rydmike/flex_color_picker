import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class OkButtonSwitch extends ConsumerWidget {
  const OkButtonSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Dialog toolbar has OK button'),
      subtitle: const Text('Use API to change icon and theme the button.'),
      value: ref.watch(okButtonPod),
      onChanged: (bool value) => ref.read(okButtonPod.state).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(actionButtons:\n'
          '  ColorPickerActionButtons(okButton: '
          '${ref.read(okButtonPod)}))',
    );
  }
}
