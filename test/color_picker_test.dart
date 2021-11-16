import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore_for_file: unnecessary_null_comparison

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

      // ignore: prefer_function_declarations_over_variables
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
                ColorPickerType.wheel: false,
              } &&
          widget.enableShadesSelection == true &&
          widget.includeIndex850 == false &&
          widget.crossAxisAlignment == CrossAxisAlignment.center &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity == false &&
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
          widget.hasBorder == false &&
          widget.borderRadius == null &&
          widget.borderColor == null &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 16 &&
          widget.wheelHasBorder == false &&
          widget.title == null &&
          widget.heading == null &&
          widget.subheading == null &&
          widget.wheelSubheading == null &&
          widget.recentColorsSubheading == null &&
          widget.opacitySubheading == null &&
          widget.showMaterialName == false &&
          widget.materialNameTextStyle == null &&
          widget.showColorName == false &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode == false &&
          widget.colorCodeHasColor == false &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          widget.colorCodeReadOnly == false &&
          widget.showColorValue == false &&
          widget.showRecentColors == false &&
          widget.maxRecentColors == 5 &&
          widget.recentColors == const <Color>[] &&
          widget.onRecentColorsChanged == null &&
          widget.enableTooltips == true &&
          widget.selectedPickerTypeColor == null &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames ==
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
            hasBorder: true,
            borderRadius: 10,
            borderColor: Colors.black,
            wheelWidth: 32,
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
          ),
        ),
      );
      //
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables
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
          widget.enableShadesSelection == true &&
          widget.includeIndex850 == true &&
          widget.crossAxisAlignment == CrossAxisAlignment.start &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity == true &&
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
          widget.hasBorder == true &&
          widget.borderRadius == 10 &&
          widget.borderColor == Colors.black &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 32 &&
          widget.wheelHasBorder == true &&
          widget.title != null &&
          widget.heading != null &&
          widget.subheading != null &&
          widget.wheelSubheading != null &&
          widget.opacitySubheading != null &&
          widget.recentColorsSubheading != null &&
          widget.showMaterialName == true &&
          widget.materialNameTextStyle == null &&
          widget.showColorName == true &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode == true &&
          widget.colorCodeHasColor == true &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          widget.colorCodeReadOnly == false &&
          widget.showColorValue == true &&
          widget.showRecentColors == true &&
          widget.maxRecentColors == 10 &&
          widget.recentColors == const <Color>[Colors.black, Colors.white] &&
          widget.onRecentColorsChanged != null &&
          widget.enableTooltips == true &&
          widget.selectedPickerTypeColor == Colors.white &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames != <ColorSwatch<Object>, String>{};
      expect(find.byWidgetPredicate(customPicker), findsOneWidget);
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
          ),
        ),
      );
      //
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables
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
          widget.enableShadesSelection == true &&
          widget.includeIndex850 == true &&
          widget.crossAxisAlignment == CrossAxisAlignment.start &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity == true &&
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
          widget.hasBorder == true &&
          widget.borderRadius == 10 &&
          widget.borderColor == Colors.black &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 32 &&
          widget.wheelHasBorder == true &&
          widget.title != null &&
          widget.heading != null &&
          widget.subheading != null &&
          widget.wheelSubheading != null &&
          widget.opacitySubheading != null &&
          widget.recentColorsSubheading != null &&
          widget.showMaterialName == true &&
          widget.materialNameTextStyle == null &&
          widget.showColorName == true &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode == true &&
          widget.colorCodeHasColor == true &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          widget.colorCodeReadOnly == false &&
          widget.showColorValue == true &&
          widget.showRecentColors == true &&
          widget.maxRecentColors == 10 &&
          widget.recentColors == const <Color>[Colors.black, Colors.white] &&
          widget.onRecentColorsChanged != null &&
          widget.enableTooltips == true &&
          widget.selectedPickerTypeColor == Colors.white &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames != <ColorSwatch<Object>, String>{};
      expect(find.byWidgetPredicate(customPicker), findsOneWidget);
    });

    //
    // *************************************************************************
    //
    testWidgets('CPI1.4: Finds custom-3 ColorPicker() using custom colors',
        (WidgetTester tester) async {
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
          ),
        ),
      );

      //
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables
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
          widget.enableShadesSelection == true &&
          widget.includeIndex850 == true &&
          widget.crossAxisAlignment == CrossAxisAlignment.start &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity == true &&
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
          widget.hasBorder == true &&
          widget.borderRadius == 10 &&
          widget.borderColor == Colors.black &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 32 &&
          widget.wheelHasBorder == true &&
          widget.title != null &&
          widget.heading != null &&
          widget.subheading != null &&
          widget.wheelSubheading != null &&
          widget.opacitySubheading != null &&
          widget.recentColorsSubheading != null &&
          widget.showMaterialName == true &&
          widget.materialNameTextStyle == null &&
          widget.showColorName == true &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode == true &&
          widget.colorCodeHasColor == true &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          widget.colorCodeReadOnly == false &&
          widget.showColorValue == true &&
          widget.showRecentColors == true &&
          widget.maxRecentColors == 10 &&
          widget.recentColors == const <Color>[Colors.black, Colors.white] &&
          widget.onRecentColorsChanged != null &&
          widget.enableTooltips == true &&
          widget.selectedPickerTypeColor == Colors.white &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames != <ColorSwatch<Object>, String>{};
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
          ),
        ),
      );

      //
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables
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
          widget.enableShadesSelection == true &&
          widget.includeIndex850 == true &&
          widget.crossAxisAlignment == CrossAxisAlignment.start &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity == true &&
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
          widget.hasBorder == true &&
          widget.borderRadius == 10 &&
          widget.borderColor == Colors.black &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 32 &&
          widget.wheelHasBorder == true &&
          widget.title != null &&
          widget.heading != null &&
          widget.subheading != null &&
          widget.wheelSubheading != null &&
          widget.opacitySubheading != null &&
          widget.recentColorsSubheading != null &&
          widget.showMaterialName == true &&
          widget.materialNameTextStyle == null &&
          widget.showColorName == true &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode == true &&
          widget.colorCodeHasColor == true &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          widget.colorCodeReadOnly == false &&
          widget.showColorValue == true &&
          widget.showRecentColors == true &&
          widget.maxRecentColors == 10 &&
          widget.recentColors == const <Color>[Colors.black, Colors.white] &&
          widget.onRecentColorsChanged != null &&
          widget.enableTooltips == true &&
          widget.selectedPickerTypeColor == Colors.white &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames != <ColorSwatch<Object>, String>{};
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
          ),
        ),
      );

      //
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables
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
          widget.enableShadesSelection == true &&
          widget.includeIndex850 == true &&
          widget.crossAxisAlignment == CrossAxisAlignment.start &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity == true &&
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
          widget.hasBorder == true &&
          widget.borderRadius == 10 &&
          widget.borderColor == Colors.black &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 32 &&
          widget.wheelHasBorder == true &&
          widget.title != null &&
          widget.heading != null &&
          widget.subheading != null &&
          widget.wheelSubheading != null &&
          widget.opacitySubheading != null &&
          widget.recentColorsSubheading != null &&
          widget.showMaterialName == true &&
          widget.materialNameTextStyle == null &&
          widget.showColorName == true &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode == true &&
          widget.colorCodeHasColor == true &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          widget.colorCodeReadOnly == false &&
          widget.showColorValue == true &&
          widget.showRecentColors == true &&
          widget.maxRecentColors == 10 &&
          widget.recentColors == const <Color>[Colors.black, Colors.white] &&
          widget.onRecentColorsChanged != null &&
          widget.enableTooltips == true &&
          widget.selectedPickerTypeColor == Colors.white &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames != <ColorSwatch<Object>, String>{};
      expect(find.byWidgetPredicate(customPicker), findsOneWidget);
    });
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key, required this.widget}) : super(key: key);
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
