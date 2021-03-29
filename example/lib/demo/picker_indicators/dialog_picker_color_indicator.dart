import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_const.dart';
import '../color_picker_dialog.dart';
import '../pods.dart';

@immutable
class DialogPickerColorIndicator extends ConsumerWidget {
  const DialogPickerColorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return ListTile(
      title: const Text('Click this color to change it in a dialog'),
      subtitle: Text(
          '${ColorTools.materialNameAndARGBCode(watch(dialogPickerColorPod).state, colorSwatchNameMap: App.colorsNameMap2)} '
          'aka ${ColorTools.nameThatColor(watch(dialogPickerColorPod).state)}'),
      trailing: ColorIndicator(
        height: watch(sizePod).state,
        width: watch(sizePod).state,
        borderRadius: watch(borderRadiusPod).state,
        elevation: watch(elevationPod).state,
        color: watch(dialogPickerColorPod).state,
        hasBorder: watch(hasBorderPod).state,
        onSelectFocus: false,
        onSelect: () async {
          final Color colorBeforeDialog =
              context.read(dialogPickerColorPod).state;
          if (!(await colorPickerDialog(context, watch))) {
            context.read(dialogPickerColorPod).state = colorBeforeDialog;
          }
        },
      ),
    );
  }
}
