import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../maybe_tooltip.dart';
import '../pods.dart';

@immutable
class ElevationSlider extends ConsumerWidget {
  const ElevationSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(elevation: '
          '${context.read(elevationPod).state.floor().toString()})',
      child: ListTile(
        title: const Text('Color picker item elevation'),
        subtitle: Slider.adaptive(
          max: 16,
          divisions: 16,
          label: context.read(elevationPod).state.floor().toString(),
          value: watch(elevationPod).state,
          onChanged: (double value) => context.read(elevationPod).state = value,
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
                context.read(elevationPod).state.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
