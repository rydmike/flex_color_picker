import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_indicator.dart';
import 'color_tools.dart';
import 'color_wheel_picker.dart';

/// Enum that represents the different color pickers.
enum ColorPickerSwatch {
  /// A color picker that contains bot Material and Accent colors.
  both,

  /// A color picker that contain only the main Material colors.
  material,

  /// A color picker that contain only the Accent colors.
  accent,

  /// A color picker that offer near white and black shades.
  bw,

  /// A color picker that shows custom provide Materials watch colors and
  /// their custom names.
  custom,

  /// A color wheel picker than can select any color.
  any,
}

/// A customizable Material primary color, accent color and custom color,
/// color-picker.
///
/// You can configure which material color swatches can be used for color
/// selection, any combination of both primary/accent in same picker or on
/// separate 'pages'. There is an almost black and white picker page, and it
/// is possible to include a page with custom material and accent swatches and
/// even provide custom names for those swatches.
/// It is possible to specify if only the main color in a swatch should be
/// selectable or also its shades.
///
/// There is also a color wheel picker that allows you to define/select any
/// color and automatically also generate a Material primary swatch from the
/// selected color.
/// If a selected color in the wheel picker belongs to any standard Material
/// color, primary or accent and any of it's shades or any of the provided
/// custom colors, then the wheel picker will not calculate an own swatch,
/// it will show all the shades from the selected color instead. Selecting
/// the shades on the wheel picker will then show where those colors are on the
/// HSV wheel. If a selected color is not any of the defined ones, then the
/// wheel picker will always generate a new shade from the selected color,
/// using the selected color as the new primary swatch [500] midpoint.
class ColorPicker extends StatefulWidget {
  /// Default constructor
  const ColorPicker({
    Key key,
    this.color = Colors.blue,
    @required this.onColorChanged,
    this.selectShades = true,
    this.includeIndex850 = false,
    this.selectedIndicator = Icons.check,
    this.showNameSelected = false,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.size = 40.0,
    this.borderRadius,
    this.hasBorder = false,
    this.wheelWidth = 16,
    this.hasWheelBorder = false,
    this.borderColor,
    this.elevation = 0,
    this.padding = 8,
    this.spacing = 4,
    this.runSpacing = 4,
    this.heading,
    this.subHeading,
    this.subWheelHeading,
    this.colorCodeTextStyle,
    this.swatchFontSize = 11,
    this.swatchLabel = const <ColorPickerSwatch, String>{
      ColorPickerSwatch.material: _swatchPrimaryLabel,
      ColorPickerSwatch.accent: _swatchAccentLabel,
      ColorPickerSwatch.bw: _swatchBlackWhiteLabel,
      ColorPickerSwatch.both: _swatchBothLabel,
      ColorPickerSwatch.custom: _swatchCustomLabel,
      ColorPickerSwatch.any: _swatchPickAnyLabel,
    },
    this.swatchAvailable = const <ColorPickerSwatch, bool>{
      ColorPickerSwatch.material: true,
      ColorPickerSwatch.accent: true,
      ColorPickerSwatch.bw: false,
      ColorPickerSwatch.both: false,
      ColorPickerSwatch.custom: false,
      ColorPickerSwatch.any: false,
    },
    this.colorSwatchNameMap,
    this.wheelSize = 190,
  })  : assert(color != null, 'The color cannot be null'),
        assert(onColorChanged != null,
            'A color change callback function is required and cannot be null.'),
        assert(selectShades != null, 'Select shades cannot be null.'),
        assert(includeIndex850 != null, 'includeIndex850  cannot be null.'),
        assert(selectedIndicator != null, 'Selected indicator cannot be null.'),
        assert(showNameSelected != null,
            'Show name of selected color cannot be null.'),
        assert(size != null, 'Picker size cannot be null.'),
        assert(size > 15 && size <= 150,
            'The picker item size must be > 15 and <= 150'),
        assert(hasBorder != null, 'Has border cannot be null.'),
        assert(wheelWidth != null, 'Color wheel width cannot be null.'),
        assert(wheelWidth >= 4 && wheelWidth <= 50,
            'The color wheel width must be >= 4 and <= 50'),
        assert(hasWheelBorder != null, 'Has wheel border cannot be null.'),
        assert(elevation != null, 'Elevation cannot be null.'),
        assert(padding != null, 'Padding pixel value cannot be null.'),
        assert(spacing != null, 'Spacing pixel value cannot be null.'),
        assert(runSpacing != null, 'Run spacing pixel value cannot be null.'),
        assert(swatchFontSize > 3 && swatchFontSize <= 20,
            'The swatch font size must be > 3 and <= 20'),
        assert(swatchLabel != null, 'Swatch selector labels cannot be null.'),
        assert(swatchAvailable != null, 'Swatch available cannot be null.'),
        assert(
            wheelSize == null || (wheelSize >= 150 && wheelSize <= 500),
            'The wheel picker can be null for default size, if size is '
            'given it must be >= 150 and <= 500'),
        super(key: key);

