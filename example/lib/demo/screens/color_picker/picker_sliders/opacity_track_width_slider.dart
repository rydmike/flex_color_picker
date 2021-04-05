import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../widgets/maybe_tooltip.dart';

@immutable
class OpacityTrackWidthSlider extends ConsumerWidget {
  const OpacityTrackWidthSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    double? usedOpacityTrackWidth;
    final double trackWidth = context.read(opacityTrackWidthPod).state;

    if (trackWidth >= 150 && trackWidth < 700) {
      usedOpacityTrackWidth = trackWidth;
    }
    if (trackWidth < 150) usedOpacityTrackWidth = null;
    if (trackWidth >= 700) usedOpacityTrackWidth = null;

    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(opacityTrackWidth: '
          '${usedOpacityTrackWidth?.floor().toString()})',
      child: ListTile(
        title: const Text('Opacity slider width'),
        subtitle: Slider.adaptive(
          min: 150,
          max: 700,
          divisions: 700 - 150,
          label: trackWidth.floor().toString(),
          value: watch(opacityTrackWidthPod).state,
          onChanged: (double value) =>
              context.read(opacityTrackWidthPod).state = value,
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
