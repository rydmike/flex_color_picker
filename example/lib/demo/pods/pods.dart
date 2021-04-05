import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../utils/store.dart';

// Simple Riverpod State providers, that I call "Pod:s" as it is nice and short,
// and it might even become the official new name for Riverpod providers.
//
// This demo app is perhaps a bit a-typical in the sense that we want every
// toggle to update something as it happens while minimizing re-builds as
// much as possible. All the properties are just simple values, maps or simple
// objects like 'Color' so a simple StateProvider for each property works
// rather nicely and is simple to use, there is just a lot of them.
//
// Still using each "Pod" in an individual widgets to toggle each
// state provider's state, is pretty easy and simple to do and maintain.
//
// Most of these state providers red their default value from a Hive box, where
// the last used value of the state provider is stored, if there is no value
// for it in the hive box, they fall back to a lookup key value from const
// { string_key : default_value } map. The string key has its onw const value
// as well and it is used both as key for the default value map and as name
// of the state provider. By giving the state providers unique names, we can
// find them in a ProviderObserver and store their new value in the the Hive
// box when their state value changes.
//
// For more complex use cases and classes, use StateNotifierProvider instead of
// StateProvider, but in this case we want to track the state change of each
// individual value below, and rebuild only needed parts for its change and to
// store/update only that particular value in the Hive box when it changed.

// A ref to the used Hive box, it should be opened before you use it, which it
// will be since we open it once at the start of the app and don't close it
// anywhere in this color picker demo app.
final Box<dynamic> _box = Hive.box<dynamic>(Store.box);

// themeModePod is a [StateProvider] to provide the state of
// the [ThemeMode], used to toggle the application wide theme mode.
final StateProvider<ThemeMode> themeModePod =
    StateProvider<ThemeMode>((ProviderReference ref) {
  return _box.get(Store.themeMode,
      defaultValue: Store.defaults[Store.themeMode]! as ThemeMode) as ThemeMode;
}, name: Store.themeMode);

// The other plethora f other state providers are all related to manipulating
// input and view output from the FlexColorPicker.

// StateProvider for the color we give to the color picker on the card.
final StateProvider<Color> cardPickerColorPod =
    StateProvider<Color>((ProviderReference ref) {
  return _box.get(Store.cardPickerColor,
      defaultValue: Store.defaults[Store.cardPickerColor]! as Color) as Color;
}, name: Store.cardPickerColor);

// StateProvider for the color we give to the color picker in the dialog.
final StateProvider<Color> dialogPickerColorPod =
    StateProvider<Color>((ProviderReference ref) {
  return _box.get(Store.dialogPickerColor,
      defaultValue: Store.defaults[Store.dialogPickerColor]! as Color) as Color;
}, name: Store.dialogPickerColor);

// StateProviders for the color we get back via onColorChangeStart callback.
final StateProvider<Color> onColorChangeStartPod =
    StateProvider<Color>((ProviderReference ref) {
  return Colors.white;
});

// StateProviders for the color we get back via onColorChanged callback
final StateProvider<Color> onColorChangedPod =
    StateProvider<Color>((ProviderReference ref) {
  return Colors.white;
});

// StateProviders for the color we get back via onColorChangeEnd callback
final StateProvider<Color> onColorChangeEndPod =
    StateProvider<Color>((ProviderReference ref) {
  return Colors.white;
});

// StateProvider for the recently used colors for color picker on the card.
// We could start with some specific list as well. We get a new list of
// recently used colors back from the color picker whenever a new color is
// selected and its internal list is updated, the callback for this is
// `onRecentColorsChanged`. We just update the entire list state with the
// new list we get from the picker. Using the callback is optional, but you
// could use it to store recently used colors during the session or even
// between sessions.
final StateProvider<List<Color>> cardRecentColorsPod =
    StateProvider<List<Color>>(
  (ProviderReference ref) {
    // ignore: avoid_dynamic_calls
    return _box
        .get(Store.cardRecentColors,
            defaultValue:
                Store.defaults[Store.cardRecentColors]! as List<Color>)
        .cast<Color>() as List<Color>;
  },
  name: Store.cardRecentColors,
);

// StateProvider for the recently used colors for color picker in the dialog.
final StateProvider<List<Color>> dialogRecentColorsPod =
    StateProvider<List<Color>>((ProviderReference ref) {
  // ignore: avoid_dynamic_calls
  return _box
      .get(Store.dialogRecentColors,
          defaultValue:
              Store.defaults[Store.dialogRecentColors]! as List<Color>)
      .cast<Color>() as List<Color>;
}, name: Store.dialogRecentColors);

