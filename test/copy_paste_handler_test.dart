import 'package:flex_color_picker/src/widgets/copy_paste_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CopyPasteHandler Widget Test', (WidgetTester tester) async {
    Future<void> mockCopyToClipboard() async {
      await Clipboard.setData(const ClipboardData(text: 'Copied Text'));
    }

    Future<void> mockPasteFromClipboard() async {
      final ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
      expect(data?.text, 'Copied Text');
    }

    final FocusNode focusNode = FocusNode();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CopyPasteHandler(
            pasteFromClipboard: mockPasteFromClipboard,
            copyToClipboard: mockCopyToClipboard,
            useContextMenu: true,
            useLongPress: true,
            useSecondaryTapDown: true,
            useSecondaryOnDesktopLongOnDevice: true,
            useSecondaryOnDesktopLongOnDeviceAndWeb: true,
            onCopyPasteMenuOpened: () {},
            focusNode: focusNode,
            autoFocus: true,
            noPasteIntent: false,
            child: Container(),
          ),
        ),
      ),
    );

    expect(find.byType(CopyPasteHandler), findsOneWidget);

    // Test copy functionality
    await tester.sendKeyEvent(LogicalKeyboardKey.meta);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyC);
    await tester.pumpAndSettle();

    // Test paste functionality
    await tester.sendKeyEvent(LogicalKeyboardKey.meta);
    await tester.sendKeyEvent(LogicalKeyboardKey.keyV);
    await tester.pumpAndSettle();
  });
}
