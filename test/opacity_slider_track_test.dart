import 'dart:async';
import 'dart:ui' as ui;

import 'package:flex_color_picker/src/widgets/opacity/opacity_slider_track.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('OpacitySliderTrack test', (WidgetTester tester) async {
    // Create an AssetImage for the test
    const AssetImage assetImage = AssetImage('assets/opacity.png');
    late ui.Image image;
    final Completer<void> completer = Completer<void>();

    // Load the image using the tester's runAsync method
    await tester.runAsync(() async {
      final ByteData data = await rootBundle.load(assetImage.keyName);
      final ui.Codec codec =
          await ui.instantiateImageCodec(data.buffer.asUint8List());
      final ui.FrameInfo frameInfo = await codec.getNextFrame();
      image = frameInfo.image;
      completer.complete();
    });

    await completer.future;

    // Create a MaterialApp as a root widget for the test
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Center(
          child: SliderTheme(
            data: SliderThemeData(
              trackShape: OpacitySliderTrack(
                color: Colors.red,
                thumbRadius: 14,
                image: image,
              ),
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
