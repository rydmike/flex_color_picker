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

  ref.read(themeModePod.notifier).state =
      Keys.defaults[Keys.themeMode]! as ThemeMode;

  // Current selected colors Riverpod "Pod" providers.
  //***************************************************************************

  ref.read(cardPickerColorPod.notifier).state =
      Keys.defaults[Keys.cardPickerColor]! as Color;

  ref.read(dialogPickerColorPod.notifier).state =
      Keys.defaults[Keys.dialogPickerColor]! as Color;

  ref.read(cardRecentColorsPod.notifier).state =
      Keys.defaults[Keys.cardRecentColors]! as List<Color>;

  ref.read(dialogRecentColorsPod.notifier).state =
      Keys.defaults[Keys.dialogRecentColors]! as List<Color>;

  // Show and Hide Riverpod "Pod" providers.
  //***************************************************************************

  ref.read(pickersEnabledPod.notifier).state =
      Keys.defaults[Keys.pickersEnabled]! as Map<ColorPickerType, bool>;

  ref.read(includeIndex850Pod.notifier).state =
      Keys.defaults[Keys.includeIndex850]! as bool;

  ref.read(enableOpacityPod.notifier).state =
      Keys.defaults[Keys.enableOpacity]! as bool;

  ref.read(showMaterialNamePod.notifier).state =
      Keys.defaults[Keys.showMaterialName]! as bool;

  ref.read(showColorNamePod.notifier).state =
      Keys.defaults[Keys.showColorName]! as bool;

  ref.read(showColorCodePod.notifier).state =
      Keys.defaults[Keys.showColorCode]! as bool;

  ref.read(colorCodeHasColorPod.notifier).state =
      Keys.defaults[Keys.colorCodeHasColor]! as bool;

  ref.read(colorCodeReadOnlyPod.notifier).state =
      Keys.defaults[Keys.colorCodeReadOnly]! as bool;

  ref.read(showColorValuePod.notifier).state =
      Keys.defaults[Keys.showColorValue]! as bool;

  ref.read(showRecentColorsPod.notifier).state =
      Keys.defaults[Keys.showRecentColors]! as bool;

  ref.read(showTitlePod.notifier).state =
      Keys.defaults[Keys.showTitle]! as bool;

  ref.read(showHeadingPod.notifier).state =
      Keys.defaults[Keys.showHeading]! as bool;

  ref.read(showSubheadingPod.notifier).state =
      Keys.defaults[Keys.showSubheading]! as bool;

  ref.read(showOpacitySubheadingPod.notifier).state =
      Keys.defaults[Keys.showOpacitySubheading]! as bool;

  ref.read(showRecentSubheadingPod.notifier).state =
      Keys.defaults[Keys.showRecentSubheading]! as bool;

  // Picker Design Riverpod "Pod" providers.
  //****************************************************************************

  ref.read(sizePod.notifier).state = Keys.defaults[Keys.size]! as double;

  ref.read(tonalSameSizePod.notifier).state =
      Keys.defaults[Keys.tonalSameSize]! as bool;

  ref.read(borderRadiusPod.notifier).state =
      Keys.defaults[Keys.borderRadius]! as double;

  ref.read(elevationPod.notifier).state =
      Keys.defaults[Keys.elevation]! as double;

  ref.read(spacingPod.notifier).state = Keys.defaults[Keys.spacing]! as double;

  ref.read(runSpacingPod.notifier).state =
      Keys.defaults[Keys.runSpacing]! as double;

  ref.read(hasBorderPod.notifier).state =
      Keys.defaults[Keys.hasBorder]! as bool;

  ref.read(wheelDiameterPod.notifier).state =
      Keys.defaults[Keys.wheelDiameter]! as double;

  ref.read(wheelWidthPod.notifier).state =
      Keys.defaults[Keys.wheelWidth]! as double;

  ref.read(wheelHasBorderPod.notifier).state =
      Keys.defaults[Keys.wheelHasBorder]! as bool;

  ref.read(opacityTrackHeightPod.notifier).state =
      Keys.defaults[Keys.opacityTrackHeight]! as double;

  ref.read(opacityTrackWidthPod.notifier).state =
      Keys.defaults[Keys.opacityTrackWidth]! as double;

  ref.read(opacityThumbRadiusPod.notifier).state =
      Keys.defaults[Keys.opacityThumbRadius]! as double;

  ref.read(enableTooltipsPod.notifier).state =
      Keys.defaults[Keys.enableTooltips]! as bool;

  // Picker Layout Riverpod "Pod" providers.
  //****************************************************************************

  ref.read(alignmentPod.notifier).state =
      Keys.defaults[Keys.alignment]! as CrossAxisAlignment;

  ref.read(columnSpacingPod.notifier).state =
      Keys.defaults[Keys.columnSpacing]! as double;

  ref.read(paddingPod.notifier).state = Keys.defaults[Keys.padding]! as double;

  ref.read(closeButtonPod.notifier).state =
      Keys.defaults[Keys.closeButton]! as bool;

  ref.read(okButtonPod.notifier).state = Keys.defaults[Keys.okButton]! as bool;

  ref.read(closeIsLastPod.notifier).state =
      Keys.defaults[Keys.closeIsLast]! as bool;

  ref.read(dialogActionButtonsPod.notifier).state =
      Keys.defaults[Keys.dialogActionButtons]! as bool;

  ref.read(dialogActionsOrderPod.notifier).state =
      Keys.defaults[Keys.dialogActionOrder]! as ColorPickerActionButtonOrder;

  ref.read(dialogActionIconsPod.notifier).state =
      Keys.defaults[Keys.dialogActionIcons]! as bool;

  // Copy Paste Actions Riverpod "Pod" providers.
  //****************************************************************************

  ref.read(copyFormatPod.notifier).state =
      Keys.defaults[Keys.copyFormat]! as ColorPickerCopyFormat;

  ref.read(ctrlCPod.notifier).state = Keys.defaults[Keys.ctrlC]! as bool;

  ref.read(ctrlVPod.notifier).state = Keys.defaults[Keys.ctrlV]! as bool;

  ref.read(autoFocusPod.notifier).state =
      Keys.defaults[Keys.autoFocus]! as bool;

  ref.read(copyButtonPod.notifier).state =
      Keys.defaults[Keys.copyButton]! as bool;

  ref.read(pasteButtonPod.notifier).state =
      Keys.defaults[Keys.pasteButton]! as bool;

  ref.read(editFieldCopyButtonPod.notifier).state =
      Keys.defaults[Keys.editFieldCopyButton]! as bool;

  ref.read(longPressMenuPod.notifier).state =
      Keys.defaults[Keys.longPressMenu]! as bool;

  ref.read(secondaryMenuPod.notifier).state =
      Keys.defaults[Keys.secondaryMenu]! as bool;

  ref.read(secondaryDesktopOtherLongPod.notifier).state =
      Keys.defaults[Keys.secondaryDesktopOtherLong]! as bool;

  ref.read(parseShortHexCodePod.notifier).state =
      Keys.defaults[Keys.parseShortHexCode]! as bool;

  ref.read(editUsesParsedPastePod.notifier).state =
      Keys.defaults[Keys.editUsesParsedPaste]! as bool;

  ref.read(snackbarParseErrorPod.notifier).state =
      Keys.defaults[Keys.snackbarParseError]! as bool;

  ref.read(feedbackParseErrorPod.notifier).state =
      Keys.defaults[Keys.feedbackParseError]! as bool;
}
