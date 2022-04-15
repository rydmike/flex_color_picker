import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pods/pods.dart';
import '../../utils/app.dart';

/// The ColorPicker shown in a dialog that is opened from the ColorPickerScreen.
Future<bool> colorPickerDialog(
  BuildContext context,
  WidgetRef ref, {
  bool cardRemote = false,
}) async {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  return ColorPicker(
    color: cardRemote
        ? ref.watch(cardPickerColorPod)
        : ref.watch(dialogPickerColorPod),
    onColorChangeStart: (Color color) {
      ref.read(onColorChangeStartPod.state).state = color;
    },
    onColorChanged: (Color color) {
      cardRemote
          ? ref.read(cardPickerColorPod.state).state = color
          : ref.read(dialogPickerColorPod.state).state = color;
      ref.read(onColorChangedPod.state).state = color;
    },
    onColorChangeEnd: (Color color) {
      ref.read(onColorChangeEndPod.state).state = color;
    },
    onRecentColorsChanged: (List<Color> colors) {
      cardRemote
          ? ref.read(cardRecentColorsPod.state).state = colors
          : ref.read(dialogRecentColorsPod.state).state = colors;
    },
    crossAxisAlignment: ref.watch(alignmentPod),
    padding: EdgeInsets.all(ref.watch(paddingPod)),
    enableShadesSelection: ref.watch(enableShadesSelectionPod),
    includeIndex850: ref.watch(includeIndex850Pod),
    enableTonalPalette: ref.watch(enableTonesSelectionPod),
    enableOpacity: ref.watch(enableOpacityPod),
    opacityTrackHeight: ref.watch(opacityTrackHeightPod),
    opacityTrackWidth: ref.watch(opacityTrackWidthPod),
    opacityThumbRadius: ref.watch(opacityThumbRadiusPod),
    copyPasteBehavior: ColorPickerCopyPasteBehavior(
      ctrlC: ref.watch(ctrlCPod),
      ctrlV: ref.watch(ctrlVPod),
      autoFocus: ref.watch(autoFocusPod),
      copyButton: ref.watch(copyButtonPod),
      pasteButton: ref.watch(pasteButtonPod),
      copyFormat: ref.watch(copyFormatPod),
      longPressMenu: ref.watch(longPressMenuPod),
      secondaryMenu: ref.watch(secondaryMenuPod),
      secondaryOnDesktopLongOnDevice: ref.watch(secondaryDesktopOtherLongPod),
      secondaryOnDesktopLongOnDeviceAndWeb:
          ref.watch(secondaryDesktopWebLongPod),
      editFieldCopyButton: ref.watch(editFieldCopyButtonPod),
      parseShortHexCode: ref.watch(parseShortHexCodePod),
      editUsesParsedPaste: ref.watch(editUsesParsedPastePod),
      snackBarParseError: ref.watch(snackbarParseErrorPod),
      feedbackParseError: ref.watch(feedbackParseErrorPod),
    ),
    actionButtons: ColorPickerActionButtons(
      // Make sure that you only enable the OK and Cancel button in the
      // toolbar when the picker is used in a dialog.
      okButton: ref.watch(okButtonPod),
      closeButton: ref.watch(closeButtonPod),
      closeIsLast: ref.watch(closeIsLastPod),
      dialogActionButtons: ref.watch(dialogActionButtonsPod),
      dialogActionOrder: ref.watch(dialogActionsOrderPod),
      dialogActionIcons: ref.watch(dialogActionIconsPod),
      dialogOkButtonType: ColorPickerActionButtonType.outlined,
      dialogCancelButtonType: ColorPickerActionButtonType.text,
    ),
    width: ref.watch(sizePod),
    height: ref.watch(sizePod),
    spacing: ref.watch(spacingPod),
    runSpacing: ref.watch(runSpacingPod),
    elevation: ref.watch(elevationPod),
    hasBorder: ref.watch(hasBorderPod),
    borderRadius: ref.watch(borderRadiusPod),
    columnSpacing: ref.watch(columnSpacingPod),
    wheelDiameter: ref.watch(wheelDiameterPod),
    wheelWidth: ref.watch(wheelWidthPod),
    wheelHasBorder: ref.watch(wheelHasBorderPod),
    enableTooltips: ref.watch(enableTooltipsPod),
    pickersEnabled: ref.watch(pickersEnabledPod),
    selectedPickerTypeColor: colorScheme.primary,
    title: ref.watch(showTitlePod)
        ? Text(
            'ColorPicker',
            style: Theme.of(context).textTheme.headline6,
          )
        : null,
    heading: ref.watch(showHeadingPod)
        ? Text(
            'Select color',
            style: Theme.of(context).textTheme.headline5,
          )
        : null,
    subheading: ref.watch(showSubheadingPod)
        ? Text(
            'Select color shade',
            style: Theme.of(context).textTheme.subtitle1,
          )
        : null,
    tonalSubheading: ref.watch(showTonalSubheadingPod)
        ? Text(
            'Material 3 tonal palette',
            style: Theme.of(context).textTheme.subtitle1,
          )
        : null,
    wheelSubheading: ref.watch(showSubheadingPod)
        ? Text(
            'Selected color and its color swatch',
            style: Theme.of(context).textTheme.subtitle1,
          )
        : null,
    opacitySubheading: ref.watch(showOpacitySubheadingPod)
        ? Text(
            'Opacity',
            style: Theme.of(context).textTheme.subtitle1,
          )
        : null,
    recentColorsSubheading: ref.watch(showRecentSubheadingPod)
        ? Text(
            'Recent colors',
            style: Theme.of(context).textTheme.subtitle1,
          )
        : null,
    showMaterialName: ref.watch(showMaterialNamePod),
    showColorName: ref.watch(showColorNamePod),
    showColorCode: ref.watch(showColorCodePod),
    colorCodeHasColor: ref.watch(colorCodeHasColorPod),
    colorCodeReadOnly: ref.watch(colorCodeReadOnlyPod),
    showColorValue: ref.watch(showColorValuePod),
    showRecentColors: ref.watch(showRecentColorsPod),
    recentColors: cardRemote
        ? ref.watch(cardRecentColorsPod)
        : ref.watch(dialogRecentColorsPod),
    maxRecentColors: cardRemote ? 8 : 5,
    customColorSwatchesAndNames: App.colorsNameMap,
  ).showPickerDialog(
    context,
    elevation: 4,
    // Let's make an even more transparent barrier color than black12
    barrierColor: const Color(0x0F000000), // 6% opacity black
    constraints:
        const BoxConstraints(minHeight: 580, minWidth: 480, maxWidth: 480),
  );
}
