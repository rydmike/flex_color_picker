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

      final WidgetPredicate defaultWheel = (Widget widget) =>
          widget is ColorWheelPicker &&
          widget.color == Colors.blue &&
          widget.onChanged != null &&
          widget.onChangeStart == null &&
          widget.onChangeEnd == null &&
          widget.onWheel != null &&
          widget.wheelWidth == 16 &&
          widget.hasBorder == false &&
          widget.borderColor == null &&
          widget.shouldUpdate == false &&
          widget.shouldRequestsFocus == false;
      expect(find.byWidgetPredicate(defaultWheel), findsOneWidget);
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
