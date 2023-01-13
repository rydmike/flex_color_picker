import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class WheelDiameterSlider extends ConsumerWidget {
  const WheelDiameterSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(wheelDiameter: '
          '${ref.read(wheelDiameterPod).floor()})',
      child: ListTile(
        title: const Text('Color wheel total width'),
        subtitle: Slider(
          min: 150,
          max: 500,
          divisions: 500 - 150,
          label: ref.watch(wheelDiameterPod).floor().toString(),
          value: ref.watch(wheelDiameterPod),
          onChanged: (double value) =>
              ref.read(wheelDiameterPod.notifier).state = value,
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
                ref.read(wheelDiameterPod).floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