  /// The active color selection when the [ColorPicker] is created.
  final Color color;

  /// This value changed callback is called when user clicks and selects a
  /// new color. Changing which swatch is viewed does not trigger this
  /// callback, it is not triggered until the user actually clicks on a
  /// color in the viewed swatch.
  final ValueChanged<Color> onColorChanged;

  /// If true (default) we allow selection of swatch color shades, if it is false
  /// we can only select the main color from a swatch, which is index [500] for
  /// Material colors and [200] for Accent colors.
  final bool selectShades;

  /// There is an extra index [850] used only by grey Material color in Flutter,
  /// if you want to include it in the grey colors, then set
  /// this value to true. Default is false.
  final bool includeIndex850;

  /// Used to provide a custom selected color icon indicator.
  final IconData selectedIndicator;

  /// If true, the name and color code of the selected color
  /// is shown below the selection. The displayed color code uses
  /// Flutter Widget [SelectableText] so if needed the value can be copied
  /// and pasted.
  final bool showNameSelected;

  /// Set the cross axis alignment used to lay out
  /// the main content in the Color Picker column, default is centered.
  final CrossAxisAlignment crossAxisAlignment;

  /// The size of the color selection targets.
  final double size;

  /// Border radius of the color selector, it defaults to half of the radius of
  /// the value that would create a round picker, so default value is [size/4].
  final double borderRadius;

  /// If [hasBorder] is true, we get a 1px border around the color indicators.
  final bool hasBorder;

  /// The width of the color wheel.
  final double wheelWidth;

  /// If [hasWheelBorder] is true we get a 1px border around the wheel selector.
  final bool hasWheelBorder;

  /// The color of the 1px optional border used on [ColorIndicator] and on
  /// [ColorWheelPicker] when their border toggle is true.
  /// If no color is given, the border color will default to:
  /// Theme.of(context).dividerColor, which is often some grey color.
  final Color borderColor;

  /// The material elevation of color selection indicators.
  final double elevation;

  /// The padding around the entire color picker.
  final double padding;

  /// The spacing between the color picker indicator items.
  final double spacing;

  /// The space between the color picker color item rows,
  /// when they need to be wrapped to multiple rows.
  final double runSpacing;

  /// A heading widget text for the color selection, typically a [Text]
  /// e.g. heading = Text('Select color swatch'). Use style to make it larger.
  /// If not provided, then there is no heading for the color picker.
  final Widget heading;

  /// A sub heading widget text for the color selection, typically a [Text]
  /// e.g. heading = Text('Select shade color'). Use style to make it larger.
  /// If not provided, then there is no subheading for the color picker.
  final Widget subHeading;

  /// A sub heading widget text for the wheel color selection, typically a
  /// [Text] e.g. heading = Text('Gives swatch'). Use style to make it larger.
  /// If not provided, then there is no wheel heading for the color picker.
  final Widget subWheelHeading;

  /// The font size of the labels in segmented control swatch selector.
  final double swatchFontSize;

