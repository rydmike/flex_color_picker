import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'opacity_slider_thumb.dart';
import 'opacity_slider_track.dart';

/// A custom opacity slider
class OpacitySlider extends StatelessWidget {
  /// Default const constructor to make the opacity slider.
  const OpacitySlider({
    Key? key,
    required this.opacity,
    required this.selectedColor,
    required this.onChanged,
    this.onChangeStart,
    this.onChangeEnd,
    this.textStyle,
  }) : super(key: key);

  /// Current opacity value.
  final double opacity;

  /// Current selected color.
  final Color selectedColor;

  /// Opacity value change call back.
  final ValueChanged<double> onChanged;

  /// Called when the user starts selecting a new value for the slider.
  ///
  /// This callback shouldn't be used to update the slider value (use
  /// [onChanged] for that), but rather to be notified when the user has started
  /// selecting a new value by starting a drag or with a tap.
  ///
  /// The value passed will be the last value that the slider had before the
  /// change began.
  final ValueChanged<double>? onChangeStart;

  /// Called when the user is done selecting a new value for the slider.
  ///
  /// This callback shouldn't be used to update the slider value (use
  /// [onChanged] for that), but rather to know when the user has completed
  /// selecting a new value by ending a drag or a click.
  final ValueChanged<double>? onChangeEnd;

  /// Text style of the displayed opacity percentage value.
  ///
  /// Defaults to Theme.of(context).textTheme.bodyText2;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: getGridImage(),
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();
        return Theme(
          data: _opacitySliderTheme(selectedColor),
          child: Slider(
            value: opacity,
            divisions: 255, // One for each alpha value
            onChanged: onChanged,
            onChangeStart: onChangeStart,
            onChangeEnd: onChangeEnd,
          ),
        );
      },
    );
  }
}

// The image for the slider theme data.
ui.Image? _gridImage;

/// Load the background grid image for the opacity slider as a dart.ui
/// [Image] from assets.
Future<ui.Image> getGridImage() {
  if (_gridImage != null) return Future<ui.Image>.value(_gridImage);
  final Completer<ui.Image> completer = Completer<ui.Image>();
  const AssetImage('packages/flex_color_picker/assets/grid.png')
      .resolve(const ImageConfiguration())
      .addListener(ImageStreamListener((ImageInfo info, bool _) {
    _gridImage = info.image;
    completer.complete(_gridImage);
  }));
  return completer.future;
}

// To style the opacity slider we use a theme that changes with
// passed in color value.
ThemeData _opacitySliderTheme(Color color) {
  final Color thumbColor =
      ThemeData.estimateBrightnessForColor(color) == Brightness.light
          ? Colors.black54
          : Colors.white;
  return ThemeData.light().copyWith(
    sliderTheme: SliderThemeData(
      trackHeight: 36,
      thumbColor: thumbColor,
      // The track uses a custom slider track, with a grid image background.
      trackShape: OpacitySliderTrack(color, image: _gridImage!),
      // The thumb uses a custom thumb that is hollow.
      thumbShape: OpacitySliderThumbShape(color),
    ),
  );
}
