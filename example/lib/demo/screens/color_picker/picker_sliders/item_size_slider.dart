import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class ItemSizeSlider extends ConsumerWidget {
  const ItemSizeSlider({Key? key}) : super(key: key);

  static const double _pickItemMinSize = 20;
  static const double _pickItemMaxSize = 60;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker('
          'width: ${ref.read(sizePod).floor().toString()}, '
          ' height: ${ref.read(sizePod).floor().toString()})',
      child: ListTile(
        title: const Text('Color picker item size'),
        subtitle: Slider.adaptive(
          min: _pickItemMinSize,
          max: _pickItemMaxSize,
          divisions: (_pickItemMaxSize - _pickItemMinSize).floor(),
          label: ref.read(sizePod).floor().toString(),
          value: ref.watch(sizePod.state).state,
          onChanged: (double value) {
            if (value / 2 < ref.read(borderRadiusPod)) {
              ref.read(borderRadiusPod.state).state = value / 2;
            }
            ref.read(sizePod.state).state = value;
          },
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
                ref.read(sizePod).floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
