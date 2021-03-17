import 'dart:math';
import 'package:flutter/material.dart';

/// The default shape of a [Slider]'s thumb.
///
/// There is a shadow for the resting, pressed, hovered, and focused state.
///
/// See also:
///
///  * [Slider], which includes a thumb defined by this shape.
///  * [SliderTheme], which can be used to configure the thumb shape of all
///    sliders in a widget subtree.
class OpacitySliderThumbShape extends RoundSliderThumbShape {
  /// Create a slider thumb that draws a white circle filled with [fillColor].
  const OpacitySliderThumbShape(
    this.fillColor, {
    double enabledThumbRadius = 17.0,
    double? disabledThumbRadius,
    double elevation = 1.0,
    double pressedElevation = 2.0,
  }) : super(
          enabledThumbRadius: enabledThumbRadius,
          disabledThumbRadius: disabledThumbRadius,
          elevation: elevation,
          pressedElevation: pressedElevation,
        );

  /// Color used to fill the inside of the thumb.
  final Color fillColor;

  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(sliderTheme.disabledThumbColor != null,
        'disabledThumbColor cannot be null');
    assert(sliderTheme.thumbColor != null, 'thumbColor cannot be null');

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Color color = colorTween.evaluate(enableAnimation)!;
    final double radius = radiusTween.evaluate(enableAnimation);

    final Path path = Path()
      ..addArc(
        Rect.fromCenter(center: center, width: 2 * radius, height: 2 * radius),
        0,
        pi * 2,
      );
    canvas.drawShadow(path, Colors.black, 1, true);
    canvas.drawCircle(center, radius, Paint()..color = color);
    canvas.drawCircle(center, radius - 2, Paint()..color = fillColor);

    final TextSpan span = TextSpan(
      style: TextStyle(
        fontSize: enabledThumbRadius * 0.78,
        fontWeight: FontWeight.w700,
        color: sliderTheme.thumbColor, //Text Color of Value on Thumb
      ),
      text: (value * 100).toStringAsFixed(0),
    );

    final TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();

    final Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));
    tp.paint(canvas, textCenter);
  }
}