// ****************************************************************************
// The rest of the providers all deal with the API input settings for the
// FlexColorPicker demo. They are mostly in the order they appear on the screen.
// ****************************************************************************

// ****************************************************************************
//  Show and Hide Riverpod "Pod" providers.
// ****************************************************************************

// State of enabled color pickers.
final StateProvider<Map<ColorPickerType, bool>> pickersEnabledPod =
    StateProvider<Map<ColorPickerType, bool>>((ProviderReference ref) {
  // ignore: avoid_dynamic_calls
  return _box
      .get(Store.pickersEnabled,
          defaultValue: Store.defaults[Store.pickersEnabled]!
              as Map<ColorPickerType, bool>)
      .cast<ColorPickerType, bool>() as Map<ColorPickerType, bool>;
}, name: Store.pickersEnabled);

// State of shades color selection.
final StateProvider<bool> enableShadesSelectionPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.enableShadesSelection,
          defaultValue: Store.defaults[Store.enableShadesSelection]! as bool)
      as bool;
}, name: Store.enableShadesSelection);

// State of including index 850 for grey color.
final StateProvider<bool> includeIndex850Pod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.includeIndex850,
      defaultValue: Store.defaults[Store.includeIndex850]! as bool) as bool;
}, name: Store.includeIndex850);

// State of enabling opacity for color.
final StateProvider<bool> enableOpacityPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.enableOpacity,
      defaultValue: Store.defaults[Store.enableOpacity]! as bool) as bool;
}, name: Store.enableOpacity);

// State of showing Material color name.
final StateProvider<bool> showMaterialNamePod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.showMaterialName,
      defaultValue: Store.defaults[Store.showMaterialName]! as bool) as bool;
}, name: Store.showMaterialName);

// State of showing general color name.
final StateProvider<bool> showColorNamePod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.showColorName,
      defaultValue: Store.defaults[Store.showColorName]! as bool) as bool;
}, name: Store.showColorName);

// State of showing color code edit-display field: on/off.
final StateProvider<bool> showColorCodePod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.showColorCode,
      defaultValue: Store.defaults[Store.showColorCode]! as bool) as bool;
}, name: Store.showColorCode);

// State of showing color code using color as background.
final StateProvider<bool> colorCodeHasColorPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.colorCodeHasColor,
      defaultValue: Store.defaults[Store.colorCodeHasColor]! as bool) as bool;
}, name: Store.colorCodeHasColor);

// State of color code field being read only.
final StateProvider<bool> colorCodeReadOnlyPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.colorCodeReadOnly,
      defaultValue: Store.defaults[Store.colorCodeReadOnly]! as bool) as bool;
}, name: Store.colorCodeReadOnly);

// State of showing color code int value.
final StateProvider<bool> showColorValuePod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.showColorValue,
      defaultValue: Store.defaults[Store.showColorValue]! as bool) as bool;
}, name: Store.showColorValue);

// State of showing recently used colors.
final StateProvider<bool> showRecentColorsPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.showRecentColors,
      defaultValue: Store.defaults[Store.showRecentColors]! as bool) as bool;
}, name: Store.showRecentColors);

// State of showing title.
final StateProvider<bool> showTitlePod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.showTitle,
      defaultValue: Store.defaults[Store.showTitle]! as bool) as bool;
}, name: Store.showTitle);

// State of showing heading.
final StateProvider<bool> showHeadingPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.showHeading,
      defaultValue: Store.defaults[Store.showHeading]! as bool) as bool;
}, name: Store.showHeading);

// State of showing sub heading, for both swatch color pickers and wheel.
final StateProvider<bool> showSubheadingPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.showSubheading,
      defaultValue: Store.defaults[Store.showSubheading]! as bool) as bool;
}, name: Store.showSubheading);

// State of showing subheading for opacity control.
final StateProvider<bool> showOpacitySubheadingPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.showOpacitySubheading,
          defaultValue: Store.defaults[Store.showOpacitySubheading]! as bool)
      as bool;
}, name: Store.showOpacitySubheading);

// State of showing sub heading for recently used colors.
final StateProvider<bool> showRecentSubheadingPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.showRecentSubheading,
          defaultValue: Store.defaults[Store.showRecentSubheading]! as bool)
      as bool;
}, name: Store.showRecentSubheading);

