import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color_indicator.dart';
import 'color_tools.dart';
import 'color_wheel_picker.dart';

/// Enum that represents the different offered color picker types.
enum ColorPickerType {
  /// A color picker that contains both primary and accent Material colors.
  both,

  /// A color picker that contain the primary Material colors.
  primary,

  /// A color picker that contain the accent Material colors.
  accent,

  /// A color picker that offer black and white and near black and white shades.
  bw,

  /// A color picker that shows custom provided colors and their material like
  /// swatch and a custom name for the color.
  custom,

  /// A HSV wheel color picker that can select any color.
  wheel,
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
/// using the selected color as the new primary swatch 500 index midpoint.
class ColorPicker extends StatefulWidget {
  /// Default constructor for the color picker.
  const ColorPicker({
    Key key,
    this.color = Colors.blue,
    @required this.onColorChanged,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.padding = const EdgeInsets.all(16),
    this.enableShadesSelection = true,
    this.includeIndex850 = false,
    this.selectedColorIcon = Icons.check,
    //
    // Picker item and wheel picker properties.
    this.width = 40.0,
    this.height = 40.0,
    this.spacing = 4,
    this.runSpacing = 4,
    this.elevation = 0,
    this.hasBorder = false,
    this.borderRadius,
    this.borderColor,
    this.wheelDiameter = 190,
    this.wheelWidth = 16,
    this.wheelHasBorder = false,
    //
    // Color picker types shown and used by the color picker.
    this.pickersEnabled = const <ColorPickerType, bool>{
      ColorPickerType.both: false,
      ColorPickerType.primary: true,
      ColorPickerType.accent: true,
      ColorPickerType.bw: false,
      ColorPickerType.custom: false,
      ColorPickerType.wheel: false,
    },
    //
    // Headings and sub headings used by the color picker.
    this.heading,
    this.subheading,
    this.wheelSubheading,
    this.showColorNameCode = false,
    this.colorNameCodeTextStyle,
    //
    // Segmented color picker selector control properties.
    this.segmentTextStyle,
    this.pickerTypeLabels = const <ColorPickerType, String>{
      ColorPickerType.primary: _selectPrimaryLabel,
      ColorPickerType.accent: _selectAccentLabel,
      ColorPickerType.bw: _selectBlackWhiteLabel,
      ColorPickerType.both: _selectBothLabel,
      ColorPickerType.custom: _selectCustomLabel,
      ColorPickerType.wheel: _selectWheelAnyLabel,
    },
    //
    // Custom color swatches and name map for the custom color swatches.
    this.customColorSwatchesAndNames,
    //
  })  : assert(color != null, 'The color cannot be null'),
        assert(onColorChanged != null,
            'A color change callback function is required and cannot be null.'),
        assert(enableShadesSelection != null, 'Select shades cannot be null.'),
        assert(includeIndex850 != null, 'includeIndex850  cannot be null.'),
        assert(selectedColorIcon != null, 'Selected indicator cannot be null.'),
        assert(showColorNameCode != null,
            'Show name of selected color cannot be null.'),
        assert(height != null, 'Picker height cannot be null.'),
        assert(height > 15 && height <= 150,
            'The picker item height must be > 15 and <= 150'),
        assert(width != null, 'Picker width cannot be null.'),
        assert(width > 15 && width <= 150,
            'The picker item width must be > 15 and <= 150'),
        assert(hasBorder != null, 'Has border cannot be null.'),
        assert(wheelWidth != null, 'Color wheel width cannot be null.'),
        assert(wheelWidth >= 4 && wheelWidth <= 50,
            'The color wheel width must be >= 4 and <= 50'),
        assert(wheelHasBorder != null, 'Has wheel border cannot be null.'),
        assert(elevation != null, 'Elevation cannot be null.'),
        assert(padding != null, 'Padding pixel value cannot be null.'),
        assert(spacing != null, 'Spacing pixel value cannot be null.'),
        assert(runSpacing != null, 'Run spacing pixel value cannot be null.'),
        assert(pickerTypeLabels != null,
            'Segment selector labels cannot be null.'),
        assert(
            pickersEnabled != null, 'Used color picker types cannot be null.'),
        assert(
            wheelDiameter == null ||
                (wheelDiameter >= 100 && wheelDiameter <= 500),
            'The wheel picker can be null for default size, if size is '
            'given it must be >= 100 and <= 500'),
        super(key: key);

