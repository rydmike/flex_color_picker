import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pods/pods.dart';
import '../../utils/app.dart';

/// The ColorPicker shown in a card on the ColorPickerScreen.
@immutable
class ColorPickerCard extends ConsumerWidget {
  const ColorPickerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 3,
      child: ColorPicker(
        color: watch(cardPickerColorPod).state,
        onColorChangeStart: (Color color) {
          context.read(onColorChangeStartPod).state = color;
        },
        onColorChanged: (Color color) {
          context.read(cardPickerColorPod).state = color;
          context.read(onColorChangedPod).state = color;
        },
        onColorChangeEnd: (Color color) {
          context.read(onColorChangeEndPod).state = color;
        },
        onRecentColorsChanged: (List<Color> colors) {
          context.read(cardRecentColorsPod).state = colors;
        },
        crossAxisAlignment: watch(alignmentPod).state,
        padding: EdgeInsets.all(watch(paddingPod).state),
        enableShadesSelection: watch(enableShadesSelectionPod).state,
        includeIndex850: watch(includeIndex850Pod).state,
        enableOpacity: watch(enableOpacityPod).state,
        opacityTrackHeight: watch(opacityTrackHeightPod).state,
        opacityTrackWidth: watch(opacityTrackWidthPod).state,
        opacityThumbRadius: watch(opacityThumbRadiusPod).state,
        copyPasteBehavior: ColorPickerCopyPasteBehavior(
          ctrlC: watch(ctrlCPod).state,
          ctrlV: watch(ctrlVPod).state,
          copyButton: watch(copyButtonPod).state,
          pasteButton: watch(pasteButtonPod).state,
          copyFormat: watch(copyFormatPod).state,
          longPressMenu: watch(longPressMenuPod).state,
          secondaryMenu: watch(secondaryMenuPod).state,
          secondaryOnDesktopLongOnDevice:
              watch(secondaryDesktopOtherLongPod).state,
          secondaryOnDesktopLongOnDeviceAndWeb:
              watch(secondaryDesktopWebLongPod).state,
          editFieldCopyButton: watch(editFieldCopyButtonPod).state,
          parseShortHexCode: watch(parseShortHexCodePod).state,
          editUsesParsedPaste: watch(editUsesParsedPastePod).state,
          snackBarParseError: watch(snackbarParseErrorPod).state,
          feedbackParseError: watch(feedbackParseErrorPod).state,
        ),
        width: watch(sizePod).state,
        height: watch(sizePod).state,
        spacing: watch(spacingPod).state,
        runSpacing: watch(runSpacingPod).state,
        elevation: watch(elevationPod).state,
        hasBorder: watch(hasBorderPod).state,
        borderRadius: watch(borderRadiusPod).state,
        columnSpacing: watch(columnSpacingPod).state,
        wheelDiameter: watch(wheelDiameterPod).state,
        wheelWidth: watch(wheelWidthPod).state,
        wheelHasBorder: watch(wheelHasBorderPod).state,
        enableTooltips: watch(enableTooltipsPod).state,
        pickersEnabled: watch(pickersEnabledPod).state,
        selectedPickerTypeColor: colorScheme.primary,
        title: watch(showTitlePod).state
            ? Text(
                'ColorPicker',
                style: Theme.of(context).textTheme.headline6,
              )
            : null,
        heading: watch(showHeadingPod).state
            ? Text(
                'Select color',
                style: Theme.of(context).textTheme.headline5,
              )
            : null,
        subheading: watch(showSubheadingPod).state
            ? Text(
                'Select color shade',
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
        wheelSubheading: watch(showSubheadingPod).state
            ? Text(
                'Selected color and its color swatch',
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
        opacitySubheading: watch(showOpacitySubheadingPod).state
            ? Text(
                'Opacity',
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
        recentColorsSubheading: watch(showRecentSubheadingPod).state
            ? Text(
                'Recent colors',
                style: Theme.of(context).textTheme.subtitle1,
              )
            : null,
        showMaterialName: watch(showMaterialNamePod).state,
        showColorName: watch(showColorNamePod).state,
        showColorCode: watch(showColorCodePod).state,
        colorCodeHasColor: watch(colorCodeHasColorPod).state,
        colorCodeReadOnly: watch(colorCodeReadOnlyPod).state,
        showColorValue: watch(showColorValuePod).state,
        showRecentColors: watch(showRecentColorsPod).state,
        recentColors: watch(cardRecentColorsPod).state,
        maxRecentColors: 8,
        customColorSwatchesAndNames: App.colorsNameMap,
        colorCodeTextStyle: Theme.of(context).textTheme.subtitle1,
        colorCodePrefixStyle: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
