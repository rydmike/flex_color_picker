import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A HSV color wheel based color picker for Flutter, used by FlexColorPicker.
///
/// The color wheel picker uses a custom painter to draw the HSV color wheel
/// and rectangle. It can also be used on its own in other color picker
/// implementations.
@immutable
class ColorWheelPicker extends StatefulWidget {
  /// Default constructor for the color wheel picker.
  const ColorWheelPicker({
    Key? key,
    required this.color,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    required this.onWheel,
    this.wheelWidth = 16.0,
    this.hasBorder = false,
    this.borderColor,
    this.shouldUpdate = false,
    this.shouldRequestsFocus = false,
  })  : assert(wheelWidth >= 4 && wheelWidth <= 50,
            'The Wheel must be between 4 and 50dp'),
        super(key: key);

  /// The starting color value for the wheel color picker.
  final Color color;

  /// Callback that returns the currently selected color in the color wheel as
  /// a [Color].
  ///
  /// The color value is changed continuously as the wheel thumb or the surface
  /// thumb is operated.
  final ValueChanged<Color> onChanged;

  /// Optional [ValueChanged] callback, called when user starts color selection
  /// operation with the current color value.
  final ValueChanged<Color>? onChangeStart;

  /// Optional [ValueChanged] callback, called when user ends color selection
  /// with the new color value.
  final ValueChanged<Color>? onChangeEnd;

  /// Required [ValueChanged] callback, called with true when the wheel is
  /// operated and false otherwise.
  final ValueChanged<bool> onWheel;

  /// The width of the color wheel in dp.
  final double wheelWidth;

  /// Set to true to draw a border around the color controls.
  ///
  /// Defaults to false.
  final bool hasBorder;

  /// Color of the border around around the circle and rectangle control.
  ///
  /// Defaults to theme of context for the divider color.
  final Color? borderColor;

  /// If the widget color update should also update the wheel, set to true.
  /// This should be set to true by parent every time [color] has been updated
  /// by parent and not internally by operating the wheel.
  ///
  /// Defaults to false.
  final bool shouldUpdate;

  /// Set to true when the ColorWheelPicker should request focus.
  ///
  /// Defaults to false.
  final bool shouldRequestsFocus;

  @override
  _ColorWheelPickerState createState() => _ColorWheelPickerState();
}

class _ColorWheelPickerState extends State<ColorWheelPicker> {
  // A global key used to find our render object
  final GlobalKey renderBoxKey = GlobalKey();

  // True, when we are dragging on the square color saturation and value box.
  // False, when we are are dragging on color wheel.
  bool isSquare = false;

  // We store the HSV color components as internal state for the
  // Hue wheel, and Saturation and Value for the square.
  late double colorHue;
  late double colorSaturation;
  late double colorValue;