  /// The active color selection when the color picker is created.
  final Color color;

  /// A value changed callback, that is called when user clicks and selects a
  /// new color. Changing which picker type is viewed does not trigger this
  /// callback, it is not triggered until a color in the viewed picker is
  /// selected.
  final ValueChanged<Color> onColorChanged;

  /// Cross axis alignment used to layout the main content of the
  /// color picker in a column. Defaults to CrossAxisAlignment.center.
  final CrossAxisAlignment crossAxisAlignment;

  /// Padding around the entire color picker content.
  /// Defaults to const EdgeInsets.all(16).
  final EdgeInsetsGeometry padding;

  /// Set to true to allow selection of color swatch shades. If false
  /// only the main color from a swatch is shown and can be selected, which
  /// is index [500] for Material primary colors and [200] for accent colors.
  /// Defaults to true.
  final bool enableShadesSelection;

  /// There is an extra index [850] used only by grey Material color in Flutter.
  /// If you want to include it in the grey color shades selection, then set
  /// to true. Defaults to false.
  final bool includeIndex850;

  /// Icon data for the icon used to indicate the selected color.
  /// Defaults to a check mark ([Icons.check]).
  ///
  /// The size of the [selectedColorIcon] is 60% of the smaller of color
  /// indicator [width] and [height]. The color of indicator icon is
  /// black or white, based on what contrast best with the selected color.
  final IconData selectedColorIcon;

  /// Width of the color indicator items in dp. Defaults to 40 dp.
  final double width;

  /// Height of the color indicator items in dp. Defaults to 40 dp.
  final double height;

  /// The spacing between the color picker indicator items.
  final double spacing;

  /// The space between the color picker color item rows,
  /// when they need to be wrapped to multiple rows.
  final double runSpacing;

  /// The Material elevation of the color indicator items.
  final double elevation;

  /// Set to true to show a 1 dp border around the color indicator items.
  /// This property is useful if the white/near white and black/near black
  /// shades color picker is enabled. Defaults to false.
  final bool hasBorder;

  /// Border radius of the color indicator items. Defaults to [width]/4.
  final double borderRadius;

  /// The color of the 1 dp optional border used on [ColorIndicator] and on
  /// [ColorWheelPicker] when their has border toggle is true.
  /// If no color is given, the border color will default to
  /// Theme.of(context).dividerColor.
  final Color borderColor;

  /// Diameter in dp of the HSV based color wheel picker.
  /// Defaults to 190 dp.
  final double wheelDiameter;

  /// The stroke width of the color wheel circle in dp. Defaults to 16 dp.
  final double wheelWidth;

  /// Set to true to show a 1 dp border around the color wheel.
  final bool wheelHasBorder;

  /// A [ColorPickerType] to bool map, that defines which picker types are
  /// enabled in the color picker's sliding segmented selector and
  /// are thus available as color pickers.
  /// Available options are based on the [ColorPickerType] enum that
  /// includes both, primary, accent, bw, custom and any.
  /// By default a map that that sets primary and accent pickers to true is
  /// used if no or a null map is given.
  /// Any undefined or missing enum keys in a given map are treated as false.
  final Map<ColorPickerType, bool> pickersEnabled;

  /// Heading widget for the color picker. Typically a Text widget,
  /// e.g. Text('Select color'). If not provided or null, there is no
  /// heading for the color picker.
  final Widget heading;

  /// Subheading widget for the color shades selection. Typically a Text widget,
  /// e.g. Text('Select color shade'). If not provided or null, there is no
  /// subheading for the color shades.
  final Widget subheading;

  /// Subheading widget for the HSV color wheel, color selection. Typically a
  /// Text widget, e.g. Text('Selected color and its material like shades').
  /// The color wheel uses a separate subheading widget so that it may have
  /// another explanation, since its use case differs from the other subheading
  /// cases. If not provided, there is no subheading for the color wheel picker.
  final Widget wheelSubheading;

  /// Set to true to show the name and color code of the selected [color].
  /// The displayed color code uses selectable text, so if needed the value
  /// can be selected and copied. There is also button that copies the
  /// Flutter style hex rgb color code to the clipboard.
  /// Defaults to false.
  final bool showColorNameCode;

