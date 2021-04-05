import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class PaddingSlider extends ConsumerWidget {
  const PaddingSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      // ignore: missing_whitespace_between_adjacent_strings
      tooltip: 'ColorPicker(padding: EdgeInsets.all'
          '(${context.read(paddingPod).state.floor().toString()}))',
      child: ListTile(
        title: const Text('Color picker content padding'),
        subtitle: Slider.adaptive(
          max: 40,
          divisions: 40,
          label: context.read(paddingPod).state.floor().toString(),
          value: watch(paddingPod).state,
          onChanged: (double value) => context.read(paddingPod).state = value,
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
                context.read(paddingPod).state.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