  // Used to set focus to the Focus() we wrap around our custom paint.
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    colorHue = color.hue;
    colorSaturation = color.saturation;
    colorValue = color.value;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ColorWheelPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Request focus to wheel.
    if (widget.shouldRequestsFocus &&
        (widget.shouldRequestsFocus != oldWidget.shouldRequestsFocus)) {
      _focusNode.requestFocus();
    }
    // Only if widget.shouldUpdate is true will we change color. It is set to
    // true by parent when it has updated the widget.color value and it needs
    // to update the custom painted color wheel.
    if (widget.shouldUpdate) {
      // Change color wheel hue value
      if (color.hue != colorHue) {
        colorHue = color.hue;
      }
      // The color saturation is the X-axis on the shade square
      if (color.saturation != colorSaturation) {
        colorSaturation = color.saturation;
      }
      // The color value is the Y-axis on the shade square
      if (color.value != colorValue) {
        colorValue = color.value;
      }
    }
  }

  // Get the widget color, but convert to HSV color that we need internally
  HSVColor get color => HSVColor.fromColor(widget.color);
  // Get the radius of the wheel, it is half of the shortest side of the
  // surrounding rectangle minus the defined width of the color wheel.
  double wheelRadius(Size size) =>
      math.min(size.width, size.height).toDouble() / 2 - widget.wheelWidth;
  double squareRadius(double radius) =>
      (radius - widget.wheelWidth / 2) / math.sqrt(2);

  Offset getOffset(Offset ratio) {
    // This is bang and cast is not pretty, but SDK does it this was too.
    final RenderBox renderBox =
        renderBoxKey.currentContext!.findRenderObject()! as RenderBox;

    final Offset startPosition = renderBox.localToGlobal(Offset.zero);
    return ratio - startPosition;
  }

  // Called when we start dragging any of the thumbs on the wheel or square
  void onStart(Offset offset) {
    // This is bang and cast is not pretty, but SDK does it this was too.
    final RenderBox renderBox =
        renderBoxKey.currentContext!.findRenderObject()! as RenderBox;

    final Size _size = renderBox.size;
    final double _radius = wheelRadius(_size);
    final double _squareRadius = squareRadius(_radius);
    final Offset _startPosition = renderBox.localToGlobal(Offset.zero);
    final Offset _center = Offset(_size.width / 2, _size.height / 2);
    final Offset _vector = offset - _startPosition - _center;

    // We are operating the wheel, so onWheel is true.
    widget.onWheel(true);

    // Did the onStart, start on the square Palette box?
    isSquare =
        _vector.dx.abs() < _squareRadius && _vector.dy.abs() < _squareRadius;
    // We started on the square palette box
    if (isSquare) {
      // Calculate the color saturation
      colorSaturation =
          _Wheel.vectorToSaturation(_vector.dx, _squareRadius).clamp(0.0, 1.0);
      // Calculate the color value
      colorValue =
          _Wheel.vectorToValue(_vector.dy, _squareRadius).clamp(0.0, 1.0);

      // If a start callback was given, call it with the start color.
      if (widget.onChangeStart != null) widget.onChangeStart!(widget.color);
      // Make a HSV color from its component values and convert to RGB and
      // return this color in the callback.
      widget.onChanged(HSVColor.fromAHSV(
        color.alpha,
        colorHue,
        colorSaturation,
        colorValue,
      ).toColor());

      // Else, we did the onStart on the color wheel
    } else {
      // If a start callback given, call it with the start color.
      if (widget.onChangeStart != null) widget.onChangeStart!(widget.color);
      // Calculate the color Hue
      colorHue = _Wheel.vectorToHue(_vector);
      // Convert the color to normal RGB value before returning it via callback.
      widget.onChanged(HSVColor.fromAHSV(
        color.alpha,
        colorHue,
        colorSaturation,
        colorValue,
      ).toColor());
    }
  }

  // Called when we drag the thumb on the wheel or square.
  void onUpdate(Offset offset) {
    // This is bang and cast is not pretty, but SDK does it this was too.
    final RenderBox renderBox =
        renderBoxKey.currentContext!.findRenderObject()! as RenderBox;

    final Size size = renderBox.size;
    final double _radius = wheelRadius(size);
    final double _squareRadius = squareRadius(_radius);
    final Offset _startPosition = renderBox.localToGlobal(Offset.zero);
    final Offset _center = Offset(size.width / 2, size.height / 2);
    final Offset _vector = offset - _startPosition - _center;

    // We are operating the wheel, so onWheel is true.
    widget.onWheel(true);

    // Are the updates are for the square palette box?
    if (isSquare) {
      // Calculate the color saturation
      colorSaturation =
          _Wheel.vectorToSaturation(_vector.dx, _squareRadius).clamp(0.0, 1.0);
      // Calculate the color value
      colorValue =
          _Wheel.vectorToValue(_vector.dy, _squareRadius).clamp(0.0, 1.0);
      // Make a HSV color from its component values and convert to RGB and
      // return this color in the callback.
      widget.onChanged(
          HSVColor.fromAHSV(color.alpha, colorHue, colorSaturation, colorValue)
              .toColor());
      // The updates are for the color wheel
    } else {
      // Calculate the color Hue
      colorHue = _Wheel.vectorToHue(_vector);
      // Convert the color to normal RGB color before it is returned.
      widget.onChanged(HSVColor.fromAHSV(
        color.alpha,
        colorHue,
        colorSaturation,
        colorValue,
      ).toColor());
    }
  }

  // Called when we end dragging the thumb on the wheel or square.
  void onEnd() {
    // We stopped operating the wheel, so onWheel is false.
    // We can use this signal to know how to handle the drag cancel event
    // when we were operating the wheel.
    widget.onWheel(false);

    // We are ending the dragging operation, call the onChangeEnd callback
    // with the color we ended up with.
    if (widget.onChangeEnd != null) widget.onChangeEnd!(widget.color);
    // We have to call onChanged once more with final value as well.
    widget.onChanged(widget.color);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      dragStartBehavior: DragStartBehavior.down,

      onVerticalDragDown: (DragDownDetails details) =>
          onStart(details.globalPosition),
      onVerticalDragUpdate: (DragUpdateDetails details) =>
          onUpdate(details.globalPosition),
      onHorizontalDragUpdate: (DragUpdateDetails details) =>
          onUpdate(details.globalPosition),
      onVerticalDragEnd: (DragEndDetails details) => onEnd(),
      onHorizontalDragEnd: (DragEndDetails details) => onEnd(),
      // If we just tap on the wheel control, we need to end as well.
      // Grabbing just the onTapUp allows to catch a drag that was too short
      // to start a drag event, while not interfering with the onTap event
      // handler we need to use elsewhere in the ColorPicker.
      onTapUp: (TapUpDetails details) => onEnd(),

      // NOTE: It would have been simpler to be able to call onEnd() on events
      // onVerticalDragCancel and onHorizontalDragCancel here as well.
      // They get triggered when the longPress menu is activated,
      // if we were 'dragging' but had not moved, in that case we need to
      // issue an `onColorChangeEnd` when a cancellation happens due to that.
      // Mostly it worked, but not entirely, for some reason the drag cancel
      // events get triggered while dragging, for no apparent reason, since
      // there has been no known cancellation, weird, might be a Flutter bug?!
      //
      // Due to this the cancel events could not be used here, since they led to
      // random onEnd() calls which made the onEnd unreliable. The workaround
      // was to make the long press menu issue an "onOpen" event and handle the
      // issuing of that particular end dragging scenario in the parent
      // (color picker). Messy, but the workaround works.

      child: SizedBox(
        key: renderBoxKey,
        child: Focus(
          focusNode: _focusNode,
          child: MouseRegion(
            cursor: MaterialStateMouseCursor.clickable,
            child: Stack(
              fit: StackFit.expand,
              children: [
                RepaintBoundary(
                  child: CustomPaint(
                    painter: _ShadePainter(
                      colorHue: colorHue,
                      colorSaturation: colorSaturation,
                      colorValue: colorValue,
                      hasBorder: widget.hasBorder,
                      borderColor:
                        widget.borderColor ?? Theme.of(context).dividerColor,
                      wheelWidth: widget.wheelWidth,
                    ),
                  ),
                ),
                CustomPaint(
                  painter: _ShadeThumbPainter(
                    colorSaturation: colorSaturation,
                    colorValue: colorValue,
                  ),
                ),
                RepaintBoundary(
                  child: CustomPaint(
                    painter: _WheelPainter(
                      hasBorder: widget.hasBorder,
                      borderColor:
                        widget.borderColor ?? Theme.of(context).dividerColor,
                      wheelWidth: widget.wheelWidth,
                      ticks: 360,
                    ),
                  ),
                ),
                CustomPaint(
                  painter: _WheelThumbPainter(
                    colorHue: colorHue,
                    wheelWidth: widget.wheelWidth,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShadePainter extends CustomPainter {
  const _ShadePainter({
    required this.colorHue,
    required this.colorSaturation,
    required this.colorValue,
    this.hasBorder = false,
    required this.borderColor,
    this.wheelWidth = 16,
  }) : super();

  final double colorHue; // Color wheel coordinate 0...360 degrees
  final double colorSaturation; // The X coordinate 0...1
  final double colorValue; // The Y coordinate 0...1

  final bool hasBorder;
  final Color borderColor;
  final double wheelWidth;

  static double wheelRadius(Size size, double wheelWidth) =>
      math.min(size.width, size.height).toDouble() / 2 - wheelWidth / 2;
  static double squareRadius(double radius, double wheelWidth) =>
      (radius - wheelWidth / 2) / math.sqrt(2);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset _center = Offset(size.width / 2, size.height / 2);
    final double _radius = wheelRadius(size, wheelWidth);
    final double _squareRadius = squareRadius(_radius, wheelWidth);

    // Draw the color shade palette.
    final Rect _rectBox = Rect.fromLTWH(_center.dx - _squareRadius,
        _center.dy - _squareRadius, _squareRadius * 2, _squareRadius * 2);
    final RRect rRect =
    RRect.fromRectAndRadius(_rectBox, const Radius.circular(4));

    final Shader _horizontal = LinearGradient(
      colors: <Color>[
        Colors.white,
        HSVColor.fromAHSV(1, colorHue, 1, 1).toColor()
      ],
    ).createShader(_rectBox);
    canvas.drawRRect(
        rRect,
        Paint()
          ..style = PaintingStyle.fill
          ..shader = _horizontal);

    final Shader _vertical = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Colors.transparent, Colors.black],
    ).createShader(_rectBox);
    canvas.drawRRect(
        rRect,
        Paint()
          ..style = PaintingStyle.fill
          ..shader = _vertical);

    // Draw a border around the outer edge of the square shade picker.
    if (hasBorder) {
      canvas.drawRRect(
          rRect,
          Paint()
            ..style = PaintingStyle.stroke
            ..color = borderColor);
    }
  }

  @override
  bool shouldRepaint(_ShadePainter oldDelegate) {
    return
      oldDelegate.hasBorder != hasBorder ||
          oldDelegate.borderColor != borderColor ||
          oldDelegate.wheelWidth != wheelWidth ||
          oldDelegate.colorHue != colorHue ||
          oldDelegate.colorSaturation != colorSaturation ||
          oldDelegate.colorValue != colorValue;
  }
}

class _WheelPainter extends CustomPainter {
  const _WheelPainter({
    this.hasBorder = false,
    required this.borderColor,
    this.ticks = 360,
    this.wheelWidth = 16,
  }) : super();

  final bool hasBorder;
  final Color borderColor;
  final int ticks;
  final double wheelWidth;

  static double wheelRadius(Size size, double wheelWidth) =>
      math.min(size.width, size.height).toDouble() / 2 - wheelWidth / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset _center = Offset(size.width / 2, size.height / 2);
    final double _radius = wheelRadius(size, wheelWidth);

    const double _rads = (2 * math.pi) / 360;
    const double _step = 1;
    const double _aliasing = 0.5;

    // Responsive views might force the Size to become a rectangle, thus
    // creating an ellipse, so we/ keep it as a circle by always using the
    // shortest side in the surrounding rectangle to make a square.
    final double _shortestRectSide =
    math.min(size.width, size.height).toDouble();

    final Rect rectCircle = Rect.fromCenter(
        center: _center,
        width: _shortestRectSide - wheelWidth,
        height: _shortestRectSide - wheelWidth);

    // Draw the color circle
    for (int i = 0; i < ticks; i++) {
      final double sRad = (i - _aliasing) * _rads;
      final double eRad = (i + _step) * _rads;
      final Paint segmentPaint = Paint()
        ..color = HSVColor.fromAHSV(1, i.toDouble(), 1, 1).toColor()
        ..style = PaintingStyle.stroke
        ..strokeWidth = wheelWidth;
      canvas.drawArc(
        rectCircle,
        sRad,
        sRad - eRad,
        false,
        segmentPaint,
      );
    }

    // Draw a border around the color wheel.
    if (hasBorder) {
      // Draw border around the inner side of the color wheel
      canvas.drawCircle(
          _center,
          _radius - wheelWidth / 2,
          Paint()
            ..style = PaintingStyle.stroke
            ..color = borderColor);

      // Draw border around the outer side of the color wheel
      canvas.drawCircle(
          _center,
          _radius + wheelWidth / 2,
          Paint()
            ..style = PaintingStyle.stroke
            ..color = borderColor);
    }
  }

  @override
  bool shouldRepaint(_WheelPainter oldDelegate) {
    return
      oldDelegate.hasBorder != hasBorder ||
          oldDelegate.borderColor != borderColor ||
          oldDelegate.wheelWidth != wheelWidth ||
          oldDelegate.ticks != ticks;
  }
}

class _ShadeThumbPainter extends CustomPainter {
  const _ShadeThumbPainter({
    required this.colorSaturation,
    required this.colorValue,
    this.wheelWidth = 16,
  }) : super();

  final double colorSaturation; // The X coordinate 0...1
  final double colorValue; // The Y coordinate 0...1

  final double wheelWidth;

  static double wheelRadius(Size size, double wheelWidth) =>
      math.min(size.width, size.height).toDouble() / 2 - wheelWidth / 2;
  static double squareRadius(double radius, double wheelWidth) =>
      (radius - wheelWidth / 2) / math.sqrt(2);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset _center = Offset(size.width / 2, size.height / 2);
    final double _radius = wheelRadius(size, wheelWidth);
    final double _squareRadius = squareRadius(_radius, wheelWidth);

    // Define paint style for the selection thumbs:
    // Outer black circle.
    final Paint _paintBlack = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    // Inner white circle, to be placed on top of the black one.
    final Paint _paintWhite = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Define the selection thumb position on the square
    final double _paletteX =
    _Wheel.saturationToVector(colorSaturation, _squareRadius, _center.dx);
    final double _paletteY =
    _Wheel.valueToVector(colorValue, _squareRadius, _center.dy);
    final Offset paletteVector = Offset(_paletteX, _paletteY);

    // Draw the wider black circle first, then draw the smaller white circle
    // on top of it, giving the appearance of a white indicator with black
    // edges around it.
    canvas.drawCircle(paletteVector, 12, _paintBlack);
    canvas.drawCircle(paletteVector, 12, _paintWhite);
  }

  @override
  bool shouldRepaint(_ShadeThumbPainter oldDelegate) {
    return
      oldDelegate.wheelWidth != wheelWidth ||
          oldDelegate.colorSaturation != colorSaturation ||
          oldDelegate.colorValue != colorValue;
  }
}

class _WheelThumbPainter extends CustomPainter {
  const _WheelThumbPainter({
    required this.colorHue,
    this.wheelWidth = 16,
  }) : super();

  final double colorHue; // Color wheel coordinate 0...360 degrees

  final double wheelWidth;

  static double wheelRadius(Size size, double wheelWidth) =>
      math.min(size.width, size.height).toDouble() / 2 - wheelWidth / 2;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset _center = Offset(size.width / 2, size.height / 2);
    final double _radius = wheelRadius(size, wheelWidth);

    // Define paint style for the selection thumbs:
    // Outer black circle.
    final Paint _paintBlack = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    // Inner white circle, to be placed on top of the black one.
    final Paint _paintWhite = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Define the selection thumb position on the color wheel.
    final Offset _wheel = _Wheel.hueToVector(
        (colorHue + 360.0) * math.pi / 180.0, _radius, _center);

    // Draw the wider black circle first, then draw the smaller white circle
    // on top of it, giving the appearance of a white indicator with black
    // edges around it.
    canvas.drawCircle(_wheel, wheelWidth / 2 + 4, _paintBlack);
    canvas.drawCircle(_wheel, wheelWidth / 2 + 4, _paintWhite);
  }

  @override
  bool shouldRepaint(_WheelThumbPainter oldDelegate) {
    return
      oldDelegate.wheelWidth != wheelWidth ||
          oldDelegate.colorHue != colorHue;
  }
}

// Draw the wheel part of the widget.
class _Wheel {
  static double vectorToHue(Offset vector) =>
      (((math.atan2(vector.dy, vector.dx)) * 180.0 / math.pi) + 360.0) % 360.0;
  static double vectorToSaturation(double vectorX, double squareRadius) =>
      vectorX * 0.5 / squareRadius + 0.5;
  static double vectorToValue(double vectorY, double squareRadius) =>
      0.5 - vectorY * 0.5 / squareRadius;
  static Offset hueToVector(double h, double radius, Offset center) => Offset(
      math.cos(h) * radius + center.dx, math.sin(h) * radius + center.dy);
  static double saturationToVector(
          double s, double squareRadius, double centerX) =>
      (s - 0.5) * squareRadius / 0.5 + centerX;
  static double valueToVector(double l, double squareRadius, double centerY) =>
      (0.5 - l) * squareRadius / 0.5 + centerY;
}
