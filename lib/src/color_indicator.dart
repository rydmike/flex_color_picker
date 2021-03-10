import 'package:flutter/material.dart';

/// A Material widget used as a color indicator and color selector by the
/// FlexColorPicker package's `ColorPicker` widget.
///
/// The color indicator can also be used on its own as a color label, e.g.
/// in a ListTile widget. It has adjustable, height, width, selection indicator
/// icon and convenience properties for rounded corners and optional border.
@immutable
class ColorIndicator extends StatefulWidget {
  /// Default const constructor for the color indicator.
  const ColorIndicator({
    Key? key,
    this.onSelect,
    this.isSelected = false,
    this.selectedRequestsFocus = false,
    this.elevation = 0,
    this.selectedIcon = Icons.check,
    this.color = Colors.blue,
    this.width = 40,
    this.height = 40,
    this.borderRadius = 10,
    this.hasBorder = false,
    this.borderColor,
  })  : assert(elevation >= 0, 'Elevation must be greater or equal to 0.'),
        assert(width > 0, 'Width must be positive.'),
        assert(height > 0, 'Height must be positive.'),
        assert(borderRadius >= 0,
            'The border radius must be greater or equal to 0.'),
        super(key: key);

  /// Optional void callback, called when the color indicator is tapped.
  ///
  /// To disable selection and ink effect, omit or assign a null callback.
  final VoidCallback? onSelect;

  /// The color indicator is selected and the [selectedIcon] will be shown.
  ///
  /// Defaults to false.
  final bool isSelected;

  /// Set to true, if a an indicator should request focus if it is selected.
  ///
  /// The indicator will always request focus when it clicked and selected,
  /// setting this value to true is to make it request focus when it is drawn,
  /// but only if it's value has changed and if this flag is true.
  ///
  /// Defaults to false.
  final bool selectedRequestsFocus;

  /// Material elevation of the color indicator.
  ///
  /// Defaults to 0.
  final double elevation;

  /// IconData used to indicate that the color indicator is selected.
  ///
  /// The size of the [selectedIcon] is 60% of the smaller of [width]
  /// and [height]. The color of indicator icon is black or white based on
  /// on what contrast best fits with the selected color.
  ///
  /// Defaults to a check mark ([Icons.check]).
  final IconData selectedIcon;

  /// The background color of the color indicator.
  ///
  /// Defaults to [Colors.blue].
  final Color color;

  /// Width of the color indicator.
  ///
  /// Defaults to 40.
  final double width;

  /// Height of the color indicator.
  ///
  /// Defaults to 40.
  final double height;

  /// Border radius of the color indicator
  ///
  /// Defaults to 10.
  final double borderRadius;

  /// Set to true if a 1 dp outline border should be drawn around the
  /// color indicator.
  ///
  /// Defaults to false.
  final bool hasBorder;

  /// Color of the border on the color indicator.
  ///
  /// Defaults to `Theme.of(context).dividerColor`.
  final Color? borderColor;

  @override
  _ColorIndicatorState createState() => _ColorIndicatorState();
}

class _ColorIndicatorState extends State<ColorIndicator> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    if (widget.isSelected) _focusNode.requestFocus();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ColorIndicator oldWidget) {
    // The widget requests focus only when its value was updated, is selected
    // and the flag 'selectedRequestsFocus' is true.
    if (widget.isSelected && widget.selectedRequestsFocus) {
      debugPrint('ColorIndicator didUpdateWidget requested focus');
      _focusNode.requestFocus();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The indicator color is light.
    final bool isLight =
        ThemeData.estimateBrightnessForColor(widget.color) == Brightness.light;
    // Set icon color to black on light color and to white on dark color.
    final Color iconColor = isLight ? Colors.black : Colors.white;
    // If no border color is given, we use the theme divider color as
    // border color, it is typically a suitable grey color.
    final Color _borderColor =
        widget.borderColor ?? Theme.of(context).dividerColor;

    return Material(
      type: MaterialType.card,
      color: widget.color,
      elevation: widget.elevation,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          side: widget.hasBorder
              ? BorderSide(color: _borderColor)
              : BorderSide.none),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: InkWell(
          // We need a key, otherwise Flutter looses track of which
          // Widget should have what focus/highlight colors when we
          // use a lot of these ColorIndicators with Inkwells.
          key: UniqueKey(),
          focusNode: _focusNode,
          // Only use focus color when in focus, but not selected.
          focusColor: widget.isSelected
              ? Colors.transparent
              : isLight
                  ? Colors.black26
                  : Colors.white30,
          // Only use highlightColor color when in focus, but not selected.
          highlightColor: widget.isSelected
              ? Colors.transparent
              : Theme.of(context).highlightColor,
          hoverColor: isLight ? Colors.black26 : Colors.white30,
          onTap: widget.onSelect != null
              ? () {
                  widget.onSelect!();
                  debugPrint('ColorIndicator onTapDown');
                  _focusNode.requestFocus();
                }
              : null,
          child: widget.isSelected
              ? Icon(
                  widget.selectedIcon,
                  color: iconColor,
                  // Size the select icon so it always fits nicely.
                  // The 0.6 value is just based on what looked good enough.
                  size: widget.width < widget.height
                      ? widget.width * 0.6
                      : widget.height * 0.6,
                )
              : null,
        ),
      ),
    );
  }
}
