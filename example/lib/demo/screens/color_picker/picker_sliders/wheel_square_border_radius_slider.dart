import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class WheelSquareBorderRadiusSlider extends ConsumerWidget {
  const WheelSquareBorderRadiusSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(wheelSquareBorderRadius: '
          '${ref.read(wheelSquareBorderRadiusPod).floor().toString()})',
      child: ListTile(
        title: const Text('Color wheel shade square border radius'),
        subtitle: Slider.adaptive(
          min: 0,
          max: 16,
          divisions: 16,
          label: ref.read(wheelSquareBorderRadiusPod).floor().toString(),
          value: ref.watch(wheelSquareBorderRadiusPod),
          onChanged: (double value) =>
              ref.read(wheelSquareBorderRadiusPod.state).state = value,
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
                ref.read(wheelSquareBorderRadiusPod).floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
