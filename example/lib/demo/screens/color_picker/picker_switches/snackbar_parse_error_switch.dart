import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class SnackbarParseErrorSwitch extends ConsumerWidget {
  const SnackbarParseErrorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Snackbar paste format error message'),
      value: ref.watch(snackbarParseErrorPod),
      onChanged: (bool value) => ref.read(snackbarParseErrorPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(snackBarParseError: '
          '${ref.read(snackbarParseErrorPod)}))',
    );
  }
}
