import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/switch_tile_tooltip.dart';

@immutable
class FeedbackParseErrorSwitch extends ConsumerWidget {
  const FeedbackParseErrorSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SwitchTileTooltip(
      title: const Text('Feedback vibration and audible paste error alert'),
      subtitle: const Text('This feature is experimental. Its support '
          'is limited on most platforms in current Flutter SDK.'),
      value: watch(feedbackParseErrorPod).state,
      onChanged: (bool value) =>
          context.read(feedbackParseErrorPod).state = value,
      tooltipEnabled: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(\n'
          '    feedbackParseError: '
          '${context.read(feedbackParseErrorPod).state}))',
    );
  }
}
