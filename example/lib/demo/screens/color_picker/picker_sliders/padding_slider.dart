import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class PaddingSlider extends ConsumerWidget {
  const PaddingSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      // ignore: missing_whitespace_between_adjacent_strings
      tooltip: 'ColorPicker(padding: EdgeInsets.all'
          '(${ref.read(paddingPod).floor()}))',
      child: ListTile(
        title: const Text('Color picker content padding'),
        subtitle: Slider(
          max: 40,
          divisions: 40,
          label: ref.read(paddingPod).floor().toString(),
          value: ref.watch(paddingPod),
          onChanged: (double value) =>
              ref.read(paddingPod.notifier).state = value,
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
                ref.read(paddingPod).floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
