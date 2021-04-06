import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/keys.dart';
import 'pods.dart';

/// Rest all color picker settings to their default values.
///
/// This changes all setting values to their default we defined for the
/// [Keys.defaults] map, but as that is done those updates are also persisted
/// by the Observer and will be used next time app is started as well.
///
/// There is just a lot of these, easy to miss one and have to remember to
/// add any new tracked state provider property to the list to be reset.
void resetSettings(BuildContext context) {
  //
  // The theme mode Riverpod "Pod" providers.
  //***************************************************************************

  context.read(themeModePod).state =
      Keys.defaults[Keys.themeMode]! as ThemeMode;

  // Current selected colors Riverpod "Pod" providers.
  //***************************************************************************

  context.read(cardPickerColorPod).state =
      Keys.defaults[Keys.cardPickerColor]! as Color;

  context.read(dialogPickerColorPod).state =
      Keys.defaults[Keys.dialogPickerColor]! as Color;

  context.read(cardRecentColorsPod).state =
      Keys.defaults[Keys.cardRecentColors]! as List<Color>;

  context.read(dialogRecentColorsPod).state =
      Keys.defaults[Keys.dialogRecentColors]! as List<Color>;

  // Show and Hide Riverpod "Pod" providers.
  //***************************************************************************

  context.read(pickersEnabledPod).state =
      Keys.defaults[Keys.pickersEnabled]! as Map<ColorPickerType, bool>;

  context.read(includeIndex850Pod).state =
      Keys.defaults[Keys.includeIndex850]! as bool;

  context.read(enableOpacityPod).state =
      Keys.defaults[Keys.enableOpacity]! as bool;

  context.read(showMaterialNamePod).state =
      Keys.defaults[Keys.showMaterialName]! as bool;

  context.read(showColorNamePod).state =
      Keys.defaults[Keys.showColorName]! as bool;

  context.read(showColorCodePod).state =
      Keys.defaults[Keys.showColorCode]! as bool;

  context.read(colorCodeHasColorPod).state =
      Keys.defaults[Keys.colorCodeHasColor]! as bool;

  context.read(colorCodeReadOnlyPod).state =
      Keys.defaults[Keys.colorCodeReadOnly]! as bool;

  context.read(showColorValuePod).state =
      Keys.defaults[Keys.showColorValue]! as bool;

  context.read(showRecentColorsPod).state =
      Keys.defaults[Keys.showRecentColors]! as bool;

  context.read(showTitlePod).state = Keys.defaults[Keys.showTitle]! as bool;

  context.read(showHeadingPod).state = Keys.defaults[Keys.showHeading]! as bool;

  context.read(showSubheadingPod).state =
      Keys.defaults[Keys.showSubheading]! as bool;

  context.read(showOpacitySubheadingPod).state =
      Keys.defaults[Keys.showOpacitySubheading]! as bool;

  context.read(showRecentSubheadingPod).state =
      Keys.defaults[Keys.showRecentSubheading]! as bool;

  // Picker Design Riverpod "Pod" providers.
  //****************************************************************************

  context.read(sizePod).state = Keys.defaults[Keys.size]! as double;

  context.read(borderRadiusPod).state =
      Keys.defaults[Keys.borderRadius]! as double;

  context.read(elevationPod).state = Keys.defaults[Keys.elevation]! as double;

  context.read(spacingPod).state = Keys.defaults[Keys.spacing]! as double;

  context.read(runSpacingPod).state = Keys.defaults[Keys.runSpacing]! as double;

  context.read(hasBorderPod).state = Keys.defaults[Keys.hasBorder]! as bool;

  context.read(wheelDiameterPod).state =
      Keys.defaults[Keys.wheelDiameter]! as double;

  context.read(wheelWidthPod).state = Keys.defaults[Keys.wheelWidth]! as double;

  context.read(wheelHasBorderPod).state =
      Keys.defaults[Keys.wheelHasBorder]! as bool;

  context.read(opacityTrackHeightPod).state =
      Keys.defaults[Keys.opacityTrackHeight]! as double;

  context.read(opacityTrackWidthPod).state =
      Keys.defaults[Keys.opacityTrackWidth]! as double;

  context.read(opacityThumbRadiusPod).state =
      Keys.defaults[Keys.opacityThumbRadius]! as double;

  context.read(enableTooltipsPod).state =
      Keys.defaults[Keys.enableTooltips]! as bool;

  // Picker Layout Riverpod "Pod" providers.
  //****************************************************************************

  context.read(alignmentPod).state =
      Keys.defaults[Keys.alignment]! as CrossAxisAlignment;

  context.read(columnSpacingPod).state =
      Keys.defaults[Keys.columnSpacing]! as double;

  context.read(paddingPod).state = Keys.defaults[Keys.padding]! as double;

  context.read(closeButtonPod).state = Keys.defaults[Keys.closeButton]! as bool;

  context.read(okButtonPod).state = Keys.defaults[Keys.okButton]! as bool;

  context.read(closeIsLastPod).state = Keys.defaults[Keys.closeIsLast]! as bool;

  context.read(dialogActionButtonsPod).state =
      Keys.defaults[Keys.dialogActionButtons]! as bool;

  context.read(dialogActionIconsPod).state =
      Keys.defaults[Keys.dialogActionIcons]! as bool;

  // Copy Paste Actions Riverpod "Pod" providers.
  //****************************************************************************

  context.read(copyFormatPod).state =
      Keys.defaults[Keys.copyFormat]! as ColorPickerCopyFormat;

  context.read(ctrlCPod).state = Keys.defaults[Keys.ctrlC]! as bool;

  context.read(ctrlVPod).state = Keys.defaults[Keys.ctrlV]! as bool;

  context.read(copyButtonPod).state = Keys.defaults[Keys.copyButton]! as bool;

  context.read(pasteButtonPod).state = Keys.defaults[Keys.pasteButton]! as bool;

  context.read(editFieldCopyButtonPod).state =
      Keys.defaults[Keys.editFieldCopyButton]! as bool;

  context.read(longPressMenuPod).state =
      Keys.defaults[Keys.longPressMenu]! as bool;

  context.read(secondaryMenuPod).state =
      Keys.defaults[Keys.secondaryMenu]! as bool;

  context.read(secondaryDesktopOtherLongPod).state =
      Keys.defaults[Keys.secondaryDesktopOtherLong]! as bool;

  context.read(parseShortHexCodePod).state =
      Keys.defaults[Keys.parseShortHexCode]! as bool;

  context.read(editUsesParsedPastePod).state =
      Keys.defaults[Keys.editUsesParsedPaste]! as bool;

  context.read(snackbarParseErrorPod).state =
      Keys.defaults[Keys.snackbarParseError]! as bool;

  context.read(feedbackParseErrorPod).state =
      Keys.defaults[Keys.feedbackParseError]! as bool;
}
