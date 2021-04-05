import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

/// Key constants for key-value pairs for storing the settings as well
/// as a map with default value for each key-value pair settings.
/// The keys are also used as named for Riverpod "pod" state providers.
class Store {
  // This class is not meant to be instantiated or extended, this constructor
  // prevents external instantiation and extension.
  Store._();

  // Hive constants
  static const String folder = 'color_picker_demo';
  static const String box = 'picker_settings';
  // Hive string keys
  //
  // Key for theme mode, we will persist it too.
  static const String themeMode = 'themeMode';
  // Keys for the selected colors and recent colors.
  static const String cardPickerColor = 'cardPickerColor';
  static const String dialogPickerColor = 'dialogPickerColor';
  static const String cardRecentColors = 'cardRecentColors';
  static const String dialogRecentColors = 'dialogRecentColors';
  // Show and Hide River "" providers.
  static const String pickersEnabled = 'pickersEnabled';
  static const String enableShadesSelection = 'enableShadesSelection';
  static const String includeIndex850 = 'includeIndex850';
  static const String enableOpacity = 'enableOpacity';
  static const String showMaterialName = 'showMaterialName';
  static const String showColorName = 'showColorName';
  static const String showColorCode = 'showColorCode';
  static const String colorCodeHasColor = 'colorCodeHasColor';
  static const String colorCodeReadOnly = 'colorCodeReadOnly';
  static const String showColorValue = 'showColorValue';
  static const String showRecentColors = 'showRecentColors';
  static const String showTitle = 'showTitle';
  static const String showHeading = 'showHeading';
  static const String showSubheading = 'showSubheading';
  static const String showOpacitySubheading = 'showOpacitySubheading';
  static const String showRecentSubheading = 'showRecentSubheading';
  // Picker Design River "" providers.
  static const String size = 'size';
  static const String borderRadius = 'borderRadius';
  static const String elevation = 'elevation';
  static const String spacing = 'spacing';
  static const String runSpacing = 'runSpacing';
  static const String hasBorder = 'hasBorder';
  static const String wheelDiameter = 'wheelDiameter';
  static const String wheelWidth = 'wheelWidth';
  static const String wheelHasBorder = 'wheelHasBorder';
  static const String opacityTrackHeight = 'opacityTrackHeight';
  static const String opacityTrackWidth = 'opacityTrackWidth';
  static const String opacityThumbRadius = 'opacityThumbRadius';
  static const String enableTooltips = 'enableTooltips';
  // Picker Layout River "" providers.
  static const String alignment = 'alignment';
  static const String columnSpacing = 'columnSpacing';
  static const String padding = 'padding';
  static const String closeButton = 'closeButton';
  static const String okButton = 'okButton';
  static const String closeIsLast = 'closeIsLast';
  static const String dialogActionButtons = 'dialogActionButtons';
  static const String dialogActionIcons = 'dialogActionIcons';
  // Copy Paste Actions River "" providers.
  static const String copyFormat = 'copyFormat';
  static const String ctrlC = 'ctrlC';
  static const String ctrlV = 'ctrlV';
  static const String copyButton = 'copyButton';
  static const String pasteButton = 'pasteButton';
  static const String editFieldCopyButton = 'editFieldCopyButton';
  static const String longPressMenu = 'longPressMenu';
  static const String secondaryMenu = 'secondaryMenu';
  static const String secondaryDesktopOtherLong = 'secondaryDesktopOtherLong';
  static const String parseShortHexCode = 'parseShortHexCode';
  static const String editUsesParsedPaste = 'editUsesParsedPaste';
  static const String snackbarParseError = 'snackbarParseError';
  static const String feedbackParseError = 'feedbackParseError';

  static const Map<String, Object> defaults = <String, Object>{
    themeMode: ThemeMode.system,
    // Keys for the selected colors and recent colors.
    cardPickerColor: Color(0xFF2196F3),
    dialogPickerColor: Color(0xFFF44336),
    cardRecentColors: <Color>[],
    dialogRecentColors: <Color>[],
    // Show and Hide River "" providers.
    pickersEnabled: <ColorPickerType, bool>{
      ColorPickerType.both: false,
      ColorPickerType.primary: true,
      ColorPickerType.accent: true,
      ColorPickerType.bw: false,
      ColorPickerType.custom: true,
      ColorPickerType.wheel: true,
    },
    enableShadesSelection: true,
    includeIndex850: false,
    enableOpacity: true,
    showMaterialName: true,
    showColorName: true,
    showColorCode: true,
    colorCodeHasColor: true,
    colorCodeReadOnly: false,
    showColorValue: false,
    showRecentColors: true,
    showTitle: true,
    showHeading: false,
    showSubheading: true,
    showOpacitySubheading: false,
    showRecentSubheading: true,
    // Picker Design River "" providers.
    size: 40.0,
    borderRadius: 4.0,
    elevation: 0.0,
    spacing: 4.0,
    runSpacing: 4.0,
    hasBorder: false,
    wheelDiameter: 190.0,
    wheelWidth: 16.0,
    wheelHasBorder: false,
    opacityTrackHeight: 22.0,
    opacityTrackWidth: 700.0,
    opacityThumbRadius: 16.0,
    enableTooltips: true,
    // Picker Layout River "" providers.
    alignment: CrossAxisAlignment.center,
    columnSpacing: 8.0,
    padding: 10.0,
    closeButton: true,
    okButton: true,
    closeIsLast: true,
    dialogActionButtons: true,
    dialogActionIcons: true,
    // Copy Paste Actions River "" providers.
    copyFormat: ColorPickerCopyFormat.dartCode,
    ctrlC: true,
    ctrlV: true,
    copyButton: true,
    pasteButton: true,
    editFieldCopyButton: true,
    longPressMenu: true,
    secondaryMenu: false,
    secondaryDesktopOtherLong: false,
    parseShortHexCode: true,
    editUsesParsedPaste: true,
    snackbarParseError: true,
    feedbackParseError: false,
  };
}
