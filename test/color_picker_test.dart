import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// ignore_for_file: unnecessary_null_comparison

//****************************************************************************
// FlexColorPicker ColorPicker Widget tests
//****************************************************************************
void main() {
  const ValueKey<String> testKey = ValueKey<String>('test');

  group('CPI1: In App With ColorPicker', () {
    debugDefaultTargetPlatformOverride = null;
    testWidgets('CPI1.1: Finds default ColorPicker()',
        (WidgetTester tester) async {
      await tester.pumpWidget(TestWidget(
          widget: ColorPicker(
        key: testKey,
        onColorChanged: (Color color) {},
      )));
      final Finder widget = find.byKey(testKey);
      expect(widget, findsOneWidget);

      final WidgetPredicate defaultPicker = (Widget widget) =>
          widget is ColorPicker &&
          widget.color == Colors.blue &&
          widget.onColorChanged != null &&
          widget.onColorChangeStart == null &&
          widget.onColorChangeEnd == null &&
          widget.pickersEnabled ==
              const <ColorPickerType, bool>{
                ColorPickerType.both: false,
                ColorPickerType.primary: true,
                ColorPickerType.accent: true,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.wheel: false,
              } &&
          widget.enableShadesSelection == true &&
          widget.includeIndex850 == false &&
          widget.crossAxisAlignment == CrossAxisAlignment.center &&
          widget.padding == const EdgeInsets.all(16) &&
          widget.columnSpacing == 8 &&
          widget.enableOpacity == false &&
          widget.opacityTrackHeight == 36 &&
          widget.opacityTrackWidth == null &&
          widget.opacityThumbRadius == 16 &&
          widget.actionButtons == const ColorPickerActionButtons() &&
          widget.copyPasteBehavior == const ColorPickerCopyPasteBehavior() &&
          widget.selectedColorIcon == Icons.check &&
          widget.width == 40 &&
          widget.height == 40 &&
          widget.spacing == 4 &&
          widget.runSpacing == 4 &&
          widget.elevation == 0 &&
          widget.hasBorder == false &&
          widget.borderRadius == null &&
          widget.borderColor == null &&
          widget.wheelDiameter == 190 &&
          widget.wheelWidth == 16 &&
          widget.wheelHasBorder == false &&
          widget.title == null &&
          widget.heading == null &&
          widget.subheading == null &&
          widget.wheelSubheading == null &&
          widget.recentColorsSubheading == null &&
          widget.opacitySubheading == null &&
          widget.showMaterialName == false &&
          widget.materialNameTextStyle == null &&
          widget.showColorName == false &&
          widget.colorNameTextStyle == null &&
          widget.showColorCode == false &&
          widget.colorCodeHasColor == false &&
          widget.colorCodeTextStyle == null &&
          widget.colorCodePrefixStyle == null &&
          widget.colorCodeReadOnly == false &&
          widget.showColorValue == false &&
          widget.showRecentColors == false &&
          widget.maxRecentColors == 5 &&
          widget.recentColors == const <Color>[] &&
          widget.onRecentColorsChanged == null &&
          widget.enableTooltips == true &&
          widget.selectedPickerTypeColor == null &&
          widget.pickerTypeTextStyle == null &&
          widget.pickerTypeLabels ==
              const <ColorPickerType, String>{
                ColorPickerType.primary: 'Primary',
                ColorPickerType.accent: 'Accent',
                ColorPickerType.bw: 'Black & White',
                ColorPickerType.both: 'Primary & Accent',
                ColorPickerType.custom: 'Custom',
                ColorPickerType.wheel: 'Wheel',
              } &&
          widget.customColorSwatchesAndNames ==
              const <ColorSwatch<Object>, String>{};
      expect(find.byWidgetPredicate(defaultPicker), findsOneWidget);
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
            width: 500,
            height: 800,
            child: widget,
          ),
        ),
      ),
    );
  }
}
