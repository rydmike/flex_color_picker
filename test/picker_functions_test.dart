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
    final List<Color> blueTonals = getTonalColors(Colors.blue[500]!);

    test('Verify that blue Tonal Palette index 0, tone 0 of is black', () {
      expect(blueTonals[0], equals(Colors.black));
    });
    test('Verify that blue Tonal Palette index 12, tone 100 of is white', () {
      expect(blueTonals[12], equals(Colors.white));
    });
    test('Verify that blue TonalPalette index 5, tone 50 of is 0xff007ace', () {
      expect(blueTonals[5], equals(const Color(0xff007ace)));
    });
  });
}
