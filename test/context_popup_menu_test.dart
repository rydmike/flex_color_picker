import 'package:flex_color_picker/src/universal_widgets/context_popup_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ContextPopupMenu platform and property test',
      (WidgetTester tester) async {
    // Define a variable to hold the selected value
    int? selectedValue;

    // Function to build the widget with different platforms and properties
    Future<void> buildWidget({
      required TargetPlatform platform,
      required bool useLongPress,
      required bool useSecondaryTapDown,
      required bool useSecondaryOnDesktopLongOnDevice,
      required bool useSecondaryOnDesktopLongOnDeviceAndWeb,
    }) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(platform: platform),
          home: Scaffold(
            body: ContextPopupMenu<int>(
              items: const <PopupMenuItem<int>>[
                PopupMenuItem<int>(value: 1, child: Text('Item 1')),
                PopupMenuItem<int>(value: 2, child: Text('Item 2')),
              ],
              onSelected: (int? value) {
                selectedValue = value;
              },
              useLongPress: useLongPress,
              useSecondaryTapDown: useSecondaryTapDown,
              useSecondaryOnDesktopLongOnDevice:
                  useSecondaryOnDesktopLongOnDevice,
              useSecondaryOnDesktopLongOnDeviceAndWeb:
                  useSecondaryOnDesktopLongOnDeviceAndWeb,
              child: const Text('Open Menu'),
            ),
          ),
        ),
      );
    }

    // Test on different platforms and properties
    for (final TargetPlatform platform in TargetPlatform.values) {
      for (final bool useLongPress in <bool>[true, false]) {
        for (final bool useSecondaryTapDown in <bool>[true, false]) {
          for (final bool useSecondaryOnDesktopLongOnDevice in <bool>[
            true,
            false
          ]) {
            for (final bool useSecondaryOnDesktopLongOnDeviceAndWeb in <bool>[
              true,
              false
            ]) {
              await buildWidget(
                platform: platform,
                useLongPress: useLongPress,
                useSecondaryTapDown: useSecondaryTapDown,
                useSecondaryOnDesktopLongOnDevice:
                    useSecondaryOnDesktopLongOnDevice,
                useSecondaryOnDesktopLongOnDeviceAndWeb:
                    useSecondaryOnDesktopLongOnDeviceAndWeb,
              );

              // Verify the menu is not visible initially
              expect(find.text('Item 1'), findsNothing);
              expect(find.text('Item 2'), findsNothing);

              // Long press to open the menu if useLongPress is true
              if (useLongPress) {
                await tester.longPress(find.text('Open Menu'));
                await tester.pumpAndSettle();
                expect(find.text('Item 1'), findsOneWidget);
                expect(find.text('Item 2'), findsOneWidget);
                await tester.tap(find.text('Item 1'));
                await tester.pumpAndSettle();
                expect(selectedValue, 1);
              }

              // Secondary tap to open the menu if useSecondaryTapDown is true
              if (useSecondaryTapDown) {
                await tester.tap(find.text('Open Menu'),
                    buttons: kSecondaryButton);
                await tester.pumpAndSettle();
                expect(find.text('Item 1'), findsOneWidget);
                expect(find.text('Item 2'), findsOneWidget);
                await tester.tap(find.text('Item 1'));
                await tester.pumpAndSettle();
                expect(selectedValue, 1);
              }
            }
          }
        }
      }
    }
  });
}
