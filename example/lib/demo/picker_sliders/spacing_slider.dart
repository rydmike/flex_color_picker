import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../maybe_tooltip.dart';
import '../pods.dart';

@immutable
class SpacingSlider extends ConsumerWidget {
  const SpacingSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(spacing: '
          '${context.read(spacingPod).state.floor().toString()})',
      child: ListTile(
        title: const Text('Color picker item spacing'),
        subtitle: Slider.adaptive(
          max: 25,
          divisions: 25,
          label: context.read(spacingPod).state.floor().toString(),
          value: watch(spacingPod).state,
          onChanged: (double value) => context.read(spacingPod).state = value,
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
                context.read(spacingPod).state.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
