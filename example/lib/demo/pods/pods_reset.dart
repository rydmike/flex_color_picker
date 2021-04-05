import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/store.dart';
import 'pods.dart';

/// Rest all color picker settings to their default values.
///
/// This changes all setting values to their default we defined for the
/// [Store.defaults] map, but as that is done those updates are also persisted
/// by the Observer and will be used next time app is started as well.
///
/// There is just a lot of these, easy to miss one and have to remember to
/// add any new tracked state provider property to the list to be reset.
void resetSettings(BuildContext context) {
  //
  // The theme mode Riverpod "Pod" providers.
  //***************************************************************************

  context.read(themeModePod).state =
      Store.defaults[Store.themeMode]! as ThemeMode;

  // Current selected colors Riverpod "Pod" providers.
  //***************************************************************************

  context.read(cardPickerColorPod).state =
      Store.defaults[Store.cardPickerColor]! as Color;

  context.read(dialogPickerColorPod).state =
      Store.defaults[Store.dialogPickerColor]! as Color;

  context.read(cardRecentColorsPod).state =
      Store.defaults[Store.cardRecentColors]! as List<Color>;

  context.read(dialogRecentColorsPod).state =
      Store.defaults[Store.dialogRecentColors]! as List<Color>;

  // Show and Hide Riverpod "Pod" providers.
  //***************************************************************************

  context.read(pickersEnabledPod).state =
      Store.defaults[Store.pickersEnabled]! as Map<ColorPickerType, bool>;

  context.read(includeIndex850Pod).state =
      Store.defaults[Store.includeIndex850]! as bool;

  context.read(enableOpacityPod).state =
      Store.defaults[Store.enableOpacity]! as bool;

  context.read(showMaterialNamePod).state =
      Store.defaults[Store.showMaterialName]! as bool;

  context.read(showColorNamePod).state =
      Store.defaults[Store.showColorName]! as bool;

  context.read(showColorCodePod).state =
      Store.defaults[Store.showColorCode]! as bool;

  context.read(colorCodeHasColorPod).state =
      Store.defaults[Store.colorCodeHasColor]! as bool;

  context.read(colorCodeReadOnlyPod).state =
      Store.defaults[Store.colorCodeReadOnly]! as bool;

  context.read(showColorValuePod).state =
      Store.defaults[Store.showColorValue]! as bool;

  context.read(showRecentColorsPod).state =
      Store.defaults[Store.showRecentColors]! as bool;

  context.read(showTitlePod).state = Store.defaults[Store.showTitle]! as bool;

  context.read(showHeadingPod).state =
      Store.defaults[Store.showHeading]! as bool;

  context.read(showSubheadingPod).state =
      Store.defaults[Store.showSubheading]! as bool;

  context.read(showOpacitySubheadingPod).state =
      Store.defaults[Store.showOpacitySubheading]! as bool;

  context.read(showRecentSubheadingPod).state =
      Store.defaults[Store.showRecentSubheading]! as bool;

  // Picker Design Riverpod "Pod" providers.
  //****************************************************************************

  context.read(sizePod).state = Store.defaults[Store.size]! as double;

  context.read(borderRadiusPod).state =
      Store.defaults[Store.borderRadius]! as double;

  context.read(elevationPod).state = Store.defaults[Store.elevation]! as double;

  context.read(spacingPod).state = Store.defaults[Store.spacing]! as double;

  context.read(runSpacingPod).state =
      Store.defaults[Store.runSpacing]! as double;

  context.read(hasBorderPod).state = Store.defaults[Store.hasBorder]! as bool;

  context.read(wheelDiameterPod).state =
      Store.defaults[Store.wheelDiameter]! as double;

  context.read(wheelWidthPod).state =
      Store.defaults[Store.wheelWidth]! as double;

  context.read(wheelHasBorderPod).state =
      Store.defaults[Store.wheelHasBorder]! as bool;

  context.read(opacityTrackHeightPod).state =
      Store.defaults[Store.opacityTrackHeight]! as double;

  context.read(opacityTrackWidthPod).state =
      Store.defaults[Store.opacityTrackWidth]! as double;

  context.read(opacityThumbRadiusPod).state =
      Store.defaults[Store.opacityThumbRadius]! as double;

  context.read(enableTooltipsPod).state =
      Store.defaults[Store.enableTooltips]! as bool;

  // Picker Layout Riverpod "Pod" providers.
  //****************************************************************************

  context.read(alignmentPod).state =
      Store.defaults[Store.alignment]! as CrossAxisAlignment;

  context.read(columnSpacingPod).state =
      Store.defaults[Store.columnSpacing]! as double;

  context.read(paddingPod).state = Store.defaults[Store.padding]! as double;

  context.read(closeButtonPod).state =
      Store.defaults[Store.closeButton]! as bool;

  context.read(okButtonPod).state = Store.defaults[Store.okButton]! as bool;

  context.read(closeIsLastPod).state =
      Store.defaults[Store.closeIsLast]! as bool;

  context.read(dialogActionButtonsPod).state =
      Store.defaults[Store.dialogActionButtons]! as bool;

  context.read(dialogActionIconsPod).state =
      Store.defaults[Store.dialogActionIcons]! as bool;

  // Copy Paste Actions Riverpod "Pod" providers.
  //****************************************************************************

  context.read(copyFormatPod).state =
      Store.defaults[Store.copyFormat]! as ColorPickerCopyFormat;

  context.read(ctrlCPod).state = Store.defaults[Store.ctrlC]! as bool;

  context.read(ctrlVPod).state = Store.defaults[Store.ctrlV]! as bool;

  context.read(copyButtonPod).state = Store.defaults[Store.copyButton]! as bool;

  context.read(pasteButtonPod).state =
      Store.defaults[Store.pasteButton]! as bool;

  context.read(editFieldCopyButtonPod).state =
      Store.defaults[Store.editFieldCopyButton]! as bool;

  context.read(longPressMenuPod).state =
      Store.defaults[Store.longPressMenu]! as bool;

  context.read(secondaryMenuPod).state =
      Store.defaults[Store.secondaryMenu]! as bool;

  context.read(secondaryDesktopOtherLongPod).state =
      Store.defaults[Store.secondaryDesktopOtherLong]! as bool;

  context.read(parseShortHexCodePod).state =
      Store.defaults[Store.parseShortHexCode]! as bool;

  context.read(editUsesParsedPastePod).state =
      Store.defaults[Store.editUsesParsedPaste]! as bool;

  context.read(snackbarParseErrorPod).state =
      Store.defaults[Store.snackbarParseError]! as bool;

  context.read(feedbackParseErrorPod).state =
      Store.defaults[Store.feedbackParseError]! as bool;
}
