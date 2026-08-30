import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flex_color_picker/src/widgets/color_picker_toolbar.dart';
import 'package:flex_color_picker/src/widgets/opacity/opacity_slider.dart';
import 'package:flex_color_picker/src/widgets/recent_colors.dart';
import 'package:flex_color_picker/src/widgets/shade_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import 'clipboard_utils.dart';

Map<ColorPickerType, bool> _only(ColorPickerType type) {
  return <ColorPickerType, bool>{
    for (final ColorPickerType pickerType in ColorPickerType.values) pickerType: pickerType == type,
  };
}

Map<ColorPickerType, bool> _none() {
  return <ColorPickerType, bool>{
    for (final ColorPickerType pickerType in ColorPickerType.values) pickerType: false,
  };
}

Map<ColorSwatch<Object>, String> _guideSwatches() {
  return <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(const Color(0xFF6200EE)): 'Guide Purple',
    ColorTools.createAccentSwatch(const Color(0xFF03DAC6)): 'Guide Teal',
  };
}

void _bindClipboard(MockClipboard mockClipboard) {
  TestWidgetsFlutterBinding.ensureInitialized().defaultBinaryMessenger.setMockMethodCallHandler(
    SystemChannels.platform,
    mockClipboard.handleMethodCall,
  );
}

