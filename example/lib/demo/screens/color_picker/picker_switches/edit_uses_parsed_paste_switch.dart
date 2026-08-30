import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/widgets/switch_tile_tooltip.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class EditUsesParsedPasteSwitch extends ConsumerWidget {
  const EditUsesParsedPasteSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SwitchTileTooltip(
      title: const Text('Color code entry field uses paste parser'),
      subtitle: const Text(
        'Turn OFF to use normal text field paste. '
        'This feature only applies to desktop keyboard shortcuts.',
      ),
      value: ref.watch(editUsesParsedPastePod),
      onChanged: (bool value) => ref.read(editUsesParsedPastePod.notifier).state = value,
      tooltipEnabled: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(copyPasteBehavior:\n'
          '  ColorPickerCopyPasteBehavior(editUsesParsedPaste: '
          '${ref.read(editUsesParsedPastePod)}))',
    );
  }
}
