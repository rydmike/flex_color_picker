import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class ColumnSpacingSlider extends ConsumerWidget {
  const ColumnSpacingSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(columnSpacing: '
          '${ref.read(columnSpacingPod).floor()})',
      child: ListTile(
        title: const Text('Vertical spacing between items'),
        subtitle: Slider(
          max: 40,
          divisions: 40,
          label: ref.watch(columnSpacingPod).floor().toString(),
          value: ref.watch(columnSpacingPod),
          onChanged: (double value) =>
              ref.read(columnSpacingPod.notifier).state = value,
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              const Text(
                'dp',
                style: TextStyle(fontSize: 11),
              ),
              Text(
                ref.read(columnSpacingPod).floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
