import 'package:flex_color_picker/src/color_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//****************************************************************************
// FlexColorPicker ColorIndicator Widget tests
//****************************************************************************
void main() {
  const ValueKey<String> testKey = ValueKey<String>('test');

  group('CIND1: In App With ColorIndicator ', () {
    debugDefaultTargetPlatformOverride = null;
    testWidgets('CIND1.1: Finds default ColorIndicator()',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const TestWidget(widget: ColorIndicator(key: testKey)));
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      final WidgetPredicate defaultIndicator = (Widget widget) =>
          widget is ColorIndicator &&
          widget.onSelect == null &&
          widget.onSelectFocus == true &&
          widget.isSelected == false &&
          widget.selectedRequestsFocus == false &&
          widget.elevation == 0 &&
          widget.selectedIcon == Icons.check &&
          widget.color == Colors.blue &&
          widget.width == 40 &&
          widget.height == 40 &&
          widget.borderRadius == 10 &&
          widget.hasBorder == false &&
          widget.borderColor == null;
      expect(find.byWidgetPredicate(defaultIndicator), findsOneWidget);
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
          child: widget,
        ),
      ),
    );
  }
}
