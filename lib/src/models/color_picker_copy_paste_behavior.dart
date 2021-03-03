import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Enum that controls the RGB string format of the copied color value.
///
/// When you copy a [Color] value from the color picker, this enum is
/// used to configure the desired default format of the received RGB string.
///
/// If you have alpha channel or opacity enabled, the alpha value will not
/// be included in the copied RGB string format. The copy format always takes
/// precedence, use the format you require for your application and if
/// opacity/alpha usage is enabled.
///
/// A planned future feature of ColorPicker will allow you to copy the color
/// value in other than RGB hex strings as well.
///
/// When you paste a color string value to the color picker, it can
/// automatically parse a string from any of these RGB strings formats to a Dart
/// and Flutter [Color] object, regardless of what the default copy format is.
/// Additionally the paste color value can be in the 3-char short RGB hex
/// format, it will also be correctly parsed to its [Color] value.
///
enum ColorPickerCopyFormat {
  /// In Flutter/Dart Hex format '0xAARRGGBB'.
  dartCode,

  /// Web Hex format with no alpha 'RRGGBB'.
  hexRRGGBB,

  /// Web Hex format with alpha 'AARRGGBB'.
  hexAARRGGBB,

  /// Web Hex format with leading num # sign and no alpha '#RRGGBB'.
  numHexRRGGBB,

  /// Web Hex format with leading num # sign and alpha '#AARRGGBB'.
  numHexAARRGGBB,
}

/// Defines the FlexColorPicker's copy and paste behavior.
///
/// You can control if the picker has:
/// * Copy and paste buttons in the top toolbar.
/// * Long press copy and paste context menu.
/// * Ctrl-C and Ctrl-V keyboard shortcuts also when not in edit field.
///   Automatically uses Command instead of Ctrl on macOS.
/// * Edit color code field with a copy color icon.
///
/// You can also:
/// * Define default result RGB string format of copy command.
/// * Define icons for copy and paste icons.
/// * Define icon theme's for the copy and paste icons.
/// * Define paste color string parsing error feedback type.
///
/// Paste operation supports all RGB string formats defined by
/// [ColorPickerCopyFormat], but default copy format is only in selected
/// [copyFormat].
///
/// Used by FlexColorPicker to define how copy paste operations behave.
@immutable
class ColorPickerCopyPasteBehavior with Diagnosticable {
  /// Default constructor
  const ColorPickerCopyPasteBehavior(
      {this.ctrlC = true,
      this.ctrlV = true,
      this.copyButton = false,
      this.pasteButton = false,
      this.copyIcon = Icons.copy,
      this.pasteIcon = Icons.paste,
      this.copyTooltip,
      this.pasteTooltip,
      this.copyFormat = ColorPickerCopyFormat.dartCode,
      this.longPressMenu = false,
      this.editFieldCopyButton = true,
      this.menuIconThemeData,
      this.menuThemeData,
      this.menuWidth = 80,
      this.menuItemHeight = 30,
      this.snackBarParseError = false,
      this.snackBarMessage,
      this.snackBarDuration = const Duration(milliseconds: 1800),
      this.feedbackParseError = false,
      // TODO: This property is no longer needed, remove it before publishing.
      // this.autoFocus = true,
      this.editUsesParsedPaste = false});

  /// A CTRL-C press will copy the clipboard into the picker.
  ///
  /// Defaults to true.
  final bool ctrlC;

  /// A CTRL-V press will paste the clipboard into the picker.
  ///
  /// Defaults to true.
  final bool ctrlV;

  /// Show a copy action icon in the picker title bar end.
  ///
  /// Defaults to false.
  final bool copyButton;

  /// Show a paste action icon in the picker title bar end.
  ///
  /// Defaults to false.
  final bool pasteButton;

  /// Icon used for the copy action icon in the title bar.
  ///
  /// This one is useful if you are not showing the color code that has
  /// a copy icon action already.
  /// The presence of the action button is determined by to the color picker
  /// provided `ColorPickerCopyPasteBehavior.copyButton` property value.
  ///
  /// Defaults to [Icons.copy].
  final IconData copyIcon;

  /// Icon used for the paste action icon in the title bar.
  ///
  /// The presence of the action button is determined by to the color picker
  /// provided `ColorPickerCopyPasteBehavior.pasteButton` property value.
  ///
  /// Defaults to [Icons.paste].
  final IconData pasteIcon;

  /// Label used as tooltip for copy action.
  ///
  /// Provide your own or use the default material localization label.
  ///
  /// Defaults to MaterialLocalizations.of(context).copyButtonLabel.
  /// If CTRL-C copying is also enabled, the string ' (CTRL-C)' is added
  /// on Linux and Windows platforms and on macOS ' (CMD-C)' is added.
  final String? copyTooltip;

