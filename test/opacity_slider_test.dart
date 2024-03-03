import 'package:flex_color_picker/src/widgets/opacity/opacity_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OpacitySlider test', (WidgetTester tester) async {
    double opacity = 0.5;

    // Create a MaterialApp as a root widget for the test
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: OpacitySlider(
            opacity: opacity,
            color: Colors.red,
            onChanged: (double value) {
              debugPrint('onChanged: $value');
              opacity = value;
            },
            onChangeStart: (double value) {
              debugPrint('onChangeStart: $value');
            },
            onChangeEnd: (double value) {
              debugPrint('onChangeEnd: $value');
            },
          ),
        ),
      ),
    ));

    // Ensure the widget tree has finished building
    await tester.pumpAndSettle();

    // Verify that the initial opacity is correct
    expect(opacity, 0.5);

    // Check if the slider is found by the test
    expect(find.byType(OpacitySlider), findsOneWidget);
  });
}
