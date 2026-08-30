import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/screens/color_picker/color_picker_dialog.dart';
import 'package:color_picker_example/demo/utils/app.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class DialogPickerColorIndicator extends ConsumerWidget {
  const DialogPickerColorIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text(
        'Click to update color from a dialog. Uses '
        '`ColorPicker.showPickerDialog`.',
      ),
      subtitle: Text(
        // ignore: cannot break earlier.
        '${ColorTools.materialNameAndARGBCode(ref.watch(dialogPickerColorPod), colorSwatchNameMap: App.colorsNameMap)} '
        'aka ${ColorTools.nameThatColor(ref.watch(dialogPickerColorPod))}',
      ),
      trailing: ColorIndicator(
        height: ref.watch(sizePod),
        width: ref.watch(sizePod),
        borderRadius: ref.watch(borderRadiusPod),
        elevation: ref.watch(elevationPod),
        color: ref.watch(dialogPickerColorPod),
        hasBorder: ref.watch(hasBorderPod),
        onSelectFocus: false,
        onSelect: () async {
          final Color colorBeforeDialog = ref.read(dialogPickerColorPod.notifier).state;
          if (!(await colorPickerDialog(context, ref))) {
            ref.read(dialogPickerColorPod.notifier).state = colorBeforeDialog;
          }
        },
      ),
    );
  }
}
