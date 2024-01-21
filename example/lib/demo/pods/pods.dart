import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../store/hive_store.dart';
import '../utils/keys.dart';

// Simple Riverpod State providers, that are called "Pod:s" in this app, just
// because it is nice and short, and it might even become the official new
// name for Riverpod providers.
//
// This demo app is perhaps a bit "a-typical" in the sense that we want every
// toggle on the SettingScreen to update something as it happens while
// minimizing re-builds as much as possible. All the properties are just simple
// values, maps or simple objects like 'Color', so a StateProvider for each
// property works rather nicely and is simple to use, there is just a lot of
// them.
//
// Still using each "Pod" in an individual widgets to toggle each
// state provider's state, is pretty easy and simple to do and maintain.
//
// Most of these state providers read their default value from a Hive box, where
// the last used value of the state provider is stored, if there is no value
// for it in the Hive box, they fall back to a lookup key value from const
// { string_key : default_value } Map. The string key has its own const value
// as well and it is used both as key for the default value map and as name
// of its StateProvider. By giving the StateProviders unique names, we can
// find them in a ProviderObserver and store their new value in the the Hive
// box when their state value changes.
//
// For more complex use cases and classes, use a StateNotifierProvider instead
// of StateProvider, but in this case we want to track the state change of each
// individual value below, and rebuild only needed parts when it changes, and to
// store/update only that particular value in the Hive box when it changed.
// If we would have all the properties in a state notifier and use a state
// notifier provider, we would get notified when any of all these properties
// changed.
//
// With a ChangeNotifier and using a Selector we could also do this,
// but then we are using mutable state variables. Using a ChangeNotifier, with
// setter and getter for each property that also persist them as they are
// changed, we can do a similar thing to this setup. Each property's UI widget
// could then also use a selector to only rebuild when it is updated. One could
// argue that using mutable state this way might even be simpler or preferred
// over this implementation. This was also an experiment and test to see if this
// can be done like this and how it feels.
//
// With this amount of control value (there are 55 of them that are persisted)
// it is becoming a bit tedious to do it this ways too. However, bare in mind
// that with a ChangeNotifier, there would need to be a local property and
// both a setter and getter for each StateProvider below. Plus a separate
// Hive save (put) call for each setter.
//
// The Hive save is now a single line in the ProviderObserver, and the
// StateProviders are initialized from the Hive box below, or via default
// const map if the Hive box has no value fro the named StateProvider that uses
// the same const value as name as the key used in the Hive box. It is actually
// quite compact considering  all it does.
//
// We do however have to deal with dynamic's and type casts to
// make this work, but since it is all based type safe providers and const
// values as keys we keep uniques in a const map, it is fairly safe as long as
// we don't use the wrong key for a provider when we get the value.

// The themeModePod is a [StateProvider] to provide the state of
// the [ThemeMode] used to toggle the application's theme mode.
final StateProvider<ThemeMode> themeModePod =
    StateProvider<ThemeMode>((StateProviderRef<ThemeMode> ref) {
  return hiveStore.get(Keys.themeMode,
      defaultValue: Keys.defaults[Keys.themeMode]! as ThemeMode) as ThemeMode;
}, name: Keys.themeMode);

// All the other state providers are all related to manipulating
// input to to the FlexColorPicker and to track some output from it as well.

// StateProvider for the color we give to the color picker on the card.
final StateProvider<Color> cardPickerColorPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(Keys.cardPickerColor,
      defaultValue: Keys.defaults[Keys.cardPickerColor]! as Color) as Color;
}, name: Keys.cardPickerColor);

// StateProvider for the color we give to the color picker in the dialog.
final StateProvider<Color> dialogPickerColorPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return hiveStore.get(Keys.dialogPickerColor,
      defaultValue: Keys.defaults[Keys.dialogPickerColor]! as Color) as Color;
}, name: Keys.dialogPickerColor);

// StateProvider for the color we get back via onColorChangeStart callback.
final StateProvider<Color> onColorChangeStartPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return Colors.white;
});

// StateProvider for the color we get back via onColorChanged callback
final StateProvider<Color> onColorChangedPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return Colors.white;
});

// StateProvider for the color we get back via onColorChangeEnd callback
final StateProvider<Color> onColorChangeEndPod =
    StateProvider<Color>((StateProviderRef<Color> ref) {
  return Colors.white;
});