Widget _app(Widget child) {
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(child: child),
    ),
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final Map<ColorSwatch<Object>, String> customSwatches = _guideSwatches();
  final Map<ColorSwatch<Object>, String> secondarySwatches = <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(const Color(0xFF3700B3)): 'Guide Purple Variant',
  };

  group('CPI3: Single picker modes', () {
    testWidgets('CPI3.1: Only both picker is enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.red,
            onColorChanged: (Color color) {},
            pickersEnabled: _only(ColorPickerType.both),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ColorPicker), findsOneWidget);
      expect(find.text('Primary & Accent'), findsNothing);
    });

    testWidgets('CPI3.2: Only accent picker is enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.redAccent,
            onColorChanged: (Color color) {},
            pickersEnabled: _only(ColorPickerType.accent),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ColorPicker), findsOneWidget);
    });

    testWidgets('CPI3.3: Only black and white picker is enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.black,
            onColorChanged: (Color color) {},
            pickersEnabled: _only(ColorPickerType.bw),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ColorPicker), findsOneWidget);
    });

    testWidgets('CPI3.4: Only custom picker is enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: const Color(0xFF6200EE),
            onColorChanged: (Color color) {},
            pickersEnabled: _only(ColorPickerType.custom),
            customColorSwatchesAndNames: customSwatches,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ColorPicker), findsOneWidget);
    });

    testWidgets('CPI3.5: Only custom secondary picker is enabled', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: const Color(0xFF3700B3),
            onColorChanged: (Color color) {},
            pickersEnabled: _only(ColorPickerType.customSecondary),
            customSecondaryColorSwatchesAndNames: secondarySwatches,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ColorPicker), findsOneWidget);
    });

    testWidgets('CPI3.6: Only wheel picker is enabled without shades or tonal', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.teal,
            onColorChanged: (Color color) {},
            pickersEnabled: _only(ColorPickerType.wheel),
            enableShadesSelection: false,
            enableTonalPalette: false,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ColorWheelPicker), findsOneWidget);
    });

    testWidgets('CPI3.7: All pickers disabled falls back to primary', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.orange,
            onColorChanged: (Color color) {},
            pickersEnabled: _none(),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ColorPicker), findsOneWidget);
    });

    testWidgets('CPI3.8: Wheel picker with accent, bw and custom seed colors', (WidgetTester tester) async {
      Future<void> pumpWheel(Color color) async {
        await tester.pumpWidget(
          _app(
            ColorPicker(
              color: color,
              onColorChanged: (Color value) {},
              pickersEnabled: _only(ColorPickerType.wheel),
              customColorSwatchesAndNames: customSwatches,
              customSecondaryColorSwatchesAndNames: secondarySwatches,
            ),
          ),
        );
        await tester.pumpAndSettle();
      }

      await pumpWheel(Colors.redAccent);
      expect(find.byType(ColorWheelPicker), findsOneWidget);
      await pumpWheel(Colors.black);
      expect(find.byType(ColorWheelPicker), findsOneWidget);
      await pumpWheel(const Color(0xFF6200EE));
      expect(find.byType(ColorWheelPicker), findsOneWidget);
      await pumpWheel(const Color(0xFF3700B3));
      expect(find.byType(ColorWheelPicker), findsOneWidget);
    });
  });

  group('CPI4: ColorPicker didUpdateWidget extra cases', () {
    testWidgets('CPI4.1: Replaces recent colors from an external list', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            showRecentColors: true,
            recentColors: const <Color>[Colors.red, Colors.green],
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RecentColors), findsOneWidget);

      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            showRecentColors: true,
            recentColors: const <Color>[Colors.yellow, Colors.purple, Colors.orange],
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(RecentColors), findsOneWidget);
    });

    testWidgets('CPI4.2: Updates custom secondary swatches and enables the picker', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.primary: true,
              ColorPickerType.accent: false,
              ColorPickerType.customSecondary: false,
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.primary: true,
              ColorPickerType.accent: false,
              ColorPickerType.customSecondary: true,
            },
            customSecondaryColorSwatchesAndNames: secondarySwatches,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Option'), findsOneWidget);
    });

    testWidgets('CPI4.3: External color change while the wheel is the only picker', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            pickersEnabled: _only(ColorPickerType.wheel),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.deepOrange,
            onColorChanged: (Color color) {},
            pickersEnabled: _only(ColorPickerType.wheel),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ColorWheelPicker), findsOneWidget);
    });
  });

  group('CPI5: Title, headings, edit icon and recent colors', () {
    testWidgets('CPI5.1: Title can be a TextSpan or a non-text widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            title: const Text.rich(TextSpan(text: 'Span title', style: TextStyle(fontSize: 18))),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Span title'), findsOneWidget);

      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            title: const SizedBox(width: 24, height: 24, child: Icon(Icons.palette)),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.palette), findsOneWidget);
    });

    testWidgets('CPI5.2: Wheel and opacity subheadings are shown', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            pickersEnabled: _only(ColorPickerType.wheel),
            enableOpacity: true,
            wheelSubheading: const Text('Wheel heading'),
            opacitySubheading: const Text('Opacity heading'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Wheel heading'), findsOneWidget);
      expect(find.text('Opacity heading'), findsOneWidget);
    });

    testWidgets('CPI5.3: Edit icon on the wheel requests the color code field', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            pickersEnabled: _only(ColorPickerType.wheel),
            showColorCode: true,
            showEditIconButton: true,
            colorCodeReadOnly: false,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.edit), findsOneWidget);
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();
      expect(find.byType(ColorCodeField), findsOneWidget);
    });

    testWidgets('CPI5.4: Tapping a recent color selects it through findPicker', (WidgetTester tester) async {
      Color selected = Colors.blue;
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {
              selected = color;
            },
            showRecentColors: true,
            recentColors: const <Color>[Colors.red, Colors.green],
            recentColorsSubheading: const Text('Recent'),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Recent'), findsOneWidget);
      await tester.tap(find.descendant(of: find.byType(RecentColors), matching: find.byType(ColorIndicator)).first);
      await tester.pumpAndSettle();
      expect(selected.value32bit, Colors.red.value32bit);
    });

    testWidgets('CPI5.5: Switching to the wheel without shades requests wheel focus', (WidgetTester tester) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.primary: true,
              ColorPickerType.accent: false,
              ColorPickerType.wheel: true,
            },
            enableShadesSelection: false,
            enableTonalPalette: false,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Wheel'));
      await tester.pumpAndSettle();
      expect(find.byType(ColorWheelPicker), findsOneWidget);
    });

    testWidgets('CPI5.6: Selecting a wheel shade updates tonal flags', (WidgetTester tester) async {
      Color selected = Colors.blue;
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {
              selected = color;
            },
            pickersEnabled: _only(ColorPickerType.wheel),
            enableShadesSelection: true,
          ),
        ),
      );
      await tester.pumpAndSettle();
      final Finder shade = find.descendant(
        of: find.byType(ShadeColors),
        matching: find.byType(ColorIndicator),
      );
      expect(shade, findsWidgets);
      await tester.tap(shade.at(1));
      await tester.pumpAndSettle();
      expect(selected, isNot(equals(Colors.blue)));
    });

    testWidgets('CPI5.8: Opening the copy menu while dragging the wheel ends the drag', (
      WidgetTester tester,
    ) async {
      Color? changeEnd;
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            onColorChangeEnd: (Color color) {
              changeEnd = color;
            },
            title: const Text('Wheel title'),
            pickersEnabled: _only(ColorPickerType.wheel),
            enableShadesSelection: false,
            enableTonalPalette: false,
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              longPressMenu: true,
              secondaryMenu: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final Offset wheelCenter = tester.getCenter(find.byType(ColorWheelPicker));
      final TestGesture drag = await tester.startGesture(wheelCenter);
      await tester.pump(const Duration(milliseconds: 50));
      await drag.moveBy(const Offset(12, 0));
      await tester.pump();

      final Offset title = tester.getCenter(find.text('Wheel title'));
      await tester.longPressAt(title);
      await tester.pumpAndSettle();
      tester.takeException();

      expect(changeEnd, isNotNull);

      await drag.up();
    });

    testWidgets('CPI5.7: Long-press copy menu opens on the picker', (WidgetTester tester) async {
      Color? changeEnd;
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            onColorChangeEnd: (Color color) {
              changeEnd = color;
            },
            title: const Text('Picker title'),
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              longPressMenu: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.longPress(find.text('Picker title'));
      await tester.pumpAndSettle();
      // Default copy/paste menu width is 80dp and overflows Copy/Paste labels.
      tester.takeException();
      expect(find.text('Copy'), findsOneWidget);
      expect(changeEnd, isNull);
    });
  });

  group('CPI6: Clipboard copy formats and paste errors', () {
    late MockClipboard mockClipboard;

    setUp(() {
      mockClipboard = MockClipboard();
      _bindClipboard(mockClipboard);
    });

    tearDown(() {
      TestWidgetsFlutterBinding.ensureInitialized().defaultBinaryMessenger.setMockMethodCallHandler(
        SystemChannels.platform,
        null,
      );
    });

    Future<void> pumpCopyPicker(
      WidgetTester tester, {
      required ColorPickerCopyFormat format,
      Color color = Colors.blue,
      bool enableOpacity = false,
    }) async {
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: color,
            onColorChanged: (Color value) {},
            enableOpacity: enableOpacity,
            copyPasteBehavior: ColorPickerCopyPasteBehavior(
              copyButton: true,
              pasteButton: true,
              copyFormat: format,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('CPI6.1: Toolbar copy uses each ColorPickerCopyFormat', (WidgetTester tester) async {
      const Color color = Colors.blue;
      final Map<ColorPickerCopyFormat, String> expected = <ColorPickerCopyFormat, String>{
        ColorPickerCopyFormat.hexRRGGBB: color.hex,
        ColorPickerCopyFormat.hexAARRGGBB: color.hexAlpha,
        ColorPickerCopyFormat.numHexRRGGBB: '#${color.hex}',
        ColorPickerCopyFormat.numHexAARRGGBB: '#${color.hexAlpha}',
      };

      for (final MapEntry<ColorPickerCopyFormat, String> entry in expected.entries) {
        await pumpCopyPicker(tester, format: entry.key, color: color);
        await tester.tap(find.descendant(of: find.byType(ColorPickerToolbar), matching: find.byIcon(Icons.copy)));
        await tester.pumpAndSettle();
        final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
        expect(data?.text, entry.value, reason: '${entry.key}');
      }
    });

    testWidgets('CPI6.2: Invalid paste shows the default snackbar', (WidgetTester tester) async {
      mockClipboard.clipboardData = <String, dynamic>{'text': 'not-a-color'};
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              pasteButton: true,
              snackBarParseError: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.paste));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('CPI6.3: Invalid paste uses a custom snackbar message and haptic feedback', (
      WidgetTester tester,
    ) async {
      mockClipboard.clipboardData = <String, dynamic>{'text': 'zzzzzz'};
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              pasteButton: true,
              snackBarParseError: true,
              snackBarMessage: 'Bad paste',
              feedbackParseError: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.paste));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(find.text('Bad paste'), findsOneWidget);
    });

    testWidgets('CPI6.4: Pasting a color with alpha captures opacity when enabled', (WidgetTester tester) async {
      Color selected = Colors.blue;
      mockClipboard.clipboardData = <String, dynamic>{'text': '0x8037FF00'};
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {
              selected = color;
            },
            enableOpacity: true,
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              pasteButton: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.paste));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 150));
      await tester.pumpAndSettle();
      expect(selected.red8bit, 0x37);
      expect(selected.green8bit, 0xFF);
      expect(selected.blue8bit, 0x00);
    });

    testWidgets('CPI6.5: Unmounting during paste-error delay does not throw', (WidgetTester tester) async {
      mockClipboard.clipboardData = <String, dynamic>{'text': 'nope'};
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {},
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              pasteButton: true,
              snackBarParseError: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.paste));
      await tester.pump();
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 400));
    });

    testWidgets('CPI6.6: Paste returns immediately when the clipboard has no data', (WidgetTester tester) async {
      Color selected = Colors.blue;
      mockClipboard.clipboardData = null;
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {
              selected = color;
            },
            copyPasteBehavior: const ColorPickerCopyPasteBehavior(
              pasteButton: true,
              snackBarParseError: true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(await Clipboard.getData(Clipboard.kTextPlain), isNull);
      await tester.tap(find.byIcon(Icons.paste));
      await tester.pumpAndSettle();
      expect(selected, Colors.blue);
      expect(find.byType(SnackBar), findsNothing);
    });
  });

  group('CPI7: Toolbar OK and Close pop a dialog', () {
    testWidgets('CPI7.1: Toolbar OK pops true and Close pops false', (WidgetTester tester) async {
      bool? dialogResult;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () async {
                    dialogResult = await const ColorPicker(
                      onColorChanged: _noopColor,
                      actionButtons: ColorPickerActionButtons(
                        okButton: true,
                        closeButton: true,
                        dialogActionButtons: false,
                      ),
                    ).showPickerDialog(context);
                  },
                  child: const Text('Open'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(ColorPickerToolbar), matching: find.byIcon(Icons.check)));
      await tester.pumpAndSettle();
      expect(dialogResult, isTrue);

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.descendant(of: find.byType(ColorPickerToolbar), matching: find.byIcon(Icons.close)));
      await tester.pumpAndSettle();
      expect(dialogResult, isFalse);
    });
  });

  group('CPI8: Opacity slider and color code editing', () {
    testWidgets('CPI8.1: Dragging the opacity slider reports start, change and end', (WidgetTester tester) async {
      Color? start;
      Color? changed;
      Color? end;
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.red.withValues(alpha: 0.5),
            onColorChanged: (Color color) {
              changed = color;
            },
            onColorChangeStart: (Color color) {
              start = color;
            },
            onColorChangeEnd: (Color color) {
              end = color;
            },
            enableOpacity: true,
            opacityTrackWidth: 200,
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(OpacitySlider), findsOneWidget);
      final Finder slider = find.descendant(of: find.byType(OpacitySlider), matching: find.byType(Slider));
      expect(slider, findsOneWidget);
      await tester.ensureVisible(slider);
      await tester.drag(slider, const Offset(40, 0));
      await tester.pumpAndSettle();
      expect(start, isNotNull);
      expect(changed, isNotNull);
      expect(end, isNotNull);
    });

    testWidgets('CPI8.2: Editing the wheel color code updates the selected color', (WidgetTester tester) async {
      Color selected = Colors.blue;
      await tester.pumpWidget(
        _app(
          ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) {
              selected = color;
            },
            onColorChangeStart: (Color color) {},
            onColorChangeEnd: (Color color) {},
            pickersEnabled: _only(ColorPickerType.wheel),
            showColorCode: true,
            showRecentColors: true,
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), '613E42');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle();
      expect(selected.value32bit, const Color(0xFF613E42).value32bit);
    });
  });
}

void _noopColor(Color color) {}
