import 'package:flutter/material.dart';

class AlignmentSwitch extends StatelessWidget {
  AlignmentSwitch({
    Key? key,
    required this.alignment,
    required this.onChanged,
  })   : _isSelected = <bool>[
          alignment == CrossAxisAlignment.start,
          alignment == CrossAxisAlignment.center,
          alignment == CrossAxisAlignment.end,
        ],
        super(key: key);

  final CrossAxisAlignment alignment;
  final ValueChanged<CrossAxisAlignment> onChanged;

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
          } else {
            _isSelected[index] = false;
          }
        }
        // This can be made compacter code wise if you use the enum
        // value order also as mode order for the toggle buttons, but wanted
        // CrossAxisAlignment.center in the middle in this case.
        if (newIndex == 0) {
          onChanged(CrossAxisAlignment.start);
        } else if (newIndex == 2) {
          onChanged(CrossAxisAlignment.end);
        } else {
          onChanged(CrossAxisAlignment.center);
        }
      },
      children: const <Widget>[
        Icon(Icons.format_align_left),
        Icon(Icons.format_align_center),
        Icon(Icons.format_align_right),
      ],
    );
  }
}
