import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class OpacityTrackWidthSlider extends ConsumerWidget {
  const OpacityTrackWidthSlider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double? usedOpacityTrackWidth;
    final double trackWidth = ref.read(opacityTrackWidthPod);

    if (trackWidth >= 150 && trackWidth < 700) {
      usedOpacityTrackWidth = trackWidth;
    }
    if (trackWidth < 150) usedOpacityTrackWidth = null;
    if (trackWidth >= 700) usedOpacityTrackWidth = null;

    return MaybeTooltip(
      condition: ref.watch(enableTooltipsPod),
      tooltip: 'ColorPicker(opacityTrackWidth: '
          '${usedOpacityTrackWidth?.floor()})',
      child: ListTile(
        title: const Text('Opacity slider width'),
        subtitle: Slider.adaptive(
          min: 150,
          max: 700,
          divisions: 700 - 150,
          label: trackWidth.floor().toString(),
          value: ref.watch(opacityTrackWidthPod),
          onChanged: (double value) =>
              ref.read(opacityTrackWidthPod.notifier).state = value,
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
                usedOpacityTrackWidth == null
                    ? 'full'
                    : usedOpacityTrackWidth.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
