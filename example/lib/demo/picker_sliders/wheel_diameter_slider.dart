import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../maybe_tooltip.dart';
import '../pods.dart';

@immutable
class WheelDiameterSlider extends ConsumerWidget {
  const WheelDiameterSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(wheelDiameter: '
          '${context.read(wheelDiameterPod).state.floor().toString()})',
      child: ListTile(
        title: const Text('Color wheel size'),
        subtitle: Slider.adaptive(
          min: 150,
          max: 500,
          divisions: 500 - 150,
          label: context.read(wheelDiameterPod).state.floor().toString(),
          value: watch(wheelDiameterPod).state,
          onChanged: (double value) =>
              context.read(wheelDiameterPod).state = value,
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
                context.read(wheelDiameterPod).state.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
