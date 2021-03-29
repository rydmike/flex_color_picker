import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../maybe_tooltip.dart';
import '../pods.dart';

@immutable
class BorderRadiusSlider extends ConsumerWidget {
  const BorderRadiusSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(borderRadius: '
          '${context.read(borderRadiusPod).state.floor().toString()})',
      child: ListTile(
        title: const Text('Color picker item border radius'),
        subtitle: Slider.adaptive(
          max: watch(sizePod).state / 2,
          divisions: (context.read(sizePod).state / 2).floor(),
          label: context.read(borderRadiusPod).state.floor().toString(),
          value: watch(borderRadiusPod).state,
          onChanged: (double value) =>
              context.read(borderRadiusPod).state = value,
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
                context.read(borderRadiusPod).state.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
