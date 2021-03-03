import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color_picker_extensions.dart';
import '../color_tools.dart';
import '../functions/picker_functions.dart';
import '../models/color_picker_copy_paste_behavior.dart';
import '../models/color_picker_action_buttons.dart';
import '../universal_widgets/dry_intrisinic.dart';

/// Color code entry and display field used by the color picker.
class ColorCodeField extends StatefulWidget {
  /// Default const constructor.
  const ColorCodeField({
    Key? key,
    required this.color,
    this.readOnly = false,
    required this.onColorChanged,
    required this.onEditFocused,
    this.textStyle,
    this.prefixStyle,
    this.toolIcons = const ColorPickerActionButtons(),
    this.copyPasteBehavior = const ColorPickerCopyPasteBehavior(),
    this.enableTooltips = true,
  }) : super(key: key);

  /// Current color value for the field.
  final Color color;

  /// Is in read only mode, we should not be able to select either.
  final bool readOnly;

  /// Color code of the entered color string is returned back in this callback.
  final ValueChanged<Color> onColorChanged;

  /// The Color code editing field has focus.
  final ValueChanged<bool> onEditFocused;

  /// TextStyle of the color code display and edit field.
  ///
  /// Defaults to Theme.of(context).textTheme.bodyText2;
  final TextStyle? textStyle;

  /// The TextStyle of the prefix of the color code.
  ///
  /// Defaults to [textStyle], if not defined.
  final TextStyle? prefixStyle;

  /// Defines icons for the color picker title bar and its actions.
  ///
  /// Defaults to ColorPickerToolIcons().
  final ColorPickerActionButtons toolIcons;

  /// Defines the color picker's copy and paste behavior.
  ///
  /// Defaults to ColorPickerPasteBehavior().
  final ColorPickerCopyPasteBehavior copyPasteBehavior;

  /// Controls if tooltips are shown or not
  ///
  /// Defaults to true.
  final bool enableTooltips;

  @override
  _ColorCodeFieldState createState() => _ColorCodeFieldState();
}

// Color code display and entry field.
class _ColorCodeFieldState extends State<ColorCodeField> {
  late TextEditingController textController;
  late FocusNode textFocusNode;
  late String colorHexCode;
  late Color color;

  // Set current selected color values as a String on the Clipboard in the
  // currently configured format.
  Future<void> _setClipboard() async {
    String colorString = '00000000';
    switch (widget.copyPasteBehavior.copyFormat) {
      case ColorPickerCopyFormat.dartCode:
        colorString = '0x${color.hexAlpha}';
        break;
      case ColorPickerCopyFormat.hexRRGGBB:
        colorString = color.hex;
        break;
      case ColorPickerCopyFormat.hexAARRGGBB:
        colorString = color.hexAlpha;
        break;
      case ColorPickerCopyFormat.numHexRRGGBB:
        colorString = '#${color.hex}';
        break;
      case ColorPickerCopyFormat.numHexAARRGGBB:
        colorString = '#${color.hexAlpha}';
        break;
    }
    final ClipboardData data = ClipboardData(text: colorString);
    await Clipboard.setData(data);
  }

  // Get the current selected color prefix format for the input field.
  // The prefix in the input field matches the set copy format.
  String get _editColorPrefix {
    switch (widget.copyPasteBehavior.copyFormat) {
      case ColorPickerCopyFormat.dartCode:
        return '0xFF';
      case ColorPickerCopyFormat.hexRRGGBB:
        return '    ';
      case ColorPickerCopyFormat.hexAARRGGBB:
        return '  FF';
      case ColorPickerCopyFormat.numHexRRGGBB:
        return '   #';
      case ColorPickerCopyFormat.numHexAARRGGBB:
        return ' #FF';
    }
  }

  @override
  void initState() {
    super.initState();
    textController = _TextEditingControllerWithCursorPosition();
    textFocusNode = FocusNode();
    textFocusNode.requestFocus();
    color = widget.color;
    colorHexCode = ColorTools.colorCode(widget.color);
    // The colorHexCode is always a Flutter/Dart style '0xFFRRGGBB' style
    // String of the passed in color value, so this is safe.
    textController.text = colorHexCode.substring(colorHexCode.length - 6);
  }