// StateProvider for the recently used colors for color picker on the card.
final StateProvider<List<Color>> cardRecentColorsPod =
    StateProvider<List<Color>>(
  (StateProviderRef<List<Color>> ref) {
    // ignore: avoid_dynamic_calls
    return hiveStore
        .get(Keys.cardRecentColors,
            defaultValue: Keys.defaults[Keys.cardRecentColors]! as List<Color>)
        .cast<Color>() as List<Color>;
  },
  name: Keys.cardRecentColors,
);

// StateProvider for the recently used colors for color picker in the dialog.
final StateProvider<List<Color>> dialogRecentColorsPod =
    StateProvider<List<Color>>((StateProviderRef<List<Color>> ref) {
  // ignore: avoid_dynamic_calls
  return hiveStore
      .get(Keys.dialogRecentColors,
          defaultValue: Keys.defaults[Keys.dialogRecentColors]! as List<Color>)
      .cast<Color>() as List<Color>;
}, name: Keys.dialogRecentColors);

// ****************************************************************************
// The rest of the providers all deal with the API input settings for the
// FlexColorPicker demo. They are mostly in the order they appear on the screen.
// ****************************************************************************

// ****************************************************************************
//  Show and Hide Riverpod "Pod" providers.
// ****************************************************************************

// State of enabled color pickers.
final StateProvider<Map<ColorPickerType, bool>> pickersEnabledPod =
    StateProvider<Map<ColorPickerType, bool>>(
        (StateProviderRef<Map<ColorPickerType, bool>> ref) {
  // ignore: avoid_dynamic_calls
  return hiveStore
      .get(Keys.pickersEnabled,
          defaultValue:
              Keys.defaults[Keys.pickersEnabled]! as Map<ColorPickerType, bool>)
      .cast<ColorPickerType, bool>() as Map<ColorPickerType, bool>;
}, name: Keys.pickersEnabled);

// State of shades color selection.
final StateProvider<bool> enableShadesSelectionPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.enableShadesSelection,
      defaultValue: Keys.defaults[Keys.enableShadesSelection]! as bool) as bool;
}, name: Keys.enableShadesSelection);

// State of shades color selection.
final StateProvider<bool> enableTonesSelectionPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.enableTonesSelection,
      defaultValue: Keys.defaults[Keys.enableTonesSelection]! as bool) as bool;
}, name: Keys.enableTonesSelection);

// State of using same size tonal color items.
final StateProvider<bool> tonalSameSizePod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.tonalSameSize,
      defaultValue: Keys.defaults[Keys.tonalSameSize]! as bool) as bool;
}, name: Keys.tonalSameSize);

// State of including index 850 for grey color.
final StateProvider<bool> includeIndex850Pod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.includeIndex850,
      defaultValue: Keys.defaults[Keys.includeIndex850]! as bool) as bool;
}, name: Keys.includeIndex850);

// State of enabling opacity for color.
final StateProvider<bool> enableOpacityPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.enableOpacity,
      defaultValue: Keys.defaults[Keys.enableOpacity]! as bool) as bool;
}, name: Keys.enableOpacity);

// State of enabling transparency for custom colors.
final StateProvider<bool> enableTransparencyPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.enableTransparency,
      defaultValue: Keys.defaults[Keys.enableTransparency]! as bool) as bool;
}, name: Keys.enableTransparency);

// State of showing Material color name.
final StateProvider<bool> showMaterialNamePod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showMaterialName,
      defaultValue: Keys.defaults[Keys.showMaterialName]! as bool) as bool;
}, name: Keys.showMaterialName);

// State of showing general color name.
final StateProvider<bool> showColorNamePod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showColorName,
      defaultValue: Keys.defaults[Keys.showColorName]! as bool) as bool;
}, name: Keys.showColorName);

// State of showing color code edit-display field: on/off.
final StateProvider<bool> showColorCodePod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showColorCode,
      defaultValue: Keys.defaults[Keys.showColorCode]! as bool) as bool;
}, name: Keys.showColorCode);

// State of showing color code using color as background.
final StateProvider<bool> colorCodeHasColorPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.colorCodeHasColor,
      defaultValue: Keys.defaults[Keys.colorCodeHasColor]! as bool) as bool;
}, name: Keys.colorCodeHasColor);

