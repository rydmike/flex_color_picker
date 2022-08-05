import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../utils/theme.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class OnChangedColorIndicator extends ConsumerWidget {
  const OnChangedColorIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Color background = ref.watch(onColorChangedPod);
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(onColorChanged: '
          '(Color ${background.hexAlpha}) { ... } )',
      child: Chip(
        label: Text('Change ${background.hexAlpha}',
            style: TextStyle(
                color: AppTheme.getChipTextColor(background, isLight),
                fontSize: 12)),
        backgroundColor: background,
      ),
    );
  }
}
