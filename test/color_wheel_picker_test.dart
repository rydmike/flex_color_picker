import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore_for_file: unused_local_variable, Claude added not used vars, fix later

void main() {
  testWidgets('ColorWheelPicker widget test', (WidgetTester tester) async {
    // Define variables to hold callback results
    Color selectedColor = Colors.red;
    bool isWheelActive = false;
    Color? startColor;
    Color? endColor;

    // Function to build the widget with the current selected color
    Widget buildWidget(Color color) {
      return MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 200,
            height: 200,
            child: ColorWheelPicker(
              color: color,
              onChanged: (Color color) {
                selectedColor = color;
                // print('onChanged: $color');
              },
              onChangeStart: (Color color) {
                startColor = color;
                // print('onChangeStart: $color');
              },
              onChangeEnd: (Color color) {
                endColor = color;
                // print('onChangeEnd: $color');
              },
              onWheel: (bool active) {
                isWheelActive = active;
                // print('onWheel: $active');
              },
              wheelWidth: 20.0,
              wheelSquarePadding: 0.0,
              wheelSquareBorderRadius: 2.0,
              hasBorder: true,
              borderColor: Colors.black,
            ),
          ),
        ),
      );
    }

    // Initial build
    await tester.pumpWidget(buildWidget(selectedColor));

    // Verify initial state
    expect(isWheelActive, isFalse);
    expect(startColor, isNull);
    expect(endColor, isNull);
    expect(selectedColor, Colors.red);

    // Simulate a drag on the color wheel square
    final Offset center = tester.getCenter(find.byType(ColorWheelPicker));
    await tester.timedDragFrom(
        center, const Offset(50, 20), const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Verify the callbacks are triggered for the square
    expect(isWheelActive, isFalse); // Stops being active as soon as drag stops
    expect(startColor, Colors.red);
    expect(selectedColor, const Color(0xff520a05));
    expect(endColor, Colors.red);

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));

    // Simulate a diagonal drag on the color wheel square
    await tester.timedDragFrom(
        center, const Offset(20, 30), const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    // Verify the callbacks are triggered for the square
    expect(startColor, const Color(0xff520a05));
    expect(endColor, const Color(0xff520a05));
    expect(selectedColor, const Color(0xff3c1613));

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Calculate a starting point on the wheel's circumference
    const double wheelRadius = 95.0; // 200/2 - 20/2
    final Offset startPoint = Offset(center.dx + wheelRadius, center.dy);

    // Simulate a short horizontal drag on the color wheel
    await tester.timedDragFrom(
        startPoint, const Offset(70, -100), const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    // Verify the callbacks are triggered for the wheel
    expect(startColor, const Color(0xff3c1613));
    expect(endColor, const Color(0xff3c1613));
    expect(selectedColor, const Color(0xff3c1328));

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Simulate vertical drag update
    await tester.timedDragFrom(
        startPoint, const Offset(30, 10), const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Verify the callbacks are triggered for vertical drag update
    expect(startColor, const Color(0xff3c1328));
    expect(endColor, const Color(0xff3c1328));
    expect(selectedColor, const Color(0xff3c1613));

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Simulate horizontal drag update
    await tester.timedDragFrom(
        startPoint, const Offset(40, 40), const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Verify the callbacks are triggered for horizontal drag update
    expect(startColor, const Color(0xff3c1613));
    expect(endColor, const Color(0xff3c1613));
    expect(selectedColor, const Color(0xff3c1f13));

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Simulate end of vertical drag
    await tester.timedDragFrom(
        startPoint, const Offset(-100, 90), const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Verify the end callback is triggered for vertical drag
    expect(startColor, const Color(0xff3c1f13));
    expect(endColor, const Color(0xff3c1f13));
    expect(selectedColor, const Color(0xff253c13));

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Simulate end of horizontal drag
    await tester.timedDragFrom(
        startPoint, const Offset(-150, -55), const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Verify the end callback is triggered for horizontal drag
    expect(startColor, const Color(0xff253c13));
    expect(endColor, const Color(0xff253c13));
    expect(selectedColor, const Color(0xff131d3c));

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Calculate a starting point NOT on the wheel's circumference
    final Offset noWheelPoint =
        Offset(center.dx + wheelRadius, center.dy + wheelRadius);

    // Simulate end of horizontal drag
    await tester.timedDragFrom(noWheelPoint, const Offset(-20, -20),
        const Duration(milliseconds: 100));
    await tester.pumpAndSettle();

    // Update the widget with the new color
    await tester.pumpWidget(buildWidget(selectedColor));
    await tester.pumpAndSettle();

    // Verify the callback results, color should not change from previous
    // value since we start outside the wheel
    expect(startColor, const Color(0xff253c13));
    expect(endColor, const Color(0xff131d3c));
    expect(selectedColor, const Color(0xff131d3c));
  });

  testWidgets('ColorWheelPicker didUpdateWidget test',
      (WidgetTester tester) async {
    Color selectedColor = Colors.red;
    bool isWheelActive = false;

    // Build widget with shouldRequestsFocus = false
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 200,
            height: 200,
            child: ColorWheelPicker(
              color: selectedColor,
              onChanged: (Color color) {
                selectedColor = color;
              },
              onWheel: (bool active) {
                isWheelActive = active;
              },
              shouldRequestsFocus: false,
              shouldUpdate: false,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Update widget with shouldRequestsFocus = true (changed)
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 200,
            height: 200,
            child: ColorWheelPicker(
              color: selectedColor,
              onChanged: (Color color) {
                selectedColor = color;
              },
              onWheel: (bool active) {
                isWheelActive = active;
              },
              shouldRequestsFocus: true,
              shouldUpdate: false,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(ColorWheelPicker), findsOneWidget);
  });

  testWidgets('ColorWheelPicker didUpdateWidget with shouldUpdate test',
      (WidgetTester tester) async {
    Color selectedColor = Colors.red;
    bool isWheelActive = false;

    // Build widget with shouldUpdate = false
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 200,
            height: 200,
            child: ColorWheelPicker(
              color: selectedColor,
              onChanged: (Color color) {
                selectedColor = color;
              },
              onWheel: (bool active) {
                isWheelActive = active;
              },
              shouldUpdate: false,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Update widget with shouldUpdate = true and different color
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 200,
            height: 200,
            child: ColorWheelPicker(
              color: Colors.blue,
              onChanged: (Color color) {
                selectedColor = color;
              },
              onWheel: (bool active) {
                isWheelActive = active;
              },
              shouldUpdate: true,
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(ColorWheelPicker), findsOneWidget);
  });
}
