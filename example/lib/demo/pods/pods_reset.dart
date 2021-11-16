import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/keys.dart';
import 'pods.dart';

/// Rest all color picker settings to their default values.
///
/// This changes all setting values to their defaults we defined in the
/// [Keys.defaults] map, as that is done those updates are also persisted
/// by the ProviderObserver and will be used next time app is started.
///
/// There is just a lot of these (55 at the moment), so it easy to miss one
/// and we have to remember to add any new tracked state provider property
/// to the list to be reset.
void resetSettings(WidgetRef ref) {
  //
  // The theme mode Riverpod "Pod" providers.
  //***************************************************************************

  ref.read(themeModePod.state).state =
      Keys.defaults[Keys.themeMode]! as ThemeMode;

  // Current selected colors Riverpod "Pod" providers.
  //***************************************************************************

  ref.read(cardPickerColorPod.state).state =
      Keys.defaults[Keys.cardPickerColor]! as Color;

  ref.read(dialogPickerColorPod.state).state =
      Keys.defaults[Keys.dialogPickerColor]! as Color;

  ref.read(cardRecentColorsPod.state).state =
      Keys.defaults[Keys.cardRecentColors]! as List<Color>;

  ref.read(dialogRecentColorsPod.state).state =
      Keys.defaults[Keys.dialogRecentColors]! as List<Color>;

  // Show and Hide Riverpod "Pod" providers.
  //***************************************************************************

  ref.read(pickersEnabledPod.state).state =
      Keys.defaults[Keys.pickersEnabled]! as Map<ColorPickerType, bool>;

  ref.read(includeIndex850Pod.state).state =
      Keys.defaults[Keys.includeIndex850]! as bool;

  ref.read(enableOpacityPod.state).state =
      Keys.defaults[Keys.enableOpacity]! as bool;

  ref.read(showMaterialNamePod.state).state =
      Keys.defaults[Keys.showMaterialName]! as bool;

  ref.read(showColorNamePod.state).state =
      Keys.defaults[Keys.showColorName]! as bool;

  ref.read(showColorCodePod.state).state =
      Keys.defaults[Keys.showColorCode]! as bool;

  ref.read(colorCodeHasColorPod.state).state =
      Keys.defaults[Keys.colorCodeHasColor]! as bool;

  ref.read(colorCodeReadOnlyPod.state).state =
      Keys.defaults[Keys.colorCodeReadOnly]! as bool;

  ref.read(showColorValuePod.state).state =
      Keys.defaults[Keys.showColorValue]! as bool;

  ref.read(showRecentColorsPod.state).state =
      Keys.defaults[Keys.showRecentColors]! as bool;

  ref.read(showTitlePod.state).state = Keys.defaults[Keys.showTitle]! as bool;

  ref.read(showHeadingPod.state).state =
      Keys.defaults[Keys.showHeading]! as bool;

  ref.read(showSubheadingPod.state).state =
      Keys.defaults[Keys.showSubheading]! as bool;

  ref.read(showOpacitySubheadingPod.state).state =
      Keys.defaults[Keys.showOpacitySubheading]! as bool;

  ref.read(showRecentSubheadingPod.state).state =
      Keys.defaults[Keys.showRecentSubheading]! as bool;

  // Picker Design Riverpod "Pod" providers.
  //****************************************************************************

  ref.read(sizePod.state).state = Keys.defaults[Keys.size]! as double;

  ref.read(borderRadiusPod.state).state =
      Keys.defaults[Keys.borderRadius]! as double;

  ref.read(elevationPod.state).state = Keys.defaults[Keys.elevation]! as double;

  ref.read(spacingPod.state).state = Keys.defaults[Keys.spacing]! as double;

  ref.read(runSpacingPod.state).state =
      Keys.defaults[Keys.runSpacing]! as double;

  ref.read(hasBorderPod.state).state = Keys.defaults[Keys.hasBorder]! as bool;

  ref.read(wheelDiameterPod.state).state =
      Keys.defaults[Keys.wheelDiameter]! as double;

  ref.read(wheelWidthPod.state).state =
      Keys.defaults[Keys.wheelWidth]! as double;

  ref.read(wheelHasBorderPod.state).state =
      Keys.defaults[Keys.wheelHasBorder]! as bool;

  ref.read(opacityTrackHeightPod.state).state =
      Keys.defaults[Keys.opacityTrackHeight]! as double;

  ref.read(opacityTrackWidthPod.state).state =
      Keys.defaults[Keys.opacityTrackWidth]! as double;

  ref.read(opacityThumbRadiusPod.state).state =
      Keys.defaults[Keys.opacityThumbRadius]! as double;

  ref.read(enableTooltipsPod.state).state =
      Keys.defaults[Keys.enableTooltips]! as bool;

  // Picker Layout Riverpod "Pod" providers.
  //****************************************************************************

  ref.read(alignmentPod.state).state =
      Keys.defaults[Keys.alignment]! as CrossAxisAlignment;

  ref.read(columnSpacingPod.state).state =
      Keys.defaults[Keys.columnSpacing]! as double;

  ref.read(paddingPod.state).state = Keys.defaults[Keys.padding]! as double;

  ref.read(closeButtonPod.state).state =
      Keys.defaults[Keys.closeButton]! as bool;

  ref.read(okButtonPod.state).state = Keys.defaults[Keys.okButton]! as bool;

  ref.read(closeIsLastPod.state).state =
      Keys.defaults[Keys.closeIsLast]! as bool;

  ref.read(dialogActionButtonsPod.state).state =
      Keys.defaults[Keys.dialogActionButtons]! as bool;

  ref.read(dialogActionIconsPod.state).state =
      Keys.defaults[Keys.dialogActionIcons]! as bool;

  // Copy Paste Actions Riverpod "Pod" providers.
  //****************************************************************************

  ref.read(copyFormatPod.state).state =
      Keys.defaults[Keys.copyFormat]! as ColorPickerCopyFormat;

  ref.read(ctrlCPod.state).state = Keys.defaults[Keys.ctrlC]! as bool;

  ref.read(ctrlVPod.state).state = Keys.defaults[Keys.ctrlV]! as bool;

  ref.read(copyButtonPod.state).state = Keys.defaults[Keys.copyButton]! as bool;

  ref.read(pasteButtonPod.state).state =
      Keys.defaults[Keys.pasteButton]! as bool;

  ref.read(editFieldCopyButtonPod.state).state =
      Keys.defaults[Keys.editFieldCopyButton]! as bool;

  ref.read(longPressMenuPod.state).state =
      Keys.defaults[Keys.longPressMenu]! as bool;

  ref.read(secondaryMenuPod.state).state =
      Keys.defaults[Keys.secondaryMenu]! as bool;

  ref.read(secondaryDesktopOtherLongPod.state).state =
      Keys.defaults[Keys.secondaryDesktopOtherLong]! as bool;

  ref.read(parseShortHexCodePod.state).state =
      Keys.defaults[Keys.parseShortHexCode]! as bool;

  ref.read(editUsesParsedPastePod.state).state =
      Keys.defaults[Keys.editUsesParsedPaste]! as bool;

  ref.read(snackbarParseErrorPod.state).state =
      Keys.defaults[Keys.snackbarParseError]! as bool;

  ref.read(feedbackParseErrorPod.state).state =
      Keys.defaults[Keys.feedbackParseError]! as bool;
}
