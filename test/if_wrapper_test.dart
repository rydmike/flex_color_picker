import 'package:flex_color_picker/src/universal_widgets/if_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

//****************************************************************************
// FlexColorPicker IFWrapper Widget tests
//****************************************************************************
void main() {
  // const ValueKey<String> testKey = ValueKey<String>('test');

  group('IFWR1: In App With IfWrapper ', () {
    debugDefaultTargetPlatformOverride = null;
    testWidgets('IFWR1.1: Finds Center when IfWrapper wrap condition is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(const TestWidget(wrap: true));
      final Finder widget = find.byType(Center);
      expect(widget, findsOneWidget);
    });
    testWidgets('IFWR1.2: Finds No Center when IfWrapper condition is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(const TestWidget(wrap: false));
      final Finder widget = find.byType(Center);
      expect(widget, findsNothing);
    });
  });

  group('IFWR2: In App With IfWrapper, with ifFalse wrapper ', () {
    debugDefaultTargetPlatformOverride = null;
    testWidgets('IFWR2.1: Finds Center when IfWrapper wrap condition is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(const TestWidget2(wrap: true));
      final Finder widget = find.byType(Center);
      expect(widget, findsOneWidget);
    });
    testWidgets('IFWR2.2: Finds No Center when IfWrapper condition is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(const TestWidget2(wrap: false));
      final Finder widget = find.byType(Center);
      expect(widget, findsNothing);
      final Finder widgetContainer = find.byType(Container);
      expect(widgetContainer, findsOneWidget);
    });
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key, required this.wrap});
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    debugDefaultTargetPlatformOverride = null;
    return MaterialApp(
      title: 'TestWidget',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TestWidget'),
        ),
        body: IfWrapper(
          condition: wrap,
          builder: (BuildContext context, Widget child) {
            return Center(child: child);
          },
          child: const Placeholder(),
        ),
      ),
    );
  }
}

class TestWidget2 extends StatelessWidget {
  const TestWidget2({super.key, required this.wrap});
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    debugDefaultTargetPlatformOverride = null;
    return MaterialApp(
      title: 'TestWidget2',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TestWidget2'),
        ),
        body: IfWrapper(
          condition: wrap,
          builder: (BuildContext context, Widget child) {
            return Center(child: child);
          },
          ifFalse: (BuildContext context, Widget child) {
            return Container(child: child);
          },
          child: const Placeholder(),
        ),
      ),
    );
  }
}
