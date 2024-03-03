import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test showColorPickerDialog', (WidgetTester tester) async {
    // Define a color to start with
    Color color = Colors.red;

    // Create a MaterialApp as a root widget for the test
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              onPressed: () async {
                color = await showColorPickerDialog(
                  context,
                  color,
                  pickersEnabled: const <ColorPickerType, bool>{
                    ColorPickerType.both: false,
                    ColorPickerType.primary: true,
                    ColorPickerType.accent: true,
                    ColorPickerType.bw: false,
                    ColorPickerType.custom: false,
                    ColorPickerType.wheel: false,
                  },
                );
              },
              child: const Text('Open Color Picker'),
            );
          },
        ),
      ),
    ));

    // Tap the button to open the color picker dialog
    await tester.tap(find.text('Open Color Picker'));
    await tester.pumpAndSettle();

    // Verify that the dialog is displayed
    expect(find.byType(AlertDialog), findsOneWidget);

    // Tap on a color to select it
    await tester.tap(find.byType(ColorIndicator).first);
    await tester.pumpAndSettle();

    // Verify that the color has been selected
    expect(color, isNotNull);
  });
}