// State of color code field being read only.
final StateProvider<bool> colorCodeReadOnlyPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.colorCodeReadOnly,
      defaultValue: Keys.defaults[Keys.colorCodeReadOnly]! as bool) as bool;
}, name: Keys.colorCodeReadOnly);

// State of showing color code int value.
final StateProvider<bool> showColorValuePod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showColorValue,
      defaultValue: Keys.defaults[Keys.showColorValue]! as bool) as bool;
}, name: Keys.showColorValue);

// State of showing recently used colors.
final StateProvider<bool> showRecentColorsPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showRecentColors,
      defaultValue: Keys.defaults[Keys.showRecentColors]! as bool) as bool;
}, name: Keys.showRecentColors);

// State of showing title.
final StateProvider<bool> showTitlePod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showTitle,
      defaultValue: Keys.defaults[Keys.showTitle]! as bool) as bool;
}, name: Keys.showTitle);

// State of showing heading.
final StateProvider<bool> showHeadingPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showHeading,
      defaultValue: Keys.defaults[Keys.showHeading]! as bool) as bool;
}, name: Keys.showHeading);

// State of showing sub heading, for both swatch color pickers and wheel.
final StateProvider<bool> showSubheadingPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showSubheading,
      defaultValue: Keys.defaults[Keys.showSubheading]! as bool) as bool;
}, name: Keys.showSubheading);

// State of showing tonal sub heading, for both swatch color pickers and wheel.
final StateProvider<bool> showTonalSubheadingPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showTonalSubheading,
      defaultValue: Keys.defaults[Keys.showTonalSubheading]! as bool) as bool;
}, name: Keys.showTonalSubheading);

// State of showing subheading for opacity control.
final StateProvider<bool> showOpacitySubheadingPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showOpacitySubheading,
      defaultValue: Keys.defaults[Keys.showOpacitySubheading]! as bool) as bool;
}, name: Keys.showOpacitySubheading);

// State of showing sub heading for recently used colors.
final StateProvider<bool> showRecentSubheadingPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.showRecentSubheading,
      defaultValue: Keys.defaults[Keys.showRecentSubheading]! as bool) as bool;
}, name: Keys.showRecentSubheading);

// ****************************************************************************
//  Picker Design Riverpod "Pod" providers.
// ****************************************************************************

// State of picker item size.
final StateProvider<double> sizePod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.size,
      defaultValue: Keys.defaults[Keys.size]! as double) as double;
}, name: Keys.size);

// State of picker item border radius.
final StateProvider<double> borderRadiusPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.borderRadius,
      defaultValue: Keys.defaults[Keys.borderRadius]! as double) as double;
}, name: Keys.borderRadius);

// State of picker item elevation.
final StateProvider<double> elevationPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.elevation,
      defaultValue: Keys.defaults[Keys.elevation]! as double) as double;
}, name: Keys.elevation);

// State of picker item spacing.
final StateProvider<double> spacingPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.spacing,
      defaultValue: Keys.defaults[Keys.spacing]! as double) as double;
}, name: Keys.spacing);

// State of picker item run spacing.
final StateProvider<double> runSpacingPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.runSpacing,
      defaultValue: Keys.defaults[Keys.runSpacing]! as double) as double;
}, name: Keys.runSpacing);

// State of using border on picker items.
final StateProvider<bool> hasBorderPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.hasBorder,
      defaultValue: Keys.defaults[Keys.hasBorder]! as bool) as bool;
}, name: Keys.hasBorder);

// State of wheel diameter.
final StateProvider<double> wheelDiameterPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.wheelDiameter,
      defaultValue: Keys.defaults[Keys.wheelDiameter]! as double) as double;
}, name: Keys.wheelDiameter);

// State of wheel width.
final StateProvider<double> wheelWidthPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.wheelWidth,
      defaultValue: Keys.defaults[Keys.wheelWidth]! as double) as double;
}, name: Keys.wheelWidth);

// State of wheel square padding.
final StateProvider<double> wheelSquarePaddingPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.wheelSquarePadding,
          defaultValue: Keys.defaults[Keys.wheelSquarePadding]! as double)
      as double;
}, name: Keys.wheelSquarePadding);

// State of wheel square padding border radius.
final StateProvider<double> wheelSquareBorderRadiusPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.wheelSquareBorderRadius,
          defaultValue: Keys.defaults[Keys.wheelSquareBorderRadius]! as double)
      as double;
}, name: Keys.wheelSquareBorderRadius);

