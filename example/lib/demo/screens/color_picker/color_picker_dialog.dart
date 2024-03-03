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
  final ThemeData theme = Theme.of(context);
  return ColorPicker(
    color: cardRemote
        ? ref.watch(cardPickerColorPod)
        : ref.watch(dialogPickerColorPod),
    onColorChangeStart: (Color color) {
      ref.read(onColorChangeStartPod.notifier).state = color;
    },
    onColorChanged: (Color color) {
      cardRemote
          ? ref.read(cardPickerColorPod.notifier).state = color
          : ref.read(dialogPickerColorPod.notifier).state = color;
      ref.read(onColorChangedPod.notifier).state = color;
    },
    onColorChangeEnd: (Color color) {
      ref.read(onColorChangeEndPod.notifier).state = color;
    },
    onRecentColorsChanged: (List<Color> colors) {
      cardRemote
          ? ref.read(cardRecentColorsPod.notifier).state = colors
          : ref.read(dialogRecentColorsPod.notifier).state = colors;
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
      dialogActionOnlyOkButton: ref.watch(dialogActionOnlyOkButtonPod),
      dialogActionOrder: ref.watch(dialogActionsOrderPod),
      dialogActionIcons: ref.watch(dialogActionIconsPod),
      dialogOkButtonType: ColorPickerActionButtonType.filled,
      dialogCancelButtonType: ColorPickerActionButtonType.filledTonal,
    ),
    width: ref.watch(sizePod),
    height: ref.watch(sizePod),
    tonalColorSameSize: ref.watch(tonalSameSizePod),
    spacing: ref.watch(spacingPod),
    runSpacing: ref.watch(runSpacingPod),
    elevation: ref.watch(elevationPod),
    hasBorder: ref.watch(hasBorderPod),
    borderRadius: ref.watch(borderRadiusPod),
    columnSpacing: ref.watch(columnSpacingPod),
    toolbarSpacing: 0,
    wheelDiameter: ref.watch(wheelDiameterPod),
    wheelWidth: ref.watch(wheelWidthPod),
    wheelHasBorder: ref.watch(wheelHasBorderPod),
    wheelSquarePadding: ref.watch(wheelSquarePaddingPod),
    wheelSquareBorderRadius: ref.watch(wheelSquareBorderRadiusPod),
    enableTooltips: ref.watch(enableTooltipsPod),
    pickersEnabled: ref.watch(pickersEnabledPod),
    pickerTypeLabels: const <ColorPickerType, String>{
      ColorPickerType.both: 'P & A',
      ColorPickerType.bw: 'B & W',
    },
    selectedPickerTypeColor: theme.colorScheme.primary,
    title: ref.watch(showTitlePod)
        ? Text(
            'ColorPicker',
            style: theme.textTheme.titleLarge,
          )
        : null,
    heading: ref.watch(showHeadingPod)
        ? Text(
            'Select color',
            style: theme.textTheme.headlineSmall,
          )
        : null,
    subheading: ref.watch(showSubheadingPod)
        ? Text(
            'Select color shade',
            style: theme.textTheme.titleMedium,
          )
        : null,
    tonalSubheading: ref.watch(showTonalSubheadingPod)
        ? Text(
            'Material 3 tonal palette',
            style: theme.textTheme.titleMedium,
          )
        : null,
    wheelSubheading: ref.watch(showSubheadingPod)
        ? Text(
            'Selected color and its color swatch',
            style: theme.textTheme.titleMedium,
          )
        : null,
    opacitySubheading: ref.watch(showOpacitySubheadingPod)
        ? Text(
            'Opacity',
            style: theme.textTheme.titleMedium,
          )
        : null,
    recentColorsSubheading: ref.watch(showRecentSubheadingPod)
        ? Text(
            'Recent colors',
            style: theme.textTheme.titleMedium,
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
    customSecondaryColorSwatchesAndNames: App.colorsOptionsMap,
  ).showPickerDialog(
    context,
    elevation: 2,
    // Let's make an even more transparent barrier color than black12
    barrierColor: const Color(0x33000000), // 6% opacity black
    constraints:
        const BoxConstraints(minHeight: 580, minWidth: 480, maxWidth: 480),
  );
}
