import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

import 'alignment_switch.dart';
import 'copy_format_switch.dart';
import 'maybe_tooltip.dart';
import 'switch_tile_tooltip.dart';

// Max width of the body content when used on a wide screen.
const double kMaxBodyWidth = 2100;
const double kMinColumnWidth = 440;

class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({Key? key}) : super(key: key);

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  ColorPickerCopyFormat copyFormat = ColorPickerCopyFormat.dartCode;

  // Show and hide
  static Map<ColorPickerType, bool> pickersEnabled = <ColorPickerType, bool>{
    ColorPickerType.both: false,
    ColorPickerType.primary: true,
    ColorPickerType.accent: true,
    ColorPickerType.bw: false,
    ColorPickerType.custom: true,
    ColorPickerType.wheel: true,
  };
  bool enableShadesSelection = true;
  bool includeIndex850 = false;

  bool showTitle = true;
  bool showHeading = true;
  bool showSubheading = true;
  bool showRecentSubheading = true;

  bool showMaterialName = true;
  bool showColorName = true;
  bool showColorCode = true;
  bool showColorValue = false;
  bool colorCodeHasColor = false;
  bool colorCodeReadOnly = false;
  bool showRecentColors = true;

  // Picker design
  double size = 40;
  double borderRadius = 4;
  double elevation = 0;
  double spacing = 4;
  double runSpacing = 4;
  bool hasBorder = true;

  double wheelDiameter = 190;
  double wheelWidth = 16;
  bool wheelHasBorder = false;

  // Picker layout
  CrossAxisAlignment alignment = CrossAxisAlignment.center;
  double padding = 10;
  double columnSpacing = 8;
  bool okButton = true;
  bool closeButton = true;
  bool dialogActionButtons = true;
  bool dialogActionIcons = true;
  bool enableTooltips = true;

  // Copy paste actions
  bool ctrlC = true;
  bool ctrlV = true;
  bool copyButton = true;
  bool pasteButton = true;
  bool editFieldCopyButton = true;
  bool longPressMenu = true;
  bool secondaryMenu = true;
  bool secondaryOnDesktopLongOnDevice = true;
  bool parseShortHexCode = true;
  bool editUsesParsedPaste = true;
  bool snackBarParseError = true;
  bool feedbackParseError = false;

  // Selected colors as local state, set via initState.
  late Color screenPickerColor;
  late Color dialogPickerColor;
  late Color onColorChangeStart;
  late Color onColorChanged;
  late Color onColorChangeEnd;

  List<Color> screenRecentColors = <Color>[];
  List<Color> dialogRecentColors = <Color>[];

  static const double _pickItemMinSize = 20;
  static const double _pickItemMaxSize = 60;
  static const double _kToggleFontSize = 11;
  static const List<Widget> _toggleButtons = <Widget>[
    Text('Primary\nAccent',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _kToggleFontSize)),
    Text('Primary', style: TextStyle(fontSize: _kToggleFontSize)),
    Text('Accent', style: TextStyle(fontSize: _kToggleFontSize)),
    Text('Black\nWhite',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: _kToggleFontSize)),
    Text('Custom ', style: TextStyle(fontSize: _kToggleFontSize)),
    Text('Wheel', style: TextStyle(fontSize: _kToggleFontSize)),
  ];

  final List<bool> toggleButtonIsSelected = pickersEnabled.values.toList();

  // Define some custom colors to be used in the custom segment.
  static const Color guideNewPrimary = Color(0xFF6200EE);
  static const Color guideNewPrimaryVariant = Color(0xFF3700B3);
  static const Color guideNewSecondary = Color(0xFF03DAC6);
  static const Color guideNewSecondaryVariant = Color(0xFF018786);
  static const Color guideNewError = Color(0xFFB00020);
  static const Color guideNewErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);
  static const Color clearBlue = Color(0xFF3db5e0);
  static const Color darkPink = Color(0xFFa33e94);
  static const Color redWine = Color(0xFFad0c1c);
  static const Color grassGreen = Color(0xFF3bb87f);
  static const Color moneyGreen = Color(0xFF869962);
  static const Color mandarinOrange = Color(0xFFdb7a25);
  static const Color brightOrange = Color(0xFFff5319);
  static const Color brightGreen = Color(0xFF00ab25);
  static const Color blueJean = Color(0xFF4f75b8);
  static const Color deepBlueSea = Color(0xFF132b80);

  // Make a custom color swatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guideNewPrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guideNewPrimaryVariant):
        'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideNewSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideNewSecondaryVariant):
        'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideNewError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideNewErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
    ColorTools.createPrimarySwatch(clearBlue): 'Clear blue',
    ColorTools.createPrimarySwatch(darkPink): 'Dark pink',
    ColorTools.createPrimarySwatch(redWine): 'Red wine',
    ColorTools.createPrimarySwatch(grassGreen): 'Grass green',
    ColorTools.createPrimarySwatch(moneyGreen): 'Money green',
    ColorTools.createPrimarySwatch(mandarinOrange): 'Mandarin orange',
    ColorTools.createPrimarySwatch(brightOrange): 'Bright orange',
    ColorTools.createPrimarySwatch(brightGreen): 'Bright green',
    ColorTools.createPrimarySwatch(blueJean): 'Washed jean blue',
    ColorTools.createPrimarySwatch(deepBlueSea): 'Deep blue sea',
  };

  @override
  void initState() {
    screenPickerColor = Colors.blue;
    dialogPickerColor = Colors.red;
    onColorChangeStart = onColorChanged = onColorChangeEnd = screenPickerColor;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Used for a simple scrollable column based responsive layout
    final double width = MediaQuery.of(context).size.width;

    // That can have 1 to max 4 columns
    int columns = width ~/ kMinColumnWidth;
    if (columns < 1) columns = 1;
    if (columns > 4) columns = 4;

    // The theme colorscheme is referenced many times, so we use a ref to it.
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final Color onColorChangeStartOnColor =
        ThemeData.estimateBrightnessForColor(onColorChangeStart) ==
                Brightness.light
            ? Colors.black
            : Colors.white;

    final Color onColorChangedOnColor =
        ThemeData.estimateBrightnessForColor(onColorChanged) == Brightness.light
            ? Colors.black
            : Colors.white;

    final Color endChangeOnColor =
        ThemeData.estimateBrightnessForColor(onColorChangeEnd) ==
                Brightness.light
            ? Colors.black
            : Colors.white;

    // ********************************************************************
    // COLUMN 1 - Content
    // ********************************************************************
    final List<Widget> column1 = <Widget>[
      const Divider(),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
        child: Text(
          'FlexColorPicker',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      // Show the selected color in a dialog
      ListTile(
        title: const Text('Click this color to change it in a dialog'),
        subtitle: Text(
          '${ColorTools.materialNameAndARGBCode(dialogPickerColor, colorSwatchNameMap: colorsNameMap)} '
          'aka ${ColorTools.nameThatColor(dialogPickerColor)}',
        ),
        trailing: ColorIndicator(
          height: size,
          width: size,
          borderRadius: borderRadius,
          elevation: elevation,
          color: dialogPickerColor,
          hasBorder: hasBorder,
          onSelectFocus: false,
          onSelect: () async {
            final Color colorBeforeDialog = dialogPickerColor;
            if (!(await colorPickerDialog())) {
              setState(() {
                dialogPickerColor = colorBeforeDialog;
              });
            }
          },
        ),
      ),
      // Show the color selected in the picker below
      ListTile(
        title: const Text('Select color below to change this color'),
        subtitle: Text(
            '${ColorTools.materialNameAndARGBCode(screenPickerColor, colorSwatchNameMap: colorsNameMap)} '
            'aka ${ColorTools.nameThatColor(screenPickerColor)}'),
        trailing: ColorIndicator(
          height: size,
          width: size,
          borderRadius: borderRadius,
          elevation: elevation,
          color: screenPickerColor,
          hasBorder: hasBorder,
        ),
      ),
      // Color picker demo in a raised card
      SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Card(
            elevation: 2,
            child: ColorPicker(
              color: screenPickerColor,
              onColorChangeStart: (Color color) {
                setState(() => onColorChangeStart = color);
              },
              onColorChanged: (Color color) {
                setState(() {
                  screenPickerColor = color;
                  onColorChanged = screenPickerColor;
                });
              },
              onColorChangeEnd: (Color color) {
                setState(() => onColorChangeEnd = color);
              },
              onRecentColorsChanged: (List<Color> colors) {
                setState(() => screenRecentColors = colors);
              },
              crossAxisAlignment: alignment,
              padding: EdgeInsets.all(padding),
              enableShadesSelection: enableShadesSelection,
              includeIndex850: includeIndex850,
              copyPasteBehavior: ColorPickerCopyPasteBehavior(
                ctrlC: ctrlC,
                ctrlV: ctrlV,
                copyButton: copyButton,
                pasteButton: pasteButton,
                copyFormat: copyFormat,
                longPressMenu: longPressMenu,
                secondaryMenu: secondaryMenu,
                secondaryOnDesktopLongOnDevice: secondaryOnDesktopLongOnDevice,
                editFieldCopyButton: editFieldCopyButton,
                parseShortHexCode: parseShortHexCode,
                editUsesParsedPaste: editUsesParsedPaste,
                snackBarParseError: snackBarParseError,
                feedbackParseError: feedbackParseError,
              ),
              width: size,
              height: size,
              spacing: spacing,
              runSpacing: runSpacing,
              elevation: elevation,
              hasBorder: hasBorder,
              borderRadius: borderRadius,
              columnSpacing: columnSpacing,
              wheelDiameter: wheelDiameter,
              wheelWidth: wheelWidth,
              wheelHasBorder: wheelHasBorder,
              enableTooltips: enableTooltips,
              pickersEnabled: pickersEnabled,
              selectedPickerTypeColor: colorScheme.primary,
              title: showTitle
                  ? Text(
                      'Color Picker',
                      style: Theme.of(context).textTheme.headline6,
                    )
                  : null,
              heading: showHeading
                  ? Text(
                      'Select color',
                      style: Theme.of(context).textTheme.headline5,
                    )
                  : null,
              subheading: showSubheading
                  ? Text(
                      'Select color shade',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : null,
              wheelSubheading: showSubheading
                  ? Text(
                      'Selected color and its color swatch',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : null,
              recentColorsSubheading: showRecentSubheading
                  ? Text(
                      'Recent colors',
                      style: Theme.of(context).textTheme.subtitle1,
                    )
                  : null,
              showMaterialName: showMaterialName,
              showColorName: showColorName,
              showColorCode: showColorCode,
              colorCodeHasColor: colorCodeHasColor,
              colorCodeReadOnly: colorCodeReadOnly,
              showColorValue: showColorValue,
              showRecentColors: showRecentColors,
              recentColors: screenRecentColors,
              maxRecentColors: 6,
              // The name map is used to give the custom colors their names.
              customColorSwatchesAndNames: colorsNameMap,
              colorCodeTextStyle: Theme.of(context).textTheme.subtitle1,
              colorCodePrefixStyle: Theme.of(context).textTheme.caption,
            ),
          ),
        ),
      ),
      //
      const ListTile(
        title: Text('Color change event callbacks'),
        subtitle: Text('There are callbacks for when a color change '
            'starts, is happening and ends. They include color before start, '
            'during change and when change ended.'),
      ),
      ListTile(
        subtitle: Wrap(children: <Widget>[
          MaybeTooltip(
            condition: enableTooltips,
            tooltip: 'ColorPicker(onColorChangeStart: '
                '(Color ${onColorChangeStart.hexAlpha}) { ... } );',
            child: Chip(
              label: Text(
                'Start ${onColorChangeStart.hexAlpha}',
                style: TextStyle(color: onColorChangeStartOnColor),
              ),
              backgroundColor: onColorChangeStart,
            ),
          ),
          const SizedBox(width: 8),
          MaybeTooltip(
            condition: enableTooltips,
            tooltip: 'ColorPicker(onColorChanged: '
                '(Color ${onColorChanged.hexAlpha}) { ... } );',
            child: Chip(
              label: Text(
                'Change ${onColorChanged.hexAlpha}',
                style: TextStyle(color: onColorChangedOnColor),
              ),
              backgroundColor: onColorChanged,
            ),
          ),
          const SizedBox(width: 8),
          MaybeTooltip(
            condition: enableTooltips,
            tooltip: 'ColorPicker(onColorChangeEnd: '
                '(Color ${onColorChangeEnd.hexAlpha}) { ... } );',
            child: Chip(
              label: Text(
                'End ${onColorChangeEnd.hexAlpha}',
                style: TextStyle(color: endChangeOnColor),
              ),
              backgroundColor: onColorChangeEnd,
            ),
          ),
        ]),
      ),
      const Divider(),
      MaybeTooltip(
        condition: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(copyFormat:\n'
            '    $copyFormat));',
        child: ListTile(
          title: const Text('Copy format'),
          trailing: CopyFormatSwitch(
            format: copyFormat,
            onChanged: (ColorPickerCopyFormat value) =>
                setState(() => copyFormat = value),
          ),
        ),
      ),
      const SizedBox(height: 8),
      const ListTile(
        title: Text('Select and COPY a color value, PASTE it into the picker '
            'with toolbar buttons, long press menu or keyboard shortcuts. '
            'Try these:'),
        subtitle: SelectableText('Primary FF7B1FA2  Accent FFCCFF90  '
            'BW FFF9F9F9\n'
            'Custom #014443  Wheel 0xFF6E55C4  ShortWeb 5EC\n'
            'Partial #DDFF  Opacity #99FF9800  Fail 94G02\n'
            'PASTE supports all above formats. COPY in selected format.'),
      ),
      SwitchTileTooltip(
        title: const Text('Enable support for CSS WEB 3 char hex RGB format'),
        subtitle: const Text('Applies to both paste action and color '
            'code entry.'),
        value: parseShortHexCode,
        onChanged: (bool value) => setState(() => parseShortHexCode = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(parseShortHexCode: '
            '$parseShortHexCode));',
      ),
    ];

    // ********************************************************************
    // COLUMN 2 - Content
    // ********************************************************************
    final List<Widget> column2 = <Widget>[
      const Divider(),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
        child: Text(
          'Show and hide',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      MaybeTooltip(
        condition: enableTooltips,
        tooltip: 'ColorPicker(pickersEnabled:\n'
            '  $pickersEnabled);',
        child: ListTile(
          title: const Text('Show pickers'),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: ToggleButtons(
                  isSelected: toggleButtonIsSelected,
                  selectedColor: colorScheme.onPrimary,
                  color: colorScheme.onSurface,
                  fillColor: colorScheme.primary,
                  hoverColor: colorScheme.primary.withOpacity(0.2),
                  focusColor: colorScheme.primary.withOpacity(0.3),
                  borderWidth: 2,
                  borderColor: colorScheme.primary,
                  selectedBorderColor: colorScheme.primary,
                  borderRadius: BorderRadius.circular(44),
                  constraints:
                      const BoxConstraints(minWidth: 50, minHeight: 44),
                  onPressed: (int index) {
                    // Copy the currently enabled pickers map.
                    final Map<ColorPickerType, bool> pEnabled =
                        <ColorPickerType, bool>{...pickersEnabled};
                    // Set enabled pickers based on toggle buttons
                    // custom logic by mutating the copy of enabled
                    // pickers.
                    toggleButtonIsSelected[index] =
                        !toggleButtonIsSelected[index];
                    if (index == 0) {
                      pEnabled[ColorPickerType.both] =
                          toggleButtonIsSelected[index];
                      // If 'Both' on then primary & Accent are off
                      if (pEnabled[ColorPickerType.both]!) {
                        toggleButtonIsSelected[1] = false;
                        pEnabled[ColorPickerType.primary] = false;
                        toggleButtonIsSelected[2] = false;
                        pEnabled[ColorPickerType.accent] = false;
                      }
                    }
                    if (index == 1) {
                      pEnabled[ColorPickerType.primary] =
                          toggleButtonIsSelected[index];
                      // If we turned on 'primary', we turn of 'Both'
                      if (pEnabled[ColorPickerType.primary]!) {
                        toggleButtonIsSelected[0] = false;
                        pEnabled[ColorPickerType.both] = false;
                      }
                    }
                    if (index == 2) {
                      pEnabled[ColorPickerType.accent] =
                          toggleButtonIsSelected[index];
                      // If we turned on 'accent', we turn of 'Both'
                      if (pEnabled[ColorPickerType.accent]!) {
                        toggleButtonIsSelected[0] = false;
                        pEnabled[ColorPickerType.both] = false;
                      }
                    }
                    if (index == 3) {
                      pEnabled[ColorPickerType.bw] =
                          toggleButtonIsSelected[index];
                    }
                    if (index == 4) {
                      pEnabled[ColorPickerType.custom] =
                          toggleButtonIsSelected[index];
                    }
                    if (index == 5) {
                      pEnabled[ColorPickerType.wheel] =
                          toggleButtonIsSelected[index];
                    }
                    setState(() {
                      // Copy the enabled pickers from the mutated
                      // copy. If we mutate the pickersEnabled map
                      // directly the didUpdateWidget will be called,
                      // but the old and new values will be same
                      // since we mutated the widget input. Doing it
                      // this way, the didUpdateWidget function of the
                      // StatefulWidget sees the changed values of
                      // pickersEnabled. We need that for dynamically
                      // changing the enabled pickers correctly.
                      // Normally you would just define the pickers
                      // you want when you instantiate it and not
                      // change it, so you would not need to do this.
                      pickersEnabled = <ColorPickerType, bool>{...pEnabled};
                    });
                  },
                  children: _toggleButtons,
                ),
              ),
            ],
          ),
        ),
      ),
      SwitchTileTooltip(
        title: const Text('Show color shades'),
        subtitle: const Text('Turn OFF to only be able to select the main '
            'color in a color swatch.'),
        value: enableShadesSelection,
        onChanged: (bool value) =>
            setState(() => enableShadesSelection = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(enableShadesSelection: $enableShadesSelection);',
      ),
      SwitchTileTooltip(
        title: const Text('Show grey color index 850'),
        subtitle: const Text('To include the not so well known 850 color in '
            'the Grey swatch, turn this ON.'),
        value: includeIndex850,
        onChanged: (bool value) => setState(() => includeIndex850 = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(includeIndex850: $includeIndex850);',
      ),
      const Divider(),
      SwitchTileTooltip(
        title: const Text('Show picker toolbar title'),
        subtitle:
            const Text('You can provide your own picker toolbar title, if '
                'it is null there is no title.'),
        value: showTitle,
        onChanged: (bool value) => setState(() => showTitle = value),
        tooltipEnabled: enableTooltips,
        tooltip: showTitle
            ? "ColorPicker(title: Text('Color Picker'));"
            : 'ColorPicker(title: null);',
      ),
      SwitchTileTooltip(
        title: const Text('Show heading text'),
        subtitle: const Text('You can provide your own heading widget, if '
            'it is null there is no heading.'),
        value: showHeading,
        onChanged: (bool value) => setState(() => showHeading = value),
        tooltipEnabled: enableTooltips,
        tooltip: showHeading
            ? "ColorPicker(heading: Text('Select color'));"
            : 'ColorPicker(heading: null);',
      ),
      SwitchTileTooltip(
        title: const Text('Show subheading text'),
        subtitle: const Text('You can provide your own subheading widget, if '
            'it is null there is no sub heading.'),
        value: showSubheading,
        onChanged: (bool value) => setState(() => showSubheading = value),
        tooltipEnabled: enableTooltips,
        tooltip: showSubheading
            ? "ColorPicker(subheading: Text('Select color shade'));"
            : 'ColorPicker(subheading: null);',
      ),
      SwitchTileTooltip(
        title: const Text('Show subheading text for recent colors'),
        subtitle: const Text('You can provide your own subheading widget, if '
            'it is null there is no sub heading.'),
        value: showRecentSubheading,
        onChanged: (bool value) => setState(() => showRecentSubheading = value),
        tooltipEnabled: enableTooltips,
        tooltip: showRecentSubheading
            ? "ColorPicker(recentColorsSubheading: Text('Recent colors'));"
            : 'ColorPicker(recentColorsSubheading: null);',
      ),
      const Divider(),
      SwitchTileTooltip(
        title: const Text('Show Material color name'),
        subtitle:
            const Text('If the color has a Material name, it is shown along '
                'with its shade index.'),
        value: showMaterialName,
        onChanged: (bool value) => setState(() => showMaterialName = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(showMaterialName: $showMaterialName);',
      ),
      SwitchTileTooltip(
        title: const Text('Show color name'),
        subtitle:
            const Text('Shows a general English color name for any selected '
                'color.'),
        value: showColorName,
        onChanged: (bool value) => setState(() => showColorName = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(showColorName: $showColorName);',
      ),
      SwitchTileTooltip(
        title: const Text('Show selected color code'),
        subtitle:
            const Text('Show the Flutter style HEX RGB value of the selected '
                'color. On the wheel picker you can also enter a HEX '
                'RGB value.'),
        value: showColorCode,
        onChanged: (bool value) => setState(() => showColorCode = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(showColorCode: $showColorCode);',
      ),
      SwitchTileTooltip(
        title: const Text('Current color used as color code background'),
        value: colorCodeHasColor,
        onChanged: (bool value) => setState(() => colorCodeHasColor = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(colorCodeHasColor: $colorCodeHasColor);',
      ),
      SwitchTileTooltip(
        title: const Text('Color code always read only'),
        subtitle: const Text('Normally color code can be edited on '
            'wheel picker, set this ON to make it read only.'),
        value: colorCodeReadOnly,
        onChanged: (bool value) => setState(() => colorCodeReadOnly = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(colorCodeReadOnly: $colorCodeReadOnly);',
      ),
      SwitchTileTooltip(
        title: const Text('Show integer color value'),
        subtitle: const Text(
            'Show the integer value of the selected color. The value '
            'can be selected and copied. Typically used as a dev feature.'),
        value: showColorValue,
        onChanged: (bool value) => setState(() => showColorValue = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(showColorValue: $showColorValue);',
      ),
      SwitchTileTooltip(
        title: const Text('Show recently used colors'),
        subtitle: const Text('With the API you can also control how many '
            'recent colors are shown and the sub heading for it.'),
        value: showRecentColors,
        onChanged: (bool value) => setState(() => showRecentColors = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(showRecentColors: $showRecentColors);',
      ),
    ];

    // *************************************************************************
    // COLUMN 3 - Content
    // *************************************************************************
    final List<Widget> column3 = <Widget>[
      const Divider(),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
        child: Text(
          'Picker design',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      // Color picker size
      MaybeTooltip(
        condition: enableTooltips,
        tooltip: 'ColorPicker(\n'
            '  width: ${size.floor().toString()},\n'
            '  height: ${size.floor().toString()});',
        child: ListTile(
          title: const Text('Color picker item size'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider.adaptive(
                min: _pickItemMinSize,
                max: _pickItemMaxSize,
                divisions: (_pickItemMaxSize - _pickItemMinSize).floor(),
                label: size.floor().toString(),
                value: size,
                onChanged: (double value) {
                  if (value / 2 < borderRadius) {
                    borderRadius = value / 2;
                  }
                  setState(() => size = value);
                },
              ),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'dp',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  size.floor().toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      // Border radius
      MaybeTooltip(
        condition: enableTooltips,
        tooltip:
            'ColorPicker(borderRadius: ${borderRadius.floor().toString()});',
        child: ListTile(
          title: const Text('Color picker item border radius'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider.adaptive(
                max: size / 2,
                divisions: (size / 2).floor(),
                label: borderRadius.floor().toString(),
                value: borderRadius,
                onChanged: (double value) =>
                    setState(() => borderRadius = value),
              ),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'dp',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  borderRadius.floor().toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      // Elevation of color pick item
      MaybeTooltip(
        condition: enableTooltips,
        tooltip: 'ColorPicker(elevation: ${elevation.floor().toString()});',
        child: ListTile(
          title: const Text('Color picker item elevation'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider.adaptive(
                max: 16,
                divisions: 16,
                label: elevation.floor().toString(),
                value: elevation,
                onChanged: (double value) => setState(() => elevation = value),
              ),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'dp',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  elevation.floor().toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      // Spacing of color pick items
      MaybeTooltip(
        condition: enableTooltips,
        tooltip: 'ColorPicker(spacing: ${spacing.floor().toString()});',
        child: ListTile(
          title: const Text('Color picker item spacing'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider.adaptive(
                max: 25,
                divisions: 25,
                label: spacing.floor().toString(),
                value: spacing,
                onChanged: (double value) => setState(() => spacing = value),
              ),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'dp',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  spacing.floor().toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      // Run spacing of color pick items
      MaybeTooltip(
        condition: enableTooltips,
        tooltip: 'ColorPicker(runSpacing: ${runSpacing.floor().toString()});',
        child: ListTile(
          title: const Text('Color picker item run spacing'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider.adaptive(
                max: 25,
                divisions: 25,
                label: runSpacing.floor().toString(),
                value: runSpacing,
                onChanged: (double value) => setState(() => runSpacing = value),
              ),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'dp',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  runSpacing.floor().toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      // Border around pick items.
      SwitchTileTooltip(
        title: const Text('Border around color pick items'),
        subtitle: const Text('With the API you can also adjust the '
            'border color.'),
        value: hasBorder,
        onChanged: (bool value) => setState(() => hasBorder = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(hasBorder: $hasBorder);',
      ),
      const Divider(),
      // Wheel size selector
      MaybeTooltip(
        condition: enableTooltips,
        tooltip:
            'ColorPicker(wheelDiameter: ${wheelDiameter.floor().toString()});',
        child: ListTile(
          title: const Text('Color wheel size'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider.adaptive(
                min: 150,
                max: 500,
                divisions: 40,
                label: wheelDiameter.floor().toString(),
                value: wheelDiameter,
                onChanged: (double value) =>
                    setState(() => wheelDiameter = value),
              ),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'dp',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  wheelDiameter.floor().toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      // Wheel width selector
      MaybeTooltip(
        condition: enableTooltips,
        tooltip: 'ColorPicker(wheelWidth: ${wheelWidth.floor().toString()});',
        child: ListTile(
          title: const Text('Color wheel width'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider.adaptive(
                min: 4,
                max: 50,
                divisions: 50 - 4,
                label: wheelWidth.floor().toString(),
                value: wheelWidth,
                onChanged: (double value) => setState(() => wheelWidth = value),
              ),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'dp',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  wheelWidth.floor().toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      SwitchTileTooltip(
        title: const Text('Border around color wheel'),
        subtitle: const Text('With the API you can also adjust the '
            'border color'),
        value: wheelHasBorder,
        onChanged: (bool value) => setState(() => wheelHasBorder = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(wheelHasBorder: $wheelHasBorder);',
      ),
      const Divider(),
      SwitchTileTooltip(
        title: const Text('Enable tooltips'),
        subtitle: const Text('Turn OFF to disable all tooltips in the picker.'
            '\n(Also enables and disables API tooltips in this demo)'),
        value: enableTooltips,
        onChanged: (bool value) => setState(() => enableTooltips = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(enableTooltips: $enableTooltips);',
      ),
    ];

    // *************************************************************************
    // COLUMN 4 - Content
    // *************************************************************************
    final List<Widget> column4 = <Widget>[
      const Divider(),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
        child: Text(
          'Picker layout',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      MaybeTooltip(
        condition: enableTooltips,
        tooltip: 'ColorPicker(crossAxisAlignment:\n'
            '  $alignment});',
        child: ListTile(
          title: const Text('Content alignment'),
          subtitle: const Text('Start - Center - End'),
          trailing: AlignmentSwitch(
            alignment: alignment,
            onChanged: (CrossAxisAlignment value) =>
                setState(() => alignment = value),
          ),
        ),
      ),
      // Vertical space between items in the color picker
      MaybeTooltip(
        condition: enableTooltips,
        tooltip:
            'ColorPicker(columnSpacing: ${columnSpacing.floor().toString()});',
        child: ListTile(
          title: const Text('Color picker row space'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider.adaptive(
                max: 40,
                divisions: 40,
                label: columnSpacing.floor().toString(),
                value: columnSpacing,
                onChanged: (double value) =>
                    setState(() => columnSpacing = value),
              ),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'dp',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  columnSpacing.floor().toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      // Padding around all the content in the picker
      MaybeTooltip(
        condition: enableTooltips,
        tooltip: 'ColorPicker(padding:\n'
            '  EdgeInsets.all(${padding.floor().toString()}));',
        child: ListTile(
          title: const Text('Color picker content padding'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider.adaptive(
                max: 40,
                divisions: 40,
                label: padding.floor().toString(),
                value: padding,
                onChanged: (double value) => setState(() => padding = value),
              ),
            ],
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                const Text(
                  'dp',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  padding.floor().toString(),
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
      SwitchTileTooltip(
        title: const Text('Dialog toolbar has CLOSE button'),
        subtitle: const Text('Use API to change icon and theme the button.'),
        value: closeButton,
        onChanged: (bool value) => setState(() => closeButton = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(actionButtons:\n'
            '  ColorPickerActionButtons(closeButton: $closeButton));',
      ),
      SwitchTileTooltip(
        title: const Text('Dialog toolbar has OK button'),
        subtitle: const Text('Use API to change icon and theme the button.'),
        value: okButton,
        onChanged: (bool value) => setState(() => okButton = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(actionButtons:\n'
            '  ColorPickerActionButtons(okButton: $okButton));',
      ),
      SwitchTileTooltip(
        title: const Text('Dialog has CANCEL and OK buttons'),
        subtitle: const Text('Bottom action button will remain present if its '
            'toolbar button is not turned ON.'),
        value: dialogActionButtons,
        onChanged: (bool value) => setState(() => dialogActionButtons = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(actionButtons:\n'
            '  ColorPickerActionButtons(dialogActionButtons: '
            '$dialogActionButtons));',
      ),
      SwitchTileTooltip(
        title: const Text('Dialog action buttons have icons'),
        subtitle: const Text('Use API to also customize button and icon.'),
        value: dialogActionIcons,
        onChanged: (bool value) => setState(() => dialogActionIcons = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(actionButtons:\n'
            '  ColorPickerActionButtons(dialogActionIcons: $dialogActionIcons));',
      ),

      const Divider(),
      Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 0, 14),
        child: Text(
          'Copy paste actions',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      SwitchTileTooltip(
        title: const Text('Enable CTRL-C CMD-C to copy'),
        value: ctrlC,
        onChanged: (bool value) => setState(() => ctrlC = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(ctrlC: $ctrlC));',
      ),
      SwitchTileTooltip(
        title: const Text('Enable CTRL-V CMD-V to paste'),
        value: ctrlV,
        onChanged: (bool value) => setState(() => ctrlV = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(ctrlV: $ctrlV));',
      ),
      SwitchTileTooltip(
        title: const Text('Enable toolbar COPY action button'),
        value: copyButton,
        onChanged: (bool value) => setState(() => copyButton = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(copyButton: $copyButton));',
      ),
      SwitchTileTooltip(
        title: const Text('Enable toolbar PASTE action button'),
        value: pasteButton,
        onChanged: (bool value) => setState(() => pasteButton = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(pasteButton: $pasteButton));',
      ),
      SwitchTileTooltip(
        title: const Text('Enable color code edit field COPY button'),
        value: editFieldCopyButton,
        onChanged: (bool value) => setState(() => editFieldCopyButton = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(editFieldCopyButton: '
            '$editFieldCopyButton));',
      ),
      SwitchTileTooltip(
        title: const Text('Secondary click COPY-PASTE menu'),
        subtitle: const Text('Typically mouse right click.'),
        value: secondaryMenu,
        onChanged: (bool value) => setState(() => secondaryMenu = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(secondaryMenu: $secondaryMenu));',
      ),
      SwitchTileTooltip(
        title: const Text('Long press COPY-PASTE menu'),
        value: longPressMenu,
        onChanged: (bool value) => setState(() => longPressMenu = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(longPressMenu: $longPressMenu));',
      ),
      SwitchTileTooltip(
        title: const Text('Long press COPY-PASTE menu on Android/iOS, but '
            'right click on desktops'),
        value: secondaryOnDesktopLongOnDevice,
        onChanged: (bool value) =>
            setState(() => secondaryOnDesktopLongOnDevice = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(\n'
            '    secondaryOnDesktopLongOnDevice: '
            '$secondaryOnDesktopLongOnDevice));',
      ),
      SwitchTileTooltip(
        title: const Text('Color code entry field uses paste parser'),
        subtitle: const Text('Turn OFF to use normal text field paste. '
            'This feature only applies to desktop keyboard shortcuts.'),
        value: editUsesParsedPaste,
        onChanged: (bool value) => setState(() => editUsesParsedPaste = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(editUsesParsedPaste: '
            '$editUsesParsedPaste));',
      ),
      SwitchTileTooltip(
        title: const Text('Snackbar paste format error message'),
        value: snackBarParseError,
        onChanged: (bool value) => setState(() => snackBarParseError = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(snackBarParseError: '
            '$snackBarParseError));',
      ),
      SwitchTileTooltip(
        title: const Text('Feedback vibration and audible paste error alert'),
        subtitle: const Text('This feature is experimental. Its support '
            'is limited on most platforms in current Flutter SDK.'),
        value: feedbackParseError,
        onChanged: (bool value) => setState(() => feedbackParseError = value),
        tooltipEnabled: enableTooltips,
        tooltip: 'ColorPicker(copyPasteBehavior:\n'
            '  ColorPickerCopyPasteBehavior(\n'
            '    feedbackParseError: $feedbackParseError));',
      ),
    ];

    // *************************************************************************
    // END of COLUMN content finals.
    // *************************************************************************
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('FlexColorPicker Demo'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: kMaxBodyWidth),
          child: Row(
            // The Row contains 1 to 4 ListViews, each in an Expanded widget.
            children: <Widget>[
              Expanded(
                child: Scrollbar(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).padding.top +
                              kToolbarHeight),
                      ...column1,
                      if (columns < 3) ...column2,
                      if (columns < 2) ...column3,
                      if (columns < 2) ...column4,
                    ],
                  ),
                ),
              ),
              if (columns > 1)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        if (columns == 3 || columns == 4) ...column2,
                        if (columns < 3) ...column3,
                        if (columns < 3) ...column4,
                      ],
                    ),
                  ),
                ),
              if (columns > 2)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        // Show the selected color in a dialog
                        ...column3,
                        if (columns < 4) ...column4,
                      ],
                    ),
                  ),
                ),
              if (columns > 3)
                Expanded(
                  child: Scrollbar(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).padding.top +
                                kToolbarHeight),
                        ...column4,
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChangeStart: (Color color) =>
          setState(() => onColorChangeStart = color),
      onColorChanged: (Color color) {
        setState(() {
          dialogPickerColor = color;
          onColorChanged = dialogPickerColor;
        });
      },
      onColorChangeEnd: (Color color) =>
          setState(() => onColorChangeEnd = color),
      crossAxisAlignment: alignment,
      padding: EdgeInsets.all(padding),
      enableShadesSelection: enableShadesSelection,
      includeIndex850: includeIndex850,
      copyPasteBehavior: ColorPickerCopyPasteBehavior(
        ctrlC: ctrlC,
        ctrlV: ctrlV,
        copyButton: copyButton,
        pasteButton: pasteButton,
        copyFormat: copyFormat,
        longPressMenu: longPressMenu,
        secondaryMenu: secondaryMenu,
        secondaryOnDesktopLongOnDevice: secondaryOnDesktopLongOnDevice,
        editFieldCopyButton: editFieldCopyButton,
        parseShortHexCode: parseShortHexCode,
        editUsesParsedPaste: editUsesParsedPaste,
        snackBarParseError: snackBarParseError,
        feedbackParseError: feedbackParseError,
      ),
      actionButtons: ColorPickerActionButtons(
        // Make sure that you only enable the OK and Cancel button in the
        // toolbar when the picker is used in a dialog.
        okButton: okButton,
        closeButton: closeButton,
        // This will remove the default dialog action buttons if it is false.
        // However, the OK button is only removed if `actionButtons.okButton` is
        // also true, and the CANCEL button only if `actionButtons.closeButton`
        // is also true.
        dialogActionButtons: dialogActionButtons,
        dialogActionIcons: dialogActionIcons,
        dialogOkButtonType: ColorPickerActionButtonType.outlined,
        dialogCancelButtonType: ColorPickerActionButtonType.text,
      ),
      width: size,
      height: size,
      spacing: spacing,
      runSpacing: runSpacing,
      elevation: elevation,
      hasBorder: hasBorder,
      borderRadius: borderRadius,
      columnSpacing: columnSpacing,
      wheelDiameter: wheelDiameter,
      wheelWidth: wheelWidth,
      wheelHasBorder: wheelHasBorder,
      enableTooltips: enableTooltips,
      pickersEnabled: pickersEnabled,
      title: showTitle
          ? Text(
              'Color Picker',
              style: Theme.of(context).textTheme.headline6,
            )
          : null,
      heading: showHeading
          ? Text(
              'Select color',
              style: Theme.of(context).textTheme.headline5,
            )
          : null,
      subheading: showSubheading
          ? Text(
              'Select color shade',
              style: Theme.of(context).textTheme.subtitle1,
            )
          : null,
      wheelSubheading: showSubheading
          ? Text(
              'Selected color and its color swatch',
              style: Theme.of(context).textTheme.subtitle1,
            )
          : null,
      recentColorsSubheading: showRecentSubheading
          ? Text(
              'Recent colors',
              style: Theme.of(context).textTheme.subtitle1,
            )
          : null,
      showMaterialName: showMaterialName,
      showColorName: showColorName,
      showColorCode: showColorCode,
      colorCodeHasColor: colorCodeHasColor,
      colorCodeReadOnly: colorCodeReadOnly,
      showColorValue: showColorValue,
      showRecentColors: showRecentColors,
      recentColors: dialogRecentColors,
      maxRecentColors: 5,
      onRecentColorsChanged: (List<Color> colors) {
        setState(() => dialogRecentColors = colors);
      },
      // The name map is used to give the custom colors their names.
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      // Let's make an even more transparent barrier color than black12
      barrierColor: const Color(0x0F000000), // 6% opacity black

      constraints:
          const BoxConstraints(minHeight: 500, minWidth: 480, maxWidth: 480),
    );
  }
}
