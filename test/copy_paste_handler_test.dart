import 'package:flex_color_picker/src/widgets/copy_paste_handler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  testWidgets('CPH1: CopyPasteHandler Widget Test', (WidgetTester tester) async {
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

  testWidgets('CPH2: CopyPasteHandler with different configurations', (WidgetTester tester) async {
    final FocusNode focusNode = FocusNode();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CopyPasteHandler(
            pasteFromClipboard: () async {},
            copyToClipboard: () async {},
            useContextMenu: true,
            useLongPress: true,
            useSecondaryTapDown: true,
            useSecondaryOnDesktopLongOnDevice: false,
            useSecondaryOnDesktopLongOnDeviceAndWeb: true,
            onCopyPasteMenuOpened: () {},
            focusNode: focusNode,
            autoFocus: true,
            noPasteIntent: false,
            child: const SizedBox(
              width: 100,
              height: 100,
              child: Text('Test'),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.byType(CopyPasteHandler), findsOneWidget);
  });

  testWidgets('CPH4: CopyPasteHandler without context menu test', (WidgetTester tester) async {
    Future<void> mockCopyToClipboard() async {
      await Clipboard.setData(const ClipboardData(text: 'Copied Text'));
    }

    Future<void> mockPasteFromClipboard() async {}

    final FocusNode focusNode = FocusNode();

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CopyPasteHandler(
            pasteFromClipboard: mockPasteFromClipboard,
            copyToClipboard: mockCopyToClipboard,
            useContextMenu: false,
            useLongPress: false,
            useSecondaryTapDown: false,
            useSecondaryOnDesktopLongOnDevice: false,
            useSecondaryOnDesktopLongOnDeviceAndWeb: false,
            onCopyPasteMenuOpened: () {},
            focusNode: focusNode,
            autoFocus: false,
            noPasteIntent: true,
            child: const Text('Test'),
          ),
        ),
      ),
    );

    expect(find.byType(CopyPasteHandler), findsOneWidget);
    await tester.pumpAndSettle();
  });

  testWidgets('CPH5: Control+C copies and Control+V pastes on Windows', (WidgetTester tester) async {
    int copyCount = 0;
    int pasteCount = 0;
    final FocusNode focusNode = FocusNode();

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.windows),
        home: Scaffold(
          body: CopyPasteHandler(
            pasteFromClipboard: () async {
              pasteCount++;
            },
            copyToClipboard: () async {
              copyCount++;
            },
            useContextMenu: false,
            useLongPress: false,
            useSecondaryTapDown: false,
            useSecondaryOnDesktopLongOnDevice: false,
            useSecondaryOnDesktopLongOnDeviceAndWeb: false,
            onCopyPasteMenuOpened: () {},
            focusNode: focusNode,
            autoFocus: true,
            noPasteIntent: false,
            child: const SizedBox(width: 100, height: 100),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final Shortcuts shortcuts = tester.widget<Shortcuts>(
      find.descendant(of: find.byType(CopyPasteHandler), matching: find.byType(Shortcuts)),
    );
    final Map<ShortcutActivator, Intent> shortcutMap = shortcuts.shortcuts;

    expect(
      shortcutMap[LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC)],
      isA<CopyIntent>(),
    );
    expect(
      shortcutMap[LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyV)],
      isA<PasteIntent>(),
    );
    expect(
      shortcutMap[LogicalKeySet(LogicalKeyboardKey.control, LogicalKeyboardKey.keyC)],
      isNot(isA<PasteIntent>()),
    );

    await tester.sendKeyDownEvent(LogicalKeyboardKey.control);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.keyC);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.keyC);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.control);
    await tester.pumpAndSettle();
    expect(copyCount, 1);
    expect(pasteCount, 0);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.control);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.keyV);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.keyV);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.control);
    await tester.pumpAndSettle();
    expect(copyCount, 1);
    expect(pasteCount, 1);

    focusNode.dispose();
  });

  testWidgets('CPH6: Meta+C copies and Meta+V pastes on macOS', (WidgetTester tester) async {
    int copyCount = 0;
    int pasteCount = 0;
    final FocusNode focusNode = FocusNode();

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(platform: TargetPlatform.macOS),
        home: Scaffold(
          body: CopyPasteHandler(
            pasteFromClipboard: () async {
              pasteCount++;
            },
            copyToClipboard: () async {
              copyCount++;
            },
            useContextMenu: false,
            useLongPress: false,
            useSecondaryTapDown: false,
            useSecondaryOnDesktopLongOnDevice: false,
            useSecondaryOnDesktopLongOnDeviceAndWeb: false,
            onCopyPasteMenuOpened: () {},
            focusNode: focusNode,
            autoFocus: true,
            noPasteIntent: false,
            child: const SizedBox(width: 100, height: 100),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final Shortcuts shortcuts = tester.widget<Shortcuts>(
      find.descendant(of: find.byType(CopyPasteHandler), matching: find.byType(Shortcuts)),
    );
    final Map<ShortcutActivator, Intent> shortcutMap = shortcuts.shortcuts;

    expect(
      shortcutMap[LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyC)],
      isA<CopyIntent>(),
    );
    expect(
      shortcutMap[LogicalKeySet(LogicalKeyboardKey.meta, LogicalKeyboardKey.keyV)],
      isA<PasteIntent>(),
    );

    await tester.sendKeyDownEvent(LogicalKeyboardKey.meta);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.keyC);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.keyC);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.meta);
    await tester.pumpAndSettle();
    expect(copyCount, 1);
    expect(pasteCount, 0);

    await tester.sendKeyDownEvent(LogicalKeyboardKey.meta);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.keyV);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.keyV);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.meta);
    await tester.pumpAndSettle();
    expect(copyCount, 1);
    expect(pasteCount, 1);

    focusNode.dispose();
  });
}
