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
          widget: DryIntrinsicWidth(key: testKey, child: Text('HELLO WORLD'))));
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);
    });
    testWidgets('DINT1.2: Finds DryIntrinsicHeight',
        (WidgetTester tester) async {
      await tester.pumpWidget(const TestWidget(
          widget:
              DryIntrinsicHeight(key: testKey, child: Text('HELLO WORLD'))));
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);
    });
  });

  testWidgets('DryIntrinsicWidth computes dry layout correctly',
      (WidgetTester tester) async {
    // Build the DryIntrinsicWidth with a child widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DryIntrinsicWidth(
              child: SizedBox(width: 50, height: 100),
            ),
          ),
        ),
      ),
    );

    // Verify that the DryIntrinsicWidth is displayed
    expect(find.byType(DryIntrinsicWidth), findsOneWidget);

    // Verify that the DryIntrinsicWidth has the correct size
    final RenderBox dryIntrinsicWidth =
        tester.renderObject<RenderBox>(find.byType(DryIntrinsicWidth));
    expect(dryIntrinsicWidth.size, equals(const Size(50, 100)));
  });

  testWidgets('DryIntrinsicWidth computes zero dry layout correctly',
      (WidgetTester tester) async {
    // Build the DryIntrinsicWidth with a child widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DryIntrinsicWidth(
              child: null,
            ),
          ),
        ),
      ),
    );

    // Verify that the DryIntrinsicWidth is displayed
    expect(find.byType(DryIntrinsicWidth), findsOneWidget);

    // Verify that the DryIntrinsicWidth has the correct size
    final RenderBox dryIntrinsicWidth =
        tester.renderObject<RenderBox>(find.byType(DryIntrinsicWidth));
    expect(dryIntrinsicWidth.size, equals(Size.zero));
  });

  testWidgets('DryIntrinsicHeight computes dry layout correctly',
      (WidgetTester tester) async {
    // Build the DryIntrinsicHeight with a child widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DryIntrinsicHeight(
              child: SizedBox(width: 100, height: 50),
            ),
          ),
        ),
      ),
    );

    // Verify that the DryIntrinsicHeight is displayed
    expect(find.byType(DryIntrinsicHeight), findsOneWidget);

    // Verify that the DryIntrinsicHeight has the correct size
    final RenderBox dryIntrinsicHeight =
        tester.renderObject<RenderBox>(find.byType(DryIntrinsicHeight));
    expect(dryIntrinsicHeight.size, equals(const Size(100, 50)));
  });

  testWidgets('DryIntrinsicHeight computes zero dry layout correctly',
      (WidgetTester tester) async {
    // Build the DryIntrinsicHeight with a child widget
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DryIntrinsicHeight(
              child: null,
            ),
          ),
        ),
      ),
    );

    // Verify that the DryIntrinsicHeight is displayed
    expect(find.byType(DryIntrinsicHeight), findsOneWidget);

    // Verify that the DryIntrinsicHeight has the correct size
    final RenderBox dryIntrinsicHeight =
        tester.renderObject<RenderBox>(find.byType(DryIntrinsicHeight));
    expect(dryIntrinsicHeight.size, equals(Size.zero));
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
          child: widget,
        ),
      ),
    );
  }
}
