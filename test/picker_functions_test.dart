import 'package:flex_color_picker/src/functions/picker_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  // Test platformControlKey copy key.
  group('Verify platformControlKey', () {
    test('Test platformControlKey TargetPlatform.android', () {
      expect(platformControlKey(TargetPlatform.android, 'C'), '');
    });
    test('Test platformControlKey TargetPlatform.iOS', () {
      expect(platformControlKey(TargetPlatform.iOS, 'C'), '');
    });
    test('Test platformControlKey TargetPlatform.fuchsia', () {
      expect(platformControlKey(TargetPlatform.fuchsia, 'C'), '');
    });
    test('Test platformControlKey TargetPlatform.linux', () {
      expect(platformControlKey(TargetPlatform.linux, 'C'), ' (CTRL-C)');
    });
    test('Test platformControlKey TargetPlatform.windows', () {
      expect(platformControlKey(TargetPlatform.windows, 'C'), ' (CTRL-C)');
    });
    test('Test platformControlKey TargetPlatform.macOS', () {
      expect(platformControlKey(TargetPlatform.macOS, 'C'), ' (CMD-C)');
    });
  });

  // Test isDesktop.
  group('Verify isDesktop', () {
    test('Test isDesktop TargetPlatform.android', () {
      expect(isDesktop(TargetPlatform.android), false);
    });
    test('Test isDesktop TargetPlatform.iOS', () {
      expect(isDesktop(TargetPlatform.iOS), false);
    });
    test('Test isDesktop TargetPlatform.fuchsia', () {
      expect(isDesktop(TargetPlatform.fuchsia), false);
    });
    test('Test isDesktop TargetPlatform.linux', () {
      expect(isDesktop(TargetPlatform.linux), true);
    });
    test('Test isDesktop TargetPlatform.windows', () {
      expect(isDesktop(TargetPlatform.windows), true);
    });
    test('Test isDesktop TargetPlatform.macOS', () {
      expect(isDesktop(TargetPlatform.macOS), true);
    });
  });

  // Test isShadeOfMain.
  group('Verify isShadeOfMain', () {
    final List<int> index = <int>[
      50,
      100,
      200,
      300,
      400,
      500,
      600,
      700,
      800,
      850, // Only used by grey swatch
      900
    ];

    for (final int i in index) {
      if (Colors.grey[i] != null) {
        test(
            'Verify that color ${Colors.grey[i]}[$i] is a shade of ${Colors.grey}',
            () {
          expect(isShadeOfMain(Colors.grey, Colors.grey[i]!, true), true);
        });
      }
    }
    test(
        'Verify that color index 850 is NOT a shade of ${Colors.grey} when 850 disabled',
        () {
      expect(isShadeOfMain(Colors.grey, Colors.grey[850]!, false), false);
    });

    for (final int i in index) {
      if (Colors.blue[i] != null) {
        test(
            'Verify that color ${Colors.blue[i]}[$i] is a shade of ${Colors.blue}',
            () {
          expect(isShadeOfMain(Colors.blue, Colors.blue[i]!, false), true);
        });
      }
    }
  });
}
