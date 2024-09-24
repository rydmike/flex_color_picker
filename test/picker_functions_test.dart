import 'package:flex_color_picker/src/functions/picker_functions.dart';
import 'package:flex_color_picker/src/models/color_picker_type.dart';
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
            'Verify that color ${Colors.grey[i]}[$i] is a '
            'shade of ${Colors.grey}', () {
          expect(isShadeOfMain(Colors.grey, Colors.grey[i]!, true), true);
        });
      }
    }
    test(
        'Verify that color index 850 is NOT a '
        'shade of ${Colors.grey} when 850 disabled', () {
      expect(isShadeOfMain(Colors.grey, Colors.grey[850]!, false), false);
    });

    for (final int i in index) {
      if (Colors.blue[i] != null) {
        test(
            'Verify that color ${Colors.blue[i]}[$i] is a '
            'shade of ${Colors.blue}', () {
          expect(isShadeOfMain(Colors.blue, Colors.blue[i]!, false), true);
        });
      }
    }

    for (final int i in index) {
      if (Colors.red[i] != null) {
        test(
            'Verify that color ${Colors.red[i]}[$i] is NOT a '
            'shade of ${Colors.red}', () {
          expect(isShadeOfMain(Colors.red, Colors.blue[i]!, false), false);
        });
      }
    }
  });

  // Test findColorSwatch.
  group('Test findColorSwatch', () {
    final List<ColorSwatch<Object>> swatches = <ColorSwatch<Object>>[
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.grey,
    ];

    test(
        'Verify that color ${Colors.red[200]!} in red, green, blue, grey '
        'swatches return ${Colors.red}', () {
      expect(findColorSwatch(Colors.red[200]!, swatches, true), Colors.red);
    });
    test(
        'Verify that color ${Colors.blue[50]!} in red, green, blue, grey '
        'swatches return ${Colors.blue}', () {
      expect(findColorSwatch(Colors.blue[50]!, swatches, true), Colors.blue);
    });
    test(
        'Verify that color ${Colors.green[900]!} in red, green, blue, grey '
        'swatches return ${Colors.blue}', () {
      expect(findColorSwatch(Colors.green[900]!, swatches, true), Colors.green);
    });
    test(
        'Verify that color ${Colors.purple[500]!} in red, green, blue, grey '
        'swatches return null', () {
      expect(findColorSwatch(Colors.purple[500]!, swatches, true), null);
    });
    test(
        'Verify that color ${Colors.grey[850]!} in red, green, blue, grey '
        'swatches return ${Colors.grey} '
        'with enable 850 set to true', () {
      expect(findColorSwatch(Colors.grey[850]!, swatches, true), Colors.grey);
    });
    test(
        'Verify that color ${Colors.grey[850]!} in red, green, blue, grey '
        'swatches return null '
        'with enable 850 set to false', () {
      expect(findColorSwatch(Colors.grey[850]!, swatches, false), null);
    });
  });

  // Test findColorSwatch.
  group('Test findColorInSelector', () {
    final List<ColorSwatch<Object>> swatches = <ColorSwatch<Object>>[
      Colors.red,
      Colors.blue,
      Colors.grey,
    ];
    final List<ColorSwatch<Object>> accSwatches = <ColorSwatch<Object>>[
      Colors.redAccent,
      Colors.greenAccent,
    ];

    final Map<ColorPickerType, List<ColorSwatch<Object>>> typeMap =
        <ColorPickerType, List<ColorSwatch<Object>>>{
      ColorPickerType.primary: swatches,
      ColorPickerType.accent: accSwatches,
    };

    final Map<ColorPickerType, bool> bothEnabled = <ColorPickerType, bool>{
      ColorPickerType.primary: true,
      ColorPickerType.accent: true,
    };

    test(
        'Test that color ${Colors.red[200]!} return primary when lookInShades '
        'is true in defined map and ColorPickerType primary is enabled.', () {
      expect(
          findColorInSelector(
              color: Colors.red[200]!,
              typeToSwatchMap: typeMap,
              pickersEnabled: bothEnabled,
              lookInShades: true,
              include850: true),
          equals(ColorPickerType.primary));
    });
    test(
        'Test that color ${Colors.blue[800]!} return primary when lookInShades '
        'is true in defined map and ColorPickerType primary is enabled.', () {
      expect(
          findColorInSelector(
              color: Colors.blue[800]!,
              typeToSwatchMap: typeMap,
              pickersEnabled: bothEnabled,
              lookInShades: true,
              include850: true),
          equals(ColorPickerType.primary));
    });
    test(
        'Test that color ${Colors.redAccent[100]!} returns accent when '
        'lookInShades is true in defined map and ColorPickerType accent '
        'is enabled.', () {
      expect(
          findColorInSelector(
              color: Colors.redAccent[100]!,
              typeToSwatchMap: typeMap,
              pickersEnabled: bothEnabled,
              lookInShades: true,
              include850: true),
          equals(ColorPickerType.accent));
    });
    test(
        'Test that color ${Colors.redAccent[100]!} returns primary when '
        'lookInShades is false in defined map and ColorPickerType accent '
        'is enabled.', () {
      expect(
          findColorInSelector(
              color: Colors.redAccent[100]!,
              typeToSwatchMap: typeMap,
              pickersEnabled: bothEnabled,
              lookInShades: false,
              include850: true),
          equals(ColorPickerType.primary));
    });
    test(
        'Test that color ${Colors.black} returns primary when '
        'lookInShades is true in defined map and ColorPickerType accent '
        'and primary are is enabled.', () {
      expect(
          findColorInSelector(
              color: Colors.black,
              typeToSwatchMap: typeMap,
              pickersEnabled: bothEnabled,
              lookInShades: true,
              include850: true),
          equals(ColorPickerType.primary));
    });
    final Map<ColorPickerType, bool> onlyPrimaryEnabled =
        <ColorPickerType, bool>{
      ColorPickerType.primary: true,
      ColorPickerType.accent: false,
    };

    test(
        'Test that color ${Colors.redAccent[100]!} returns primary when '
        'lookInShades is true in defined map and ColorPickerType accent '
        'is disabled.', () {
      expect(
          findColorInSelector(
              color: Colors.redAccent[100]!,
              typeToSwatchMap: typeMap,
              pickersEnabled: onlyPrimaryEnabled,
              lookInShades: true,
              include850: true),
          equals(ColorPickerType.primary));
    });
  });

  // Test isDesktop.
  group('Test getTonalColors', () {
    final List<Color> blueTonals = getTonalColors(Colors.blue[500]!, true);

    test('Verify that blue Tonal Palette index 0, tone 0 of is black', () {
      expect(blueTonals[0], equals(Colors.black));
    });
    test('Verify that blue Tonal Palette index 14, tone 100 of is white', () {
      expect(blueTonals[14], equals(Colors.white));
    });
    // But with Material color utilities v0.1.5 or later this is new result:
    test('Verify that blue TonalPalette index 6, tone 50 of is 0xff007bcc', () {
      expect(blueTonals[6], equals(const Color(0xff007bcc)));
    });
  });

  //****************************************************************************
  // FlexColorExtensions unit tests.
  //
  // Color.lighten function, reference value and edge cases tests.
  //****************************************************************************
  group('FCE2: WITH Color extension Color.lighten.', () {
    const Color col = Color(0xFF6200EE);
    const Color white = Color(0xFFFFFFFF);
    const Color black = Color(0xFF000000);
    // const Color? nullColor = null;
    test('FCE2.01: GIVEN lighten() EXPECT default lighten(10).', () {
      // ignore: avoid_redundant_argument_values
      expect(col.lighten(), col.lighten(10));
    });
    test('FCE2.02: GIVEN lighten(0) EXPECT no change.', () {
      expect(col.lighten(0), col);
    });
    test('FCE2.03: GIVEN lighten(<0) EXPECT no change.', () {
      expect(col.lighten(-1), col);
    });
    test('FCE2.04: GIVEN lighten(100) EXPECT White.', () {
      expect(col.lighten(100), white);
    });
    test('FCE2.05: GIVEN lighten(>100) EXPECT White.', () {
      expect(col.lighten(101), white);
    });
    test('FCE2.06: GIVEN $col.lighten(20) EXPECT Color(0xff9b55ff).', () {
      expect(col.lighten(20), const Color(0xff9b55ff));
    });
    test('FCE2.07: GIVEN $black.lighten(1) EXPECT Color(0xff9b55ff).', () {
      expect(black.lighten(1), const Color(0xff030303));
    });
  });

  //****************************************************************************
  // FlexColorExtensions unit tests.
  //
  // Color.darken function, reference value and edge cases tests.
  //****************************************************************************
  group('FCE3: WITH Color extension Color.darken ', () {
    const Color col = Color(0xFF6200EE);
    const Color white = Color(0xFFFFFFFF);
    const Color black = Color(0xFF000000);
    test('FCE3.01: GIVEN darken() EXPECT default darken(10).', () {
      // ignore: avoid_redundant_argument_values
      expect(col.darken(), col.darken(10));
    });
    test('FCE3.02: GIVEN darken(0) EXPECT no change.', () {
      expect(col.darken(0), col);
    });
    test('FCE3.03: GIVEN darken(<0) EXPECT no change.', () {
      expect(col.darken(-1), col);
    });
    test('FCE3.04: GIVEN darken(100) EXPECT black.', () {
      expect(col.darken(100), black);
    });
    test('FCE3.05: GIVEN darken(>100) EXPECT black.', () {
      expect(col.darken(101), black);
    });
    test('FCE3.06: GIVEN $col.darken(20) EXPECT Color(0xff380088).', () {
      expect(col.darken(20), const Color(0xff380088));
    });
    test('FCE3.08: GIVEN $white.darken(1) EXPECT Color(0xfffcfcfc).', () {
      expect(white.darken(1), const Color(0xfffcfcfc));
    });
  });
}
