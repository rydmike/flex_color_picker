import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../maybe_tooltip.dart';
import '../pods.dart';

@immutable
class OpacityTrackHeightSlider extends ConsumerWidget {
  const OpacityTrackHeightSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return MaybeTooltip(
      condition: watch(enableTooltipsPod).state,
      tooltip: 'ColorPicker(opacityTrackHeight: '
          '${context.read(opacityTrackHeightPod).state.floor().toString()})',
      child: ListTile(
        title: const Text('Opacity slider height'),
        subtitle: Slider.adaptive(
          min: 10,
          max: 50,
          divisions: 50 - 10,
          label: context.read(opacityTrackHeightPod).state.floor().toString(),
          value: watch(opacityTrackHeightPod).state,
          onChanged: (double value) =>
              context.read(opacityTrackHeightPod).state = value,
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
                context.read(opacityTrackHeightPod).state.floor().toString(),
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
