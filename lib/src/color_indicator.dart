import 'package:flutter/material.dart';

/// A Material card widget used as a color indicator and color select
/// area, typically by the ColorPicker but can be used on its own as well as
/// color indicator e.g. in a LisTile trailing widget.
///
/// Has adjustable selection indicator icon and convenience properties for rounded
/// corners and border.
class ColorIndicator extends StatelessWidget {
  /// Default constructor
  const ColorIndicator({
    Key key,
    this.onSelect,
    this.isSelected = false,
    this.elevation = 0,
    this.selectedIndicator = Icons.check,
    this.color = Colors.blue,
    this.width = 40,
    this.height = 40,
    this.borderRadius = 10,
    this.hasBorder = false,
    this.borderColor,
  })  : assert(isSelected != null, 'isSelected cannot be null.'),
        assert(elevation >= 0, 'Elevation must be greater or equal to 0.'),
        assert(selectedIndicator != null,
            'Selection indicator icon data cannot be null.'),
        assert(color != null, 'Color may not be null.'),
        assert(width != null, 'Width may not be null.'),
        assert(width > 0, 'Width must be positive.'),
        assert(height != null, 'Height may not be null.'),
        assert(height > 0, 'Height must be positive.'),
        assert(borderRadius >= 0,
            'The border radius must be greater or equal to 0.'),
        assert(hasBorder != null, 'HasBorder boolean cannot be null.'),
        super(key: key);

  /// Callback for when the color indicator is 'selected' (tapped).
  /// To disable selection and the tapping ink effect pass a null callback.
  final VoidCallback onSelect;

  /// The color indicator is selected and the [selectedIndicator] will be shown.
  final bool isSelected;

  /// Material elevation of the color indicator, if null defaults to 0.
  final double elevation;

  /// An icon used to indicate that the color indicator is selected.
  /// Defaults to a check mark.
  final IconData selectedIndicator;

  /// The color that color indicator shows.
  final Color color;

  /// Height of the color indicator.
  final double height;

  /// Width of the color indicator.
  final double width;

  /// Border radius of the color indicator
  final double borderRadius;

  /// Set to true if a 1 px outline border should be drawn around the
  /// color indicator.
  final bool hasBorder;

  /// Color the border on the color indicator.
  /// Defaults to theme of context divider color.
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    // Set icon color to black on light color and to white on dark color
    final bool _isLight =
        ThemeData.estimateBrightnessForColor(color) == Brightness.light;
    final Color _iconColor = _isLight ? Colors.black : Colors.white;

    // If no border color is given, we use the theme divider color as
    // border color, it is typically a suitable grey color
    final Color _borderColor = borderColor ?? Theme.of(context).dividerColor;

    return Material(
      type: MaterialType.card,
      elevation: elevation ?? 0, // If null was passed we use zero
      borderRadius: BorderRadius.circular(borderRadius),
      clipBehavior: Clip.antiAlias,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: hasBorder ? Border.all(color: _borderColor) : null,
        ),
        // Using an extra transparent Material wrapper on an InkWell is a
        // trick used to get Ink and Hover effects on colored or
        // gradient background widgets
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onSelect,
            // The default hover effect on colors is too faint, this is slightly more
            // pronounced, this is an opinionated choice.
            hoverColor: _isLight ? Colors.black12 : Colors.white24,
            child: isSelected
                ? Icon(
                    selectedIndicator,
                    color: _iconColor,
                    // We size the select icon so it always fits nicely
                    // and proportionally looks nice in the color indicator.
                    // The 0.6 value is just based on what looked good enough.
                    size: width < height ? width * 0.6 : height * 0.6,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
