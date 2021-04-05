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
  Widget build(BuildContext context, ScopedReader watch) {
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker('
          'width: ${context.read(sizePod).state.floor().toString()}, '
          ' height: ${context.read(sizePod).state.floor().toString()})',
      child: ListTile(
        title: const Text('Color picker item size'),
        subtitle: Slider.adaptive(
          min: _pickItemMinSize,
          max: _pickItemMaxSize,
          divisions: (_pickItemMaxSize - _pickItemMinSize).floor(),
          label: context.read(sizePod).state.floor().toString(),
          value: watch(sizePod).state,
          onChanged: (double value) {
            if (value / 2 < context.read(borderRadiusPod).state) {
              context.read(borderRadiusPod).state = value / 2;
            }
            context.read(sizePod).state = value;
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
                context.read(sizePod).state.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