  /// The text theme style for the displayed color code in the picker.
  /// Defaults too Theme.of(context).textTheme.subtitle2
  final TextStyle colorCodeTextStyle;

  /// A [ColorPickerSwatch] to String map that contains labels for swatchSelector.
  /// Defaults strings are provided in English if not given.
  final Map<ColorPickerSwatch, String> swatchLabel;

  /// A [ColorPickerSwatch] to bool map that set which picker swatches are
  /// available in the segmented selector. Available options are based on
  /// [ColorPickerSwatch] and include values: both, material, accent, bw, custom
  /// and any. Default includes material and accent.
  final Map<ColorPickerSwatch, bool> swatchAvailable;

  /// A [colorSwatchNameMap] with custom swatches can be provided. It is used
  /// as swatch selection for the [ColorPickerSwatch.custom] option in the selector.
  final Map<ColorSwatch<Object>, String> colorSwatchNameMap;

  /// Size of the HSV hue based wheel color picker on the 'Any color' segment
  final double wheelSize;

  static const String _swatchBothLabel = 'Primary & Accent';
  static const String _swatchPrimaryLabel = 'Primary';
  static const String _swatchAccentLabel = 'Accent';
  static const String _swatchBlackWhiteLabel = 'Black & White';
  static const String _swatchCustomLabel = 'Custom';
  static const String _swatchPickAnyLabel = 'Any color';

  @override
  _ColorPickerState createState() => _ColorPickerState();

  /// A method to show the created [ColorPicker] in a dialog.
  ///
  /// This is often called as
  /// pickedColor = await ColorPicker('constructor values').dialog('dialog parameters'),
  /// to create a ColorPicker and show it in a dialog in one go and get the picked
  /// or cancelled color as a result.
  ///
  /// The [showPickerDialog] method is a convenience member to show the [ColorPicker]
  /// widget in a modal dialog. It re-implements the standard ´showDialog´ function
  /// with a twist, it provides opinionated Cancel and Select buttons
  /// and it also by default uses a lighter barrier color.
  /// This is useful if the color picker is used to dynamically change color of a
  /// widget or entire application theme. We can better see the impact of the
  /// color choice behind the modal dialog if the barrier is made more transparent.
  Future<bool> showPickerDialog(
    /// Pass in the context from where you are opening the dialog.
    BuildContext context, {

    /// Title of the color picker dialog, often omitted if the [heading] of
    /// the [ColorPicker] is used.
    Widget title,

    /// Label shown on button for cancelling the color picking and closing the
    /// dialog. Clicking CANCEL will return the [color] that the [ColorPicker]
    /// widget was created with. The string value defaults to 'CANCEL'.
    String cancelLabel,

    /// Label shown on button for selecting the current color in the color picker dialog
    /// and closing the dialog. The current active color selection in the [ColorPicker]
    /// is returned as the result when the SELECT button is clicked.
    /// The string value defaults to 'SELECT'.
    String selectLabel,

    /// If true, the dialog can be closed by clicking outside, this will result in
    /// returning the [color] that the [ColorPicker] widget was created with.
    /// Defaults to true.
    bool barrierDismissible = true,

    // In master channel, since version v1.18.1-pre.11, we can now set the
    // barrier color for the standard showDialog function. Previously this
    // was not possible and a re-implementation of showDialog that exposed
    // barrier color from the lower function showGeneralDialog was used.
    // The old implementation is for now kept in the commented out section
    // further below.

    /// The background transparency color of the dialog barrier.
    /// Defaults to [Colors.black12] which is considerably lighter than the
    /// standard [Colors.black54] and allows us to see impact of selected color
    /// on app behind the dialog. If this is not desired, set it back to
    /// [Colors.black54] when you call [showPickerDialog].
    Color barrierColor = Colors.black12,
    bool useSafeArea = true,
    bool useRootNavigator = true,
    RouteSettings routeSettings,

    /// If you need to you can provide BoxConstraints to constrain the size
    /// of the dialog. You might want to do this for the height as otherwise
    /// it might jump up and down jarringly when you switch size with the
    /// swatch selector. Normally you would not change the picker element
    /// sizes after you have determined what works in your implementation
    /// so you can usually figure out a good dialog box size that works well
    /// for your use case instead of allowing the dialog to auto size itself
    /// all over the place.
    BoxConstraints constraints,
  }) async {
    assert(barrierDismissible != null, 'May not be null');
    assert(useSafeArea != null, 'May not be null');
    assert(useRootNavigator != null, 'May not be null');
    assert(debugCheckHasMaterialLocalizations(context),
        'A context with Material localizations is required');

    // If the Cancel and Select are null we use default values
    cancelLabel ??= 'CANCEL';
    selectLabel ??= 'SELECT';

    bool _colorWasSelected; // False if dialog cancelled, true if color selected

    await showDialog<bool>(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        useSafeArea: useSafeArea,
        useRootNavigator: useRootNavigator,
        routeSettings: routeSettings,
        builder: (BuildContext context) {
          return AlertDialog(
            // Opinionated dialog that depends on [padding] from [ColorPicker]
            titlePadding: EdgeInsets.all(padding),
            contentPadding: const EdgeInsets.all(0),
            actionsPadding: EdgeInsets.fromLTRB(0, 0, padding, 0),
            // Opinionated dialog button padding
            buttonPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: title,
            content: constraints == null
                ? this
                : ConstrainedBox(
                    constraints: constraints,
                    child: this,
                  ),
            scrollable: true,
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  // Cancel was pressed, we pop and return FALSE
                  Navigator.of(context).pop(false);
                },
                child: Text(cancelLabel),
              ),
              OutlineButton(
                onPressed: () {
                  // Select was pressed, we pop and return TRUE
                  Navigator.of(context).pop(true);
                },
                child: Text(selectLabel),
              ),
            ],
          );
        }).then((bool value) {
      // If the dialog return value was null, then we got here by a
      // barrier dismiss, then we set the return value to false
      _colorWasSelected = value ?? false;
    });
    return _colorWasSelected;
  }
}

