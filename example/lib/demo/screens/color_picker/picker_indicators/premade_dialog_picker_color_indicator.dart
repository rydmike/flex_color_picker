import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';
import '../../../utils/app.dart';

@immutable
class PremadeDialogPickerColorIndicator extends ConsumerWidget {
  const PremadeDialogPickerColorIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Click to update only when dialog is closed. '
          'Uses `showColorPickerDialog`.'),
      subtitle: Text(
          // ignore: lines_longer_than_80_chars
          '${ColorTools.materialNameAndARGBCode(ref.watch(dialogPickerColorPod), colorSwatchNameMap: App.colorsNameMap)} '
          'aka ${ColorTools.nameThatColor(ref.watch(dialogPickerColorPod))}'),
      trailing: ColorIndicator(
        height: ref.watch(sizePod),
        width: ref.watch(sizePod),
        borderRadius: ref.watch(borderRadiusPod),
        elevation: ref.watch(elevationPod),
        color: ref.watch(dialogPickerColorPod),
        hasBorder: ref.watch(hasBorderPod),
        onSelectFocus: false,
        onSelect: () async {
          ref.read(dialogPickerColorPod.notifier).state =
              await dialogColor(context, ref, ref.read(dialogPickerColorPod));
        },
      ),
    );
  }

  // Wait for the dialog to return color selection result.
  Future<Color> dialogColor(BuildContext context, WidgetRef ref, Color color) {
    final ThemeData theme = Theme.of(context);
    return showColorPickerDialog(
      // The dialog needs a context, we pass it in.
      context,
      // We use the dialogSelectColor, as its starting color.
      color,
      crossAxisAlignment: ref.watch(alignmentPod),
      padding: EdgeInsets.all(ref.watch(paddingPod)),
      enableShadesSelection: ref.watch(enableShadesSelectionPod),
      includeIndex850: ref.watch(includeIndex850Pod),
      enableTonalPalette: ref.watch(enableTonesSelectionPod),
      tonalPaletteFixedMinChroma: ref.watch(tonalPaletteFixedMinChromaPod),
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
      showEditIconButton: ref.watch(showEditIconButtonPod),
      colorCodeHasColor: ref.watch(colorCodeHasColorPod),
      focusedEditHasNoColor: ref.watch(focusedEditHasNoColorPod),
      colorCodeReadOnly: ref.watch(colorCodeReadOnlyPod),
      showColorValue: ref.watch(showColorValuePod),
      showRecentColors: ref.watch(showRecentColorsPod),
      recentColors: ref.watch(dialogRecentColorsPod),
      maxRecentColors: 5,
      customColorSwatchesAndNames: App.colorsNameMap,
      customSecondaryColorSwatchesAndNames: App.colorsOptionsMap,
      dialogElevation: 2,
      // Let's make an even more transparent barrier color than black12
      barrierColor: const Color(0x33000000), // 6% opacity black
      constraints:
          const BoxConstraints(minHeight: 580, minWidth: 480, maxWidth: 480),
    );
  }
}
