import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class ColumnSpacingSlider extends ConsumerWidget {
  const ColumnSpacingSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(columnSpacing: '
          '${context.read(columnSpacingPod).state.floor().toString()})',
      child: ListTile(
        title: const Text('Vertical spacing between items'),
        subtitle: Slider.adaptive(
          max: 40,
          divisions: 40,
          label: context.read(columnSpacingPod).state.floor().toString(),
          value: watch(columnSpacingPod).state,
          onChanged: (double value) =>
              context.read(columnSpacingPod).state = value,
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
                context.read(columnSpacingPod).state.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
