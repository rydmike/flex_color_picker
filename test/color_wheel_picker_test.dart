import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore_for_file: unnecessary_null_comparison

//****************************************************************************
// FlexColorPicker ColorWheelPicker Widget tests
//****************************************************************************
void main() {
  const ValueKey<String> testKey = ValueKey<String>('test');

  group('CWP1: In App With ColorWheelPicker', () {
    debugDefaultTargetPlatformOverride = null;
    testWidgets('CWP1.1: Finds default ColorWheelPicker()',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestWidget(
          widget: ColorWheelPicker(
        key: testKey,
        color: Colors.blue,
        onChanged: (Color color) {},
        onWheel: (bool wheel) {},
      )));
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables
      final WidgetPredicate defaultWheel = (Widget widget) =>
          widget is ColorWheelPicker &&
          widget.color == Colors.blue &&
          widget.onChanged != null &&
          widget.onChangeStart == null &&
          widget.onChangeEnd == null &&
          widget.onWheel != null &&
          widget.wheelWidth == 16 &&
          widget.wheelSquarePadding == 0 &&
          widget.wheelSquareBorderRadius == 4 &&
          !widget.hasBorder &&
          widget.borderColor == null &&
          !widget.shouldUpdate &&
          !widget.shouldRequestsFocus;
      expect(find.byWidgetPredicate(defaultWheel), findsOneWidget);
    });

    testWidgets('CWP1.1: Finds custom-1 ColorWheelPicker()',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestWidget(
          widget: ColorWheelPicker(
        key: testKey,
        color: Colors.blue,
        onChanged: (Color color) {},
        onChangeStart: (Color color) {},
        onChangeEnd: (Color color) {},
        onWheel: (bool wheel) {},
        wheelWidth: 20,
        wheelSquarePadding: 4,
        wheelSquareBorderRadius: 6,
        hasBorder: true,
        borderColor: Colors.black,
        shouldUpdate: true,
        shouldRequestsFocus: true,
      )));
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      // ignore: prefer_function_declarations_over_variables
      final WidgetPredicate defaultWheel = (Widget widget) =>
          widget is ColorWheelPicker &&
          widget.color == Colors.blue &&
          widget.onChanged != null &&
          widget.onChangeStart != null &&
          widget.onChangeEnd != null &&
          widget.onWheel != null &&
          widget.wheelWidth == 20 &&
          widget.wheelSquarePadding == 4 &&
          widget.wheelSquareBorderRadius == 6 &&
          widget.hasBorder &&
          widget.borderColor == Colors.black &&
          widget.shouldUpdate &&
          widget.shouldRequestsFocus;
      expect(find.byWidgetPredicate(defaultWheel), findsOneWidget);
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
        body: Center(
          child: SizedBox(
            width: 300,
            height: 300,
            child: widget,
          ),
        ),
      ),
    );
  }
}