  @override
  void dispose() {
    textController.dispose();
    textFocusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ColorCodeField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.color != widget.color) {
      color = widget.color;
      colorHexCode = ColorTools.colorCode(widget.color);
      textController.text = colorHexCode.substring(colorHexCode.length - 6);
      // textFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    // The tooltip for copying the color code via the icon button
    String? copyTooltip;

    if (widget.enableTooltips) {
      // Get current platform.
      final TargetPlatform platform = Theme.of(context).platform;
      // Get the Material localizations.
      final MaterialLocalizations translate = MaterialLocalizations.of(context);
      // If shortcut key enabled, make a shortcut platform aware info tooltip.
      String copyKeyTooltip = '';
      if (widget.copyPasteBehavior.ctrlC) {
        copyKeyTooltip = platformControlKey(platform, 'C');
      }
      // Make the Copy tooltip.
      copyTooltip =
          (widget.copyPasteBehavior.copyTooltip ?? translate.copyButtonLabel) +
              copyKeyTooltip;
    }

    // Define opinionated styles for the color code display and entry field.
    final bool isLight = Theme.of(context).brightness == Brightness.light;
    final Color fieldBackground =
        isLight ? Colors.black.withAlpha(11) : Colors.white.withAlpha(33);
    final Color fieldBorder =
        isLight ? Colors.black.withAlpha(33) : Colors.white.withAlpha(55);

    // Set the default text style to bodyText2 if not given.
    final TextStyle effectiveStyle =
        (widget.textStyle ?? Theme.of(context).textTheme.bodyText2)!;

    final TextStyle effectivePrefixStyle = widget.prefixStyle ?? effectiveStyle;

    // Compute color code field size based on the used font size. Might not
    // always be ideal, but with normal fonts and sizes they have been tested to
    // work well enough visually and to always have room for "DDDDDD", which is
    // usually the widest possible entry string.
    final double fontSize = effectiveStyle.fontSize ?? 14.0;
    final double iconSize = fontSize * 1.1;
    final double borderRadius = fontSize * 1.2;
    final double fieldWidth = fontSize * 10;

    return SizedBox(
      width: fieldWidth,
      // A custom width layout widget used due to issue:
      // https://github.com/flutter/flutter/issues/71687
      child: DryIntrinsicWidth(
        child: Focus(
          // Tell the parent when the text edit field has focus, but if it
          // is in read only mode, we are going to say it does not have
          // focus so we can copy the value with Ctrl-C
          onFocusChange: (bool focus) {
            widget.onEditFocused(focus && !widget.readOnly);
          },
          child: TextField(
            enabled: true,
            readOnly: widget.readOnly,
            enableInteractiveSelection: !widget.readOnly,
            controller: textController,
            focusNode: textFocusNode,
            // autofocus: false,
            // We can enter 7 chars for the Hex color code, but the 7th one
            // will actually always be removed by the onChanged callback.
            maxLength: 7,
            // Max lines is 1 by default, we set min lines to be 1 as well.
            minLines: 1,
            // Remove line that shows entered chars when maxLength is used.
            buildCounter: (BuildContext context,
                    {required int currentLength,
                    int? maxLength,
                    required bool isFocused}) =>
                null,
            style: effectiveStyle,
            // Only affects the type of keyboard shown on devices, does not
            // make the input uppercase.
            textCapitalization: TextCapitalization.characters,
            // These input formatters limits the input to only valid chars for
            // a hex color code, and we also automatically convert them to
            // uppercase.
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp('[a-fA-F0-9]')),
              _UpperCaseTextFormatter(),
            ],
            toolbarOptions: widget.readOnly
                ? const ToolbarOptions(
                    copy: true,
                    selectAll: true,
                  )
                : const ToolbarOptions(
                    copy: true,
                    cut: true,
                    selectAll: true,
                    paste: true,
                  ),
            decoration: InputDecoration(
              suffixIcon: widget.copyPasteBehavior.editFieldCopyButton
                  ? IconButton(
                      icon: Icon(widget.copyPasteBehavior.copyIcon),
                      padding: const EdgeInsets.all(0),
                      tooltip: copyTooltip,
                      iconSize: iconSize,
                      splashRadius: borderRadius,
                      color: effectiveStyle.color,
                      constraints: const BoxConstraints(),
                      onPressed: _setClipboard,
                    )
                  : SizedBox(height: borderRadius * 2),
              suffixIconConstraints: BoxConstraints(
                minHeight: borderRadius * 2,
                minWidth: borderRadius * 2,
              ),
              isDense: true,
              contentPadding: EdgeInsetsDirectional.only(start: fontSize),
              prefixText: _editColorPrefix,
              prefixStyle: effectivePrefixStyle,
              filled: true,
              fillColor: fieldBackground,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: fieldBorder,
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            //
            onChanged: (String value) {
              if (value.isNotEmpty) {
                setState(() {
                  // If longer than 6 chars, remove the last char
                  if (value.length >= 7) value = value.substring(0, 6);
                  textController.text = value;
                  colorHexCode = '0xFF${value.padRight(6, '0')}';
                  color = Color(int.parse(colorHexCode));
                });
                widget.onColorChanged(color);
              }
            },
            onSubmitted: (String value) {
              if (value.isNotEmpty) {
                setState(() {
                  textController.text = value.padRight(6, '0');
                  colorHexCode = '0xFF${value.padRight(6, '0')}';
                  color = Color(int.parse(colorHexCode));
                });
                widget.onColorChanged(color);
              }
            },
            // TODO: Keep or loos this?
            onEditingComplete: () {
              // Move to the copy button
              textFocusNode.nextFocus();
            },
          ),
        ),
      ),
    );
  }
}

// Keeps the cursor in same place when modifying the content of the TextField
// with a TextEditingController.
class _TextEditingControllerWithCursorPosition extends TextEditingController {
  _TextEditingControllerWithCursorPosition({String? text}) : super(text: text);
  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: value.selection,
      composing: TextRange.empty,
    );
  }
}

// This TextField formatter converts all input to uppercase.
class _UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
