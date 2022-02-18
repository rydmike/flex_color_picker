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
  Widget build(BuildContext context, WidgetRef ref) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Card(
      elevation: 3,
      child: ColorPicker(
        color: ref.watch(cardPickerColorPod),
        onColorChangeStart: (Color color) {
          ref.read(onColorChangeStartPod.state).state = color;
        },
        onColorChanged: (Color color) {
          ref.read(cardPickerColorPod.state).state = color;
          ref.read(onColorChangedPod.state).state = color;
        },
        onColorChangeEnd: (Color color) {
          ref.read(onColorChangeEndPod.state).state = color;
        },
        onRecentColorsChanged: (List<Color> colors) {
          ref.read(cardRecentColorsPod.state).state = colors;
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
          copyButton: ref.watch(copyButtonPod),
          pasteButton: ref.watch(pasteButtonPod),
          copyFormat: ref.watch(copyFormatPod),
          longPressMenu: ref.watch(longPressMenuPod),
          secondaryMenu: ref.watch(secondaryMenuPod),
          secondaryOnDesktopLongOnDevice:
              ref.watch(secondaryDesktopOtherLongPod),
          secondaryOnDesktopLongOnDeviceAndWeb:
              ref.watch(secondaryDesktopWebLongPod),
          editFieldCopyButton: ref.watch(editFieldCopyButtonPod),
          parseShortHexCode: ref.watch(parseShortHexCodePod),
          editUsesParsedPaste: ref.watch(editUsesParsedPastePod),
          snackBarParseError: ref.watch(snackbarParseErrorPod),
          feedbackParseError: ref.watch(feedbackParseErrorPod),
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
        recentColors: ref.watch(cardRecentColorsPod),
        maxRecentColors: 8,
        customColorSwatchesAndNames: App.colorsNameMap,
        colorCodeTextStyle: Theme.of(context).textTheme.subtitle1,
        colorCodePrefixStyle: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