  /// Text style for the displayed color code in the picker.
  /// Defaults to Theme.of(context).textTheme.subtitle2, if not defined.
  final TextStyle colorNameCodeTextStyle;

  /// The TextStyle of the labels in segmented control swatch selector.
  /// If null, defaults to Theme.of(context).textTheme.caption.
  final TextStyle segmentTextStyle;

  /// A [ColorPickerType] to String map that contains labels for picker types.
  /// Default label strings are provided in English if not given.
  final Map<ColorPickerType, String> pickerTypeLabels;

  /// Color swatch to name map, with custom swatches and their names. Used to
  /// provide color swatches for the custom color picker, including their
  /// custom names. These colors, their swatch shades and names, are shown
  /// and used when the picker type [ColorPickerType.custom] option is enabled
  /// in the color picker.
  final Map<ColorSwatch<Object>, String> customColorSwatchesAndNames;

  /// English default label for picker with both primary and accent colors.
  static const String _selectBothLabel = 'Primary & Accent';

  /// English default label for picker with primary colors.
  static const String _selectPrimaryLabel = 'Primary';

  /// English default label for picker with accent colors.
  static const String _selectAccentLabel = 'Accent';

  /// English default label for picker with black and white shades.
  static const String _selectBlackWhiteLabel = 'Black & White';

  /// English default label for picker with custom defined colors.
  static const String _selectCustomLabel = 'Custom';

  /// English default label for the HSV wheel picker that can select any color.
  static const String _selectWheelAnyLabel = 'Wheel';

  @override
  _ColorPickerState createState() => _ColorPickerState();