// ****************************************************************************
//  Picker Design Riverpod "Pod" providers.
// ****************************************************************************

// State of picker item size.
final StateProvider<double> sizePod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.size,
      defaultValue: Store.defaults[Store.size]! as double) as double;
}, name: Store.size);

// State of picker item border radius.
final StateProvider<double> borderRadiusPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.borderRadius,
      defaultValue: Store.defaults[Store.borderRadius]! as double) as double;
}, name: Store.borderRadius);

// State of picker item elevation.
final StateProvider<double> elevationPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.elevation,
      defaultValue: Store.defaults[Store.elevation]! as double) as double;
}, name: Store.elevation);

// State of picker item spacing.
final StateProvider<double> spacingPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.spacing,
      defaultValue: Store.defaults[Store.spacing]! as double) as double;
}, name: Store.spacing);

// State of picker item run spacing.
final StateProvider<double> runSpacingPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.runSpacing,
      defaultValue: Store.defaults[Store.runSpacing]! as double) as double;
}, name: Store.runSpacing);

// State of using border on picker items.
final StateProvider<bool> hasBorderPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.hasBorder,
      defaultValue: Store.defaults[Store.hasBorder]! as bool) as bool;
}, name: Store.hasBorder);

// State of wheel diameter.
final StateProvider<double> wheelDiameterPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.wheelDiameter,
      defaultValue: Store.defaults[Store.wheelDiameter]! as double) as double;
}, name: Store.wheelDiameter);

// State of wheel width.
final StateProvider<double> wheelWidthPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.wheelWidth,
      defaultValue: Store.defaults[Store.wheelWidth]! as double) as double;
}, name: Store.wheelWidth);

// State of using border on wheel picker .
final StateProvider<bool> wheelHasBorderPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.wheelHasBorder,
      defaultValue: Store.defaults[Store.wheelHasBorder]! as bool) as bool;
}, name: Store.wheelHasBorder);

// State of used height on color opacity slider.
final StateProvider<double> opacityTrackHeightPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.opacityTrackHeight,
          defaultValue: Store.defaults[Store.opacityTrackHeight]! as double)
      as double;
}, name: Store.opacityTrackHeight);

// State of used width on color opacity slider.
final StateProvider<double> opacityTrackWidthPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.opacityTrackWidth,
          defaultValue: Store.defaults[Store.opacityTrackWidth]! as double)
      as double;
}, name: Store.opacityTrackWidth);

// State of used thumb radius on color opacity slider.
final StateProvider<double> opacityThumbRadiusPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.opacityThumbRadius,
          defaultValue: Store.defaults[Store.opacityThumbRadius]! as double)
      as double;
}, name: Store.opacityThumbRadius);

// State of showing tooltips.
final StateProvider<bool> enableTooltipsPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.enableTooltips,
      defaultValue: Store.defaults[Store.enableTooltips]! as bool) as bool;
}, name: Store.enableTooltips);

// ****************************************************************************
//  Picker Layout Riverpod "Pod" providers.
// ****************************************************************************

// State of used alignment in the color picker
final StateProvider<CrossAxisAlignment> alignmentPod =
    StateProvider<CrossAxisAlignment>((ProviderReference ref) {
  return _box.get(Store.alignment,
          defaultValue: Store.defaults[Store.alignment]! as CrossAxisAlignment)
      as CrossAxisAlignment;
}, name: Store.alignment);

// State of used spacing between each item in the column in the picker.
final StateProvider<double> columnSpacingPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.columnSpacing,
      defaultValue: Store.defaults[Store.columnSpacing]! as double) as double;
}, name: Store.columnSpacing);

// State of used padding surrounding the content around the picker.
final StateProvider<double> paddingPod =
    StateProvider<double>((ProviderReference ref) {
  return _box.get(Store.padding,
      defaultValue: Store.defaults[Store.padding]! as double) as double;
}, name: Store.padding);

// State of using a close button on dialog toolbar.
final StateProvider<bool> closeButtonPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.closeButton,
      defaultValue: Store.defaults[Store.closeButton]! as bool) as bool;
}, name: Store.closeButton);

// State of using a OK button on dialog toolbar.
final StateProvider<bool> okButtonPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.okButton,
      defaultValue: Store.defaults[Store.okButton]! as bool) as bool;
}, name: Store.okButton);