// State of using border on wheel picker .
final StateProvider<bool> wheelHasBorderPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.wheelHasBorder,
      defaultValue: Keys.defaults[Keys.wheelHasBorder]! as bool) as bool;
}, name: Keys.wheelHasBorder);

// State of used height on color opacity slider.
final StateProvider<double> opacityTrackHeightPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.opacityTrackHeight,
          defaultValue: Keys.defaults[Keys.opacityTrackHeight]! as double)
      as double;
}, name: Keys.opacityTrackHeight);

// State of used width on color opacity slider.
final StateProvider<double> opacityTrackWidthPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.opacityTrackWidth,
      defaultValue: Keys.defaults[Keys.opacityTrackWidth]! as double) as double;
}, name: Keys.opacityTrackWidth);

// State of used thumb radius on color opacity slider.
final StateProvider<double> opacityThumbRadiusPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.opacityThumbRadius,
          defaultValue: Keys.defaults[Keys.opacityThumbRadius]! as double)
      as double;
}, name: Keys.opacityThumbRadius);

// State of showing tooltips.
final StateProvider<bool> enableTooltipsPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.enableTooltips,
      defaultValue: Keys.defaults[Keys.enableTooltips]! as bool) as bool;
}, name: Keys.enableTooltips);

// ****************************************************************************
//  Picker Layout Riverpod "Pod" providers.
// ****************************************************************************

// State of used alignment in the color picker
final StateProvider<CrossAxisAlignment> alignmentPod =
    StateProvider<CrossAxisAlignment>(
        (StateProviderRef<CrossAxisAlignment> ref) {
  return hiveStore.get(Keys.alignment,
          defaultValue: Keys.defaults[Keys.alignment]! as CrossAxisAlignment)
      as CrossAxisAlignment;
}, name: Keys.alignment);

// State of used spacing between each item in the column in the picker.
final StateProvider<double> columnSpacingPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.columnSpacing,
      defaultValue: Keys.defaults[Keys.columnSpacing]! as double) as double;
}, name: Keys.columnSpacing);

// State of used padding surrounding the content around the picker.
final StateProvider<double> paddingPod =
    StateProvider<double>((StateProviderRef<double> ref) {
  return hiveStore.get(Keys.padding,
      defaultValue: Keys.defaults[Keys.padding]! as double) as double;
}, name: Keys.padding);

// State of using a close button on dialog toolbar.
final StateProvider<bool> closeButtonPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.closeButton,
      defaultValue: Keys.defaults[Keys.closeButton]! as bool) as bool;
}, name: Keys.closeButton);

// State of using a OK button on dialog toolbar.
final StateProvider<bool> okButtonPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.okButton,
      defaultValue: Keys.defaults[Keys.okButton]! as bool) as bool;
}, name: Keys.okButton);

// State of using having close button as last action on dialog toolbar.
final StateProvider<bool> closeIsLastPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.closeIsLast,
      defaultValue: Keys.defaults[Keys.closeIsLast]! as bool) as bool;
}, name: Keys.closeIsLast);

// State of having Cancel OK bottom action in the dialog.
final StateProvider<bool> dialogActionButtonsPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.dialogActionButtons,
      defaultValue: Keys.defaults[Keys.dialogActionButtons]! as bool) as bool;
}, name: Keys.dialogActionButtons);

// State of order OK cancel buttons in dialog actions
final StateProvider<ColorPickerActionButtonOrder> dialogActionsOrderPod =
    StateProvider<ColorPickerActionButtonOrder>(
        (StateProviderRef<ColorPickerActionButtonOrder> ref) {
  return hiveStore.get(Keys.dialogActionOrder,
      defaultValue: Keys.defaults[Keys.dialogActionOrder]!
          as ColorPickerActionButtonOrder) as ColorPickerActionButtonOrder;
}, name: Keys.dialogActionOrder);

// State of having icons on Cancel OK bottom actions buttons in the dialog.
final StateProvider<bool> dialogActionIconsPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.dialogActionIcons,
      defaultValue: Keys.defaults[Keys.dialogActionIcons]! as bool) as bool;
}, name: Keys.dialogActionIcons);

// ****************************************************************************
//  Copy Paste Actions Riverpod "Pod" providers.
// ****************************************************************************

