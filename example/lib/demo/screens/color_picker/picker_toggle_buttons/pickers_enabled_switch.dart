import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

class PickersEnabledSwitch extends ConsumerWidget {
  const PickersEnabledSwitch({Key? key}) : super(key: key);
  static const double _kToggleFontSize = 11.5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<ColorPickerType, bool> pickersEnabled =
        ref.watch(pickersEnabledPod);
    final List<bool> isSelected = <bool>[
      pickersEnabled[ColorPickerType.both] ?? false,
      pickersEnabled[ColorPickerType.primary] ?? false,
      pickersEnabled[ColorPickerType.accent] ?? false,
      pickersEnabled[ColorPickerType.bw] ?? false,
      pickersEnabled[ColorPickerType.custom] ?? false,
      pickersEnabled[ColorPickerType.wheel] ?? false,
    ];
    return Column(
      children: <Widget>[
        const ListTile(
          title: Text('Enabled pickers'),
        ),
        MaybeTooltip(
          condition: ref.watch(enableTooltipsPod),
          tooltip: 'ColorPicker(pickersEnabled:\n'
              '  ${ref.read(pickersEnabledPod)})',
          child: ListTile(
            trailing: ToggleButtons(
              isSelected: isSelected,
              onPressed: (int index) {
                isSelected[index] = !isSelected[index];
                // If 'Both' turned ON, then 'primary' and 'Accent' is OFF.
                if (index == 0 && isSelected[0]) {
                  isSelected[1] = false;
                  isSelected[2] = false;
                }
                // If 'primary' turned ON, then 'Both' is turned OFF.
                if (index == 1 && isSelected[1]) isSelected[0] = false;
                // If 'accent' turned ON, then 'Both' is turned OFF.
                if (index == 2 && isSelected[2]) isSelected[0] = false;
                // Assign new state to enabled pickers.
                ref.read(pickersEnabledPod.state).state =
                    <ColorPickerType, bool>{
                  ColorPickerType.both: isSelected[0],
                  ColorPickerType.primary: isSelected[1],
                  ColorPickerType.accent: isSelected[2],
                  ColorPickerType.bw: isSelected[3],
                  ColorPickerType.custom: isSelected[4],
                  ColorPickerType.wheel: isSelected[5],
                };
              },
              children: const <Widget>[
                Text('Primary\nAccent',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: _kToggleFontSize)),
                Text('Primary', style: TextStyle(fontSize: _kToggleFontSize)),
                Text('Accent', style: TextStyle(fontSize: _kToggleFontSize)),
                Text('Black\nWhite',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: _kToggleFontSize)),
                Text('Custom ', style: TextStyle(fontSize: _kToggleFontSize)),
                Text('Wheel', style: TextStyle(fontSize: _kToggleFontSize)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
