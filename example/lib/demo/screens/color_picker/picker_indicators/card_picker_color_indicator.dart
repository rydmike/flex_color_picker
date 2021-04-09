import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../utils/app.dart';

@immutable
class CardPickerColorIndicator extends ConsumerWidget {
  const CardPickerColorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ListTile(
      title: const Text('Change this color with the ColorPicker below'),
      subtitle: Text(
          '${ColorTools.materialNameAndARGBCode(watch(cardPickerColorPod).state, colorSwatchNameMap: App.colorsNameMap)} '
          'aka ${ColorTools.nameThatColor(watch(cardPickerColorPod).state)}'),
      trailing: ColorIndicator(
        height: watch(sizePod).state,
        width: watch(sizePod).state,
        borderRadius: watch(borderRadiusPod).state,
        elevation: watch(elevationPod).state,
        color: watch(cardPickerColorPod).state,
        hasBorder: watch(hasBorderPod).state,
      ),
    );
  }
}
