import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_const.dart';
import '../maybe_tooltip.dart';
import '../pods.dart';

@immutable
class OnStartColorIndicator extends ConsumerWidget {
  const OnStartColorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Color background = watch(onColorChangeStartPod).state;
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(onColorChangeStart: '
          '(Color ${background.hexAlpha}) { ... } )',
      child: Chip(
        label: Text(
          'Start ${watch(onColorChangeStartPod).state.hexAlpha}',
          style: TextStyle(
              color: AppConst.getChipTextColor(background, isLight),
              fontSize: 12),
        ),
        backgroundColor: background,
      ),
    );
  }
}
