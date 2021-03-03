import 'package:flutter/material.dart';

/// A Material widget used as a color indicator and color selector by the
/// FlexColorPicker package's `ColorPicker` widget.
///
/// The color indicator can also be used on its own as a color label, e.g.
/// in a ListTile widget. It has adjustable, height, width, selection indicator
/// icon and convenience properties for rounded corners and optional border.
@immutable
class ColorIndicator extends StatelessWidget {
  /// Default const constructor for the color indicator.
  const ColorIndicator({
    Key? key,
    this.onSelect,
    this.isSelected = false,
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
  Widget build(BuildContext context) {
    // The indicator color is light.
    final bool isLight =
        ThemeData.estimateBrightnessForColor(color) == Brightness.light;
    // Set icon color to black on light color and to white on dark color.
    final Color iconColor = isLight ? Colors.black : Colors.white;

    // If no border color is given, we use the theme divider color as
    // border color, it is typically a suitable grey color
    final Color _borderColor = borderColor ?? Theme.of(context).dividerColor;

    return Material(
      type: MaterialType.card,
      elevation: elevation,
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
        // pattern used to get Ink and Hover effects on colored or
        // gradient background widgets.
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // The onTap does not do anything, just gives us inc effect.
            // If the onTap is null, onTapDown does not work, and if we
            // call onSelect on both, we get two callbacks, don't want that.
            // If onSelect was null, we want null to disable Ink, not the
            // empty callback.
            onTap: onSelect == null ? null : () {},
            // The tapDown gives the call back, and will let parent react to
            // onLongPress, which is used by the copy/paste menu.
            onTapDown: onSelect == null ? null : (_) => onSelect!(),
            hoverColor: isLight ? Colors.black12 : Colors.white24,
            child: isSelected
                ? Icon(
                    selectedIcon,
                    color: iconColor,
                    // Size the select icon so it always fits nicely
                    // and looks nice proportionally in the color indicator.
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