  /// Label used as tooltip for paste action.
  ///
  /// Provide your own or use the default material localization label.
  ///
  /// Defaults to: MaterialLocalizations.of(context).pasteButtonLabel.
  /// If CTRL-V pasting is also enabled, the string ' (CTRL-V)' is added
  /// on Linux and Windows platforms and on macOS ' (CMD-V)' is added.
  final String? pasteTooltip;

  /// Defines the default format of the copied string.
  ///
  /// Defaults to [ColorPickerCopyFormat.dartCode].
  final ColorPickerCopyFormat copyFormat;

  /// Long press on picker background to get a copy and paste menu action.
  ///
  /// Defaults to false.
  final bool longPressMenu;

  /// Show a copy button in the color code edit and display field.
  ///
  /// Defaults to true.
  final bool editFieldCopyButton;

  /// The theme for the menu icons.
  ///
  /// The menu is compact, so icons are small by design.
  ///
  /// Uses any none null property in passed in [IconThemeData]. If the
  /// passed value is null, or any property in it is null, then it uses
  /// property values from `Theme.of(context).iconTheme`, if they are not
  /// null. For any null value, the following fallback defaults are used:
  ///   color: remains null, so default [IconThemeData] color behavior is kept.
  ///   size: 16
  ///   opacity: 0.90
  final IconThemeData? menuIconThemeData;

  /// The theme of the popup menu.
  ///
  /// Uses any none null property in provided [PopupMenuThemeData], if value is
  /// null or any property in it is null, then it uses property values from
  /// `Theme.of(context).popupMenuTheme` if they are not null, for any null
  /// value the following fallback defaults are used:
  ///   color: theme.cardColor.withOpacity(0.9)
  ///   shape: RoundedRectangleBorder(
  ///            borderRadius: BorderRadius.circular(8),
  ///            side: BorderSide(
  ///            color: theme.dividerColor))
  ///   elevation: 3
  ///   textStyle: theme.textTheme.bodyText2!
  ///   enableFeedback: true
  final PopupMenuThemeData? menuThemeData;

  /// The width of the menu.
  ///
  /// Defaults to 80 dp.
  final double menuWidth;

  /// The height of each menu item.
  ///
  /// Defaults to 30 dp.
  final double menuItemHeight;

  /// Show a snack bar paste parse error when pasting something that could not
  /// be parsed to a color value.
  ///
  /// A paste parse error occurs when something is pasted into the color picker
  /// that cannot parsed to a color value.
  ///
  /// Defaults to false.
  final bool snackBarParseError;

  /// The message widget shown in the paste parse error snack bar.
  ///
  /// The widget is typically a [Text]. It is shown in the snack bar when there
  /// is a paste parse error and [snackBarParseError] is true.
  ///
  /// If null, it defaults to the combination of the two Material localization
  /// labels `pasteButtonLabel`: `invalidDateFormatLabel` in a [Text] widget.
  /// In English it says "Paste: Invalid format.".
  final Widget? snackBarMessage;

  /// The duration the paste parse error snack bar message is shown.
  ///
  /// Defaults to const Duration(milliseconds: 1800).
  final Duration snackBarDuration;

  /// If true then vibrate, play audible click or an alert sound, when a
  /// paste parse error occurs.
  ///
  /// A paste parse error occurs when something is pasted into the color picker
  /// that cannot parsed to a color value.
  ///
  /// This feature is experimental, its support is limited on most platforms
  /// in Flutter. If Flutter one day supports the Material Sound Guide, this
  /// feature can be improved with better sound effects. Currently it cannot be
  /// improved without importing none SDK plugins/packages to make sounds.
  /// This package strives to work without any plugins or packages, so it will
  /// not add any additional none Flutter SDK imports.
  ///
  /// Defaults to false.
  final bool feedbackParseError;

  // TODO: This property is no longer needed, remove it before publishing.
  // /// The color picker key listener widget has auto focus, it will capture the
  // /// keyboard paste actions by default.
  // ///
  // /// This works well when the picker is used in a dialog. It does not work as
  // /// well if is used in a UI with many other widgets that may have the focus.
  // /// In that case, a tap on the picker background or on one of its widgets
  // /// (depending on used gesture detection `hitTestBehavior`) is needed to
  // /// give it focus and enable the keyboard paste listener that handles the
  // /// paste keyboard shortcut event.
  // ///
  // /// Normally this can be left to its default true value, but if it interferes
  // /// with other UI components that needs autofocus, you can try setting it to
  // /// false.
  // ///
  // /// Defaults to true.
  // final bool autoFocus;

