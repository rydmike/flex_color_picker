import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class SnackbarParseErrorSwitch extends ConsumerWidget {
  const SnackbarParseErrorSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Snackbar paste format error message'),
      value: watch(snackbarParseErrorPod).state,
      onChanged: (bool value) =>
          context.read(snackbarParseErrorPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(snackBarParseError: '
          '${context.read(snackbarParseErrorPod).state}))',
    );
  }
}
