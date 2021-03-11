import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class CopyFormatSwitch extends StatelessWidget {
  CopyFormatSwitch({
    Key? key,
    required this.format,
    required this.onChanged,
  })   : _isSelected = <bool>[
          format == ColorPickerCopyFormat.dartCode,
          format == ColorPickerCopyFormat.hexRRGGBB,
          format == ColorPickerCopyFormat.hexAARRGGBB,
          format == ColorPickerCopyFormat.numHexRRGGBB,
          format == ColorPickerCopyFormat.numHexAARRGGBB,
        ],
        super(key: key);

  final ColorPickerCopyFormat format;
  final ValueChanged<ColorPickerCopyFormat> onChanged;

  final List<bool> _isSelected;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ToggleButtons(
      isSelected: _isSelected,
      selectedColor: colorScheme.onPrimary,
      color: colorScheme.onSurface,
      fillColor: colorScheme.primary,
      hoverColor: colorScheme.primary.withOpacity(0.2),
      focusColor: colorScheme.primary.withOpacity(0.3),
      borderWidth: 2,
      borderColor: colorScheme.primary,
      selectedBorderColor: colorScheme.primary,
      borderRadius: BorderRadius.circular(44),
      constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
      onPressed: (int newIndex) {
        for (int index = 0; index < _isSelected.length; index++) {
          if (index == newIndex) {
            _isSelected[index] = true;
            onChanged(ColorPickerCopyFormat.values[newIndex]);
          } else {
            _isSelected[index] = false;
          }
        }
      },
      children: const <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text('0xARGB'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Text('RGB'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Text('ARGB'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2),
          child: Text('#RGB'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Text('#ARGB'),
        ),
      ],
    );
  }
}