class _ColorPickerState extends State<ColorPicker> {
  // The currently active used list of color swatches we select
  // the active color from
  List<ColorSwatch<Object>> _activeColorSwatchList;
  // The active Swatch in the active Color swatch List
  ColorSwatch<Object> _activeSwatch;
  // Which swatch are we using
  ColorPickerSwatch _useSwatch;
  // Current selected color
  Color _selectedColor;

  // Map of swatch choices and its widgets for the Cupertino segmented control
  // it gets initialized in the _initSelectedValue() function
  Map<ColorPickerSwatch, Widget> _swatchChoices;
  // Map of swatch names it corresponding list of color swatches
  // it gets initialized in the _initSelectedValue() function
  Map<ColorPickerSwatch, List<ColorSwatch<Object>>> _swatchColorLists;
  // We need a map we can guarantee that has no gaps, so we will make a local
  // version of it that is always complete, the
  // gets initialized in the _initSelectedValue() function
  Map<ColorPickerSwatch, bool> _swatchAvailable;

  // A boolean that is only true when we have more than one
  // swatch group available, if there is just one swatch available
  // then that swatch will be used, but we will not draw the selector
  bool _useSwatchSelector;

  // Set to true when shade selector on any widget, needs to force
  // an update on the color wheel
  bool _forcedUpdate = false;

  // The content alignment
  CrossAxisAlignment _alignment;

  @override
  void initState() {
    super.initState();

    // Set the selected color to the widget constructor provided start color
    _selectedColor = widget.color;

    // Initialize other values
    _initSelectedValue(true);
  }

  @override
  void didUpdateWidget(ColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Initialize the values again because the underlying widget changed.
    _initSelectedValue(false);
  }

