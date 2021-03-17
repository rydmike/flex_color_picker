import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// A custom track for the opacity slider
// ignore: prefer_mixin
class OpacitySliderTrack extends SliderTrackShape with BaseSliderTrackShape {
  /// Currently selected color.
  final Color selectedColor;

  /// The image used a background image in the slider.
  final ui.Image image;

  /// Paint used to draw the slider track.
  final Paint gridPaint;

  /// Constructor for the opacity slider track.
  OpacitySliderTrack(
    this.selectedColor, {
    required this.image,
  }) : gridPaint = Paint()
          ..shader = ImageShader(
            image,
            TileMode.repeated,
            TileMode.repeated,
            Matrix4.identity().storage,
          );

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    assert(sliderTheme.disabledActiveTrackColor != null,
        'disabledActiveTrackColor cannot be null.');
    assert(sliderTheme.disabledInactiveTrackColor != null,
        'disabledInactiveTrackColor cannot be null.');
    assert(sliderTheme.activeTrackColor != null,
        'activeTrackColor cannot be null.');
    assert(sliderTheme.inactiveTrackColor != null,
        'inactiveTrackColor cannot be null.');
    assert(sliderTheme.thumbShape != null, 'thumbShape cannot be null.');

    // If the slider [SliderThemeData.trackHeight] is less than or equal to 0,
    // then it makes no difference whether the track is painted or not,
    // therefore the painting  can be a no-op.
    if ((sliderTheme.trackHeight ?? 0) <= 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );
    final Radius trackRadius = Radius.circular(trackRect.height / 2);
    final Radius activeTrackRadius = Radius.circular(trackRect.height / 2 + 1);

    final Paint activePaint = Paint()..color = Colors.transparent;

    final Paint inactivePaint = Paint()
      ..shader = ui.Gradient.linear(
          Offset.zero,
          Offset(trackRect.width, 0),
          <Color>[selectedColor.withOpacity(0), selectedColor.withOpacity(1)],
          <double>[0.05, 0.95]);

    Paint leftTrackPaint;
    Paint rightTrackPaint;
    switch (textDirection) {
      case TextDirection.ltr:
        leftTrackPaint = activePaint;
        rightTrackPaint = inactivePaint;
        break;
      case TextDirection.rtl:
        leftTrackPaint = inactivePaint;
        rightTrackPaint = activePaint;
        break;
    }

    const int thumbRadius = 14;

    final RRect shapeRect = ui.RRect.fromLTRBAndCorners(
      trackRect.left - thumbRadius,
      (textDirection == TextDirection.ltr)
          ? trackRect.top - (additionalActiveTrackHeight / 2)
          : trackRect.top,
      trackRect.right + thumbRadius,
      (textDirection == TextDirection.ltr)
          ? trackRect.bottom + (additionalActiveTrackHeight / 2)
          : trackRect.bottom,
      topLeft: (textDirection == TextDirection.ltr)
          ? activeTrackRadius
          : trackRadius,
      bottomLeft: (textDirection == TextDirection.ltr)
          ? activeTrackRadius
          : trackRadius,
      topRight: (textDirection == TextDirection.ltr)
          ? activeTrackRadius
          : trackRadius,
      bottomRight: (textDirection == TextDirection.ltr)
          ? activeTrackRadius
          : trackRadius,
    );

    context.canvas.drawRRect(shapeRect, leftTrackPaint);
    context.canvas.drawRRect(shapeRect, gridPaint);
    context.canvas.drawRRect(shapeRect, rightTrackPaint);
  }
}
