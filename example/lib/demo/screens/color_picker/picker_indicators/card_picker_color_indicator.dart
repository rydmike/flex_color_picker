import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../utils/app.dart';

@immutable
class CardPickerColorIndicator extends ConsumerWidget {
  const CardPickerColorIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Change this color with the ColorPicker below'),
      subtitle: Text(
          // ignore: lines_longer_than_80_chars
          '${ColorTools.materialNameAndARGBCode(ref.watch(cardPickerColorPod), colorSwatchNameMap: App.colorsNameMap)} '
          'aka ${ColorTools.nameThatColor(ref.watch(cardPickerColorPod))}'),
      trailing: ColorIndicator(
        height: ref.watch(sizePod),
        width: ref.watch(sizePod),
        borderRadius: ref.watch(borderRadiusPod),
        elevation: ref.watch(elevationPod),
        color: ref.watch(cardPickerColorPod),
        hasBorder: ref.watch(hasBorderPod),
      ),
    );
  }
}
