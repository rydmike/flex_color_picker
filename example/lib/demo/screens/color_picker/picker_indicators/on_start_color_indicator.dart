import 'package:color_picker_example/demo/pods/pods.dart';
import 'package:color_picker_example/demo/utils/theme.dart';
import 'package:color_picker_example/demo/widgets/maybe_tooltip.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';

@immutable
class OnStartColorIndicator extends ConsumerWidget {
  const OnStartColorIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color background = ref.watch(onColorChangeStartPod);
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip:
          'ColorPicker(onColorChangeStart: '
          '(Color ${background.hexAlpha}) { ... } )',
      child: Chip(
        label: Text(
          'Start ${ref.watch(onColorChangeStartPod).hexAlpha}',
          style: TextStyle(color: AppTheme.getChipTextColor(background, isLight), fontSize: 12),
        ),
        backgroundColor: background,
      ),
    );
  }
}
