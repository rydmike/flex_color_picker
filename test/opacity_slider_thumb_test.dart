import 'package:flex_color_picker/src/widgets/opacity/opacity_slider_thumb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OpacitySliderThumb test', (WidgetTester tester) async {
    // Create a MaterialApp as a root widget for the test
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SliderTheme(
            data: const SliderThemeData(
              thumbShape: OpacitySliderThumb(color: Colors.red),
            ),
            child: Slider(
              value: 0.5,
              onChanged: (double value) {},
            ),
          ),
        ),
      ),
    ));

    // Ensure the widget tree has finished building
    await tester.pumpAndSettle();

    // Check if the slider is found by the test
    expect(find.byType(Slider), findsOneWidget);
  });
}
