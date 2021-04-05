import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../utils/theme.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class OnChangedColorIndicator extends ConsumerWidget {
  const OnChangedColorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Color background = watch(onColorChangedPod).state;
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
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
