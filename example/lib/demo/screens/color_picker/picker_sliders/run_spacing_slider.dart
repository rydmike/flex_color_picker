import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class RunSpacingSlider extends ConsumerWidget {
  const RunSpacingSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(runSpacing: '
          '${ref.read(runSpacingPod).floor()})',
      child: ListTile(
        title: const Text('Color picker item run spacing'),
        subtitle: Slider.adaptive(
            max: 25,
            divisions: 25,
            label: ref.read(runSpacingPod).floor().toString(),
            value: ref.watch(runSpacingPod),
            onChanged: (double value) =>
                ref.read(runSpacingPod.notifier).state = value),
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
                ref.read(runSpacingPod).floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
