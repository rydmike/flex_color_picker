import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class FeedbackParseErrorSwitch extends ConsumerWidget {
  const FeedbackParseErrorSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Feedback vibration and audible paste error alert'),
      subtitle: const Text(
        'This feature is experimental. Its support '
        'is limited on most platforms in current Flutter SDK.',
      ),
      value: ref.watch(feedbackParseErrorPod),
      onChanged: (bool value) => ref.read(feedbackParseErrorPod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(\n'
          '    feedbackParseError: '
          '${ref.read(feedbackParseErrorPod)}))',
    );
  }
}
