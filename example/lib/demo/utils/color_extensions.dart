import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Extension methods that mimic some of TinyColor's functions
/// https://pub.dev/packages/tinycolor
/// Included functions from TinyColor re-implemented as color extension are:
/// * lighten (int)
/// * darken(int)
extension ColorExtensions on Color {
  /// Like TinyColor's lighten function, it lightens the color with the
  /// given percentage amount.
  Color lighten([final int amount = 10]) {
    // HSLColor returns saturation 1 for black, we want 0 to be able lighten
    // black color up along grey scale from black.
    final HSLColor hsl = this == const Color(0xFF000000)
        ? HSLColor.fromColor(this).withSaturation(0)
        : HSLColor.fromColor(this);
    return hsl
        .withLightness(math.min(1, math.max(0, hsl.lightness + amount / 100)))
        .toColor();
  }

  /// Like TinyColor's darken function, it darkens the color with the
  /// given percentage amount.
  Color darken([final int amount = 10]) {
    final HSLColor hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness(math.min(1, math.max(0, hsl.lightness - amount / 100)))
        .toColor();
  }
}