  /// Show the defined [ColorPicker] in a custom alert dialog.
  ///
  /// The [showPickerDialog] method is a convenience function to show the
  /// [ColorPicker] widget in a modal dialog. It re-implements the standard
  /// `showDialog` function with opinionated Cancel and Select buttons. It
  /// also by default uses a lighter barrier color. This is useful if the
  /// color picker is used to dynamically change color of a widget or entire
  /// application theme since we can better see the impact of the color
  /// choice behind the modal dialog if the barrier is made more transparent.
  ///
  /// Returns a Future bool that resolves to true if the select color action
  /// was selected and to false if the cancel action was selected when the
  /// dialog was closed.
  Future<bool> showPickerDialog(
    /// The dialog requires a BuildContext.
    BuildContext context, {

    /// Title of the color picker dialog, often omitted in favor of using
    /// [heading] already defined in the [ColorPicker].
    Widget title,

    /// Padding around the dialog title, if a title is used.
    /// Defaults to const EdgeInsets.all(0), since the title is normally omitted
    /// and provided via the [heading] property of the [ColorPicker] instead.
    final EdgeInsetsGeometry titlePadding = const EdgeInsets.all(0),

    /// Label shown on the button for cancelling the color picking and closing
    /// the dialog. If the cancel action is selected the dialog will return
    /// false. It is up to the caller to use this information in a suitable
    /// manner. Often the cancel action will require the caller to restore the
    /// original color that was used when the color picker was created and
    /// dialog was opened.
    ///
    /// The label defaults to 'CANCEL' if not provided.
    String cancelLabel,

    /// Label shown on button for selecting the current color in the color
    /// picker dialog and closing the dialog. The dialog will will return true.
    /// If the caller has handled the [onColorChanged] callbacks from the
    /// color picker, the select action will normally not require any further
    /// action. The select action is the default action and can also be
    /// triggered by enter press on a keyboard.
    ///
    /// The label defaults to 'SELECT' if not provided.
    String selectLabel,

    /// Padding around the Cancel and Select action buttons at the bottom of
    /// the dialog.
    ///
    /// Typically used to provide padding to the button bar between the button
    /// bar and the edges of the dialog.
    ///
    /// Defaults to const EdgeInsets.symmetric(horizontal: 16).
    final EdgeInsetsGeometry actionsPadding =
        const EdgeInsets.symmetric(horizontal: 16),

    /// The padding that surrounds each button in [actions].
    ///
    /// This is different from [actionsPadding], which defines the padding
    /// between the entire button bar and the edges of the dialog.
    ///
    /// Defaults to const EdgeInsets.all(16).
    final EdgeInsetsGeometry buttonPadding = const EdgeInsets.all(16),

    /// Padding around the content in the dialog.
    ///
    /// Defaults to const EdgeInsets.all(0), as the content padding is normally
    /// expected to be a part of the [ColorPicker].
    final EdgeInsetsGeometry contentPadding = const EdgeInsets.all(0),

    /// Inset padding for all the content in dialog.
    ///
    /// Defaults to const EdgeInsets.all(0), as the inset padding is normally
    /// expected to be a part of the padding of the [ColorPicker].
    final EdgeInsets insetPadding = const EdgeInsets.all(0),

    /// If true, the dialog can be closed by clicking outside it.
    /// Defaults to true.
    bool barrierDismissible = true,

    /// The background transparency color of the dialog barrier.
    /// Defaults to [Colors.black12] which is considerably lighter than the
    /// standard [Colors.black54] and allows us to see impact of selected color
    /// on app behind the dialog. If this is not desired, set it back to
    /// [Colors.black54] when you call [showPickerDialog].
    Color barrierColor = Colors.black12,

    /// The `useSafeArea` argument is used to indicate if the dialog should only
    /// display in 'safe' areas of the screen not used by the operating system
    /// (see [SafeArea] for more details). It is `true` by default, which means
    /// the dialog will not overlap operating system areas. If it is set to
    /// `false` the dialog will only be constrained by the screen size.
    /// It can not be `null`.
    bool useSafeArea = true,

    /// The `useRootNavigator` argument is used to determine whether to push the
    /// dialog to the [Navigator] furthest from or nearest to the given
    /// `context`.
    /// By default, `useRootNavigator` is `true` and the dialog route created
    /// by this method is pushed to the root navigator. It can not be `null`.
    bool useRootNavigator = true,

    /// The `routeSettings` argument is passed to [showGeneralDialog],
    /// see [RouteSettings] for details.
    RouteSettings routeSettings,

    /// You can provide BoxConstraints to constrain the size of the dialog.
    /// You might want to do this at least for the height, otherwise
    /// the dialog might jump up and down jarringly if its size changes when
    /// you change picker type with the selector.¨
    ///
    /// Normally you would not change the picker element sizes after you
    /// have determined what works in your implementation, so you can usually
    /// figure out a good dialog box size that works well for your use case
    /// instead of allowing the color picker dialog to auto size itself,
    /// which it will do if no constraints are defined.
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
            titlePadding: titlePadding,
            contentPadding: contentPadding,
            actionsPadding: actionsPadding,
            buttonPadding: buttonPadding,
            insetPadding: insetPadding,
            title: title,
            content: constraints == null
                ? this
                : ConstrainedBox(
                    constraints: constraints,
                    child: this,
                  ),
            scrollable: true,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Cancel was pressed, we pop and return FALSE
                  Navigator.of(context).pop(false);
                },
                child: Text(cancelLabel),
              ),
              OutlinedButton(
                onPressed: () {
                  // Select was pressed, we pop and return TRUE
                  Navigator.of(context).pop(true);
                },
                autofocus: true,
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
  List<ColorSwatch<Object>> activeColorSwatchList;
  // The active Swatch in the active Color swatch List
  ColorSwatch<Object> activeSwatch;
  // Which picker are we using now.
  ColorPickerType activePicker;
  // Current selected color
  Color selectedColor;

  // Map of swatch names in corresponding list of color swatches,
  // gets initialized in the initSelectedValue() function.
  Map<ColorPickerType, List<ColorSwatch<Object>>> typeToSwatchMap;
  // We need a map we can guarantee has no gaps, so we make a local
  // version of it that is always complete,
  // gets initialized in the initSelectedValue() function.
  Map<ColorPickerType, bool> pickersEnabled;
  Map<ColorPickerType, bool> oldPickersEnabled;

  // A boolean that is only true when we have more than one
  // swatch group available, if there is just one picker enabled
  // then that picker will be used, but we will not use the selector.
  bool usePickerSelector;

  // Set to true when shade selector on any widget, needs to force
  // an update on the color wheel.
  bool forcedUpdate = false;

  // The content alignment
  CrossAxisAlignment alignment;

  @override
  void initState() {
    // Set the selected color to the widget constructor provided start color
    selectedColor = widget.color;
    // Initialize other values
    initSelectedValue(findPicker: true);
    super.initState();
  }

  @override
  void didUpdateWidget(ColorPicker oldWidget) {
    // Initialize the values again because the underlying widget changed.
    // If the available color picker selection was changed we need to find
    // the picker again and set the findPicker option to true.
    initSelectedValue(
        findPicker: widget.pickersEnabled != oldWidget.pickersEnabled);
    super.didUpdateWidget(oldWidget);
  }

  void initSelectedValue({bool findPicker = false}) {
    // Init will not force update the saturation and value on wheel (H)SV part.
    forcedUpdate = false;

    // Set alignment to widget value, but if it is null, set it to center.
    alignment = widget.crossAxisAlignment ?? CrossAxisAlignment.center;

    // If no custom color map is provided (null) we use an empty map.
    final Map<ColorSwatch<Object>, String> colorsNameMap =
        widget.customColorSwatchesAndNames ?? <ColorSwatch<Object>, String>{};

    // A map with the picker type enum as key to color swatch lists.
    typeToSwatchMap = <ColorPickerType, List<ColorSwatch<Object>>>{
      ColorPickerType.both: ColorTools.primaryAndAccentColors,
      ColorPickerType.primary: ColorTools.primaryColors,
      ColorPickerType.accent: ColorTools.accentColors,
      ColorPickerType.bw: ColorTools.blackAndWhite,
      ColorPickerType.custom: colorsNameMap.keys.toList(),
      ColorPickerType.wheel: <ColorSwatch<Object>>[
        // Make a swatch of the selected color in the wheel.
        ColorTools.primarySwatch(selectedColor)
      ],
    };

    // Set useCustomPicker to false if no custom data for it was provided,
    // even if using custom picker might have been true, we have to have some
    // custom color swatches as well to be able to use them.
    bool useCustomPicker =
        widget.pickersEnabled[ColorPickerType.custom] ?? false;
    if (widget.customColorSwatchesAndNames == null) useCustomPicker = false;

    // Color picker type to boolean for each enabled case.
    // This local map of the widget provided version always contains defaults
    // or 'false' if no value was provided in via the widget constructor.
    // This makes it possible and convenient in the constructor to only
    // provide values for any values that we want to deviate from the default
    // and keep the other values at default, a simple version of a
    // 'CopyWith' method.
    pickersEnabled = <ColorPickerType, bool>{
      ColorPickerType.both:
          widget.pickersEnabled[ColorPickerType.both] ?? false,
      ColorPickerType.primary:
          widget.pickersEnabled[ColorPickerType.primary] ?? true,
      ColorPickerType.accent:
          widget.pickersEnabled[ColorPickerType.accent] ?? true,
      ColorPickerType.bw: widget.pickersEnabled[ColorPickerType.bw] ?? false,
      ColorPickerType.custom: useCustomPicker,
      ColorPickerType.wheel:
          widget.pickersEnabled[ColorPickerType.wheel] ?? false,
    };
    // debugPrint(pickersEnabled.toString());

    // We use the picker selector segment control only if more than one picker
    // is enabled in the color picker. If anybody ever reads this code
    // I admit, this kind of logic is a bit tricky. Imo looping over them and
    // counting the ones that are true and returning true if the count is > 1
    // is also imo more understandable, but this was interesting to try :)
    usePickerSelector =
        pickersEnabled.values.fold<int>(0, (int t, bool e) => t + (e ? 1 : 0)) >
            1;

    // If we have a picker selector, we will build with selected picker and
    // select the segment as active where we found the given active color.
    if (usePickerSelector) {
      if (findPicker) activePicker = findColorInSelector(selectedColor);
      // If in a rebuild and the swatch was removed, we use the first one
      // that is still left in the segment control.
      if (!pickersEnabled.containsKey(activePicker)) {
        activePicker = pickersEnabled.keys.toList()[0];
      }
    }
    // If we don't have segment control selector, we use the only
    // swatch selection that is is still true without showing a
    // segment control
    else {
      if (pickersEnabled[ColorPickerType.both]) {
        activePicker = ColorPickerType.both;
      } else if (pickersEnabled[ColorPickerType.primary]) {
        activePicker = ColorPickerType.primary;
      } else if (pickersEnabled[ColorPickerType.accent]) {
        activePicker = ColorPickerType.accent;
      } else if (pickersEnabled[ColorPickerType.bw]) {
        activePicker = ColorPickerType.bw;
      } else if (pickersEnabled[ColorPickerType.custom]) {
        activePicker = ColorPickerType.custom;
      } else if (pickersEnabled[ColorPickerType.wheel]) {
        activePicker = ColorPickerType.wheel;
      }
      // If they were all false we show the Material primary swatches.
      else {
        activePicker = ColorPickerType.primary;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set default text style for the segmented slider control.
    final TextStyle segmentTextStyle =
        widget.segmentTextStyle ?? Theme.of(context).textTheme.caption;

    // Widget map for the sliding Cupertino segmented control that allows us to
    // switch between the pickers we enabled.
    // We set the labels to default values if none given. The constructor also
    // holds defaults, but that does not prevent them for being overridden
    // with explicit null values, in this case we do not want that so we still
    // check for nulls here as well and use default labels if null is given.

    // Map of swatch choices and its widgets for the Cupertino segmented
    // control, gets initialized in the initSelectedValue() function.
    final Map<ColorPickerType, Widget> pickerTypes = <ColorPickerType, Widget>{
      if (pickersEnabled[ColorPickerType.both])
        ColorPickerType.both: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.pickerTypeLabels[ColorPickerType.both] ??
                ColorPicker._selectBothLabel,
            textAlign: TextAlign.center,
            style: segmentTextStyle,
          ),
        ),
      if (pickersEnabled[ColorPickerType.primary])
        ColorPickerType.primary: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.pickerTypeLabels[ColorPickerType.primary] ??
                ColorPicker._selectPrimaryLabel,
            textAlign: TextAlign.center,
            style: segmentTextStyle,
          ),
        ),
      if (pickersEnabled[ColorPickerType.accent])
        ColorPickerType.accent: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.pickerTypeLabels[ColorPickerType.accent] ??
                ColorPicker._selectAccentLabel,
            textAlign: TextAlign.center,
            style: segmentTextStyle,
          ),
        ),
      if (pickersEnabled[ColorPickerType.bw])
        ColorPickerType.bw: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.pickerTypeLabels[ColorPickerType.bw] ??
                ColorPicker._selectBlackWhiteLabel,
            textAlign: TextAlign.center,
            style: segmentTextStyle,
          ),
        ),
      if (pickersEnabled[ColorPickerType.custom])
        ColorPickerType.custom: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.pickerTypeLabels[ColorPickerType.custom] ??
                ColorPicker._selectCustomLabel,
            textAlign: TextAlign.center,
            style: segmentTextStyle,
          ),
        ),
      if (pickersEnabled[ColorPickerType.wheel])
        ColorPickerType.wheel: Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            widget.pickerTypeLabels[ColorPickerType.wheel] ??
                ColorPicker._selectWheelAnyLabel,
            textAlign: TextAlign.center,
            style: segmentTextStyle,
          ),
        ),
    };

    // The normal case is that we have a swatch that we need to find
    if (activePicker != ColorPickerType.wheel) {
      // Pick the active color swatch list from the map based on used swatch
      activeColorSwatchList = typeToSwatchMap[activePicker];
      // Set which color swatch is the active one of the ones in the active list
      activeSwatch = findColorSwatch(selectedColor, activeColorSwatchList);

      // For the 'wheel' color, we need to check if the selected
      // color is part of a swatch and if it is, return that as the active
      // swatch, and only if we do not find one, a swatch is created.
    } else {
      if (ColorTools.isAccentColor(selectedColor)) {
        activeSwatch = ColorTools.accentSwatch(selectedColor);
      } else if (ColorTools.isPrimaryColor(selectedColor)) {
        activeSwatch = ColorTools.primarySwatch(selectedColor);
      } else if (ColorTools.isBlackAndWhiteColor(selectedColor)) {
        activeSwatch = ColorTools.blackAndWhiteSwatch(selectedColor);
      } else {
        activeSwatch = ColorTools.customSwatch(
            selectedColor, widget.customColorSwatchesAndNames);
      }
    }
    // If we did not find the selected color in the active swatch list
    // we set active swatch to the first swatch in active list, just
    // to get a selection, this is a fall back from an error situation
    // where a selected color was passed to the color picker that was
    // not found in any of the provided swatches in active pickers. Note that
    // if the wheel picker is enabled, the color will always be found
    // in it as a last resort.
    activeSwatch ??= activeColorSwatchList[0];

    // The resulting used text theme, if null was passed in we assign it
    // a default of Theme.of(context).textTheme.subtitle2;
    final TextStyle effectiveTextTheme =
        widget.colorNameCodeTextStyle ?? Theme.of(context).textTheme.subtitle2;

    // A tooltip for copying the color code via an icon button
    final MaterialLocalizations tooltips = MaterialLocalizations.of(context);
    final String copyTooltip = tooltips?.copyButtonLabel ?? 'Copy';

    // There is row that we need to align based on the given column alignment.
    // This is partial implementation that may not work optimally with all
    // possible column CrossAxisAlignments. If it becomes an issue for some use
    // cases, consider exposing the row alignment via its own property. The idea
    // with this is that it follow the cross axis alignment of the column for
    // its main alignment options.
    MainAxisAlignment rowAlignment;
    if (alignment == CrossAxisAlignment.start) {
      rowAlignment = MainAxisAlignment.start;
    } else if (alignment == CrossAxisAlignment.end) {
      rowAlignment = MainAxisAlignment.end;
    } else {
      rowAlignment = MainAxisAlignment.center;
    }

    return Padding(
      padding: widget.padding,
      child: Column(
        // Align the column content based on constructor crossAxisAlignment,
        // but null safe and follows didUpdateWidget changes as well
        crossAxisAlignment: alignment,
        children: <Widget>[
          // Show heading widget if we have one.
          if (widget.heading != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: widget.heading,
            ),
          // Show the picker selector if more than one picker is enabled.
          if (usePickerSelector)
            SizedBox(
              width: double.infinity,
              child: CupertinoSlidingSegmentedControl<ColorPickerType>(
                children: pickerTypes,
                onValueChanged: (ColorPickerType value) {
                  setState(() => activePicker = value);
                },
                groupValue: activePicker,
              ),
            ),
          // Add some space after picker selector if there was one.
          if (usePickerSelector) const SizedBox(height: 12),
          // If it is not the wheel picker, we draw all the main colors
          // for the active swatch list. The Wrap widget is perfect for this use
          // case, no complicated grid needed.
          if (activePicker != ColorPickerType.wheel)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                spacing: widget.spacing,
                runSpacing: widget.runSpacing,
                children: <Widget>[
                  ...buildMainColors(activeColorSwatchList),
                ],
              ),
            ),
          // This is the wheel case, so we draw the custom painter color wheel.
          if (activePicker == ColorPickerType.wheel)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: SizedBox(
                height: widget.wheelDiameter,
                width: widget.wheelDiameter,
                child: ColorWheelPicker(
                  color: selectedColor,
                  wheelWidth: widget.wheelWidth,
                  hasBorder: widget.wheelHasBorder,
                  forcedUpdate: forcedUpdate,
                  onChanged: (Color color) {
                    setState(() {
                      selectedColor = color;
                      widget.onColorChanged(selectedColor);
                    });
                  },
                ),
              ),
            ),
          // The shades color selection part is only visible if enabled and we
          // show sub-heading (if we have one in such a case) for the none
          // wheel case.
          if (widget.subheading != null &&
              widget.enableShadesSelection &&
              activePicker != ColorPickerType.wheel)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: widget.subheading,
            ),
          // The shades color selection part is only visible if enabled and
          // we show sub-heading (if we have one in such a case) for the none
          // wheel case.
          if (widget.wheelSubheading != null &&
              widget.enableShadesSelection &&
              activePicker == ColorPickerType.wheel)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: widget.wheelSubheading,
            ),
          // Draw the shade colors for the selected main color.
          if (widget.enableShadesSelection)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Wrap(
                spacing: widget.spacing,
                runSpacing: widget.runSpacing,
                children: <Widget>[
                  ...buildShadesColors(activeSwatch),
                ],
              ),
            ),
          // Show the name and codes of selected color, if enabled.
          if (widget.showColorNameCode)
            Row(
              mainAxisAlignment: rowAlignment,
              children: <Widget>[
                SelectableText(
                  ColorTools.colorNameAndHexCode(
                    selectedColor,
                    colorSwatchNameMap: widget.customColorSwatchesAndNames,
                  ),
                  style: effectiveTextTheme,
                ),
                // Icon button that copies the color code to the clipboard.
                IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  tooltip: copyTooltip,
                  splashRadius: 20,
                  onPressed: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: '0x${ColorTools.colorHexCode(selectedColor)}',
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

  // Build all the main colors in the active color swatch list.
  List<Widget> buildMainColors(List<ColorSwatch<Object>> colorSwatches) {
    final double borderRadius = widget.borderRadius ?? widget.width / 4.0;
    return <Widget>[
      for (final ColorSwatch<Object> colorSwatch in colorSwatches)
        ColorIndicator(
          isSelected: isShadeOfMain(colorSwatch, selectedColor),
          color: colorSwatch,
          width: widget.width,
          height: widget.height,
          borderRadius: borderRadius,
          hasBorder: widget.hasBorder,
          borderColor: widget.borderColor,
          elevation: widget.elevation,
          selectedIcon: widget.selectedColorIcon,
          onSelect: () => onColorSelected(colorSwatch[500] ?? colorSwatch[200]),
        )
    ];
  }

  // Build all the shade colors for the selected main color swatch.
  List<Widget> buildShadesColors(ColorSwatch<Object> color) {
    final double borderRadius = widget.borderRadius ?? widget.width / 4.0;
    return <Widget>[
      for (final Color color in getMaterialColorShades(color))
        ColorIndicator(
          isSelected:
              selectedColor == color || selectedColor?.value == color?.value,
          color: color,
          width: widget.width,
          height: widget.height,
          borderRadius: borderRadius,
          hasBorder: widget.hasBorder,
          borderColor: widget.borderColor,
          elevation: widget.elevation,
          selectedIcon: widget.selectedColorIcon,
          onSelect: () {
            if (activePicker == ColorPickerType.wheel) forcedUpdate = true;
            return onColorSelected(color);
          },
        )
    ];
  }

  // Locate in which available picker with its color swatches a
  // given color can be found in and return that pickers enum type.
  // This is used to activate the correct Cupertino segment for the provided
  // color, so that it can be selected and shown as selected.
  ColorPickerType findColorInSelector(Color color) {
    // Search for the given color in any of the swatches that are set
    // as available in the selector and return the swatch where we find
    // the color.
    for (final ColorPickerType key in typeToSwatchMap.keys) {
      if (pickersEnabled[key]) {
        for (final ColorSwatch<Object> swatch in typeToSwatchMap[key]) {
          if (isShadeOfMain(swatch, color)) return key;
        }
      }
    }
    // If we did not find the color in any of the swatches in the selector, we
    // will just return the first swatch available in the selector.
    for (final ColorPickerType key in typeToSwatchMap.keys) {
      if (pickersEnabled[key]) {
        return key;
      }
    }

    // And finally if no selector was set to enabled, we return material anyway.
    return ColorPickerType.primary;
  }

  // A color was selected, update state and notify parent via callback.
  void onColorSelected(Color color) {
    setState(() {
      selectedColor = color;
      if (widget.onColorChanged != null) widget.onColorChanged(color);
    });
  }

  // Check if a given color is a shade of the main color, return true if it is.
  bool isShadeOfMain(ColorSwatch<Object> mainColor, Color shadeColor) {
    for (final Color shade in getMaterialColorShades(mainColor)) {
      if (shade == shadeColor || shade?.value == shadeColor?.value) return true;
    }
    return false;
  }

  // Find and return the ColorSwatch in a List of ColorSwatches that contains
  // a given color.
  ColorSwatch<Object> findColorSwatch(
      Color color, List<ColorSwatch<Object>> swatches) {
    for (final ColorSwatch<Object> mainColor in swatches) {
      if (isShadeOfMain(mainColor, color)) {
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
  List<Color> getMaterialColorShades(ColorSwatch<Object> color) {
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
