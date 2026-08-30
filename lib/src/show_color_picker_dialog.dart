part of 'color_picker.dart';

/// Show a [ColorPicker] in a modal dialog and wait for a selected [Color].
///
/// This is a convenience wrapper around constructing a [ColorPicker] and
/// calling [ColorPicker.showPickerDialog]. It uses opinionated Cancel and OK
/// buttons. The returned [Future] completes with the color selected when the
/// dialog is closed with OK. If the user cancels or dismisses the dialog, the
/// original [color] is returned.
///
/// Picker configuration matches [ColorPicker]. Dialog chrome (title, padding,
/// barrier, transitions) is passed through to [ColorPicker.showPickerDialog].
///
/// ## [context]
///
/// Required [BuildContext] for the dialog.
///
/// ## [color]
///
/// The active color selection when the color picker dialog is created.
///
/// ## [pickersEnabled]
///
/// A [ColorPickerType] to bool map. Defines which pickers are enabled in the
/// color picker's sliding selector and thus available as color pickers.
///
/// Available options are based on the [ColorPickerType] enum that includes
/// values `both`, `primary`, `accent`, `bw`, `custom`, `customSecondary` and
/// `wheel`.
///
/// By default, a map that sets primary and accent pickers to true, and other
/// pickers to false, is used.
///
/// To modify key-value enable/disable pairs, you only have to provide values
/// for the pairs you want to change from their default value. Any missing
/// key-value pair in the provided map will keep their default value.
///
/// ## [enableShadesSelection]
///
/// Set to true to allow selection of color swatch shades.
///
/// If false, only the main color from a swatch is shown and can be selected.
/// This is index `500` for Material primary colors and index `200` for accent
/// colors. On the wheel, only the selected color is shown; there is no
/// related color swatch of the selected color shown.
///
/// Defaults to true.
///
/// ## [includeIndex850]
///
/// There is an extra index `850` used only by grey Material color in Flutter.
/// If you want to include it in the grey color shades selection, then set
/// this property to true.
///
/// Defaults to false.
///
/// ## [enableTonalPalette]
///
/// Set to true to allow selection of a color tone from a tonal palette.
///
/// When true, the color picker uses Material 3 color utilities to compute a
/// tonal palette for the selected color, so you can pick a tone from that
/// palette.
///
/// For more info on the Material 3 color system, see:
/// https://m3.material.io/styles/color/the-color-system/key-colors-tones
///
/// Tonal palette indicator items are 10/13 the size of [width] and [height],
/// so their total width more closely matches the Material primary swatch
/// (10 colors) when both palettes are shown. The Material 3 tonal palette has
/// 13 colors.
///
/// Defaults to false.
///
/// ## [tonalPaletteFixedMinChroma]
///
/// Whether the tonal palette uses a fixed minimum chroma value for all tones
/// or the chroma of the selected color.
///
/// Prior to version 3.6.0 the tonal palette used a minimum chroma of 48 or
/// the chroma of the selected color. That matched Flutter's
/// [ColorScheme.fromSeed] primary tonal palette behavior before Flutter
/// 3.22.0.
///
/// Starting from version 3.6.0, FlexColorPicker creates an HCT tonal palette
/// using whatever hue and chroma is in the selected color.
///
/// Set this to true to restore the old behavior (fixed minimum chroma 48 for
/// all tones).
///
/// Defaults to false.
///
/// ## [mainAxisSize]
///
/// How much space should be occupied in the color picker's vertical axis.
///
/// After allocating space to children, the [ColorPicker] column may have
/// remaining free space. This value controls whether to maximize or minimize
/// that space, subject to the incoming layout constraints.
///
/// If some children have non-zero flex factors (and none have a fit of
/// [FlexFit.loose]), they expand to consume all available space and there is
/// no remaining free space, making this value irrelevant to the final layout.
///
/// Defaults to [MainAxisSize.max], like [Column].
///
/// ## [crossAxisAlignment]
///
/// Cross-axis alignment used to lay out the main content of the color picker
/// in its column layout.
///
/// Defaults to [CrossAxisAlignment.center].
///
/// ## [padding]
///
/// Padding around the entire color picker content.
///
/// Defaults to `const EdgeInsets.all(16)`.
///
/// ## [columnSpacing]
///
/// Vertical spacing between items in the color picker column.
///
/// Defaults to 8 dp. Must be from 0 to 300 dp.
///
/// ## [toolbarSpacing]
///
/// Vertical spacing below the top toolbar header and action buttons.
///
/// If not defined, defaults to [columnSpacing]. Must be null or from 0 to
/// 300 dp.
///
/// ## [shadesSpacing]
///
/// Vertical spacing below the Material 2 based color shades palette.
///
/// If not defined, defaults to [columnSpacing]. Must be null or from 0 to
/// 300 dp.
///
/// ## [enableOpacity]
///
/// Enable the opacity control for the color value.
///
/// Set to true to allow users to control the opacity of the selected color.
/// The displayed opacity on the slider goes from 0% (fully transparent) to
/// 100% (fully opaque).
///
/// When enabled, opacity is not returned as a separate value; it is in the
/// alpha channel of the returned ARGB color in the on-color callbacks.
///
/// Defaults to false.
///
/// ## [opacityTrackHeight]
///
/// The height of the opacity slider track.
///
/// Defaults to 36 dp.
///
/// ## [opacityTrackWidth]
///
/// The width of the opacity slider track.
///
/// If null, the slider expands to the available width of the picker. If not
/// null, it must be >= 150 dp.
///
/// ## [opacityThumbRadius]
///
/// The radius of the thumb on the opacity slider.
///
/// Defaults to 16 dp.
///
/// ## [actionButtons]
///
/// Used to configure action buttons for the color picker dialog.
///
/// Defaults to [ColorPickerActionButtons].
///
/// ## [copyPasteBehavior]
///
/// Used to configure the copy-paste behavior of the color picker.
///
/// Defaults to [ColorPickerCopyPasteBehavior].
///
/// ## [selectedColorIcon]
///
/// Icon used to indicate the selected color.
///
/// Size is 60% of the smaller of [width] and [height]. The icon color is
/// black or white, based on contrast with the selected color.
///
/// Defaults to [Icons.check].
///
/// ## [width]
///
/// Width of the color indicator items.
///
/// Defaults to 40 dp. Must be from 15 to 150 dp.
///
/// ## [height]
///
/// Height of the color indicator items.
///
/// Defaults to 40 dp. Must be from 15 to 150 dp.
///
/// ## [tonalColorSameSize]
///
/// Set to true to make tonal color items the same size as the main and swatch
/// shade indicator items.
///
/// If false, tonal items are smaller and auto-sized so the palette width
/// matches the Material 2 color palette.
///
/// Defaults to false for legacy compatibility. Prefer true if you only use
/// the tonal palette and want matching item sizes.
///
/// ## [spacing]
///
/// Horizontal spacing between the color picker indicator items.
///
/// Defaults to 4 dp. Must be from 0 to 50 dp.
///
/// ## [runSpacing]
///
/// Space between color picker item rows when they wrap to multiple rows.
///
/// Defaults to 4 dp. Must be from 0 to 50 dp.
///
/// ## [elevation]
///
/// Material elevation of the color indicator items.
///
/// Defaults to 0 dp. Must be >= 0.
///
/// ## [hasBorder]
///
/// Set to true to show a 1 dp border around the color indicator items.
///
/// Useful if the white/near-white and black/near-black shades picker is
/// enabled.
///
/// Defaults to false.
///
/// ## [borderRadius]
///
/// Border radius of the color indicator items.
///
/// If null, defaults to [width]/4. Must be from 0 to 50 dp if not null.
///
/// ## [borderColor]
///
/// Color of the 1 dp optional border used on [ColorIndicator] and
/// [ColorWheelPicker] when each has its border toggle set to true.
///
/// If no color is given, defaults to `Theme.of(context).dividerColor`.
///
/// ## [wheelDiameter]
///
/// Diameter of the HSV based color wheel picker.
///
/// Defaults to 190 dp. Must be from 100 to 500 dp.
///
/// ## [wheelWidth]
///
/// Stroke width of the color wheel circle.
///
/// Defaults to 16 dp. Must be from 4 to 50 dp.
///
/// ## [wheelSquarePadding]
///
/// Padding between the shade square inside the hue wheel and the inner side
/// of the wheel.
///
/// Keep it reasonable relative to [wheelDiameter] and [wheelWidth]; values
/// from 0 to 20 are recommended.
///
/// Defaults to 0 dp.
///
/// ## [wheelSquareBorderRadius]
///
/// Border radius of the shade square inside the hue wheel.
///
/// Visual only: the thumb center still reaches the square box corner. Edge
/// color shades remain in the sharp corner even if not shown.
///
/// Recommended values 0 to 16. Defaults to 4 dp.
///
/// ## [wheelHasBorder]
///
/// Set to true to show a 1 dp border around the color wheel.
///
/// Defaults to false.
///
/// ## [title]
///
/// Title widget for the color picker toolbar.
///
/// Typically a [Text] widget, e.g. `Text('ColorPicker')`. If null, there is
/// no title on the toolbar.
///
/// Can be used instead of [heading] or together with it. At the end of the
/// title, 1 to 4 action buttons may be present for copy, paste, select-close
/// and cancel-close. Select-close and cancel-close should only be enabled when
/// the picker is used in a dialog. Copy and paste can be enabled when it is
/// not in a dialog.
///
/// ## [heading]
///
/// Heading widget for the color picker.
///
/// Typically a [Text] widget, e.g. `Text('Select color')`. If null, there is
/// no heading.
///
/// ## [subheading]
///
/// Subheading widget for the color shades selection.
///
/// Typically a [Text] widget, e.g. `Text('Select color shade')`. If null,
/// there is no subheading for the color shades.
///
/// ## [tonalSubheading]
///
/// Subheading widget for the color tone selection.
///
/// Typically a [Text] widget, e.g. `Text('Select color shade')`. If null,
/// there is no subheading for the tonal palette.
///
/// ## [wheelSubheading]
///
/// Subheading widget for the HSV color wheel picker.
///
/// Typically a [Text] widget, e.g.
/// `Text('Selected color and its material like shades')`.
///
/// The wheel uses a separate subheading because its use case differs from the
/// other subheadings. If not provided, there is no subheading for the wheel.
///
/// ## [recentColorsSubheading]
///
/// Subheading widget for the recently used colors.
///
/// Typically a [Text] widget, e.g. `Text('Recent colors')`. If null, there is
/// no subheading. Not shown even if provided when [showRecentColors] is false.
///
/// ## [opacitySubheading]
///
/// Subheading widget for the opacity slider.
///
/// Typically a [Text] widget, e.g. `Text('Opacity')`. If null, there is no
/// subheading. Not shown even if provided when [enableOpacity] is false.
///
/// ## [showMaterialName]
///
/// Set to true to show the Material name and index of the selected color.
///
/// Defaults to false.
///
/// ## [materialNameTextStyle]
///
/// Text style for the displayed Material color name.
///
/// Defaults to `Theme.of(context).textTheme.bodyMedium` if not defined.
///
/// ## [showColorName]
///
/// Set to true to show an English color name of the selected color.
///
/// Uses [ColorTools.nameThatColor] (1566 named codes) to find the closest
/// match and return its name.
///
/// Defaults to false.
///
/// ## [colorNameTextStyle]
///
/// Text style for the displayed color name.
///
/// Defaults to `Theme.of(context).textTheme.bodyMedium` if not defined.
///
/// ## [showColorCode]
///
/// Set to true to show the RGB hex color code of the selected color.
///
/// The code can be copied with the copy icon or other enabled copy actions.
/// On the wheel picker it can be edited to enter a known RGB hex value,
/// unless [colorCodeReadOnly] is true.
///
/// Defaults to false.
///
/// ## [colorCodeHasColor]
///
/// When true, the color code entry field uses the currently selected color as
/// its background.
///
/// That makes the field a large current-color indicator. Text color adjusts
/// for contrast, as does the opacity indicator text. Enabling this overrides
/// any color in [colorCodeTextStyle] and [colorCodePrefixStyle], but other
/// style properties are kept.
///
/// Defaults to false.
///
/// ## [showEditIconButton]
///
/// Whether to show an edit icon button before the color code field.
///
/// Gives a visual cue that the field can be edited. Shown only when the wheel
/// picker is active and [colorCodeReadOnly] is false. Tapping the button
/// focuses the color code entry field.
///
/// Defaults to false.
///
/// ## [editIcon]
///
/// Icon to use on the edit icon button.
///
/// Defaults to [Icons.edit].
///
/// ## [focusedEditHasNoColor]
///
/// Whether the color code entry field should have no color when focused.
///
/// If [colorCodeHasColor] is true, the field also acts as a large color
/// indicator, which can make editing confusing as the field color changes
/// while you type. Set this to true to keep the field uncolored during
/// value entry.
///
/// Defaults to false.
///
/// ## [colorCodeTextStyle]
///
/// Text style for the displayed color code.
///
/// Defaults to `Theme.of(context).textTheme.bodyMedium` if not defined.
///
/// ## [colorCodePrefixStyle]
///
/// Text style of the prefix of the color code.
///
/// The prefix always includes the alpha value and may include `#` or `0x`
/// based on [ColorPickerCopyPasteBehavior.copyFormat].
///
/// Defaults to [colorCodeTextStyle] if not defined.
///
/// ## [colorCodeReadOnly]
///
/// When true, the color code field is always read only.
///
/// Normally it can be edited on pickers that can select any color (currently
/// the wheel picker; also future full-range pickers). Fixed palettes are
/// always read only; this setting does not affect them.
///
/// Regardless of picker and this value, you can still change the color by
/// pasting if copy-paste configuration allows it.
///
/// Defaults to false.
///
/// ## [showColorValue]
///
/// Set to true to show the int [Color] value of the selected color.
///
/// A developer feature. Shown after the color code, using
/// [colorCodeTextStyle]. There is no copy button; the value is in a
/// [SelectableText] widget so it can be selected and copied.
///
/// Defaults to false.
///
/// ## [showRecentColors]
///
/// Set to true to show a list of recently selected colors at the bottom of
/// the picker.
///
/// Uses first-in, first-out to keep 2 to 20 colors (default 5) on the list.
/// The max can be changed with [maxRecentColors].
///
/// Defaults to false.
///
/// ## [maxRecentColors]
///
/// Maximum number of recent colors to show.
///
/// Must be from 2 to 20. Defaults to 5.
///
/// ## [recentColors]
///
/// Starting list of recently selected colors.
///
/// Defaults to an empty list. You can provide a stored state if desired.
///
/// ## [enableTooltips]
///
/// Set to true to enable all tooltips in this widget.
///
/// If tooltips get in the way, set this to false. Consider exposing this as
/// an app setting so users can turn tooltips on and off.
///
/// Defaults to true.
///
/// ## [selectedPickerTypeColor]
///
/// Color on the thumb of the slider that shows the selected picker type.
///
/// If not defined, defaults to `Color(0xFFFFFFFF)` (white) in light theme and
/// `Color(0xFF636366)` in dark theme, the defaults for
/// [CupertinoSlidingSegmentedControl].
///
/// A custom color causes the picker to adjust the selected thumb text color
/// for contrast.
///
/// ## [pickerTypeTextStyle]
///
/// Text style of the labels in the segmented color picker type selector.
///
/// Defaults to `Theme.of(context).textTheme.bodySmall` if not defined.
///
/// ## [pickerTypeLabels]
///
/// A [ColorPickerType] to [String] map with labels for the picker type
/// selector.
///
/// If not defined, or omitted in the provided map, these English defaults
/// are used:
///  * [ColorPickerType.both] : 'Primary & Accent'
///  * [ColorPickerType.primary] : 'Primary'
///  * [ColorPickerType.accent] : 'Accent'
///  * [ColorPickerType.bw] : 'Black & White'
///  * [ColorPickerType.custom] : 'Custom'
///  * [ColorPickerType.customSecondary] : 'Option'
///  * [ColorPickerType.wheel] : 'Wheel'
///
/// ## [customColorSwatchesAndNames]
///
/// Color swatch to name map for the custom color picker.
///
/// Provides custom [ColorSwatch] objects and their name labels, used when
/// [ColorPickerType.custom] is enabled.
///
/// Defaults to an empty map. If empty, the custom colors picker is not shown
/// even if it is enabled in [pickersEnabled].
///
/// ## [customSecondaryColorSwatchesAndNames]
///
/// Color swatch to name map for the secondary custom color picker.
///
/// Used when [ColorPickerType.customSecondary] is enabled.
///
/// Defaults to an empty map. If empty, that picker is not shown even if it
/// is enabled in [pickersEnabled].
///
/// ## [dialogTitle]
///
/// Title of the color picker dialog, often omitted in favor of using [title]
/// and/or [heading] already defined on the picker.
///
/// ## [titlePadding]
///
/// Padding around the dialog title, if a title is used.
///
/// Defaults to [EdgeInsets.zero], since the title is normally omitted and
/// provided via [heading] instead.
///
/// ## [titleTextStyle]
///
/// Style for the text in the dialog [dialogTitle] of this [AlertDialog].
///
/// If null, `DialogTheme.titleTextStyle` is used. If that is null, defaults
/// to [TextTheme.titleLarge] of [ThemeData.textTheme].
///
/// ## [contentPadding]
///
/// Padding around the content in the dialog.
///
/// Defaults to [EdgeInsets.zero], as content padding is expected to be part
/// of the [ColorPicker].
///
/// ## [actionsPadding]
///
/// Padding around the Cancel and OK action buttons at the bottom of the
/// dialog, between the button bar and the dialog edges.
///
/// Defaults to null and follows ambient [AlertDialog] themed actions padding
/// or the [AlertDialog] default if not defined.
///
/// Versions before FlexColorPicker 3.0.0 defaulted to
/// `EdgeInsets.symmetric(horizontal: 16)`; use that for the same padding as
/// in previous versions.
///
/// ## [buttonPadding]
///
/// Padding that surrounds each bottom action button.
///
/// Different from [actionsPadding], which pads the entire button bar.
///
/// Defaults to null and follows ambient [AlertDialog] themed button padding
/// or the [AlertDialog] default if not defined.
///
/// Versions before FlexColorPicker 3.0.0 defaulted to `EdgeInsets.all(16)`;
/// use that for the same button padding as in previous versions.
///
/// ## [backgroundColor]
///
/// Background color of the dialog surface (`Material.color`).
///
/// If null, `ThemeData.dialogBackgroundColor` is used.
///
/// The color picker is designed for a background brightness that follows the
/// active theme mode. White in dark theme, for example, will not produce
/// usable results.
///
/// ## [dialogElevation]
///
/// Z-coordinate of this dialog.
///
/// If null, `DialogTheme.elevation` is used, and if that is null the dialog
/// elevation is 24.0. Controls shadow size and elevation overlay opacity.
/// If non-zero, contents are clipped. Changing the value animates the shadow
/// and overlay over `Material.animationDuration`.
///
/// Defaults to 0.
///
/// ## [shadowColor]
///
/// Color used to paint a drop shadow under the dialog's [Material], reflecting
/// the dialog's elevation.
///
/// ## [surfaceTintColor]
///
/// Color used as a surface tint overlay on the dialog's background color,
/// reflecting the dialog's elevation.
///
/// ## [semanticLabel]
///
/// Semantic label used by accessibility frameworks when the dialog opens and
/// closes.
///
/// On iOS, if not provided, a label is inferred from [dialogTitle] if it is
/// not null. On Android, if not provided, the dialog uses
/// [MaterialLocalizations.alertDialogLabel].
///
/// See also:
///
///  * [SemanticsConfiguration.namesRoute], for how this value is used.
///
/// ## [insetPadding]
///
/// Padding added to `MediaQueryData.viewInsets` on the outside of the
/// [ColorPicker] dialog.
///
/// Minimum space between the screen edges and the dialog. Defaults to
/// `EdgeInsets.symmetric(horizontal: 40, vertical: 24)`.
///
/// ## [clipBehavior]
///
/// How the dialog contents are clipped (or not) to the given shape.
///
/// See [Clip] for options and common use cases. Defaults to [Clip.none].
///
/// ## [shape]
///
/// Shape of this dialog's border (`Material.shape`).
///
/// The default shape is a [RoundedRectangleBorder] with a radius of 4.0.
///
/// ## [barrierDismissible]
///
/// If true, the dialog can be closed by clicking outside it.
///
/// Defaults to true.
///
/// ## [barrierColor]
///
/// Background transparency color of the dialog barrier.
///
/// Defaults to [Colors.black12], lighter than the standard [Colors.black54],
/// so you can see the impact of the selected color on the app behind the
/// dialog. Set [Colors.black54] if that is not desired, or make it even more
/// transparent (including fully transparent).
///
/// ## [barrierLabel]
///
/// Semantic label used for a dismissible barrier. Defaults to null.
///
/// ## [useSafeArea]
///
/// If true, the dialog only displays in safe areas of the screen not used by
/// the operating system (see [SafeArea]).
///
/// Defaults to true. If false, the dialog is constrained only by the screen
/// size.
///
/// ## [routeSettings]
///
/// Passed to [showGeneralDialog]; see [RouteSettings] for details.
///
/// ## [anchorPoint]
///
/// Offset [anchorPoint] for the dialog.
///
/// ## [transitionBuilder]
///
/// Defines how the route arrives on and leaves the screen.
///
/// If not specified, the default Material platform transition builder for
/// [showDialog] is used.
///
/// ## [transitionDuration]
///
/// How long it takes for the route to arrive on or leave the screen.
///
/// Only has an effect when a custom [transitionBuilder] is used. Defaults to
/// 200 milliseconds.
///
/// ## [constraints]
///
/// [BoxConstraints] to constrain the size of the dialog.
///
/// You typically want at least a height constraint, otherwise the dialog
/// height can jump when the user changes picker type. After you have sizes
/// that work for all active pickers, prefer a fixed dialog size over letting
/// the dialog auto-size (which it does if no constraints are defined).
Future<Color> showColorPickerDialog(
  /// Required build context for the dialog.
  BuildContext context,

  /// Active color selection when the dialog is created.
  Color color, {

  /// Which pickers are enabled. Missing keys keep their defaults.
  Map<ColorPickerType, bool> pickersEnabled = const <ColorPickerType, bool>{
    ColorPickerType.both: false,
    ColorPickerType.primary: true,
    ColorPickerType.accent: true,
    ColorPickerType.bw: false,
    ColorPickerType.custom: false,
    ColorPickerType.wheel: false,
  },

  /// Allow selection of color swatch shades. Defaults to true.
  bool enableShadesSelection = true,

  /// Include Material grey index `850`. Defaults to false.
  bool includeIndex850 = false,

  /// Allow selection from a Material 3 tonal palette. Defaults to false.
  bool enableTonalPalette = false,

  /// Use fixed min chroma 48 for all tonal tones (pre-3.6.0). Defaults to false.
  bool tonalPaletteFixedMinChroma = false,

  /// Vertical free space in the picker column. Defaults to [MainAxisSize.max].
  MainAxisSize mainAxisSize = MainAxisSize.max,

  /// Cross-axis alignment of the picker column. Defaults to center.
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,

  /// Padding around the entire picker content.
  EdgeInsetsGeometry padding = const EdgeInsets.all(16),

  /// Vertical spacing between column items. 0 to 300 dp, default 8.
  double columnSpacing = 8,

  /// Spacing below the toolbar. Null uses `columnSpacing`. 0 to 300 dp.
  double? toolbarSpacing,

  /// Spacing below the Material 2 shades palette. Null uses `columnSpacing`.
  double? shadesSpacing,

  /// Enable opacity slider; alpha is returned in the ARGB color. Defaults to false.
  bool enableOpacity = false,

  /// Opacity slider track height. Defaults to 36 dp.
  double opacityTrackHeight = 36,

  /// Opacity slider track width. Null fills available width; else >= 150 dp.
  double? opacityTrackWidth,

  /// Opacity slider thumb radius. Defaults to 16 dp.
  double opacityThumbRadius = 16,

  /// Dialog OK/Cancel action button configuration.
  ColorPickerActionButtons actionButtons = const ColorPickerActionButtons(),

  /// Copy-paste behavior for the picker.
  ColorPickerCopyPasteBehavior copyPasteBehavior = const ColorPickerCopyPasteBehavior(),

  /// Icon on the selected color indicator. Defaults to [Icons.check].
  IconData selectedColorIcon = Icons.check,

  /// Color indicator width. 15 to 150 dp, default 40.
  double width = 40.0,

  /// Color indicator height. 15 to 150 dp, default 40.
  double height = 40.0,

  /// Make tonal items the same size as main/swatch items. Defaults to false.
  bool tonalColorSameSize = false,

  /// Horizontal spacing between indicator items. 0 to 50 dp, default 4.
  double spacing = 4,

  /// Run spacing when indicator rows wrap. 0 to 50 dp, default 4.
  double runSpacing = 4,

  /// Indicator item elevation. Must be >= 0, default 0.
  double elevation = 0,

  /// Draw a 1 dp border around indicator items. Defaults to false.
  bool hasBorder = false,

  /// Indicator border radius. Null uses `width`/4; else 0 to 50 dp.
  double? borderRadius,

  /// Border color for indicators and wheel. Null uses theme divider color.
  Color? borderColor,

  /// HSV wheel diameter. 100 to 500 dp, default 190.
  double wheelDiameter = 190,

  /// Color wheel stroke width. 4 to 50 dp, default 16.
  double wheelWidth = 16,

  /// Padding between wheel shade square and inner wheel. Default 0 dp.
  double wheelSquarePadding = 0,

  /// Border radius of the wheel shade square. Default 4 dp.
  double wheelSquareBorderRadius = 4,

  /// Draw a 1 dp border around the color wheel. Defaults to false.
  bool wheelHasBorder = false,

  /// Toolbar title widget; may sit beside copy/paste/close actions.
  Widget? title,

  /// Heading widget above the picker. Null means no heading.
  Widget? heading,

  /// Subheading for color shades. Null means none.
  Widget? subheading,

  /// Subheading for tonal tones. Null means none.
  Widget? tonalSubheading,

  /// Subheading for the HSV wheel. Null means none.
  Widget? wheelSubheading,

  /// Subheading for recent colors. Hidden when `showRecentColors` is false.
  Widget? recentColorsSubheading,

  /// Subheading for the opacity slider. Hidden when `enableOpacity` is false.
  Widget? opacitySubheading,

  /// Show Material name and index of the selected color. Defaults to false.
  bool showMaterialName = false,

  /// Text style for the Material color name.
  TextStyle? materialNameTextStyle,

  /// Show English name via `ColorTools.nameThatColor`. Defaults to false.
  bool showColorName = false,

  /// Text style for the English color name.
  TextStyle? colorNameTextStyle,

  /// Show RGB hex code; editable on the wheel unless `colorCodeReadOnly`.
  bool showColorCode = false,

  /// Use selected color as the code field background. Defaults to false.
  bool colorCodeHasColor = false,

  /// Show edit icon before the code field on the wheel. Defaults to false.
  bool showEditIconButton = false,

  /// Icon for the edit button. Defaults to [Icons.edit].
  IconData editIcon = Icons.edit,

  /// Keep the code field uncolored while focused. Defaults to false.
  bool focusedEditHasNoColor = false,

  /// Text style for the color code.
  TextStyle? colorCodeTextStyle,

  /// Text style for the color code prefix (`#` / `0x` / alpha).
  TextStyle? colorCodePrefixStyle,

  /// Always keep the color code field read only. Defaults to false.
  bool colorCodeReadOnly = false,

  /// Show the int color value after the hex code. Defaults to false.
  bool showColorValue = false,

  /// Show recent colors at the bottom. Defaults to false.
  bool showRecentColors = false,

  /// Max recent colors, 2 to 20. Defaults to 5.
  int maxRecentColors = 5,

  /// Starting recent colors list. Defaults to empty.
  List<Color> recentColors = const <Color>[],

  /// Enable all picker tooltips. Defaults to true.
  bool enableTooltips = true,

  /// Thumb color of the picker-type selector.
  Color? selectedPickerTypeColor,

  /// Text style of picker-type selector labels.
  TextStyle? pickerTypeTextStyle,

  /// Labels for the picker-type selector. Missing keys use English defaults.
  Map<ColorPickerType, String> pickerTypeLabels = const <ColorPickerType, String>{
    ColorPickerType.primary: ColorPicker._selectPrimaryLabel,
    ColorPickerType.accent: ColorPicker._selectAccentLabel,
    ColorPickerType.bw: ColorPicker._selectBlackWhiteLabel,
    ColorPickerType.both: ColorPicker._selectBothLabel,
    ColorPickerType.custom: ColorPicker._selectCustomLabel,
    ColorPickerType.wheel: ColorPicker._selectWheelAnyLabel,
  },

  /// Custom swatches and names for `ColorPickerType.custom`.
  Map<ColorSwatch<Object>, String> customColorSwatchesAndNames = const <ColorSwatch<Object>, String>{},

  /// Custom swatches and names for `ColorPickerType.customSecondary`.
  Map<ColorSwatch<Object>, String> customSecondaryColorSwatchesAndNames = const <ColorSwatch<Object>, String>{},

  /// Dialog title; often omitted in favor of picker `title` / `heading`.
  Widget? dialogTitle,

  /// Padding around the dialog title. Defaults to [EdgeInsets.zero].
  EdgeInsetsGeometry titlePadding = EdgeInsets.zero,

  /// Style for the dialog title text.
  TextStyle? titleTextStyle,

  /// Padding around dialog content. Defaults to [EdgeInsets.zero].
  EdgeInsetsGeometry contentPadding = EdgeInsets.zero,

  /// Padding around the dialog action button bar.
  EdgeInsetsGeometry? actionsPadding,

  /// Padding around each dialog action button.
  EdgeInsetsGeometry? buttonPadding,

  /// Dialog surface background color.
  Color? backgroundColor,

  /// Dialog elevation. Null uses theme; documented default 0.
  double? dialogElevation,

  /// Drop shadow color under the dialog.
  Color? shadowColor,

  /// Surface tint overlay color for dialog elevation.
  Color? surfaceTintColor,

  /// Accessibility label for dialog open/close.
  String? semanticLabel,

  /// Minimum inset from screen edges to the dialog.
  EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: 40, vertical: 24),

  /// How dialog contents clip to `shape`. Defaults to [Clip.none].
  Clip clipBehavior = Clip.none,

  /// Dialog border shape.
  ShapeBorder? shape,

  /// Close the dialog by tapping outside it. Defaults to true.
  bool barrierDismissible = true,

  /// Barrier color. Defaults to [Colors.black12].
  Color barrierColor = Colors.black12,

  /// Semantic label for a dismissible barrier.
  String? barrierLabel,

  /// Only show the dialog in [SafeArea]. Defaults to true.
  bool useSafeArea = true,

  /// Route settings passed to [showGeneralDialog].
  RouteSettings? routeSettings,

  /// Dialog anchor point.
  Offset? anchorPoint,

  /// Custom show/hide route transition. Null uses Material [showDialog].
  RouteTransitionsBuilder? transitionBuilder,

  /// Transition duration; only used with `transitionBuilder`. Default 200 ms.
  Duration transitionDuration = const Duration(milliseconds: 200),

  /// Size constraints for the dialog; recommended to avoid height jumps.
  BoxConstraints? constraints,
}) async {
  Color selectedColor = color;
  if (!(await ColorPicker(
    color: color,
    onColorChanged: (Color newColor) {
      selectedColor = newColor;
    },
    pickersEnabled: pickersEnabled,
    enableShadesSelection: enableShadesSelection,
    includeIndex850: includeIndex850,
    enableTonalPalette: enableTonalPalette,
    tonalPaletteFixedMinChroma: tonalPaletteFixedMinChroma,
    crossAxisAlignment: crossAxisAlignment,
    mainAxisSize: mainAxisSize,
    padding: padding,
    columnSpacing: columnSpacing,
    toolbarSpacing: toolbarSpacing,
    shadesSpacing: shadesSpacing,
    enableOpacity: enableOpacity,
    opacityTrackHeight: opacityTrackHeight,
    opacityTrackWidth: opacityTrackWidth,
    opacityThumbRadius: opacityThumbRadius,
    actionButtons: actionButtons,
    copyPasteBehavior: copyPasteBehavior,
    selectedColorIcon: selectedColorIcon,
    width: width,
    height: height,
    spacing: spacing,
    tonalColorSameSize: tonalColorSameSize,
    runSpacing: runSpacing,
    elevation: elevation,
    hasBorder: hasBorder,
    borderRadius: borderRadius,
    borderColor: borderColor,
    wheelDiameter: wheelDiameter,
    wheelWidth: wheelWidth,
    wheelSquarePadding: wheelSquarePadding,
    wheelSquareBorderRadius: wheelSquareBorderRadius,
    wheelHasBorder: wheelHasBorder,
    title: title,
    heading: heading,
    subheading: subheading,
    tonalSubheading: tonalSubheading,
    wheelSubheading: wheelSubheading,
    recentColorsSubheading: recentColorsSubheading,
    opacitySubheading: opacitySubheading,
    showMaterialName: showMaterialName,
    materialNameTextStyle: materialNameTextStyle,
    showColorName: showColorName,
    colorNameTextStyle: colorNameTextStyle,
    showColorCode: showColorCode,
    colorCodeHasColor: colorCodeHasColor,
    showEditIconButton: showEditIconButton,
    editIcon: editIcon,
    focusedEditHasNoColor: focusedEditHasNoColor,
    colorCodeTextStyle: colorCodeTextStyle,
    colorCodePrefixStyle: colorCodePrefixStyle,
    colorCodeReadOnly: colorCodeReadOnly,
    showColorValue: showColorValue,
    showRecentColors: showRecentColors,
    maxRecentColors: maxRecentColors,
    recentColors: recentColors,
    enableTooltips: enableTooltips,
    selectedPickerTypeColor: selectedPickerTypeColor,
    pickerTypeTextStyle: pickerTypeTextStyle,
    pickerTypeLabels: pickerTypeLabels,
    customColorSwatchesAndNames: customColorSwatchesAndNames,
    customSecondaryColorSwatchesAndNames: customSecondaryColorSwatchesAndNames,
  ).showPickerDialog(
    context,
    title: dialogTitle,
    titlePadding: titlePadding,
    titleTextStyle: titleTextStyle,
    contentPadding: contentPadding,
    actionsPadding: actionsPadding,
    buttonPadding: buttonPadding,
    backgroundColor: backgroundColor,
    elevation: dialogElevation,
    shadowColor: shadowColor,
    surfaceTintColor: surfaceTintColor,
    semanticLabel: semanticLabel,
    insetPadding: insetPadding,
    clipBehavior: clipBehavior,
    shape: shape,
    barrierColor: barrierColor,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel,
    useSafeArea: useSafeArea,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    transitionBuilder: transitionBuilder,
    transitionDuration: transitionDuration,
    constraints: constraints,
  ))) {
    selectedColor = color;
  }
  return selectedColor;
}
