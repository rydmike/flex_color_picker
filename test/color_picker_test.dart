import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore_for_file: unnecessary_null_comparison, for clarity in tests.

//****************************************************************************
// FlexColorPicker ColorPicker Widget tests
//****************************************************************************
void main() {
  const ValueKey<String> testKey = ValueKey<String>('test');

  group('CPI1: In App With ColorPicker', () {
    debugDefaultTargetPlatformOverride = null;
    testWidgets('CPI1.1: Finds default ColorPicker()',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: ColorPicker(
            key: testKey,
            onColorChanged: (Color color) {},
          ),
        ),
      );
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables, use in tests.
      final WidgetPredicate defaultPicker = (Widget widget) =>
          widget is ColorPicker &&
          widget.color == Colors.blue &&
          widget.onColorChanged != null &&
          widget.onColorChangeStart == null &&
          widget.onColorChangeEnd == null &&
          widget.pickersEnabled ==
              const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: true,
                ColorPickerType.accent: true,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.customSecondary: false,
                ColorPickerType.wheel: false,
              } &&
          widget.enableShadesSelection &&
          !widget.includeIndex850 &&
          widget.crossAxisAlignment == CrossAxisAlignment.center &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          !widget.enableOpacity &&
          widget.opacityTrackHeight == 36 &&
          widget.opacityTrackWidth == null &&
          widget.opacityThumbRadius == 16 &&
          widget.actionButtons == const ColorPickerActionButtons() &&
          widget.copyPasteBehavior == const ColorPickerCopyPasteBehavior() &&
          widget.selectedColorIcon == Icons.check &&
          widget.width == 40 &&
          widget.height == 40 &&
          widget.spacing == 4 &&
          widget.runSpacing == 4 &&
          widget.elevation == 0 &&
          !widget.hasBorder &&
          widget.borderRadius == null &&
          widget.borderColor == null &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 16 &&
          widget.wheelSquarePadding == 0 &&
          widget.wheelSquareBorderRadius == 4 &&
          !widget.wheelHasBorder &&
          widget.title == null &&
          widget.heading == null &&
          widget.subheading == null &&
          widget.wheelSubheading == null &&
          widget.recentColorsSubheading == null &&
          widget.opacitySubheading == null &&
          !widget.showMaterialName &&
          widget.materialNameTextStyle == null &&
          !widget.showColorName &&
          widget.colorNameTextStyle == null &&
          !widget.showColorCode &&
          !widget.colorCodeHasColor &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          !widget.colorCodeReadOnly &&
          !widget.showColorValue &&
          !widget.showRecentColors &&
          widget.maxRecentColors == 5 &&
          widget.recentColors == const <Color>[] &&
          widget.onRecentColorsChanged == null &&
          widget.enableTooltips &&
          widget.selectedPickerTypeColor == null &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.customSecondary: 'Option',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames ==
              const <ColorSwatch<Object>, String>{} &&
          widget.customSecondaryColorSwatchesAndNames ==
              const <ColorSwatch<Object>, String>{};

      expect(find.byWidgetPredicate(defaultPicker), findsOneWidget);
    });
    //
    // *************************************************************************
    //
    testWidgets('CPI1.2: Finds custom-1 ColorPicker() with both picker',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: ColorPicker(
            key: testKey,
            color: Colors.red,
            onColorChanged: (Color color) {},
            onColorChangeStart: (Color color) {},
            onColorChangeEnd: (Color color) {},
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.both: true,
              ColorPickerType.primary: false,
              ColorPickerType.accent: false,
              ColorPickerType.bw: true,
              ColorPickerType.custom: true,
              ColorPickerType.wheel: true,
            },
            includeIndex850: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            enableOpacity: true,
            actionButtons: const ColorPickerActionButtons(
              okButton: true,
              closeButton: true,
              okTooltip: 'OK NOW',
              closeTooltip: 'CLOSE NOW',
            ),
            width: 39,
            hasBorder: true,
            borderRadius: 10,
            borderColor: Colors.black,
            wheelWidth: 32,
            wheelSquarePadding: 4,
            wheelSquareBorderRadius: 6,
            wheelHasBorder: true,
            title: const Text('Title1'),
            heading: const Text('Title2'),
            subheading: const Text('Title3'),
            wheelSubheading: const Text('Title4'),
            opacitySubheading: const Text('Title5'),
            recentColorsSubheading: const Text('Title6'),
            showMaterialName: true,
            showColorName: true,
            showColorCode: true,
            colorCodeHasColor: true,
            showColorValue: true,
            showRecentColors: true,
            maxRecentColors: 10,
            recentColors: const <Color>[Colors.black, Colors.white],
            onRecentColorsChanged: (List<Color> colors) {},
            selectedPickerTypeColor: Colors.white,
            customColorSwatchesAndNames: <ColorSwatch<Object>, String>{
              ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                  'Guide Purple',
              ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                  'Guide Purple Variant',
              ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                  'Guide Teal',
            },
            customSecondaryColorSwatchesAndNames: <ColorSwatch<Object>, String>{
              ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                  'Guide Purple',
              ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                  'Guide Purple Variant',
              ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                  'Guide Teal',
            },
          ),
        ),
      );
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables, use in tests ok.
      final WidgetPredicate customPicker = (Widget widget) =>
          widget is ColorPicker &&
          widget.color == Colors.red &&
          widget.onColorChanged != null &&
          widget.onColorChangeStart != null &&
          widget.onColorChangeEnd != null &&
          widget.pickersEnabled ==
              const <ColorPickerType, bool>{
                ColorPickerType.both: true,
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
                ColorPickerType.bw: true,
                ColorPickerType.custom: true,
                ColorPickerType.wheel: true,
              } &&
          widget.enableShadesSelection &&
          widget.includeIndex850 &&
          widget.crossAxisAlignment == CrossAxisAlignment.start &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity &&
          widget.opacityTrackHeight == 36 &&
          widget.opacityTrackWidth == null &&
          widget.opacityThumbRadius == 16 &&
          widget.actionButtons ==
              const ColorPickerActionButtons(
                okButton: true,
                closeButton: true,
                okTooltip: 'OK NOW',
                closeTooltip: 'CLOSE NOW',
              ) &&
          widget.copyPasteBehavior == const ColorPickerCopyPasteBehavior() &&
          widget.selectedColorIcon == Icons.check &&
          widget.width == 39 &&
          widget.height == 40 &&
          widget.spacing == 4 &&
          widget.runSpacing == 4 &&
          widget.elevation == 0 &&
          widget.hasBorder &&
          widget.borderRadius == 10 &&
          widget.borderColor == Colors.black &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 32 &&
          widget.wheelSquarePadding == 4 &&
          widget.wheelSquareBorderRadius == 6 &&
          widget.wheelHasBorder &&
          widget.title != null &&
          widget.heading != null &&
          widget.subheading != null &&
          widget.wheelSubheading != null &&
          widget.opacitySubheading != null &&
          widget.recentColorsSubheading != null &&
          widget.showMaterialName &&
          widget.materialNameTextStyle == null &&
          widget.showColorName &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode &&
          widget.colorCodeHasColor &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          !widget.colorCodeReadOnly &&
          widget.showColorValue &&
          widget.showRecentColors &&
          widget.maxRecentColors == 10 &&
          widget.recentColors == const <Color>[Colors.black, Colors.white] &&
          widget.onRecentColorsChanged != null &&
          widget.enableTooltips &&
          widget.selectedPickerTypeColor == Colors.white &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.customSecondary: 'Option',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames !=
              <ColorSwatch<Object>, String>{} &&
          widget.customSecondaryColorSwatchesAndNames !=
              <ColorSwatch<Object>, String>{};
      expect(find.byWidgetPredicate(customPicker, skipOffstage: false),
          findsOneWidget);
    });
    //
    // *************************************************************************
    //
    testWidgets('CPI1.3: Finds custom-2 ColorPicker() using wheel',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: ColorPicker(
            key: testKey,
            color: const Color(0xF03295C1), // Results in wheel selected
            onColorChanged: (Color color) {},
            onColorChangeStart: (Color color) {},
            onColorChangeEnd: (Color color) {},
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: true,
              ColorPickerType.bw: true,
              ColorPickerType.custom: true,
              ColorPickerType.wheel: true,
            },
            includeIndex850: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            enableOpacity: true,
            actionButtons: const ColorPickerActionButtons(
              okButton: true,
              closeButton: true,
              okTooltip: 'OK NOW',
              closeTooltip: 'CLOSE NOW',
            ),
            hasBorder: true,
            borderRadius: 10,
            borderColor: Colors.black,
            wheelWidth: 32,
            wheelSquarePadding: 5,
            wheelSquareBorderRadius: 0,
            wheelHasBorder: true,
            title: const Text('Title1'),
            heading: const Text('Title2'),
            subheading: const Text('Title3'),
            wheelSubheading: const Text('Title4'),
            opacitySubheading: const Text('Title5'),
            recentColorsSubheading: const Text('Title6'),
            showMaterialName: true,
            showColorName: true,
            showColorCode: true,
            colorCodeHasColor: true,
            showColorValue: true,
            showRecentColors: true,
            maxRecentColors: 10,
            recentColors: const <Color>[Colors.black, Colors.white],
            onRecentColorsChanged: (List<Color> colors) {},
            selectedPickerTypeColor: Colors.white,
            customColorSwatchesAndNames: <ColorSwatch<Object>, String>{
              ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                  'Guide Purple',
              ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                  'Guide Purple Variant',
              ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                  'Guide Teal',
            },
            customSecondaryColorSwatchesAndNames: <ColorSwatch<Object>, String>{
              ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                  'Guide Purple',
              ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                  'Guide Purple Variant',
              ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                  'Guide Teal',
            },
          ),
        ),
      );
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables, use in tests ok.
      final WidgetPredicate customPicker = (Widget widget) =>
          widget is ColorPicker &&
          widget.color == const Color(0xF03295C1) &&
          widget.onColorChanged != null &&
          widget.onColorChangeStart != null &&
          widget.onColorChangeEnd != null &&
          widget.pickersEnabled ==
              const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: true,
                ColorPickerType.accent: true,
                ColorPickerType.bw: true,
                ColorPickerType.custom: true,
                ColorPickerType.wheel: true,
              } &&
          widget.enableShadesSelection &&
          widget.includeIndex850 &&
          widget.crossAxisAlignment == CrossAxisAlignment.start &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity &&
          widget.opacityTrackHeight == 36 &&
          widget.opacityTrackWidth == null &&
          widget.opacityThumbRadius == 16 &&
          widget.actionButtons ==
              const ColorPickerActionButtons(
                okButton: true,
                closeButton: true,
                okTooltip: 'OK NOW',
                closeTooltip: 'CLOSE NOW',
              ) &&
          widget.copyPasteBehavior == const ColorPickerCopyPasteBehavior() &&
          widget.selectedColorIcon == Icons.check &&
          widget.width == 40 &&
          widget.height == 40 &&
          widget.spacing == 4 &&
          widget.runSpacing == 4 &&
          widget.elevation == 0 &&
          widget.hasBorder &&
          widget.borderRadius == 10 &&
          widget.borderColor == Colors.black &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 32 &&
          widget.wheelSquarePadding == 5 &&
          widget.wheelSquareBorderRadius == 0 &&
          widget.wheelHasBorder &&
          widget.title != null &&
          widget.heading != null &&
          widget.subheading != null &&
          widget.wheelSubheading != null &&
          widget.opacitySubheading != null &&
          widget.recentColorsSubheading != null &&
          widget.showMaterialName &&
          widget.materialNameTextStyle == null &&
          widget.showColorName &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode &&
          widget.colorCodeHasColor &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          !widget.colorCodeReadOnly &&
          widget.showColorValue &&
          widget.showRecentColors &&
          widget.maxRecentColors == 10 &&
          widget.recentColors == const <Color>[Colors.black, Colors.white] &&
          widget.onRecentColorsChanged != null &&
          widget.enableTooltips &&
          widget.selectedPickerTypeColor == Colors.white &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.customSecondary: 'Option',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames !=
              <ColorSwatch<Object>, String>{} &&
          widget.customSecondaryColorSwatchesAndNames !=
              <ColorSwatch<Object>, String>{};
      expect(find.byWidgetPredicate(customPicker), findsOneWidget);
    });

    //
    // *************************************************************************
    //
    testWidgets(
        'CPI1.4: Finds custom-3 ColorPicker() using custom colors '
        'and tonal palette and same size tonal', (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: ColorPicker(
            key: testKey,
            color: const Color(0xFA6200EE), // Results in custom selected
            onColorChanged: (Color color) {},
            onColorChangeStart: (Color color) {},
            onColorChangeEnd: (Color color) {},
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: true,
              ColorPickerType.bw: true,
              ColorPickerType.custom: true,
              ColorPickerType.wheel: true,
            },
            includeIndex850: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            enableOpacity: true,
            enableTonalPalette: true,
            tonalColorSameSize: true,
            opacityTrackHeight: 40,
            opacityThumbRadius: 25,
            opacityTrackWidth: 300,
            actionButtons: const ColorPickerActionButtons(
              okButton: true,
              closeButton: true,
              dialogActionIcons: true,
              closeIsLast: false,
              okTooltip: 'OK NOW',
              closeTooltip: 'CLOSE NOW',
              dialogCancelButtonLabel: 'CANCEL ME',
              dialogCancelButtonType: ColorPickerActionButtonType.outlined,
              dialogOkButtonLabel: 'OK ME',
              dialogOkButtonType: ColorPickerActionButtonType.outlined,
            ),
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              copyButton: true,
              pasteButton: true,
              copyTooltip: 'Copy ME',
              pasteTooltip: 'Paste ME',
              longPressMenu: true,
              secondaryMenu: true,
              secondaryOnDesktopLongOnDevice: true,
              secondaryOnDesktopLongOnDeviceAndWeb: true,
              snackBarMessage: 'Error color',
              editUsesParsedPaste: true,
              parseShortHexCode: true,
              editFieldCopyButton: false,
              feedbackParseError: true,
            ),
            hasBorder: true,
            borderRadius: 10,
            borderColor: Colors.black,
            wheelWidth: 32,
            wheelSquarePadding: 10,
            wheelSquareBorderRadius: 2,
            wheelHasBorder: true,
            title: const Text('Title1'),
            heading: const Text('Title2'),
            subheading: const Text('Title3'),
            tonalSubheading: const Text('Title3-t'),
            wheelSubheading: const Text('Title4'),
            opacitySubheading: const Text('Title5'),
            recentColorsSubheading: const Text('Title6'),
            showMaterialName: true,
            showColorName: true,
            showColorCode: true,
            colorCodeHasColor: true,
            showColorValue: true,
            showRecentColors: true,
            maxRecentColors: 10,
            recentColors: const <Color>[Colors.black, Colors.white],
            onRecentColorsChanged: (List<Color> colors) {},
            selectedPickerTypeColor: Colors.white,
            customColorSwatchesAndNames: <ColorSwatch<Object>, String>{
              ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                  'Guide Purple',
              ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                  'Guide Purple Variant',
              ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                  'Guide Teal',
            },
            customSecondaryColorSwatchesAndNames: <ColorSwatch<Object>, String>{
              ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                  'Guide Purple',
              ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                  'Guide Purple Variant',
              ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                  'Guide Teal',
            },
          ),
        ),
      );
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables, use in tests ok.
      final WidgetPredicate customPicker = (Widget widget) =>
          widget is ColorPicker &&
          widget.color == const Color(0xFA6200EE) &&
          widget.onColorChanged != null &&
          widget.onColorChangeStart != null &&
          widget.onColorChangeEnd != null &&
          widget.pickersEnabled ==
              const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: true,
                ColorPickerType.accent: true,
                ColorPickerType.bw: true,
                ColorPickerType.custom: true,
                ColorPickerType.wheel: true,
              } &&
          widget.enableShadesSelection &&
          widget.includeIndex850 &&
          widget.crossAxisAlignment == CrossAxisAlignment.start &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity &&
          widget.opacityTrackHeight == 40 &&
          widget.opacityThumbRadius == 25 &&
          widget.opacityTrackWidth == 300 &&
          widget.actionButtons ==
              const ColorPickerActionButtons(
                okButton: true,
                closeButton: true,
                dialogActionIcons: true,
                closeIsLast: false,
                okTooltip: 'OK NOW',
                closeTooltip: 'CLOSE NOW',
                dialogCancelButtonLabel: 'CANCEL ME',
                dialogCancelButtonType: ColorPickerActionButtonType.outlined,
                dialogOkButtonLabel: 'OK ME',
                dialogOkButtonType: ColorPickerActionButtonType.outlined,
              ) &&
          widget.copyPasteBehavior ==
              const ColorPickerCopyPasteBehavior(
                copyButton: true,
                pasteButton: true,
                copyTooltip: 'Copy ME',
                pasteTooltip: 'Paste ME',
                longPressMenu: true,
                secondaryMenu: true,
                secondaryOnDesktopLongOnDevice: true,
                secondaryOnDesktopLongOnDeviceAndWeb: true,
                snackBarMessage: 'Error color',
                editUsesParsedPaste: true,
                parseShortHexCode: true,
                editFieldCopyButton: false,
                feedbackParseError: true,
              ) &&
          widget.selectedColorIcon == Icons.check &&
          widget.width == 40 &&
          widget.height == 40 &&
          widget.spacing == 4 &&
          widget.runSpacing == 4 &&
          widget.elevation == 0 &&
          widget.hasBorder &&
          widget.borderRadius == 10 &&
          widget.borderColor == Colors.black &&
          widget.wheelDiameter == 190 &&
          widget.wheelSquarePadding == 10 &&
          widget.wheelSquareBorderRadius == 2 &&
          widget.wheelWidth == 32 &&
          widget.wheelHasBorder &&
          widget.title != null &&
          widget.heading != null &&
          widget.subheading != null &&
          widget.wheelSubheading != null &&
          widget.opacitySubheading != null &&
          widget.recentColorsSubheading != null &&
          widget.showMaterialName &&
          widget.materialNameTextStyle == null &&
          widget.showColorName &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode &&
          widget.colorCodeHasColor &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          !widget.colorCodeReadOnly &&
          widget.showColorValue &&
          widget.showRecentColors &&
          widget.maxRecentColors == 10 &&
          widget.recentColors == const <Color>[Colors.black, Colors.white] &&
          widget.onRecentColorsChanged != null &&
          widget.enableTooltips &&
          widget.selectedPickerTypeColor == Colors.white &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.customSecondary: 'Option',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames !=
              <ColorSwatch<Object>, String>{} &&
          widget.customSecondaryColorSwatchesAndNames !=
              <ColorSwatch<Object>, String>{};
      expect(find.byWidgetPredicate(customPicker), findsOneWidget);
    });

    //
    // *************************************************************************
    //
    testWidgets('CPI1.5: Finds custom-3 ColorPicker() using primary colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: ColorPicker(
            key: testKey,
            color: Colors.red.shade200, // Results in custom selected
            onColorChanged: (Color color) {},
            onColorChangeStart: (Color color) {},
            onColorChangeEnd: (Color color) {},
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: true,
              ColorPickerType.bw: true,
              ColorPickerType.custom: true,
              ColorPickerType.wheel: true,
            },
            includeIndex850: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            enableOpacity: true,
            opacityTrackHeight: 40,
            opacityThumbRadius: 25,
            opacityTrackWidth: 300,
            actionButtons: const ColorPickerActionButtons(
              okButton: true,
              closeButton: true,
              dialogActionIcons: true,
              closeIsLast: false,
              okTooltip: 'OK NOW',
              closeTooltip: 'CLOSE NOW',
              dialogCancelButtonLabel: 'CANCEL ME',
              dialogCancelButtonType: ColorPickerActionButtonType.outlined,
              dialogOkButtonLabel: 'OK ME',
              dialogOkButtonType: ColorPickerActionButtonType.outlined,
            ),
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              copyButton: true,
              pasteButton: true,
              copyTooltip: 'Copy ME',
              pasteTooltip: 'Paste ME',
              longPressMenu: true,
              secondaryMenu: true,
              secondaryOnDesktopLongOnDevice: true,
              secondaryOnDesktopLongOnDeviceAndWeb: true,
              snackBarMessage: 'Error color',
              editUsesParsedPaste: true,
              parseShortHexCode: true,
              editFieldCopyButton: false,
              feedbackParseError: true,
            ),
            hasBorder: true,
            borderRadius: 10,
            borderColor: Colors.black,
            wheelWidth: 32,
            wheelSquarePadding: 0,
            wheelSquareBorderRadius: 0,
            wheelHasBorder: true,
            title: const Text('Title1'),
            heading: const Text('Title2'),
            subheading: const Text('Title3'),
            wheelSubheading: const Text('Title4'),
            opacitySubheading: const Text('Title5'),
            recentColorsSubheading: const Text('Title6'),
            showMaterialName: true,
            showColorName: true,
            showColorCode: true,
            colorCodeHasColor: true,
            showColorValue: true,
            showRecentColors: true,
            maxRecentColors: 10,
            recentColors: const <Color>[Colors.black, Colors.white],
            onRecentColorsChanged: (List<Color> colors) {},
            selectedPickerTypeColor: Colors.white,
            customColorSwatchesAndNames: <ColorSwatch<Object>, String>{
              ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                  'Guide Purple',
              ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                  'Guide Purple Variant',
              ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                  'Guide Teal',
            },
            customSecondaryColorSwatchesAndNames: <ColorSwatch<Object>, String>{
              ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                  'Guide Purple',
              ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                  'Guide Purple Variant',
              ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                  'Guide Teal',
            },
          ),
        ),
      );
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables, use in tests ok.
      final WidgetPredicate customPicker = (Widget widget) =>
          widget is ColorPicker &&
          widget.color == Colors.red.shade200 &&
          widget.onColorChanged != null &&
          widget.onColorChangeStart != null &&
          widget.onColorChangeEnd != null &&
          widget.pickersEnabled ==
              const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: true,
                ColorPickerType.accent: true,
                ColorPickerType.bw: true,
                ColorPickerType.custom: true,
                ColorPickerType.wheel: true,
              } &&
          widget.enableShadesSelection &&
          widget.includeIndex850 &&
          widget.crossAxisAlignment == CrossAxisAlignment.start &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity &&
          widget.opacityTrackHeight == 40 &&
          widget.opacityThumbRadius == 25 &&
          widget.opacityTrackWidth == 300 &&
          widget.actionButtons ==
              const ColorPickerActionButtons(
                okButton: true,
                closeButton: true,
                dialogActionIcons: true,
                closeIsLast: false,
                okTooltip: 'OK NOW',
                closeTooltip: 'CLOSE NOW',
                dialogCancelButtonLabel: 'CANCEL ME',
                dialogCancelButtonType: ColorPickerActionButtonType.outlined,
                dialogOkButtonLabel: 'OK ME',
                dialogOkButtonType: ColorPickerActionButtonType.outlined,
              ) &&
          widget.copyPasteBehavior ==
              const ColorPickerCopyPasteBehavior(
                copyButton: true,
                pasteButton: true,
                copyTooltip: 'Copy ME',
                pasteTooltip: 'Paste ME',
                longPressMenu: true,
                secondaryMenu: true,
                secondaryOnDesktopLongOnDevice: true,
                secondaryOnDesktopLongOnDeviceAndWeb: true,
                snackBarMessage: 'Error color',
                editUsesParsedPaste: true,
                parseShortHexCode: true,
                editFieldCopyButton: false,
                feedbackParseError: true,
              ) &&
          widget.selectedColorIcon == Icons.check &&
          widget.width == 40 &&
          widget.height == 40 &&
          widget.spacing == 4 &&
          widget.runSpacing == 4 &&
          widget.elevation == 0 &&
          widget.hasBorder &&
          widget.borderRadius == 10 &&
          widget.borderColor == Colors.black &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 32 &&
          widget.wheelSquarePadding == 0 &&
          widget.wheelSquareBorderRadius == 0 &&
          widget.wheelHasBorder &&
          widget.title != null &&
          widget.heading != null &&
          widget.subheading != null &&
          widget.wheelSubheading != null &&
          widget.opacitySubheading != null &&
          widget.recentColorsSubheading != null &&
          widget.showMaterialName &&
          widget.materialNameTextStyle == null &&
          widget.showColorName &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode &&
          widget.colorCodeHasColor &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          !widget.colorCodeReadOnly &&
          widget.showColorValue &&
          widget.showRecentColors &&
          widget.maxRecentColors == 10 &&
          widget.recentColors == const <Color>[Colors.black, Colors.white] &&
          widget.onRecentColorsChanged != null &&
          widget.enableTooltips &&
          widget.selectedPickerTypeColor == Colors.white &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.customSecondary: 'Option',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames !=
              <ColorSwatch<Object>, String>{} &&
          widget.customSecondaryColorSwatchesAndNames !=
              <ColorSwatch<Object>, String>{};
      expect(find.byWidgetPredicate(customPicker), findsOneWidget);
    });

    //
    // *************************************************************************
    //
    testWidgets('CPI1.6: Finds custom-3 ColorPicker() using accent colors',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        TestWidget(
          widget: ColorPicker(
            key: testKey,
            color: Colors.pinkAccent.shade700, // Results in custom selected
            onColorChanged: (Color color) {},
            onColorChangeStart: (Color color) {},
            onColorChangeEnd: (Color color) {},
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.both: false,
              ColorPickerType.primary: true,
              ColorPickerType.accent: true,
              ColorPickerType.bw: true,
              ColorPickerType.custom: true,
              ColorPickerType.wheel: true,
            },
            includeIndex850: true,
            crossAxisAlignment: CrossAxisAlignment.start,
            enableOpacity: true,
            opacityTrackHeight: 40,
            opacityThumbRadius: 25,
            opacityTrackWidth: 300,
            actionButtons: const ColorPickerActionButtons(
              okButton: true,
              closeButton: true,
              dialogActionIcons: true,
              closeIsLast: false,
              okTooltip: 'OK NOW',
              closeTooltip: 'CLOSE NOW',
              dialogCancelButtonLabel: 'CANCEL ME',
              dialogCancelButtonType: ColorPickerActionButtonType.outlined,
              dialogOkButtonLabel: 'OK ME',
              dialogOkButtonType: ColorPickerActionButtonType.outlined,
            ),
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              copyButton: true,
              pasteButton: true,
              copyTooltip: 'Copy ME',
              pasteTooltip: 'Paste ME',
              longPressMenu: true,
              secondaryMenu: true,
              secondaryOnDesktopLongOnDevice: true,
              secondaryOnDesktopLongOnDeviceAndWeb: true,
              snackBarMessage: 'Error color',
              editUsesParsedPaste: true,
              parseShortHexCode: true,
              editFieldCopyButton: false,
              feedbackParseError: true,
            ),
            hasBorder: true,
            borderRadius: 10,
            borderColor: Colors.black,
            wheelWidth: 32,
            wheelSquarePadding: 3.5,
            wheelSquareBorderRadius: 3.5,
            wheelHasBorder: true,
            title: const Text('Title1'),
            heading: const Text('Title2'),
            subheading: const Text('Title3'),
            wheelSubheading: const Text('Title4'),
            opacitySubheading: const Text('Title5'),
            recentColorsSubheading: const Text('Title6'),
            showMaterialName: true,
            showColorName: true,
            showColorCode: true,
            colorCodeHasColor: true,
            showColorValue: true,
            showRecentColors: true,
            maxRecentColors: 10,
            recentColors: const <Color>[Colors.black, Colors.white],
            onRecentColorsChanged: (List<Color> colors) {},
            selectedPickerTypeColor: Colors.white,
            customColorSwatchesAndNames: <ColorSwatch<Object>, String>{
              ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                  'Guide Purple',
              ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                  'Guide Purple Variant',
              ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                  'Guide Teal',
            },
            customSecondaryColorSwatchesAndNames: <ColorSwatch<Object>, String>{
              ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                  'Guide Purple',
              ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                  'Guide Purple Variant',
              ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                  'Guide Teal',
            },
          ),
        ),
      );
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables, use in tests ok.
      final WidgetPredicate customPicker = (Widget widget) =>
          widget is ColorPicker &&
          widget.color == Colors.pinkAccent.shade700 &&
          widget.onColorChanged != null &&
          widget.onColorChangeStart != null &&
          widget.onColorChangeEnd != null &&
          widget.pickersEnabled ==
              const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: true,
                ColorPickerType.accent: true,
                ColorPickerType.bw: true,
                ColorPickerType.custom: true,
                ColorPickerType.wheel: true,
              } &&
          widget.enableShadesSelection &&
          widget.includeIndex850 &&
          widget.crossAxisAlignment == CrossAxisAlignment.start &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity &&
          widget.opacityTrackHeight == 40 &&
          widget.opacityThumbRadius == 25 &&
          widget.opacityTrackWidth == 300 &&
          widget.actionButtons ==
              const ColorPickerActionButtons(
                okButton: true,
                closeButton: true,
                dialogActionIcons: true,
                closeIsLast: false,
                okTooltip: 'OK NOW',
                closeTooltip: 'CLOSE NOW',
                dialogCancelButtonLabel: 'CANCEL ME',
                dialogCancelButtonType: ColorPickerActionButtonType.outlined,
                dialogOkButtonLabel: 'OK ME',
                dialogOkButtonType: ColorPickerActionButtonType.outlined,
              ) &&
          widget.copyPasteBehavior ==
              const ColorPickerCopyPasteBehavior(
                copyButton: true,
                pasteButton: true,
                copyTooltip: 'Copy ME',
                pasteTooltip: 'Paste ME',
                longPressMenu: true,
                secondaryMenu: true,
                secondaryOnDesktopLongOnDevice: true,
                secondaryOnDesktopLongOnDeviceAndWeb: true,
                snackBarMessage: 'Error color',
                editUsesParsedPaste: true,
                parseShortHexCode: true,
                editFieldCopyButton: false,
                feedbackParseError: true,
              ) &&
          widget.selectedColorIcon == Icons.check &&
          widget.width == 40 &&
          widget.height == 40 &&
          widget.spacing == 4 &&
          widget.runSpacing == 4 &&
          widget.elevation == 0 &&
          widget.hasBorder &&
          widget.borderRadius == 10 &&
          widget.borderColor == Colors.black &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 32 &&
          widget.wheelSquarePadding == 3.5 &&
          widget.wheelSquareBorderRadius == 3.5 &&
          widget.wheelHasBorder &&
          widget.title != null &&
          widget.heading != null &&
          widget.subheading != null &&
          widget.wheelSubheading != null &&
          widget.opacitySubheading != null &&
          widget.recentColorsSubheading != null &&
          widget.showMaterialName &&
          widget.materialNameTextStyle == null &&
          widget.showColorName &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode &&
          widget.colorCodeHasColor &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          !widget.colorCodeReadOnly &&
          widget.showColorValue &&
          widget.showRecentColors &&
          widget.maxRecentColors == 10 &&
          widget.recentColors == const <Color>[Colors.black, Colors.white] &&
          widget.onRecentColorsChanged != null &&
          widget.enableTooltips &&
          widget.selectedPickerTypeColor == Colors.white &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.customSecondary: 'Option',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames !=
              <ColorSwatch<Object>, String>{} &&
          widget.customSecondaryColorSwatchesAndNames !=
              <ColorSwatch<Object>, String>{};
      expect(find.byWidgetPredicate(customPicker), findsOneWidget);
    });
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    debugDefaultTargetPlatformOverride = null;
    return MaterialApp(
      title: 'TestWidget',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TestWidget'),
        ),
        body: SingleChildScrollView(
          child: widget,
        ),
      ),
    );
  }
}
