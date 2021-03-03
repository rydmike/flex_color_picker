import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/color_picker_type.dart';

/// PickerSelector widget.
///
/// Not library exposed, private to the library.
@immutable
class PickerSelector extends StatelessWidget {
  /// Default const constructor.
  const PickerSelector({
    Key? key,
    required this.pickerTypes,
    required this.value,
    required this.onValueChanged,
    this.thumbColor,
    required this.columnSpacing,
  }) : super(key: key);

  /// A map of used pickers and their widgets.
  final Map<ColorPickerType, Widget> pickerTypes;

  /// Current active picker selection
  final ColorPickerType value;

  /// Callback to change picker type.
  final ValueChanged<ColorPickerType> onValueChanged;

  /// The current thumb color of the picker selector.
  ///
  /// Uses cupertino default light and dark style if not provided.
  final Color? thumbColor;

  /// The spacing after the picker.
  final double columnSpacing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(bottom: columnSpacing),
        child: CupertinoSlidingSegmentedControl<ColorPickerType>(
          children: pickerTypes,
          thumbColor: thumbColor ??
              const CupertinoDynamicColor.withBrightness(
                color: Color(0xFFFFFFFF),
                darkColor: Color(0xFF636366),
              ),
          onValueChanged: (ColorPickerType? value) {
            if (value != null) onValueChanged(value);
          },
          groupValue: value,
        ),
      ),
    );
  }
}
