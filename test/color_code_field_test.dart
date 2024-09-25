import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'clipboard_utils.dart';

void main() {
  testWidgets('ColorCodeField widget test', (WidgetTester tester) async {
    // Clipboard testing does not work without this.
    final MockClipboard mockClipboard = MockClipboard();
    TestWidgetsFlutterBinding.ensureInitialized()
        .defaultBinaryMessenger
        .setMockMethodCallHandler(
            SystemChannels.platform, mockClipboard.handleMethodCall);

    bool focusChanged = false;
    Color changedColor = Colors.transparent;

    Future<void> testColorCodeField({
      required ThemeData theme,
      required ColorPickerCopyFormat copyFormat,
      required bool requestFocus,
      required bool focusedEditHasNoColor,
      required bool colorCodeHasColor,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Scaffold(
            body: ColorCodeField(
              color: Colors.red, // Provide the required color parameter
              onColorChanged: (Color color) {
                changedColor = color;
              },
              onEditFocused: (bool hasFocus) {
                focusChanged = hasFocus;
              },
              requestFocus: requestFocus,
              focusedEditHasNoColor: focusedEditHasNoColor,
              colorCodeHasColor: colorCodeHasColor,
              toolIcons: const ColorPickerActionButtons(),
              copyPasteBehavior: ColorPickerCopyPasteBehavior(
                editFieldCopyButton: true,
                copyFormat: copyFormat,
              ),
              enableTooltips: true,
              shouldUpdate: false,
            ),
          ),
        ),
      );

      // Find the ColorCodeField widget
      final Finder colorCodeFieldFinder = find.byType(ColorCodeField);
      expect(colorCodeFieldFinder, findsOneWidget);

      // Focus the ColorCodeField
      await tester.tap(colorCodeFieldFinder);
      await tester.pumpAndSettle();
      expect(focusChanged, isTrue);

      // Enter text into the ColorCodeField
      await tester.enterText(colorCodeFieldFinder, 'FF5733');
      await tester.pumpAndSettle();
      expect(changedColor, const Color(0xFFFF5733));

      // Complete editing
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(changedColor, const Color(0xFFFF5733));

      // Tap the copy button to set the clipboard content
      final Finder copyButtonFinder = find.descendant(
        of: colorCodeFieldFinder,
        matching: find.byType(IconButton),
      );
      await tester.tap(copyButtonFinder);
      await tester.pumpAndSettle();

      // Verify clipboard content
      final ClipboardData? clipData =
          await Clipboard.getData(Clipboard.kTextPlain);
      String expectedClipboardContent;
      switch (copyFormat) {
        case ColorPickerCopyFormat.dartCode:
          expectedClipboardContent = '0xFFFF5733';
        case ColorPickerCopyFormat.hexRRGGBB:
          expectedClipboardContent = 'FF5733';
        case ColorPickerCopyFormat.hexAARRGGBB:
          expectedClipboardContent = 'FFFF5733';
        case ColorPickerCopyFormat.numHexRRGGBB:
          expectedClipboardContent = '#FF5733';
        case ColorPickerCopyFormat.numHexAARRGGBB:
          expectedClipboardContent = '#FFFF5733';
      }
      expect(clipData?.text, expectedClipboardContent);
    }

    // Test in light mode
    await testColorCodeField(
      theme: ThemeData.light(),
      copyFormat: ColorPickerCopyFormat.dartCode,
      requestFocus: true,
      focusedEditHasNoColor: true,
      colorCodeHasColor: true,
    );

    // Test in dark mode
    await testColorCodeField(
      theme: ThemeData.dark(),
      copyFormat: ColorPickerCopyFormat.hexRRGGBB,
      requestFocus: false,
      focusedEditHasNoColor: false,
      colorCodeHasColor: false,
    );

    // Test other copy formats
    await testColorCodeField(
      theme: ThemeData.light(),
      copyFormat: ColorPickerCopyFormat.hexAARRGGBB,
      requestFocus: true,
      focusedEditHasNoColor: true,
      colorCodeHasColor: true,
    );

    await testColorCodeField(
      theme: ThemeData.dark(),
      copyFormat: ColorPickerCopyFormat.numHexRRGGBB,
      requestFocus: false,
      focusedEditHasNoColor: false,
      colorCodeHasColor: false,
    );

    await testColorCodeField(
      theme: ThemeData.light(),
      copyFormat: ColorPickerCopyFormat.numHexAARRGGBB,
      requestFocus: true,
      focusedEditHasNoColor: true,
      colorCodeHasColor: true,
    );
  });
}
