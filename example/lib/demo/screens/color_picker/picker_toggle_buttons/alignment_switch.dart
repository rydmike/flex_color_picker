import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

class AlignmentSwitch extends ConsumerWidget {
  const AlignmentSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CrossAxisAlignment alignment = ref.watch(alignmentPod);
    final List<bool> isSelected = <bool>[
      alignment == CrossAxisAlignment.start,
      alignment == CrossAxisAlignment.center,
      alignment == CrossAxisAlignment.end,
    ];
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(crossAxisAlignment:\n  $alignment})',
      child: ListTile(
        title: const Text('Content alignment'),
        subtitle: const Text('Start - Center - End'),
        trailing: ToggleButtons(
          isSelected: isSelected,
          onPressed: (int newIndex) {
            if (newIndex == 0) {
              ref.read(alignmentPod.state).state = CrossAxisAlignment.start;
            } else if (newIndex == 1) {
              ref.read(alignmentPod.state).state = CrossAxisAlignment.center;
            } else {
              ref.read(alignmentPod.state).state = CrossAxisAlignment.end;
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
