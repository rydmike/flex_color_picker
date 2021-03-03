import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// These too classes are a workaround to issue:
// https://github.com/flutter/flutter/issues/71687
// This workaround for the issue was made by:
// @slightfoot and @matthew-caroll (GitHub accounts)

/// Same as `IntrinsicWidth` except that when this widget is instructed
/// to `computeDryLayout()`, it doesn't invoke that on its child, instead
/// it computes the child's intrinsic width.
///
/// This widget is useful in situations where the `child` does not
/// support dry layout, e.g., `TextField` as of 01/02/2021.
class DryIntrinsicWidth extends SingleChildRenderObjectWidget {
  /// Default constructor.
  const DryIntrinsicWidth({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  _RenderDryIntrinsicWidth createRenderObject(BuildContext context) =>
      _RenderDryIntrinsicWidth();
}

class _RenderDryIntrinsicWidth extends RenderIntrinsicWidth {
  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child != null) {
      final double? width =
          child?.computeMinIntrinsicWidth(constraints.maxHeight);
      final double? height = child?.computeMinIntrinsicHeight(width ?? 0);
      return Size(width ?? 0, height ?? 0);
    } else {
      return Size.zero;
    }
  }
}

/// Same as `IntrinsicHeight` except that when this widget is instructed
/// to `computeDryLayout()`, it doesn't invoke that on its child, instead
/// it computes the child's intrinsic height.
///
/// This widget is useful in situations where the `child` does not
/// support dry layout, e.g., `TextField` as of 01/02/2021.
class DryIntrinsicHeight extends SingleChildRenderObjectWidget {
  /// Default constructor.
  const DryIntrinsicHeight({
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  _RenderDryIntrinsicHeight createRenderObject(BuildContext context) =>
      _RenderDryIntrinsicHeight();
}

class _RenderDryIntrinsicHeight extends RenderIntrinsicHeight {
  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child != null) {
      final double? height =
          child?.computeMinIntrinsicHeight(constraints.maxWidth);
      final double? width = child?.computeMinIntrinsicWidth(height ?? 0);
      return Size(width ?? 0, height ?? 0);
    } else {
      return Size.zero;
    }
  }
}