  void _initSelectedValue(bool isInit) {
    // Will not force update the saturaton and value on wheel (H)SV part
    _forcedUpdate = false;

    // Set alignment to widget value, but if it is null, set it to center
    _alignment = widget.crossAxisAlignment ?? CrossAxisAlignment.center;

    // A map with the color swatch lists for each of the enum values
    _swatchColorLists = <ColorPickerSwatch, List<ColorSwatch<Object>>>{
      ColorPickerSwatch.both: ColorTools.bothPrimaryAndAccentColors,
      ColorPickerSwatch.material: ColorTools.primaryColors,
      ColorPickerSwatch.accent: ColorTools.accentColors,
      ColorPickerSwatch.bw: ColorTools.blackAndWhite,
      ColorPickerSwatch.custom: widget.colorSwatchNameMap.keys.toList(),
      ColorPickerSwatch.any: <ColorSwatch<Object>>[
        ColorTools.primarySwatch(_selectedColor)
      ],
    };

    // A map that contains true for each swatch that we are using.
    // This map contains defaults if no value is provided, it makes it
    // possible and convenient in the constructor to only provide values
    // for any value that we want to deviate from the default and keep the
    // other values at default, a simple version of a 'CopyWith' method.
    _swatchAvailable = <ColorPickerSwatch, bool>{
      ColorPickerSwatch.both:
          widget.swatchAvailable[ColorPickerSwatch.both] ?? false,
      ColorPickerSwatch.material:
          widget.swatchAvailable[ColorPickerSwatch.material] ?? true,
      ColorPickerSwatch.accent:
          widget.swatchAvailable[ColorPickerSwatch.accent] ?? true,
      ColorPickerSwatch.bw:
          widget.swatchAvailable[ColorPickerSwatch.bw] ?? false,
      ColorPickerSwatch.custom:
          widget.swatchAvailable[ColorPickerSwatch.custom] ?? false,
      ColorPickerSwatch.any:
          widget.swatchAvailable[ColorPickerSwatch.any] ?? true,
    };

    // We use the swatch selector segment control only if more than one swatch
    // is made available to the color picker
    _useSwatchSelector = _swatchAvailable.values
            .fold<int>(0, (int t, bool e) => t + (e ? 1 : 0)) >
        1;

    // Widget map for the sliding Cupertino segmented control that allows us to
    // switch between the swatches we made available to this instance.
    // We set the labels to default values if none given. The constructor also
    // holds defaults, but that does not prevent them for being overridden
    // with explicit null values, in this case we do not want that so we still
    // check for nulls here as well and use default labels if null is given.
    _swatchChoices = <ColorPickerSwatch, Widget>{
      if (_swatchAvailable[ColorPickerSwatch.both])
        ColorPickerSwatch.both: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.swatchLabel[ColorPickerSwatch.both] ??
                ColorPicker._swatchBothLabel,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: widget.swatchFontSize),
          ),
        ),
      if (_swatchAvailable[ColorPickerSwatch.material])
        ColorPickerSwatch.material: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.swatchLabel[ColorPickerSwatch.material] ??
                ColorPicker._swatchPrimaryLabel,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: widget.swatchFontSize),
          ),
        ),
      if (_swatchAvailable[ColorPickerSwatch.accent])
        ColorPickerSwatch.accent: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.swatchLabel[ColorPickerSwatch.accent] ??
                ColorPicker._swatchAccentLabel,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: widget.swatchFontSize),
          ),
        ),
      if (_swatchAvailable[ColorPickerSwatch.bw])
        ColorPickerSwatch.bw: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.swatchLabel[ColorPickerSwatch.bw] ??
                ColorPicker._swatchBlackWhiteLabel,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: widget.swatchFontSize),
          ),
        ),
      if (_swatchAvailable[ColorPickerSwatch.custom])
        ColorPickerSwatch.custom: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.swatchLabel[ColorPickerSwatch.custom] ??
                ColorPicker._swatchCustomLabel,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: widget.swatchFontSize),
          ),
        ),
      if (_swatchAvailable[ColorPickerSwatch.any])
        ColorPickerSwatch.any: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.swatchLabel[ColorPickerSwatch.any] ??
                ColorPicker._swatchPickAnyLabel,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: widget.swatchFontSize),
          ),
        ),
    };

    // If we still have a widget selector, we will build with selected swatch and
    // select the segment as active where we found the given active color.
    if (_useSwatchSelector) {
      if (isInit) _useSwatch = _findSwatchInSelector(_selectedColor);
      // If in a rebuild the swatch was removed, we use the first one
      // that is still left in the segment control
      if (!_swatchChoices.containsKey(_useSwatch)) {
        _useSwatch = _swatchChoices.keys.toList()[0];
      }
    }
    // If we don't have segment control selector, we use the only
    // swatch selection that is is still true without showing a
    // segment control
    else {
      if (_swatchAvailable[ColorPickerSwatch.both]) {
        _useSwatch = ColorPickerSwatch.both;
      } else if (_swatchAvailable[ColorPickerSwatch.material]) {
        _useSwatch = ColorPickerSwatch.material;
      } else if (_swatchAvailable[ColorPickerSwatch.accent]) {
        _useSwatch = ColorPickerSwatch.accent;
      } else if (_swatchAvailable[ColorPickerSwatch.bw]) {
        _useSwatch = ColorPickerSwatch.bw;
      } else if (_swatchAvailable[ColorPickerSwatch.custom]) {
        _useSwatch = ColorPickerSwatch.custom;
      } else if (_swatchAvailable[ColorPickerSwatch.any]) {
        _useSwatch = ColorPickerSwatch.any;
      }
      // If they were all false we show the Material swatches anyway
      else {
        _useSwatch = ColorPickerSwatch.material;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // The normal case is that we have a swatch that we need to find
    if (_useSwatch != ColorPickerSwatch.any) {
      // Pick the active color swatch list from the map based on used swatch
      _activeColorSwatchList = _swatchColorLists[_useSwatch];
      // Set which color swatch is the active one of the ones in the active list
      _activeSwatch = _findColorSwatch(_selectedColor, _activeColorSwatchList);

      // But for the 'any color', the Hue wheel we need to check if the selected
      // color is part of a swatch and if it is return that as the active
      // swatch, and if we do not find one a swatch is created
    } else {
      if (ColorTools.isAccentColor(_selectedColor)) {
        _activeSwatch = ColorTools.accentSwatch(_selectedColor);
      } else if (ColorTools.isPrimaryColor(_selectedColor)) {
        _activeSwatch = ColorTools.primarySwatch(_selectedColor);
      } else if (ColorTools.isBlackAndWhiteColor(_selectedColor)) {
        _activeSwatch = ColorTools.blackAndWhiteSwatch(_selectedColor);
      } else {
        _activeSwatch =
            ColorTools.customSwatch(_selectedColor, widget.colorSwatchNameMap);
      }
    }
    // If we did not find the selected color in the active swatch list
    // we set active swatch to the first swatch in active list, just
    // to get a selection, this is a fall back from an error situation
    // where a selected color was passed to the color picker that was
    // not found in any of the provided swatches. Note that if the
    // wheel
    _activeSwatch ??= _activeColorSwatchList[0];

    // The resulting used text theme: if null was passed in we assign it
    // a default of Theme.of(context).textTheme.subtitle2;
    final TextStyle _usedTextTheme =
        widget.colorCodeTextStyle ?? Theme.of(context).textTheme.subtitle2;

    // A tooltip for copying the color code via an icon button
    final MaterialLocalizations tooltips = MaterialLocalizations.of(context);
    final String copyTooltip = tooltips?.copyButtonLabel ?? 'Copy';

    MainAxisAlignment rowAlignment;
    if (_alignment == CrossAxisAlignment.start) {
      rowAlignment = MainAxisAlignment.start;
    } else if (_alignment == CrossAxisAlignment.end) {
      rowAlignment = MainAxisAlignment.end;
    } else {
      rowAlignment = MainAxisAlignment.center;
    }

    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: Column(
        // Aligned based on constructor crossAxisAlignment, but null safe and
        // follows didUpdateWidget changes as well
        crossAxisAlignment: _alignment,
        children: <Widget>[
          // We start with 8 px height spacing, same as locked vertical padding
          // between whatever widgets are shown.
          const SizedBox(height: 8),
          // Show heading widget if we have one
          if (widget.heading != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: widget.heading,
            ),
          // Show the color swatch selector if more than one swatch to be shown
          if (_useSwatchSelector)
            SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl<ColorPickerSwatch>(
                children: _swatchChoices,
                onValueChanged: (ColorPickerSwatch value) {
                  setState(() => _useSwatch = value);
                },
                groupValue: _useSwatch,
              ),
            ),
          // Add some space after swatch selector if there was a swatch selector
          if (_useSwatchSelector) const SizedBox(height: 12),
          // If it is not the wheel picker, we draw all the main colors
          // for the active swatch list. The Wrap widget is perfect for this use
          // case, no complicated grid needed.
          if (_useSwatch != ColorPickerSwatch.any)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                spacing: widget.spacing,
                runSpacing: widget.runSpacing,
                children: <Widget>[
                  ..._buildListMainColor(_activeColorSwatchList),
                ],
              ),
            ),
          // This is the any color, so we draw the custom paint color wheel
          if (_useSwatch == ColorPickerSwatch.any)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                height: widget.wheelSize,
                width: widget.wheelSize,
                child: ColorWheelPicker(
                  color: _selectedColor,
                  wheelWidth: widget.wheelWidth,
                  hasBorder: widget.hasWheelBorder,
                  forcedUpdate: _forcedUpdate,
                  onChanged: (Color color) {
                    setState(() {
                      _selectedColor = color;
                      widget.onColorChanged(_selectedColor);
                    });
                  },
                ),
              ),
            ),
          // If show names of colors is enabled, we show the names,
          // if we are not showing shade colors, then we show the complete name
          // in the main color with code. The color code is also selectable text
          // although Flutter desktop does not yet allow copying it. (28.3.2020)
          if (widget.showNameSelected &&
              !widget.selectShades &&
              _useSwatch != ColorPickerSwatch.any)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SelectableText(
                ColorTools.colorNameAndHexCode(_selectedColor,
                    colorSwatchNameMap: widget.colorSwatchNameMap),
                style: _usedTextTheme,
              ),
            ),
          // The shades color selection part is only visible if enabled and we
          // show sub-heading if we have one in such a case for the none
          // wheel 'any' case
          if (widget.subHeading != null &&
              widget.selectShades &&
              _useSwatch != ColorPickerSwatch.any)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: widget.subHeading,
            ),
          // The shades color selection part is only visible if enabled and
          // we show sub-heading if we have one in such a case for the none
          // wheel 'any' case
          if (widget.subWheelHeading != null &&
              widget.selectShades &&
              _useSwatch == ColorPickerSwatch.any)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: widget.subWheelHeading,
            ),
          // Draw the shade colors for the selected main color.
          if (widget.selectShades)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                spacing: widget.spacing,
                runSpacing: widget.runSpacing,
                children: <Widget>[
                  ..._buildListShadesColor(_activeSwatch),
                ],
              ),
            ),
          // Show the name and codes of selected shade color, if enabled
          if (widget.selectShades && widget.showNameSelected)
            Row(
              mainAxisAlignment: rowAlignment,
              children: <Widget>[
                SelectableText(
                  ColorTools.colorNameAndHexCode(
                    _selectedColor,
                    colorSwatchNameMap: widget.colorSwatchNameMap,
                  ),
                  style: _usedTextTheme,
                ),
                // Icon button that copies the color code ot the clipboard
                IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  tooltip: copyTooltip,
                  splashRadius: 20,
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: '0x${ColorTools.colorHexCode(_selectedColor)}',
                      ),
                    );
                  },
                )
              ],
            ),
        ],
      ),
    );
  }

  // Build all the main colors in the active color swatch list
  List<Widget> _buildListMainColor(List<ColorSwatch<Object>> colorSwatches) {
    final double _borderRadius = widget.borderRadius ?? widget.size / 4.0;
    return <Widget>[
      for (final ColorSwatch<Object> colorSwatch in colorSwatches)
        ColorIndicator(
          isSelected: _isShadeOfMain(colorSwatch, _selectedColor),
          color: colorSwatch,
          width: widget.size,
          height: widget.size,
          borderRadius: _borderRadius,
          hasBorder: widget.hasBorder,
          borderColor: widget.borderColor,
          elevation: widget.elevation,
          selectedIndicator: widget.selectedIndicator,
          onSelect: () =>
              _onColorSelected(colorSwatch[500] ?? colorSwatch[200]),
        )
    ];
  }

  // Build all the shade colors for the selected main color swatch
  List<Widget> _buildListShadesColor(ColorSwatch<Object> color) {
    final double _borderRadius = widget.borderRadius ?? widget.size / 4.0;
    return <Widget>[
      for (final Color color in _getMaterialColorShades(color))
        ColorIndicator(
          isSelected: _selectedColor == color,
          color: color,
          width: widget.size,
          height: widget.size,
          borderRadius: _borderRadius,
          hasBorder: widget.hasBorder,
          borderColor: widget.borderColor,
          elevation: widget.elevation,
          selectedIndicator: widget.selectedIndicator,
          onSelect: () {
            if (_useSwatch == ColorPickerSwatch.any) _forcedUpdate = true;
            return _onColorSelected(color);
          },
        )
    ];
  }

  // Locate in which available Cupertino segment with its color swatches a
  // given color can be found in, and return that swatch enum.
  // This is used to activate the correct Cupertino segment for the provided
  // color, so that it can be selected and shown as selected.
  ColorPickerSwatch _findSwatchInSelector(Color color) {
    // Search for the given color in any of the swatches that are set
    // as available in the selector and return the swatch where we find
    // the color
    for (final ColorPickerSwatch key in _swatchColorLists.keys) {
      if (_swatchAvailable[key]) {
        for (final ColorSwatch<Object> swatch in _swatchColorLists[key]) {
          if (_isShadeOfMain(swatch, color)) return key;
        }
      }
    }
    // If we did not find the color in any of the swatches in the selector, we
    // will just return the first swatch available in the selector
    for (final ColorPickerSwatch key in _swatchColorLists.keys) {
      if (_swatchAvailable[key]) {
        return key;
      }
    }

    // And finally if no selector was set to enabled, we return material anyway
    return ColorPickerSwatch.material;
  }

  // A color was selected, update state and notify parent via callback
  void _onColorSelected(Color color) {
    setState(() {
      _selectedColor = color;
      if (widget.onColorChanged != null) widget.onColorChanged(color);
    });
  }

  // Check if a given color is a shade of the main color, return true if it is
  bool _isShadeOfMain(ColorSwatch<Object> mainColor, Color shadeColor) {
    for (final Color shade in _getMaterialColorShades(mainColor)) {
      if (shade == shadeColor) return true;
    }
    return false;
  }

  // Find and return the ColorSwatch in a List of ColorSwatches that contains
  // a given color
  ColorSwatch<Object> _findColorSwatch(
      Color color, List<ColorSwatch<Object>> swatches) {
    for (final ColorSwatch<Object> mainColor in swatches) {
      if (_isShadeOfMain(mainColor, color)) {
        return mainColor;
      }
    }
    return (color is ColorSwatch && swatches.contains(color)) ? color : null;
  }

  // Return a List of colors with all the colors that exist in a given
  // ColorSwatch. Include the 850 index for grey color that has this value,
  // it is the only ColorSwatch that has 850. This function works both
  // for MaterialColor and AccentColor, and for custom color swatches that
  // uses the ColorSwatch indexes below.
  List<Color> _getMaterialColorShades(ColorSwatch<Object> color) {
    return <Color>[
      if (color[50] != null) color[50],
      if (color[100] != null) color[100],
      if (color[200] != null) color[200],
      if (color[300] != null) color[300],
      if (color[400] != null) color[400],
      if (color[500] != null) color[500],
      if (color[600] != null) color[600],
      if (color[700] != null) color[700],
      if (color[800] != null) color[800],
      if (color[850] != null && widget.includeIndex850) color[850],
      if (color[900] != null) color[900],
    ];
  }
}
