import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_const.dart';
import '../maybe_tooltip.dart';
import '../pods.dart';

@immutable
class OnEndColorIndicator extends ConsumerWidget {
  const OnEndColorIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final Color background = watch(onColorChangeEndPod).state;
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(onColorChangeEnd: '
          '(Color ${background.hexAlpha}) { ... } )',
      child: Chip(
        label: Text(
          'Start ${background.hexAlpha}',
          style: TextStyle(
              color: App.getChipTextColor(background, isLight), fontSize: 12),
        ),
        backgroundColor: background,
      ),
    );
  }
}
