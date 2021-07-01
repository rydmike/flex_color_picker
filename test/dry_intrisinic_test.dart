import 'package:flex_color_picker/src/universal_widgets/dry_intrisinic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//****************************************************************************
// FlexColorPicker DryIntrinsicWidth and Height Widget tests
//****************************************************************************
void main() {
  const ValueKey<String> testKey = ValueKey<String>('test');

  group('DINT1: In App With DryIntrinsicWidth  ', () {
    debugDefaultTargetPlatformOverride = null;
    testWidgets('DINT1.1: Finds DryIntrinsicWidth',
        (WidgetTester tester) async {
      await tester.pumpWidget(const TestWidget(
          widget: DryIntrinsicWidth(key: testKey, child: const Placeholder())));
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);
    });
    testWidgets('DINT1.2: Finds DryIntrinsicHeight',
        (WidgetTester tester) async {
      await tester.pumpWidget(const TestWidget(
          widget:
              DryIntrinsicHeight(key: testKey, child: const Placeholder())));
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);
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
