import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flex_color_picker/src/widgets/color_picker_toolbar.dart';
import 'package:flex_color_picker/src/widgets/opacity/opacity_slider.dart';
import 'package:flex_color_picker/src/widgets/recent_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol_finders/patrol_finders.dart';

// ignore_for_file: unnecessary_null_comparison

//****************************************************************************
// FlexColorPicker ColorPicker Widget tests
//****************************************************************************
void main() {
  const ValueKey<String> testKey = ValueKey<String>('test');

  group('PAT1: Default ColorPicker', () {
    debugDefaultTargetPlatformOverride = null;

    patrolWidgetTest(
      'PAT1.1: Patrol test finds correct primary and accent pickers and colors',
      (PatrolTester $) async {
        Color resultColor = Colors.blue;
        await $.pumpWidgetAndSettle(
          TestPicker(
            widget: ColorPicker(
              key: testKey,
              onColorChanged: (Color color) {
                resultColor = color;
              },
            ),
          ),
        );

        // Test primary color picker.
        expect(find.text('Primary'), findsOneWidget);
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        expect(resultColor.value, Colors.red.value);
        await $(ColorIndicator).at(2).tap();
        expect(resultColor.value, Colors.purple.value);
        await $(ColorIndicator).at(20).tap();
        expect(resultColor.value, Colors.purple[100]!.value);

        // Test accent color picker.
        expect(find.text('Accent'), findsOneWidget);
        await $('Accent').tap();
        await $(ColorIndicator).tap();
        expect(resultColor.value, Colors.redAccent.value);
        await $(ColorIndicator).at(5).tap();
        expect(resultColor.value, Colors.blueAccent.value);
        await $(ColorIndicator).at(18).tap();
        expect(resultColor.value, Colors.blueAccent[400]!.value);
      },
    );

    //
    // *************************************************************************
    //

    patrolWidgetTest(
      'PAT1.2: Patrol test configured pickers and colors',
      // config: PatrolTestConfig(findTimeout: const Duration(seconds: 10)),
      (PatrolTester $) async {
        Color resultColor = Colors.blue;
        Color startColor = Colors.blue;
        Color endColor = Colors.blue;
        List<Color> recentColors = <Color>[];

        await $.pumpWidgetAndSettle(
          TestPicker(
            widget: ColorPicker(
              key: testKey,
              color: Colors.red, // Primary picker s default selected
              onColorChanged: (Color color) {
                resultColor = color;
              },
              onColorChangeStart: (Color color) {
                startColor = color;
              },
              onColorChangeEnd: (Color color) {
                endColor = color;
              },
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.both: true,
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
                ColorPickerType.bw: true,
                ColorPickerType.custom: true,
                ColorPickerType.customSecondary: true,
                ColorPickerType.wheel: true,
              },
              includeIndex850: true,
              crossAxisAlignment: CrossAxisAlignment.start,
              enableTonalPalette: true,
              enableOpacity: true,
              actionButtons: const ColorPickerActionButtons(
                okButton: true,
                closeButton: true,
                okTooltip: 'OK NOW',
                closeTooltip: 'CLOSE NOW',
                toolIconsThemeData: IconThemeData(
                  color: Colors.red,
                  size: 20,
                  opacity: 0.88,
                ),
                visualDensity: VisualDensity.comfortable,
                padding: EdgeInsets.all(2),
                splashRadius: 20,
                dialogActionButtons: false,
                dialogActionOnlyOkButton: true,
              ),
              copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                copyButton: true,
                pasteButton: true,
                editFieldCopyButton: true,
              ),
              hasBorder: true,
              borderRadius: 10,
              borderColor: Colors.black,
              wheelWidth: 32,
              wheelSquarePadding: 4,
              wheelSquareBorderRadius: 6,
              wheelHasBorder: true,
              title: const Text('Title'),
              heading: const Text('Heading'),
              subheading: const Text('Subheading'),
              tonalSubheading: const Text('Tonal'),
              wheelSubheading: const Text('Wheel heading'),
              opacitySubheading: const Text('Opacity heading'),
              recentColorsSubheading: const Text('Recent colors heading'),
              showMaterialName: true,
              showColorName: true,
              showColorCode: true,
              colorCodeHasColor: true,
              showColorValue: true,
              showRecentColors: true,
              maxRecentColors: 4,
              recentColors: recentColors,
              onRecentColorsChanged: (List<Color> colors) {
                recentColors = colors;
              },
              selectedPickerTypeColor: Colors.white,
              customColorSwatchesAndNames: <ColorSwatch<Object>, String>{
                ColorTools.createPrimarySwatch(const Color(0xFF6200EE)):
                    'Guide Purple',
                ColorTools.createPrimarySwatch(const Color(0xFF3700B3)):
                    'Guide Purple Variant',
                ColorTools.createAccentSwatch(const Color(0xFF03DAC6)):
                    'Guide Teal',
              },
              customSecondaryColorSwatchesAndNames: <ColorSwatch<Object>,
                  String>{
                ColorTools.createPrimarySwatch(const Color(0xFF00EE4B)):
                    'Option 1',
                ColorTools.createPrimarySwatch(const Color(0xFF92B300)):
                    'Option 2',
              },
            ),
          ),
        );

        // We should NOT find the separated primary and accent pickers
        expect(find.text('Primary'), findsNothing);
        expect(find.text('Accent'), findsNothing);
        // Test titles
        expect(find.text('Title'), findsOneWidget);
        expect(find.text('Heading'), findsOneWidget);
        expect(find.text('Subheading'), findsOneWidget);
        expect(find.text('Tonal'), findsOneWidget);
        expect(find.text('Opacity heading'), findsOneWidget);
        expect(find.text('Recent colors heading'), findsOneWidget);

        // Test primary & accent color picker.
        expect(find.text('Primary & Accent'), findsOneWidget);
        await $('Primary & Accent').tap();
        await $(ColorIndicator).at(1).tap();
        expect(startColor.value, Colors.red.value);
        expect(endColor.value, Colors.redAccent.value);
        expect(resultColor.value, Colors.redAccent.value);
        // Test recent colors
        expect(recentColors.contains(Color(Colors.red.value)), true);
        await $(ColorIndicator).at(34).tap();
        expect(startColor.value, Colors.redAccent.value);
        expect(endColor.value, Colors.grey.value);
        expect(resultColor.value, Colors.grey.value);
        // Test recent colors
        expect(recentColors.contains(Color(Colors.red.value)), true);
        expect(recentColors.contains(Color(Colors.redAccent.value)), true);
        await $(ColorIndicator).at(44).tap();
        expect(startColor.value, Colors.grey.value);
        expect(endColor.value, Colors.grey[850]!.value);
        expect(resultColor.value, Colors.grey[850]!.value);
        // Test recent colors
        expect(recentColors.contains(Color(Colors.red.value)), true);
        expect(recentColors.contains(Color(Colors.redAccent.value)), true);
        expect(recentColors.contains(Color(Colors.grey.value)), true);

        // Test black & white color picker.
        expect(find.text('Black & White'), findsOneWidget);
        await $('Black & White').tap();
        // Black shade color test
        await $(ColorIndicator).at(8).tap();
        expect(startColor.value, Colors.grey[850]!.value);
        expect(endColor.value, ColorTools.blackShade[600]!.value);
        expect(resultColor.value, ColorTools.blackShade[600]!.value);
        // Test recent colors
        expect(recentColors.contains(Color(Colors.red.value)), true);
        expect(recentColors.contains(Color(Colors.redAccent.value)), true);
        expect(recentColors.contains(Color(Colors.grey.value)), true);
        expect(recentColors.contains(Color(Colors.grey[850]!.value)), true);
        // White shade color test
        await $(ColorIndicator).at(1).tap();
        expect(resultColor.value, ColorTools.whiteShade[500]!.value);
        // Test recent colors
        expect(recentColors.contains(Color(Colors.red.value)),
            false); // 4 max, no red
        expect(recentColors.contains(Color(Colors.redAccent.value)), true);
        expect(recentColors.contains(Color(Colors.grey.value)), true);
        expect(recentColors.contains(Color(Colors.grey[850]!.value)), true);
        expect(recentColors.contains(Color(ColorTools.blackShade[600]!.value)),
            true);
        await $(ColorIndicator).at(2).tap();
        expect(resultColor, Colors.white);
        await $(ColorIndicator).at(11).tap();
        expect(resultColor.value, ColorTools.whiteShade[900]!.value);

        // Test Custom color picker.
        expect(find.text('Custom'), findsOneWidget);
        await $('Custom').tap();
        await $(ColorIndicator).at(1).tap();
        expect(startColor.value, ColorTools.whiteShade[900]!.value);
        expect(endColor, const Color(0xFF3700B3));
        expect(resultColor, const Color(0xFF3700B3));

        // Test Option color picker.
        expect(find.text('Option'), findsOneWidget);
        await $('Option').tap();
        await $(ColorIndicator).at(1).tap();
        expect(startColor, const Color(0xFF3700B3));
        expect(endColor, const Color(0xFF92B300));
        expect(resultColor, const Color(0xFF92B300));

        // Test Wheel color picker.
        expect(find.text('Wheel'), findsOneWidget);
        await $('Wheel').tap();
        expect(find.text('Wheel heading'), findsOneWidget);
        expect(find.text('Tonal'), findsOneWidget);
        // The 10th ColorIndicator will be first tonal and always black.
        await $(ColorIndicator).at(10).tap();
        expect(startColor, const Color(0xFF92B300));
        expect(endColor, Colors.black);
        expect(resultColor, Colors.black);
        await $(ColorIndicator).at(16).tap();
        expect(startColor, Colors.black);
        expect(endColor, const Color(0xFF688000));
        expect(resultColor, const Color(0xFF688000));
        // Find the ColorWheelPicker
        expect(find.byType(ColorWheelPicker), findsOneWidget);
        // Tap center of the ColorWheelPicker
        await $(ColorWheelPicker).tap();
        expect(resultColor, const Color(0xff748040));

        // The 24th ColorIndicator will be last tonal and always white.
        await $(ColorIndicator).at(24).tap();
        expect(resultColor, Colors.white);

        // Find the RecentColors
        expect(find.byType(RecentColors), findsOneWidget);
        // Recent colors has 4 color indicators, since we set max to 4.
        expect($(RecentColors).$(ColorIndicator), findsNWidgets(4));
        // Let's tap the last one, we need to scroll to it first.
        await $(RecentColors).$(ColorIndicator).at(3).scrollTo().tap();
        // Result should be 5 result color from earlier above.
        expect(resultColor, const Color(0xff92b300));

        // Find the OpacitySlider
        // TODO(rydmike): Get the slider test working!
        expect(find.byType(OpacitySlider), findsOneWidget);
        // expect(find.byType(Slider), findsOneWidget);
        // Tap center of the OpacitySlider
        // await $(OpacitySlider)
        //     .scrollTo(settlePolicy: SettlePolicy.trySettle)
        //     .tap();

        // Find the Text entry
        expect(find.byType(ColorCodeField), findsOneWidget);
        expect(find.byType(TextField), findsOneWidget);
        // TODO(rydmike): Get the color code entry test working!
        // await $(find.byType(TextField)).enterText('613E42');
        // await $(find.byType(ColorCodeField)).enterText('613E42');
        // expect(resultColor, const Color(0xFF613E42));

        // Find the ToolBar
        expect(find.byType(ColorPickerToolbar), findsOneWidget);
        // Find the ToolBar buttons, 4 of them configured.
        expect($(ColorPickerToolbar).$(IconButton), findsNWidgets(4));
        // Copy the Color
        await $(ColorPickerToolbar).$(IconButton).at(0).tap(
              settlePolicy: SettlePolicy.trySettle,
              visibleTimeout: const Duration(seconds: 1),
              settleTimeout: const Duration(seconds: 2),
            );
        // TODO(rydmike): Figure out how to test clipboard copy/paste.
        // We should have some clipboard data from above tap. But the below
        // attempt to get the data never completes. The code flow hit paths
        // from above also indicates the buffer is empty after the tap above.
        // final ClipboardData? clipData =
        //     await Clipboard.getData(Clipboard.kTextPlain);
        // debugPrint('Clip data: $clipData');

        // TEST COPY/PASTE via toolbar buttons
        // Go to another tab select a new color
        await $('Primary & Accent').tap();
        await $(ColorIndicator).at(1).tap();
        expect(resultColor.value, Colors.redAccent.value);
        // Copy in the redAccent color
        await $(ColorPickerToolbar).$(IconButton).at(0).tap(
              settlePolicy: SettlePolicy.trySettle,
              visibleTimeout: const Duration(seconds: 1),
              settleTimeout: const Duration(seconds: 2),
            );
        // Select pink color
        await $(ColorIndicator).at(2).tap();
        expect(resultColor.value, Colors.pink.value);
        // Paste in the red accent value color
        await $(ColorPickerToolbar).$(IconButton).at(1).tap(
              settlePolicy: SettlePolicy.trySettle,
              visibleTimeout: const Duration(seconds: 1),
              settleTimeout: const Duration(seconds: 2),
            );
        // This is the color we should find but do not since copy did nothing.
        // The paste wont work either.
        // expect(Color(resultColor.value), Color(Colors.redAccent.value));
        // Color(0xffe91e63);
      },
    );

    // Test issue https://github.com/rydmike/flex_color_picker/issues/71
    patrolWidgetTest(
      'PAT1.3: Patrol widget test for issue #71 ',
      (PatrolTester $) async {
        Color resultColor = const Color(0xFF613E42);
        await $.pumpWidgetAndSettle(
          TestPicker(
            widget: ColorPicker(
              key: testKey,
              color: resultColor,
              enableTonalPalette: true,
              onColorChanged: (Color color) {
                resultColor = color;
              },
              width: 40,
              height: 40,
              borderRadius: 4,
              spacing: 5,
              runSpacing: 5,
              wheelDiameter: 155,
              showMaterialName: true,
              showColorName: true,
              showColorCode: true,
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: true,
                ColorPickerType.accent: true,
                ColorPickerType.bw: false,
                ColorPickerType.custom: true,
                ColorPickerType.wheel: true,
              },
              actionButtons: const ColorPickerActionButtons(
                okButton: false,
                closeButton: true,
                okTooltip: 'DO',
                closeTooltipIsClose: false,
                toolIconsThemeData: IconThemeData(
                  color: Colors.blue,
                  size: 20,
                  opacity: 0.95,
                ),
                visualDensity: VisualDensity.comfortable,
                padding: EdgeInsets.all(2),
                splashRadius: 20,
                dialogActionButtons: true,
                dialogActionOnlyOkButton: true,
              ),
            ),
          ),
        );

        // Test primary color picker.
        expect(find.text('Primary'), findsOneWidget);
        expect(find.text('Accent'), findsOneWidget);
        expect(find.text('Custom'), findsNothing); // We gave no custom colors
        expect(find.text('Wheel'), findsOneWidget);

        // Find the ColorWheelPicker, we are on it by default
        expect(find.byType(ColorWheelPicker), findsOneWidget);
        // Tap sliding selector on wheel
        await $('Wheel').tap();

        // The 14th ColorIndicator will be 5th tonal
        await $(ColorIndicator).at(14).tap();
        expect(resultColor, const Color(0xFF7D2939));

        // Tap primary slider, no crash! This crashed without the FIX for #71
        await $('Primary').tap();
        // Tap a Material red shade color
        await $(ColorIndicator).at(22).tap();
        expect(resultColor.value, Colors.red[300]!.value);
      },
    );

    patrolWidgetTest(
      'PAT1.4: Patrol test dialog - default labels, tex buttons',
      (PatrolTester $) async {
        Color resultColor = Colors.blue;
        await $.pumpWidgetAndSettle(
          TestPicker(
            widget: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () async {
                    resultColor = await showColorPickerDialog(
                      context,
                      resultColor,
                      pickersEnabled: const <ColorPickerType, bool>{
                        ColorPickerType.both: false,
                        ColorPickerType.primary: true,
                        ColorPickerType.accent: true,
                        ColorPickerType.bw: false,
                        ColorPickerType.custom: false,
                        ColorPickerType.wheel: false,
                      },
                      includeIndex850: true,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      enableTonalPalette: true,
                      enableOpacity: true,
                      actionButtons: const ColorPickerActionButtons(
                        okButton: true,
                        closeButton: true,
                        okTooltip: 'OK NOW',
                        closeTooltip: 'CLOSE NOW',
                        toolIconsThemeData: IconThemeData(
                          color: Colors.red,
                          size: 20,
                          opacity: 0.88,
                        ),
                        visualDensity: VisualDensity.comfortable,
                        padding: EdgeInsets.all(2),
                        splashRadius: 20,
                        dialogActionButtons: true,
                        // dialogActionOnlyOkButton: false,
                      ),
                      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                        copyButton: true,
                        pasteButton: true,
                        editFieldCopyButton: true,
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        // Test primary color picker.
        expect(find.text('Open'), findsOneWidget);
        await $('Open').tap();

        expect(find.text('Primary'), findsOneWidget);
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        await $(ColorIndicator).at(2).tap();
        // expect(resultColor.value, Colors.purple.value);
        await $(ColorIndicator).at(20).tap();
        // expect(resultColor.value, Colors.purple[100]!.value);

        // Test accent color picker.
        expect(find.text('Accent'), findsOneWidget);
        await $('Accent').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.redAccent.value);
        await $(ColorIndicator).at(5).tap();
        // expect(resultColor.value, Colors.blueAccent.value);
        await $(ColorIndicator).at(18).tap();
        expect(find.text('OK'), findsOneWidget);
        await $('OK').tap();
        expect(resultColor.value, Colors.blueAccent[400]!.value);

        // Open dialog again
        await $('Open').tap();
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        await $(ColorIndicator).at(2).tap();
        // expect(resultColor.value, Colors.purple.value);
        expect(find.text('OK'), findsOneWidget);
        await $('OK').tap();
        expect(resultColor.value, Colors.purple.value);

        // Open dialog again
        await $('Open').tap();
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        expect(find.text('Cancel'), findsOneWidget);
        await $('Cancel').tap();
        expect(resultColor.value, Colors.purple.value);
      },
    );

    patrolWidgetTest(
      'PAT1.5: Patrol test dialog - custom labels, filled buttons',
      (PatrolTester $) async {
        Color resultColor = Colors.blue;
        await $.pumpWidgetAndSettle(
          TestPicker(
            widget: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () async {
                    resultColor = await showColorPickerDialog(
                      context,
                      resultColor,
                      pickersEnabled: const <ColorPickerType, bool>{
                        ColorPickerType.both: false,
                        ColorPickerType.primary: true,
                        ColorPickerType.accent: true,
                        ColorPickerType.bw: false,
                        ColorPickerType.custom: false,
                        ColorPickerType.wheel: false,
                      },
                      includeIndex850: true,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      enableTonalPalette: true,
                      enableOpacity: true,
                      actionButtons: const ColorPickerActionButtons(
                        okButton: true,
                        closeButton: true,
                        okTooltip: 'OK NOW',
                        closeTooltip: 'CLOSE NOW',
                        toolIconsThemeData: IconThemeData(
                          color: Colors.red,
                          size: 20,
                          opacity: 0.88,
                        ),
                        visualDensity: VisualDensity.comfortable,
                        padding: EdgeInsets.all(2),
                        splashRadius: 20,
                        dialogActionButtons: true,
                        // dialogActionOnlyOkButton: false,
                        dialogCancelButtonLabel: 'CLOSE',
                        dialogOkButtonLabel: 'USE',
                        dialogOkButtonType: ColorPickerActionButtonType.filled,
                        dialogCancelButtonType:
                            ColorPickerActionButtonType.filled,
                      ),
                      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                        copyButton: true,
                        pasteButton: true,
                        editFieldCopyButton: true,
                        feedbackParseError: true,
                        parseShortHexCode: true,
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        // Test primary color picker.
        expect(find.text('Open'), findsOneWidget);
        await $('Open').tap();

        expect(find.text('Primary'), findsOneWidget);
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        await $(ColorIndicator).at(2).tap();
        // expect(resultColor.value, Colors.purple.value);
        expect(find.text('USE'), findsOneWidget);
        await $('USE').tap();
        expect(Color(resultColor.value), Color(Colors.purple.value));

        // Open dialog again
        await $('Open').tap();
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        expect(find.text('CLOSE'), findsOneWidget);
        await $('CLOSE').tap();
        expect(resultColor.value, Colors.purple.value);
      },
    );

    patrolWidgetTest(
      'PAT1.6: Patrol test dialog - custom labels, filledTonal buttons',
      (PatrolTester $) async {
        Color resultColor = Colors.blue;
        await $.pumpWidgetAndSettle(
          TestPicker(
            platform: TargetPlatform.windows,
            widget: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () async {
                    resultColor = await showColorPickerDialog(
                      context,
                      resultColor,
                      pickersEnabled: const <ColorPickerType, bool>{
                        ColorPickerType.both: false,
                        ColorPickerType.primary: true,
                        ColorPickerType.accent: true,
                        ColorPickerType.bw: false,
                        ColorPickerType.custom: false,
                        ColorPickerType.wheel: false,
                      },
                      includeIndex850: true,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      enableTonalPalette: true,
                      enableOpacity: true,
                      actionButtons: const ColorPickerActionButtons(
                        okButton: true,
                        closeButton: true,
                        closeIsLast: false,
                        okTooltip: 'OK NOW',
                        closeTooltip: 'CLOSE NOW',
                        toolIconsThemeData: IconThemeData(
                          color: Colors.red,
                          size: 20,
                          opacity: 0.88,
                        ),
                        visualDensity: VisualDensity.comfortable,
                        padding: EdgeInsets.all(2),
                        splashRadius: 20,
                        dialogActionButtons: true,
                        // dialogActionOnlyOkButton: false,
                        dialogCancelButtonLabel: 'CLOSER',
                        dialogOkButtonLabel: 'USE',
                        dialogOkButtonType:
                            ColorPickerActionButtonType.filledTonal,
                        dialogCancelButtonType:
                            ColorPickerActionButtonType.filledTonal,
                        dialogActionOrder:
                            ColorPickerActionButtonOrder.adaptive,
                      ),
                      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                        copyButton: true,
                        pasteButton: true,
                        editFieldCopyButton: true,
                        feedbackParseError: true,
                        parseShortHexCode: true,
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        // Test primary color picker.
        expect(find.text('Open'), findsOneWidget);
        await $('Open').tap();

        expect(find.text('Primary'), findsOneWidget);
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        await $(ColorIndicator).at(2).tap();
        // expect(resultColor.value, Colors.purple.value);
        expect(find.text('USE'), findsOneWidget);
        await $('USE').tap();
        expect(Color(resultColor.value), Color(Colors.purple.value));

        // Dialog is closed
        expect(find.text('Open'), findsOneWidget);
        // Open dialog again
        await $('Open').tap();
        // Close via Cancel button
        expect(find.text('CLOSER'), findsOneWidget);
        await $('CLOSER').tap();

        // Open dialog again
        await $('Open').tap();
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        // Find the ToolBar
        expect(find.byType(ColorPickerToolbar), findsOneWidget);
        // Find the ToolBar buttons, 4 of them configured.
        expect($(ColorPickerToolbar).$(IconButton), findsNWidgets(4));
        // Close via toolbar, 4th button is OK, since close is NOT last
        await $(ColorPickerToolbar).$(IconButton).at(3).tap();
        expect(resultColor.value, Colors.red.value);

        // Dialog is closed
        expect(find.text('Open'), findsOneWidget);
        // Open dialog again
        await $('Open').tap();
        await $('Primary').tap();
        await $(ColorIndicator).at(3).tap();
        // expect(resultColor.value, Colors.deepPurple.value);
        // Find the ToolBar buttons, 4 of them configured.
        expect($(ColorPickerToolbar).$(IconButton), findsNWidgets(4));
        // Close via toolbar, 3rd button is Close, since close is NOT last
        await $(ColorPickerToolbar).$(IconButton).at(2).tap();
        // Dialog is closed
        expect(find.text('Open'), findsOneWidget);
        // Expect no change in color
        expect(resultColor.value, Colors.red.value);
      },
    );

    patrolWidgetTest(
      'PAT1.7: Patrol test dialog - custom labels, elevated buttons, '
      'with constraints.',
      (PatrolTester $) async {
        Color resultColor = Colors.blue;
        await $.pumpWidgetAndSettle(
          TestPicker(
            widget: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () async {
                    resultColor = await showColorPickerDialog(
                      context,
                      resultColor,
                      constraints: const BoxConstraints(
                          minHeight: 480, minWidth: 320, maxWidth: 320),
                      pickersEnabled: const <ColorPickerType, bool>{
                        ColorPickerType.both: false,
                        ColorPickerType.primary: true,
                        ColorPickerType.accent: true,
                        ColorPickerType.bw: false,
                        ColorPickerType.custom: false,
                        ColorPickerType.wheel: false,
                      },
                      includeIndex850: true,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      enableTonalPalette: true,
                      enableOpacity: true,
                      actionButtons: const ColorPickerActionButtons(
                        okButton: true,
                        closeButton: true,
                        okTooltip: 'OK NOW',
                        closeTooltip: 'CLOSE NOW',
                        toolIconsThemeData: IconThemeData(
                          color: Colors.red,
                          size: 20,
                          opacity: 0.88,
                        ),
                        visualDensity: VisualDensity.comfortable,
                        padding: EdgeInsets.all(2),
                        splashRadius: 20,
                        dialogActionButtons: true,
                        // dialogActionOnlyOkButton: false,
                        dialogCancelButtonLabel: 'CLOSE',
                        dialogOkButtonLabel: 'Do',
                        dialogOkButtonType:
                            ColorPickerActionButtonType.elevated,
                        dialogCancelButtonType:
                            ColorPickerActionButtonType.elevated,
                        dialogActionOrder:
                            ColorPickerActionButtonOrder.okIsRight,
                        dialogActionIcons: true,
                      ),
                      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                        copyButton: true,
                        pasteButton: true,
                        editFieldCopyButton: true,
                        feedbackParseError: true,
                        parseShortHexCode: true,
                      ),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        // Test primary color picker.
        expect(find.text('Open'), findsOneWidget);
        await $('Open').tap();

        expect(find.text('Primary'), findsOneWidget);
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        await $(ColorIndicator).at(6).tap();
        // expect(resultColor.value, Colors.lightBlue.value);
        expect(find.text('Do'), findsOneWidget);
        await $('Do').tap();
        expect(Color(resultColor.value), Color(Colors.lightBlue.value));

        // Dialog is closed
        expect(find.text('Open'), findsOneWidget);
        // Open dialog again
        await $('Open').tap();
        // Close via Cancel button
        expect(find.text('CLOSE'), findsOneWidget);
        await $('CLOSE').tap();

        // Open dialog again
        await $('Open').tap();
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        // Find the ToolBar
        expect(find.byType(ColorPickerToolbar), findsOneWidget);
        // Find the ToolBar buttons, 4 of them configured.
        expect($(ColorPickerToolbar).$(IconButton), findsNWidgets(4));
        // Close via toolbar, 4th button is Close, since close is last
        await $(ColorPickerToolbar).$(IconButton).at(3).tap();
        expect(resultColor.value, Colors.lightBlue.value);

        // Dialog is closed
        expect(find.text('Open'), findsOneWidget);
        // Open dialog again
        await $('Open').tap();
        await $('Primary').tap();
        await $(ColorIndicator).at(3).tap();
        // expect(resultColor.value, Colors.deepPurple.value);
        // Find the ToolBar buttons, 4 of them configured.
        expect($(ColorPickerToolbar).$(IconButton), findsNWidgets(4));
        // Close via toolbar, 3rd button is OK, since close is NOT last
        await $(ColorPickerToolbar).$(IconButton).at(2).tap();
        // Dialog is closed
        expect(find.text('Open'), findsOneWidget);
        // Expect no change in color
        expect(Color(resultColor.value), Color(Colors.deepPurple.value));
        // Color(0xff673ab7);
      },
    );

    patrolWidgetTest(
      'PAT1.8: Patrol test dialog - custom labels, outlined buttons, '
      'with constraints and custom transition.',
      (PatrolTester $) async {
        Color resultColor = Colors.blue;
        await $.pumpWidgetAndSettle(
          TestPicker(
            widget: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () async {
                    resultColor = await showColorPickerDialog(
                      context,
                      resultColor,
                      constraints: const BoxConstraints(
                          minHeight: 480, minWidth: 320, maxWidth: 320),
                      pickersEnabled: const <ColorPickerType, bool>{
                        ColorPickerType.both: false,
                        ColorPickerType.primary: true,
                        ColorPickerType.accent: true,
                        ColorPickerType.bw: false,
                        ColorPickerType.custom: false,
                        ColorPickerType.wheel: true,
                      },
                      includeIndex850: true,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      enableTonalPalette: true,
                      enableOpacity: true,
                      actionButtons: const ColorPickerActionButtons(
                        okButton: true,
                        closeButton: true,
                        okTooltip: 'OK NOW',
                        closeTooltip: 'CLOSE NOW',
                        toolIconsThemeData: IconThemeData(
                          color: Colors.red,
                          size: 20,
                          opacity: 0.88,
                        ),
                        visualDensity: VisualDensity.comfortable,
                        padding: EdgeInsets.all(2),
                        splashRadius: 20,
                        dialogActionButtons: true,
                        dialogCancelButtonLabel: 'CLOSE',
                        dialogOkButtonLabel: 'OK',
                        dialogOkButtonType:
                            ColorPickerActionButtonType.outlined,
                        dialogCancelButtonType:
                            ColorPickerActionButtonType.outlined,
                        dialogActionOrder:
                            ColorPickerActionButtonOrder.okIsLeft,
                      ),
                      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
                        copyButton: true,
                        pasteButton: true,
                        editFieldCopyButton: true,
                        feedbackParseError: true,
                        parseShortHexCode: true,
                      ),
                      transitionBuilder: (BuildContext context,
                          Animation<double> a1,
                          Animation<double> a2,
                          Widget widget) {
                        final double curvedValue =
                            Curves.easeInOutBack.transform(a1.value) - 1.0;
                        return Transform(
                          transform: Matrix4.translationValues(
                              0.0, curvedValue * 200, 0.0),
                          child: Opacity(
                            opacity: a1.value,
                            child: widget,
                          ),
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 400),
                    );
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        );

        // Test primary color picker.
        expect(find.text('Open'), findsOneWidget);
        await $('Open').tap();

        expect(find.text('Primary'), findsOneWidget);
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        await $(ColorIndicator).at(6).tap();
        // expect(resultColor.value, Colors.lightBlue.value);
        expect(find.text('OK'), findsOneWidget);
        await $('OK').tap();
        expect(Color(resultColor.value), Color(Colors.lightBlue.value));

        // Open dialog again
        await $('Open').tap();
        await $('Primary').tap();
        await $(ColorIndicator).tap();
        // expect(resultColor.value, Colors.red.value);
        // Find the ToolBar
        expect(find.byType(ColorPickerToolbar), findsOneWidget);
        // Find the ToolBar buttons, 4 of them configured.
        expect($(ColorPickerToolbar).$(IconButton), findsNWidgets(4));
        // Close via toolbar, 4th button is Close, since close is last
        await $(ColorPickerToolbar).$(IconButton).at(3).tap();
        expect(resultColor.value, Colors.lightBlue.value);

        // Dialog is closed
        expect(find.text('Open'), findsOneWidget);
        // Open dialog again
        await $('Open').tap();
        // Close via Cancel button
        expect(find.text('CLOSE'), findsOneWidget);
        await $('CLOSE').tap();

        // Open dialog again
        await $('Open').tap();
        await $('Primary').tap();
        await $(ColorIndicator).at(3).tap();
        // expect(resultColor.value, Colors.deepPurple.value);
        // Find the ToolBar buttons, 4 of them configured.
        expect($(ColorPickerToolbar).$(IconButton), findsNWidgets(4));
        // Close via toolbar, 3rd button is OK, since close is NOT last
        await $(ColorPickerToolbar).$(IconButton).at(2).tap();
        // Dialog is closed
        expect(find.text('Open'), findsOneWidget);
        // Expect no change in color
        expect(Color(resultColor.value), Color(Colors.deepPurple.value));

        // Open dialog again
        await $('Open').tap();
        // Got to wheel picker
        expect(find.text('Wheel'), findsOneWidget);
        await $('Wheel').tap();
        // Tap the center of the wheel picker
        expect(find.byType(ColorWheelPicker), findsOneWidget);
        await $(ColorWheelPicker).tap();
        // Tap close button
        expect(find.text('OK'), findsOneWidget);
        await $('OK').tap();
        // We get a purple color from smack in the middle
        expect(Color(resultColor.value), const Color(0xff574080));
      },
    );

    ///---
  });
}

class TestPicker extends StatelessWidget {
  const TestPicker({super.key, required this.widget, this.platform});
  final Widget widget;
  final TargetPlatform? platform;

  @override
  Widget build(BuildContext context) {
    debugDefaultTargetPlatformOverride = null;
    return MaterialApp(
      title: 'TestWidget',
      theme: ThemeData(
        platform: platform,
      ),
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
