import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../maybe_tooltip.dart';
import '../pods.dart';

class AlignmentSwitch extends ConsumerWidget {
  const AlignmentSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final CrossAxisAlignment alignment = watch(alignmentPod).state;
    final List<bool> isSelected = <bool>[
      alignment == CrossAxisAlignment.start,
      alignment == CrossAxisAlignment.center,
      alignment == CrossAxisAlignment.end,
    ];
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(crossAxisAlignment:\n  $alignment})',
      child: ListTile(
        title: const Text('Content alignment'),
        subtitle: const Text('Start - Center - End'),
        trailing: ToggleButtons(
          isSelected: isSelected,
          onPressed: (int newIndex) {
            if (newIndex == 0) {
              context.read(alignmentPod).state = CrossAxisAlignment.start;
            } else if (newIndex == 1) {
              context.read(alignmentPod).state = CrossAxisAlignment.center;
            } else {
              context.read(alignmentPod).state = CrossAxisAlignment.end;
            }
          },
          children: const <Widget>[
            Icon(Icons.format_align_left),
            Icon(Icons.format_align_center),
            Icon(Icons.format_align_right),
          ],
        ),
      ),
    );
  }
}