// State of using having close button as last action on dialog toolbar.
final StateProvider<bool> closeIsLastPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.closeIsLast,
      defaultValue: Store.defaults[Store.closeIsLast]! as bool) as bool;
}, name: Store.closeIsLast);

// State of having Cancel OK bottom action in the dialog.
final StateProvider<bool> dialogActionButtonsPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.dialogActionButtons,
      defaultValue: Store.defaults[Store.dialogActionButtons]! as bool) as bool;
}, name: Store.dialogActionButtons);

// State of having icons on Cancel OK bottom actions buttons in the dialog.
final StateProvider<bool> dialogActionIconsPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.dialogActionIcons,
      defaultValue: Store.defaults[Store.dialogActionIcons]! as bool) as bool;
}, name: Store.dialogActionIcons);

// ****************************************************************************
//  Copy Paste Actions Riverpod "Pod" providers.
// ****************************************************************************

// State of used color code COPY format.
final StateProvider<ColorPickerCopyFormat> copyFormatPod =
    StateProvider<ColorPickerCopyFormat>((ProviderReference ref) {
  return _box.get(Store.copyFormat,
      defaultValue: Store.defaults[Store.copyFormat]!
          as ColorPickerCopyFormat) as ColorPickerCopyFormat;
}, name: Store.copyFormat);

// State of using CTRL-C keyboard shortcut.
final StateProvider<bool> ctrlCPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.ctrlC,
      defaultValue: Store.defaults[Store.ctrlC]! as bool) as bool;
}, name: Store.ctrlC);

// State of using CTRL-V keyboard shortcut.
final StateProvider<bool> ctrlVPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.ctrlV,
      defaultValue: Store.defaults[Store.ctrlV]! as bool) as bool;
}, name: Store.ctrlV);

// State of using Copy button on toolbar.
final StateProvider<bool> copyButtonPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.copyButton,
      defaultValue: Store.defaults[Store.copyButton]! as bool) as bool;
}, name: Store.copyButton);

// State of using Paste button on toolbar.
final StateProvider<bool> pasteButtonPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.pasteButton,
      defaultValue: Store.defaults[Store.pasteButton]! as bool) as bool;
}, name: Store.pasteButton);

// State of using Paste button on edit code field.
final StateProvider<bool> editFieldCopyButtonPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.editFieldCopyButton,
      defaultValue: Store.defaults[Store.editFieldCopyButton]! as bool) as bool;
}, name: Store.editFieldCopyButton);

// State of using long press copy-paste context menu.
final StateProvider<bool> longPressMenuPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.longPressMenu,
      defaultValue: Store.defaults[Store.longPressMenu]! as bool) as bool;
}, name: Store.longPressMenu);

// State of using secondary (right) click copy-paste context menu.
final StateProvider<bool> secondaryMenuPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.secondaryMenu,
      defaultValue: Store.defaults[Store.secondaryMenu]! as bool) as bool;
}, name: Store.secondaryMenu);

// State of using secondary (right) click on desktop and long press
// on devices to show the copy-paste context menu
final StateProvider<bool> secondaryDesktopOtherLongPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.secondaryDesktopOtherLong,
      defaultValue:
          Store.defaults[Store.secondaryDesktopOtherLong]! as bool) as bool;
}, name: Store.secondaryDesktopOtherLong);

// State of if Web 3-char code RGB, should be interpreted as RRGGBB.
final StateProvider<bool> parseShortHexCodePod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.parseShortHexCode,
      defaultValue: Store.defaults[Store.parseShortHexCode]! as bool) as bool;
}, name: Store.parseShortHexCode);

// State of if text edit field should use code parser on keyboard paste.
final StateProvider<bool> editUsesParsedPastePod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.editUsesParsedPaste,
      defaultValue: Store.defaults[Store.editUsesParsedPaste]! as bool) as bool;
}, name: Store.editUsesParsedPaste);

// State of if color code parse error should result in a snackbar error message.
final StateProvider<bool> snackbarParseErrorPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.snackbarParseError,
      defaultValue: Store.defaults[Store.snackbarParseError]! as bool) as bool;
}, name: Store.snackbarParseError);

// State of if color code parse error should give audible and vibration alert.
final StateProvider<bool> feedbackParseErrorPod =
    StateProvider<bool>((ProviderReference ref) {
  return _box.get(Store.feedbackParseError,
      defaultValue: Store.defaults[Store.feedbackParseError]! as bool) as bool;
}, name: Store.feedbackParseError);