  /// If true, the color code entry field uses parsed paste action.
  ///
  /// By default a text field, like the color code entry, will just paste
  /// whatever text is in the copy/paste buffer into the field. This
  /// is the default behavior here too, with the exception that the field
  /// only accepts valid hex value input chars. Still it will still only just
  /// paste the acceptable input chars in the paste buffer. This is the
  /// default also for the color code edit field.
  ///
  /// If this property is true, it will use the more clever color copy/paste
  /// value parsing used by the other copy and paste actions for when the input
  /// field is not in focus, also in the code entry field when it is in focus.
  /// This results in a paste action in the field that always fully replaces
  /// the content with the parsed color value of the pasted data, not just
  /// pasting in the string in the copy/paste buffer.
  ///
  /// Defaults to false.
  ///
  /// Which is equivalent to past versions (1.x) default behavior when
  /// pasting strings into the code entry field. Setting the value to true may
  /// be preferred for a consistent paste experience.
  final bool editUsesParsedPaste;

  /// Copy the object with one or more provided properties changed.
  ColorPickerCopyPasteBehavior copyWith({
    bool? ctrlC,
    bool? ctrlV,
    bool? copyButton,
    bool? pasteButton,
    IconData? copyIcon,
    IconData? pasteIcon,
    String? copyTooltip,
    String? pasteTooltip,
    ColorPickerCopyFormat? copyFormat,
    bool? longPressMenu,
    bool? editFieldCopyButton,
    IconThemeData? menuIconThemeData,
    PopupMenuThemeData? menuThemeData,
    double? menuWidth,
    double? menuItemHeight,
    bool? snackBarParseError,
    Widget? snackBarMessage,
    Duration? snackBarDuration,
    bool? feedbackParseError,
    // TODO: This property is no longer needed, remove it before publishing.
    // bool? autoFocus,
    bool? editUsesParsedPaste,
  }) {
    if ((ctrlC == null || identical(ctrlC, this.ctrlC)) &&
        (ctrlV == null || identical(ctrlV, this.ctrlV)) &&
        (copyButton == null || identical(copyButton, this.copyButton)) &&
        (pasteButton == null || identical(pasteButton, this.pasteButton)) &&
        (copyIcon == null || identical(copyIcon, this.copyIcon)) &&
        (pasteIcon == null || identical(pasteIcon, this.pasteIcon)) &&
        (copyTooltip == null || identical(copyTooltip, this.copyTooltip)) &&
        (pasteTooltip == null || identical(pasteTooltip, this.pasteTooltip)) &&
        (copyFormat == null || identical(copyFormat, this.copyFormat)) &&
        (longPressMenu == null ||
            identical(longPressMenu, this.longPressMenu)) &&
        (editFieldCopyButton == null ||
            identical(editFieldCopyButton, this.editFieldCopyButton)) &&
        (menuIconThemeData == null ||
            identical(menuIconThemeData, this.menuIconThemeData)) &&
        (menuThemeData == null ||
            identical(menuThemeData, this.menuThemeData)) &&
        (menuWidth == null || identical(menuWidth, this.menuWidth)) &&
        (menuItemHeight == null ||
            identical(menuItemHeight, this.menuItemHeight)) &&
        (snackBarParseError == null ||
            identical(snackBarParseError, this.snackBarParseError)) &&
        (snackBarMessage == null ||
            identical(snackBarMessage, this.snackBarMessage)) &&
        (snackBarDuration == null ||
            identical(snackBarDuration, this.snackBarDuration)) &&
        (feedbackParseError == null ||
            identical(feedbackParseError, this.feedbackParseError)) &&
        // TODO: This property is no longer needed, remove it before publishing.
        // (autoFocus == null || identical(autoFocus, this.autoFocus)) &&
        (editUsesParsedPaste == null ||
            identical(editUsesParsedPaste, this.editUsesParsedPaste))) {
      return this;
    }

    return ColorPickerCopyPasteBehavior(
      ctrlC: ctrlC ?? this.ctrlC,
      ctrlV: ctrlV ?? this.ctrlV,
      copyButton: copyButton ?? this.copyButton,
      pasteButton: pasteButton ?? this.pasteButton,
      copyIcon: copyIcon ?? this.copyIcon,
      pasteIcon: pasteIcon ?? this.pasteIcon,
      copyTooltip: copyTooltip ?? this.copyTooltip,
      pasteTooltip: pasteTooltip ?? this.pasteTooltip,
      copyFormat: copyFormat ?? this.copyFormat,
      longPressMenu: longPressMenu ?? this.longPressMenu,
      editFieldCopyButton: editFieldCopyButton ?? this.editFieldCopyButton,
      menuIconThemeData: menuIconThemeData ?? this.menuIconThemeData,
      menuThemeData: menuThemeData ?? this.menuThemeData,
      menuWidth: menuWidth ?? this.menuWidth,
      menuItemHeight: menuItemHeight ?? this.menuItemHeight,
      snackBarParseError: snackBarParseError ?? this.snackBarParseError,
      snackBarMessage: snackBarMessage ?? this.snackBarMessage,
      snackBarDuration: snackBarDuration ?? this.snackBarDuration,
      feedbackParseError: feedbackParseError ?? this.feedbackParseError,
      // TODO: This property is no longer needed, remove it before publishing.
      // autoFocus: autoFocus ?? this.autoFocus,
      editUsesParsedPaste: editUsesParsedPaste ?? this.editUsesParsedPaste,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ColorPickerCopyPasteBehavior &&
        ctrlC == other.ctrlC &&
        ctrlV == other.ctrlV &&
        copyButton == other.copyButton &&
        pasteButton == other.pasteButton &&
        copyIcon == other.copyIcon &&
        pasteIcon == other.pasteIcon &&
        copyTooltip == other.copyTooltip &&
        pasteTooltip == other.pasteTooltip &&
        copyFormat == other.copyFormat &&
        longPressMenu == other.longPressMenu &&
        editFieldCopyButton == other.editFieldCopyButton &&
        menuIconThemeData == other.menuIconThemeData &&
        menuThemeData == other.menuThemeData &&
        menuWidth == other.menuWidth &&
        menuItemHeight == other.menuItemHeight &&
        snackBarParseError == other.snackBarParseError &&
        snackBarMessage == other.snackBarMessage &&
        snackBarDuration == other.snackBarDuration &&
        feedbackParseError == other.feedbackParseError &&
        // TODO: This property is no longer needed, remove it before publishing.
        // autoFocus == other.autoFocus &&
        editUsesParsedPaste == other.editUsesParsedPaste;
  }

  @override
  int get hashCode {
    final List<Object?> values = <Object?>[
      ctrlC,
      ctrlV,
      copyButton,
      pasteButton,
      copyIcon,
      pasteIcon,
      copyTooltip,
      pasteTooltip,
      copyFormat,
      longPressMenu,
      editFieldCopyButton,
      menuIconThemeData,
      menuThemeData,
      menuWidth,
      menuItemHeight,
      snackBarParseError,
      snackBarMessage,
      snackBarDuration,
      feedbackParseError,
      // TODO: This property is no longer needed, remove it before publishing.
      // autoFocus,
      editUsesParsedPaste,
    ];
    return hashList(values);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('ctrlC', ctrlC));
    properties.add(DiagnosticsProperty<bool>('ctrlV', ctrlV));
    properties.add(DiagnosticsProperty<bool>('copyButton', copyButton));
    properties.add(DiagnosticsProperty<bool>('pasteButton', pasteButton));
    properties.add(DiagnosticsProperty<IconData>('copyIcon', copyIcon));
    properties.add(DiagnosticsProperty<IconData>('pasteIcon', pasteIcon));
    properties.add(StringProperty('copyTooltip', copyTooltip));
    properties.add(StringProperty('pasteTooltip', pasteTooltip));
    properties
        .add(EnumProperty<ColorPickerCopyFormat>('copyFormat', copyFormat));
    properties.add(DiagnosticsProperty<bool>('longPressMenu', longPressMenu));
    properties.add(
        DiagnosticsProperty<bool>('editFieldCopyButton', editFieldCopyButton));
    properties.add(DiagnosticsProperty<IconThemeData?>(
        'menuIconThemeData', menuIconThemeData));
    properties.add(DiagnosticsProperty<PopupMenuThemeData?>(
        'menuThemeData', menuThemeData));
    properties.add(DoubleProperty('menuWidth', menuWidth));
    properties.add(DoubleProperty('menuItemHeight', menuItemHeight));
    properties.add(
        DiagnosticsProperty<bool>('snackBarParseError', snackBarParseError));
    properties
        .add(DiagnosticsProperty<Widget?>('snackBarMessage', snackBarMessage));
    properties.add(
        DiagnosticsProperty<Duration>('snackBarDuration', snackBarDuration));
    properties.add(
        DiagnosticsProperty<bool>('feedbackParseError', feedbackParseError));
    // TODO: This property is no longer needed, remove it before publishing.
    // properties.add(DiagnosticsProperty<bool>('autoFocus', autoFocus));
    properties.add(
        DiagnosticsProperty<bool>('editUsesParsedPaste', editUsesParsedPaste));
  }
}
