import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class WheelWidthSlider extends ConsumerWidget {
  const WheelWidthSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(wheelWidth: '
          '${context.read(wheelWidthPod).state.floor().toString()})',
      child: ListTile(
        title: const Text('Color wheel width'),
        subtitle: Slider.adaptive(
          min: 4,
          max: 50,
          divisions: 50 - 4,
          label: context.read(wheelWidthPod).state.floor().toString(),
          value: watch(wheelWidthPod).state,
          onChanged: (double value) =>
              context.read(wheelWidthPod).state = value,
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
                context.read(wheelWidthPod).state.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
