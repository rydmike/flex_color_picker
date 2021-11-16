import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class BorderRadiusSlider extends ConsumerWidget {
  const BorderRadiusSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(borderRadius: '
          '${ref.read(borderRadiusPod).floor().toString()})',
      child: ListTile(
        title: const Text('Color picker item border radius'),
        subtitle: Slider.adaptive(
          max: ref.watch(sizePod) / 2,
          divisions: (ref.read(sizePod) / 2).floor(),
          label: ref.read(borderRadiusPod).floor().toString(),
          value: ref.watch(borderRadiusPod),
          onChanged: (double value) =>
              ref.read(borderRadiusPod.state).state = value,
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
                ref.read(borderRadiusPod).floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
