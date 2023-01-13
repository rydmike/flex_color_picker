import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class WheelSquarePaddingSlider extends ConsumerWidget {
  const WheelSquarePaddingSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(wheelSquarePadding: '
          '${ref.read(wheelSquarePaddingPod).floor()})',
      child: ListTile(
        title: const Text('Color wheel shade square padding'),
        subtitle: Slider(
          min: 0,
          max: 20,
          divisions: 20,
          label: ref.watch(wheelSquarePaddingPod).floor().toString(),
          value: ref.watch(wheelSquarePaddingPod),
          onChanged: (double value) =>
              ref.read(wheelSquarePaddingPod.notifier).state = value,
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
                ref.read(wheelSquarePaddingPod).floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
