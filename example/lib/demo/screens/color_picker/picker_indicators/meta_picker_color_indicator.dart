import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../color_picker_dialog.dart';

@immutable
class MetaPickerColorIndicator extends ConsumerWidget {
  const MetaPickerColorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ListTile(
      title: const Text('Control the ColorPicker below'),
      subtitle: Wrap(
        runSpacing: 4,
        spacing: 4,
        children: const <Widget>[
          ColorControlBox(color: Color(0xFF43A047)),
          ColorControlBox(color: Color(0xCAFF5252)),
          ColorControlBox(color: Color(0xFFF7F7F7)),
          ColorControlBox(color: Color(0xF04F75B8)),
          ColorControlBox(color: Color(0xA8E86600)),
          ColorControlBox(color: Color(0xFFFF5319)),
          ColorControlBox(color: Color(0xFF7D2079)),
        ],
      ),
      trailing: ColorIndicator(
        height: watch(sizePod).state,
        width: watch(sizePod).state,
        borderRadius: watch(borderRadiusPod).state,
        elevation: watch(elevationPod).state,
        color: watch(cardPickerColorPod).state,
        hasBorder: watch(hasBorderPod).state,
        onSelectFocus: false,
        onSelect: () async {
          final Color colorBeforeDialog =
              context.read(cardPickerColorPod).state;
          if (!(await colorPickerDialog(
            context,
            watch,
            cardRemote: true,
          ))) {
            context.read(cardPickerColorPod).state = colorBeforeDialog;
          }
        },
      ),
    );
  }
}

class ColorControlBox extends ConsumerWidget {
  const ColorControlBox({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ColorIndicator(
      height: watch(sizePod).state * 0.8,
      width: watch(sizePod).state * 0.8,
      borderRadius: watch(borderRadiusPod).state * 0.8,
      elevation: watch(elevationPod).state,
      color: watch(enableOpacityPod).state ? color : color.withAlpha(0xFF),
      hasBorder: watch(hasBorderPod).state,
      onSelectFocus: false,
      isSelected: watch(cardPickerColorPod).state == color,
      onSelect: () {
        context.read(cardPickerColorPod).state = color;
      },
    );
  }
}
