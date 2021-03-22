import 'dart:math';
import 'package:flutter/material.dart';

/// The [OpacitySliderThumb] is a custom version of [RoundSliderThumbShape]
/// that draws a circle as thumb, with [color] as color inside the thumb.
/// It also display's slider value inside the thumb.
///
/// The slider thumb theme color is used for the circle outline and text color
/// for the displayed value.
///
/// There is a shadow for the resting, pressed, hovered, and focused state.
///
/// See also:
///
///  * [Slider], which includes a thumb defined by this shape.
///  * [SliderTheme], which can be used to configure the thumb shape of all
///    sliders in a widget subtree.
class OpacitySliderThumb extends RoundSliderThumbShape {
  /// Create a slider thumb that draws a circle filled with [color]
  /// and shows the slider `value` * 100 in the thumb.
  const OpacitySliderThumb({
    required this.color,
    double enabledThumbRadius = 16.0,
    double? disabledThumbRadius,
    double elevation = 1.0,
    double pressedElevation = 4.0,
  }) : super(
          enabledThumbRadius: enabledThumbRadius,
          disabledThumbRadius: disabledThumbRadius,
          elevation: elevation,
          pressedElevation: pressedElevation,
        );

  /// Color used to fill the inside of the thumb.
  final Color color;

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

    final Canvas _canvas = context.canvas;

    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final Color _color = colorTween.evaluate(enableAnimation)!;
    final double _radius = radiusTween.evaluate(enableAnimation);

    final Path _path = Path()
      ..addArc(
        Rect.fromCenter(
          center: center,
          width: 2 * _radius,
          height: 2 * _radius,
        ),
        0,
        pi * 2,
      );

    _canvas.drawShadow(_path, Colors.black, 1, true);
    _canvas.drawCircle(center, _radius, Paint()..color = _color);
    _canvas.drawCircle(center, _radius - 2, Paint()..color = color);

    final TextSpan _span = TextSpan(
      style: TextStyle(
        fontSize: enabledThumbRadius * 0.78,
        fontWeight: FontWeight.w600,
        color: sliderTheme.thumbColor, //Text Color of Value on Thumb
      ),
      text: (value * 100).toStringAsFixed(0),
    );

    final TextPainter _textPainter = TextPainter(
      text: _span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    _textPainter.layout();

    final Offset _textCenter = Offset(
      center.dx - (_textPainter.width / 2),
      center.dy - (_textPainter.height / 2),
    );
    _textPainter.paint(_canvas, _textCenter);
  }
}