// State of used color code COPY format.
final StateProvider<ColorPickerCopyFormat> copyFormatPod =
    StateProvider<ColorPickerCopyFormat>(
        (StateProviderRef<ColorPickerCopyFormat> ref) {
  return hiveStore.get(Keys.copyFormat,
      defaultValue: Keys.defaults[Keys.copyFormat]!
          as ColorPickerCopyFormat) as ColorPickerCopyFormat;
}, name: Keys.copyFormat);

// State of using CTRL-C keyboard shortcut.
final StateProvider<bool> ctrlCPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.ctrlC,
      defaultValue: Keys.defaults[Keys.ctrlC]! as bool) as bool;
}, name: Keys.ctrlC);

// State of using CTRL-V keyboard shortcut.
final StateProvider<bool> ctrlVPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.ctrlV,
      defaultValue: Keys.defaults[Keys.ctrlV]! as bool) as bool;
}, name: Keys.ctrlV);

// State of using auto focus on picker.
final StateProvider<bool> autoFocusPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.autoFocus,
      defaultValue: Keys.defaults[Keys.autoFocus]! as bool) as bool;
}, name: Keys.autoFocus);

// State of using Copy button on toolbar.
final StateProvider<bool> copyButtonPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.copyButton,
      defaultValue: Keys.defaults[Keys.copyButton]! as bool) as bool;
}, name: Keys.copyButton);

// State of using Paste button on toolbar.
final StateProvider<bool> pasteButtonPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.pasteButton,
      defaultValue: Keys.defaults[Keys.pasteButton]! as bool) as bool;
}, name: Keys.pasteButton);

// State of using Paste button on edit code field.
final StateProvider<bool> editFieldCopyButtonPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.editFieldCopyButton,
      defaultValue: Keys.defaults[Keys.editFieldCopyButton]! as bool) as bool;
}, name: Keys.editFieldCopyButton);

// State of using long press copy-paste context menu.
final StateProvider<bool> longPressMenuPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.longPressMenu,
      defaultValue: Keys.defaults[Keys.longPressMenu]! as bool) as bool;
}, name: Keys.longPressMenu);

// State of using secondary (right) click copy-paste context menu.
final StateProvider<bool> secondaryMenuPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.secondaryMenu,
      defaultValue: Keys.defaults[Keys.secondaryMenu]! as bool) as bool;
}, name: Keys.secondaryMenu);

// State of using secondary (right) click on desktop and long press
// on devices to show the copy-paste context menu
final StateProvider<bool> secondaryDesktopOtherLongPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.secondaryDesktopOtherLong,
          defaultValue: Keys.defaults[Keys.secondaryDesktopOtherLong]! as bool)
      as bool;
}, name: Keys.secondaryDesktopOtherLong);

// State of using secondary (right) click on desktop and long press
// on devices and web to show the copy-paste context menu
final StateProvider<bool> secondaryDesktopWebLongPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.secondaryDesktopWebLong,
          defaultValue: Keys.defaults[Keys.secondaryDesktopWebLong]! as bool)
      as bool;
}, name: Keys.secondaryDesktopWebLong);

// State of if Web 3-char code RGB, should be interpreted as RRGGBB.
final StateProvider<bool> parseShortHexCodePod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.parseShortHexCode,
      defaultValue: Keys.defaults[Keys.parseShortHexCode]! as bool) as bool;
}, name: Keys.parseShortHexCode);

// State of if text edit field should use code parser on keyboard paste.
final StateProvider<bool> editUsesParsedPastePod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.editUsesParsedPaste,
      defaultValue: Keys.defaults[Keys.editUsesParsedPaste]! as bool) as bool;
}, name: Keys.editUsesParsedPaste);

// State of if color code parse error should result in a snackbar error message.
final StateProvider<bool> snackbarParseErrorPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.snackbarParseError,
      defaultValue: Keys.defaults[Keys.snackbarParseError]! as bool) as bool;
}, name: Keys.snackbarParseError);

// State of if color code parse error should give audible and vibration alert.
final StateProvider<bool> feedbackParseErrorPod =
    StateProvider<bool>((StateProviderRef<bool> ref) {
  return hiveStore.get(Keys.feedbackParseError,
      defaultValue: Keys.defaults[Keys.feedbackParseError]! as bool) as bool;
}, name: Keys.feedbackParseError);
