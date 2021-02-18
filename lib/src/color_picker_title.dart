import 'package:flutter/material.dart';

/// A a title bar for the color picker.
class ColorPickerTitle extends StatelessWidget {
  /// Widget constructor.
  const ColorPickerTitle({
    Key? key,
    this.title,
    this.onClose,
  }) : super(key: key);

  /// A title widget, usually a Text widget.
  final Widget? title;

  /// Optional close button, if null there is no close button.
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (title != null) title!,
        if (onClose != null)
          IconButton(icon: const Icon(Icons.close), onPressed: onClose)
      ],
    );
  }
}
