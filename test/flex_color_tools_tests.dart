import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

void main() {
  //
  // PRIMARY COLOR TESTS
  //
  // Test primaryColors values and orders in the list.
  group('Verify ColorTools.primaryColors values and order', () {
    test('Test index 0 is red', () {
      expect(ColorTools.primaryColors[0], Colors.red);
    });
    test('Test index 1 is pink', () {
      expect(ColorTools.primaryColors[1], Colors.pink);
    });
    test('Test index 2 is purple', () {
      expect(ColorTools.primaryColors[2], Colors.purple);
    });
    test('Test index 3 is deepPurple', () {
      expect(ColorTools.primaryColors[3], Colors.deepPurple);
    });
    test('Test index 4 is indigo', () {
      expect(ColorTools.primaryColors[4], Colors.indigo);
    });
    test('Test index 5 is red', () {
      expect(ColorTools.primaryColors[5], Colors.blue);
    });
    test('Test index 6 is lightBlue', () {
      expect(ColorTools.primaryColors[6], Colors.lightBlue);
    });
    test('Test index 7 is cyan', () {
      expect(ColorTools.primaryColors[7], Colors.cyan);
    });
    test('Test index 8 is teal', () {
      expect(ColorTools.primaryColors[8], Colors.teal);
    });
    test('Test index 9 is green', () {
      expect(ColorTools.primaryColors[9], Colors.green);
    });
    test('Test index 10 is lightGreen', () {
      expect(ColorTools.primaryColors[10], Colors.lightGreen);
    });
    test('Test index 11 is lime', () {
      expect(ColorTools.primaryColors[11], Colors.lime);
    });
    test('Test index 12 is yellow', () {
      expect(ColorTools.primaryColors[12], Colors.yellow);
    });
    test('Test index 13 is amber', () {
      expect(ColorTools.primaryColors[13], Colors.amber);
    });
    test('Test index 14 is orange', () {
      expect(ColorTools.primaryColors[14], Colors.orange);
    });
    test('Test index 15 is deepOrange', () {
      expect(ColorTools.primaryColors[15], Colors.deepOrange);
    });
    test('Test index 16 is brown', () {
      expect(ColorTools.primaryColors[16], Colors.brown);
    });
    test('Test index 17 is blueGrey', () {
      expect(ColorTools.primaryColors[17], Colors.blueGrey);
    });
    test('Test index 18 is grey', () {
      expect(ColorTools.primaryColors[18], Colors.grey);
    });
    test('Test index 19 throws range error, no more colors', () {
      expect(() => ColorTools.primaryColors[19], throwsRangeError);
    });
  });
  //
  // Test default English primary color names
  group('Verify ColorTools English names for primary colors', () {
    test('Test Red English name', () {
      expect(ColorTools.redName, 'Red');
    });
    test('Test Pink English name', () {
      expect(ColorTools.pinkName, 'Pink');
    });
    test('Test Purple English name', () {
      expect(ColorTools.purpleName, 'Purple');
    });
    test('Test Deep purple English name', () {
      expect(ColorTools.deepPurpleName, 'Deep purple');
    });
    test('Test Indigo English name', () {
      expect(ColorTools.indigoName, 'Indigo');
    });
    test('Test Blue English name', () {
      expect(ColorTools.blueName, 'Blue');
    });
    test('Test Light blue English name', () {
      expect(ColorTools.lightBlueName, 'Light blue');
    });
    test('Test Cyan English name', () {
      expect(ColorTools.cyanName, 'Cyan');
    });
    test('Test Teal English name', () {
      expect(ColorTools.tealName, 'Teal');
    });
    test('Test Green English name', () {
      expect(ColorTools.greenName, 'Green');
    });
    test('Test Light green English name', () {
      expect(ColorTools.lightGreenName, 'Light green');
    });
    test('Test Lime English name', () {
      expect(ColorTools.limeName, 'Lime');
    });
    test('Test Yellow English name', () {
      expect(ColorTools.yellowName, 'Yellow');
    });
    test('Test Amber English name', () {
      expect(ColorTools.amberName, 'Amber');
    });
    test('Test Orange English name', () {
      expect(ColorTools.orangeName, 'Orange');
    });
    test('Test Deep orange English name', () {
      expect(ColorTools.deepOrangeName, 'Deep orange');
    });
    test('Test Brown English name', () {
      expect(ColorTools.brownName, 'Brown');
    });
    test('Test Blue-grey English name', () {
      expect(ColorTools.blueGreyName, 'Blue-grey');
    });
    test('Test Grey English name', () {
      expect(ColorTools.greyName, 'Grey');
    });
  });
  //
  // Verify colors name maps equality
  group('Verify primary Colors to color names map content', () {
    test('Test primary colors to name map equality', () {
      expect(
          const MapEquality<ColorSwatch<Object>, String>().equals(
              ColorTools.primaryColorNames, <ColorSwatch<Object>, String>{
            Colors.red: 'Red',
            Colors.pink: 'Pink',
            Colors.purple: 'Purple',
            Colors.deepPurple: 'Deep purple',
            Colors.indigo: 'Indigo',
            Colors.blue: 'Blue',
            Colors.lightBlue: 'Light blue',
            Colors.cyan: 'Cyan',
            Colors.teal: 'Teal',
            Colors.green: 'Green',
            Colors.lightGreen: 'Light green',
            Colors.lime: 'Lime',
            Colors.yellow: 'Yellow',
            Colors.amber: 'Amber',
            Colors.orange: 'Orange',
            Colors.deepOrange: 'Deep orange',
            Colors.brown: 'Brown',
            Colors.blueGrey: 'Blue-grey',
            Colors.grey: 'Grey',
          }),
          true);
    });
  });
  // Test Color names for all primary colors
  group('Test colors names for all Material primary colors.', () {
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
    // The SDK excludes the grey color, we include it.
    final List<MaterialColor> primaries = <MaterialColor>[
      ...Colors.primaries,
      Colors.grey
    ];
    for (final ColorSwatch<Object> swatch in primaries) {
      for (final int i in index) {
        if (swatch[i] != null) {
          test(
              'ColorTools.materialName No Index '
              '${ColorTools.primaryColorNames[swatch]} '
              '[$i] (${swatch[i]}) returns '
              '${ColorTools.primaryColorNames[swatch]}', () {
            expect(ColorTools.materialName(swatch[i]!, withIndex: false),
                ColorTools.primaryColorNames[swatch]);
          });
          test(
              'ColorTools.materialName With Index '
              '${ColorTools.primaryColorNames[swatch]} '
              '[$i] (${swatch[i]}) returns '
              '${ColorTools.primaryColorNames[swatch]} [$i]}', () {
            expect(ColorTools.materialName(swatch[i]!),
                '${ColorTools.primaryColorNames[swatch]} [$i]');
          });
          test(
              'ColorTools.materialNameAndCode '
              '${ColorTools.primaryColorNames[swatch]} '
              '[$i] (${swatch[i]}) returns '
              '${ColorTools.materialNameAndCode(swatch[i]!)}', () {
            expect(
                ColorTools.materialNameAndCode(swatch[i]!),
                '${ColorTools.primaryColorNames[swatch]} [$i] '
                '(0x${swatch[i]!.value.toRadixString(16).toUpperCase()})');
          });
        }
      }
    }
  });
  //
  // Test that all SDK primary colors return true with isPrimaryColor
  group(
      'Test that all Colors.primaries return true with '
      'ColorTools.isPrimaryColor()', () {
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
    // The SDK excludes the grey color, we include it.
    final List<MaterialColor> primaries = <MaterialColor>[
      ...Colors.primaries,
      Colors.grey
    ];
    for (final ColorSwatch<Object> swatch in primaries) {
      for (final int i in index) {
        if (swatch[i] != null) {
          test('Verify that ${swatch[i]}[$i] is a primary color ', () {
            expect(ColorTools.isPrimaryColor(swatch[i]!), true);
          });
        }
      }
    }
  });
  // Test that all primary indexed colors find correct swatch color.
  group('Test that all primary index colors belongs to its swatch.', () {
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
    // The SDK excludes the grey color, we include it.
    final List<MaterialColor> primaries = <MaterialColor>[
      ...Colors.primaries,
      Colors.grey
    ];
    for (final ColorSwatch<Object> swatch in primaries) {
      for (final int i in index) {
        if (swatch[i] != null) {
          test('Color ${swatch[i]}[$i] returns primarySwatch($swatch)} ', () {
            expect(ColorTools.primarySwatch(swatch[i]!), swatch);
          });
        }
      }
    }
  });
  //
  // Reference test for create primary Swatch
  group('Verify reference value 0xFF132B80 for createPrimarySwatch', () {
    final MaterialColor refColor =
        ColorTools.createPrimarySwatch(const Color(0xFF132B80));
    test('Test swatch value is provided Color value 0xFF132B80', () {
      expect(refColor.value, 0xFF132B80);
    });
    test('Test swatch index [50] reference value 0xFF7D8AB9', () {
      expect(refColor[50], const Color(0xFF7D8AB9));
    });
    test('Test swatch index [100] reference value 0xFF7180B3', () {
      expect(refColor[100], const Color(0xFF7180B3));
    });
    test('Test swatch index [200] reference value 0xFF5A6BA6', () {
      expect(refColor[200], const Color(0xFF5A6BA6));
    });
    test('Test swatch index [300] reference value 0xFF425599', () {
      expect(refColor[300], const Color(0xFF425599));
    });
    test('Test swatch index [400] reference value 0xFF2B408D', () {
      expect(refColor[400], const Color(0xFF2B408D));
    });
    test('Test swatch index [500] reference value 0xFF132B80', () {
      expect(refColor[500], const Color(0xFF132B80));
    });
    test('Test swatch index [600] reference value 0xFF112773', () {
      expect(refColor[600], const Color(0xFF112773));
    });
    test('Test swatch index [700] reference value 0xFF0F2266', () {
      expect(refColor[700], const Color(0xFF0F2266));
    });
    test('Test swatch index [800] reference value 0xFF0D1E5A', () {
      expect(refColor[800], const Color(0xFF0D1E5A));
    });
    test('Test swatch index [900] reference value 0xFF0B1A4D', () {
      expect(refColor[900], const Color(0xFF0B1A4D));
    });
  });
  //
  // ACCENT COLOR TESTS
  //
  // Test accentColors values and orders in the list.
  group('Verify ColorTools.accentColors values and order', () {
    test('Test index 0 is redAccent', () {
      expect(ColorTools.accentColors[0], Colors.redAccent);
    });
    test('Test index 1 is pinkAccent', () {
      expect(ColorTools.accentColors[1], Colors.pinkAccent);
    });
    test('Test index 2 is purpleAccent', () {
      expect(ColorTools.accentColors[2], Colors.purpleAccent);
    });
    test('Test index 3 is deepPurpleAccent', () {
      expect(ColorTools.accentColors[3], Colors.deepPurpleAccent);
    });
    test('Test index 4 is indigoAccent', () {
      expect(ColorTools.accentColors[4], Colors.indigoAccent);
    });
    test('Test index 5 is blueAccent', () {
      expect(ColorTools.accentColors[5], Colors.blueAccent);
    });
    test('Test index 6 is lightBlueAccent', () {
      expect(ColorTools.accentColors[6], Colors.lightBlueAccent);
    });
    test('Test index 7 is cyanAccent', () {
      expect(ColorTools.accentColors[7], Colors.cyanAccent);
    });
    test('Test index 8 is tealAccent', () {
      expect(ColorTools.accentColors[8], Colors.tealAccent);
    });
    test('Test index 9 is greenAccent', () {
      expect(ColorTools.accentColors[9], Colors.greenAccent);
    });
    test('Test index 10 is lightGreenAccent', () {
      expect(ColorTools.accentColors[10], Colors.lightGreenAccent);
    });
    test('Test index 11 is limeAccent', () {
      expect(ColorTools.accentColors[11], Colors.limeAccent);
    });
    test('Test index 12 is yellowAccent', () {
      expect(ColorTools.accentColors[12], Colors.yellowAccent);
    });
    test('Test index 13 is amberAccent', () {
      expect(ColorTools.accentColors[13], Colors.amberAccent);
    });
    test('Test index 14 is orangeAccent', () {
      expect(ColorTools.accentColors[14], Colors.orangeAccent);
    });
    test('Test index 15 is deepOrangeAccent', () {
      expect(ColorTools.accentColors[15], Colors.deepOrangeAccent);
    });
    test('Test index 16 throws range error, no more colors!', () {
      expect(() => ColorTools.accentColors[16], throwsRangeError);
    });
  });
  //
  // Test default English accent color names
  group('Verify ColorTools English names for accent colors', () {
    test('Test Red accent English name', () {
      expect(ColorTools.redAccentName, 'Red accent');
    });
    test('Test Pink accent English name', () {
      expect(ColorTools.pinkAccentName, 'Pink accent');
    });
    test('Test Purple accent English name', () {
      expect(ColorTools.purpleAccentName, 'Purple accent');
    });
    test('Test Deep purple accent English name', () {
      expect(ColorTools.deepPurpleAccentName, 'Deep purple accent');
    });
    test('Test Indigo accent English name', () {
      expect(ColorTools.indigoAccentName, 'Indigo accent');
    });
    test('Test Blue accent English name', () {
      expect(ColorTools.blueAccentName, 'Blue accent');
    });
    test('Test Light accent blue English name', () {
      expect(ColorTools.lightBlueAccentName, 'Light blue accent');
    });
    test('Test Cyan accent English name', () {
      expect(ColorTools.cyanAccentName, 'Cyan accent');
    });
    test('Test Teal accent English name', () {
      expect(ColorTools.tealAccentName, 'Teal accent');
    });
    test('Test Green accent English name', () {
      expect(ColorTools.greenAccentName, 'Green accent');
    });
    test('Test Light green accent English name', () {
      expect(ColorTools.lightGreenAccentName, 'Light green accent');
    });
    test('Test Lime accent English name', () {
      expect(ColorTools.limeAccentName, 'Lime accent');
    });
    test('Test Yellow accent English name', () {
      expect(ColorTools.yellowAccentName, 'Yellow accent');
    });
    test('Test Amber accent English name', () {
      expect(ColorTools.amberAccentName, 'Amber accent');
    });
    test('Test Orange accent English name', () {
      expect(ColorTools.orangeAccentName, 'Orange accent');
    });
    test('Test Deep orange accent English name', () {
      expect(ColorTools.deepOrangeAccentName, 'Deep orange accent');
    });
  });
  //
  // Verify colors name maps equality
  group('Verify Accent Colors to color names map content', () {
    test('Test accent colors to name map equality', () {
      expect(
          const MapEquality<ColorSwatch<Object>, String>().equals(
              ColorTools.accentColorsNames, <ColorSwatch<Object>, String>{
            Colors.redAccent: 'Red accent',
            Colors.pinkAccent: 'Pink accent',
            Colors.purpleAccent: 'Purple accent',
            Colors.deepPurpleAccent: 'Deep purple accent',
            Colors.indigoAccent: 'Indigo accent',
            Colors.blueAccent: 'Blue accent',
            Colors.lightBlueAccent: 'Light blue accent',
            Colors.cyanAccent: 'Cyan accent',
            Colors.tealAccent: 'Teal accent',
            Colors.greenAccent: 'Green accent',
            Colors.lightGreenAccent: 'Light green accent',
            Colors.limeAccent: 'Lime accent',
            Colors.yellowAccent: 'Yellow accent',
            Colors.amberAccent: 'Amber accent',
            Colors.orangeAccent: 'Orange accent',
            Colors.deepOrangeAccent: 'Deep orange accent',
          }),
          true);
    });
  });
  // Test Color names for all accent colors
  group('Test colors names for all Material accent colors.', () {
    final List<int> index = <int>[
      100,
      200,
      400,
      700,
    ];
    for (final ColorSwatch<Object> swatch in Colors.accents) {
      for (final int i in index) {
        test(
            'ColorTools.materialName No Index '
            '${ColorTools.accentColorsNames[swatch]} '
            '[$i] (${swatch[i]}) returns '
            '${ColorTools.accentColorsNames[swatch]}', () {
          expect(ColorTools.materialName(swatch[i]!, withIndex: false),
              ColorTools.accentColorsNames[swatch]);
        });
        test(
            'ColorTools.materialName With Index '
            '${ColorTools.accentColorsNames[swatch]} '
            '[$i] (${swatch[i]}) returns '
            '${ColorTools.accentColorsNames[swatch]} [$i]}', () {
          expect(ColorTools.materialName(swatch[i]!),
              '${ColorTools.accentColorsNames[swatch]} [$i]');
        });
        test(
            'ColorTools.materialNameAndCode '
            '${ColorTools.accentColorsNames[swatch]} '
            '[$i] (${swatch[i]}) returns '
            '${ColorTools.materialNameAndCode(swatch[i]!)}', () {
          expect(
              ColorTools.materialNameAndCode(swatch[i]!),
              '${ColorTools.accentColorsNames[swatch]} [$i] '
              '(0x${swatch[i]!.value.toRadixString(16).toUpperCase()})');
        });
      }
    }
  });
  //
  // Test that all SDK accent colors return true with isAccentColor
  group(
      'Test that all Colors.accents return true with '
      'ColorTools.isAccentColor()', () {
    final List<int> index = <int>[
      100,
      200,
      400,
      700,
    ];
    for (final ColorSwatch<Object> swatch in Colors.accents) {
      for (final int i in index) {
        test('Verify that ${swatch[i]}[$i] is an accent color ', () {
          expect(ColorTools.isAccentColor(swatch[i]!), true);
        });
      }
    }
  });
  //
  // Test that all accent indexed colors find correct swatch color.
  group('Test that all accent index colors belongs to its swatch.', () {
    final List<int> index = <int>[
      100,
      200,
      400,
      700,
    ];
    for (final ColorSwatch<Object> swatch in Colors.accents) {
      for (final int i in index) {
        test('Color ${swatch[i]}[$i] returns accentSwatch($swatch)} ', () {
          expect(ColorTools.accentSwatch(swatch[i]!), swatch);
        });
      }
    }
  });
  //
  // Reference test for create accent Swatch
  group('Verify reference value 0xFF03DAC6 for createAccentSwatch', () {
    final MaterialAccentColor refColor =
        ColorTools.createAccentSwatch(const Color(0xFF03DAC6));
    test('Test swatch value is provided Color value 0xFF03DAC6', () {
      expect(refColor.value, 0xFF03DAC6);
    });
    test('Test swatch index [100] reference value 0xFF1CDECC', () {
      expect(refColor[100], const Color(0xFF1CDECC));
    });
    test('Test swatch index [200] reference value 0xFF03DAC6', () {
      expect(refColor[200], const Color(0xFF03DAC6));
    });
    test('Test swatch index [400] reference value 0xFF02AE9E', () {
      expect(refColor[400], const Color(0xFF02AE9E));
    });
    test('Test swatch index [700] reference value 0xFF026D63', () {
      expect(refColor[700], const Color(0xFF026D63));
    });
  });
  //
  // B&W COLOR TESTS
  //
  // Test the black color values
  group('Verify definitions for black and near black values', () {
    test('BlackShade [50] value is 0xFF121212', () {
      expect(ColorTools.blackShade[50], const Color(0xFF121212));
    });
    test('BlackShade [100] value is 0xFF111111', () {
      expect(ColorTools.blackShade[100], const Color(0xFF111111));
    });
    test('BlackShade [200] value is 0xFF101010', () {
      expect(ColorTools.blackShade[200], const Color(0xFF101010));
    });
    test('BlackShade [300] value is 0xFF0E0E0E', () {
      expect(ColorTools.blackShade[300], const Color(0xFF0E0E0E));
    });
    test('BlackShade [400] value is 0xFF0C0C0C', () {
      expect(ColorTools.blackShade[400], const Color(0xFF0C0C0C));
    });
    test('BlackShade [500] value is 0xFF0A0A0A', () {
      expect(ColorTools.blackShade[500], const Color(0xFF0A0A0A));
    });
    test('BlackShade [600] value is 0xFF080808', () {
      expect(ColorTools.blackShade[600], const Color(0xFF080808));
    });
    test('BlackShade [700] value is 0xFF050505', () {
      expect(ColorTools.blackShade[700], const Color(0xFF050505));
    });
    test('BlackShade [800] value is 0xFF030303', () {
      expect(ColorTools.blackShade[800], const Color(0xFF030303));
    });
    test('BlackShade [900] value is 0xFF000000', () {
      expect(ColorTools.blackShade[900], const Color(0xFF000000));
    });
  });
  //
  // Test the white color values
  group('Verify definitions for white and near white values', () {
    test('WhiteShade [50] value is 0xFFFFFFFF', () {
      expect(ColorTools.whiteShade[50], const Color(0xFFFFFFFF));
    });
    test('WhiteShade [100] value is 0xFFFEFEFE', () {
      expect(ColorTools.whiteShade[100], const Color(0xFFFEFEFE));
    });
    test('WhiteShade [200] value is 0xFFFDFDFD', () {
      expect(ColorTools.whiteShade[200], const Color(0xFFFDFDFD));
    });
    test('WhiteShade [300] value is 0xFFFCFCFC', () {
      expect(ColorTools.whiteShade[300], const Color(0xFFFCFCFC));
    });
    test('WhiteShade [400] value is 0xFFFBFBFB', () {
      expect(ColorTools.whiteShade[400], const Color(0xFFFBFBFB));
    });
    test('WhiteShade [500] value is 0xFFFAFAFB', () {
      expect(ColorTools.whiteShade[500], const Color(0xFFFAFAFB));
    });
    test('WhiteShade [600] value is 0xFFF9F9F9', () {
      expect(ColorTools.whiteShade[600], const Color(0xFFF9F9F9));
    });
    test('WhiteShade [700] value is 0xFFF8F8F8', () {
      expect(ColorTools.whiteShade[700], const Color(0xFFF8F8F8));
    });
    test('WhiteShade [800] value is 0xFFF7F7F7', () {
      expect(ColorTools.whiteShade[800], const Color(0xFFF7F7F7));
    });
    test('WhiteShade [900] value is 0xFFF6F6F6', () {
      expect(ColorTools.whiteShade[900], const Color(0xFFF6F6F6));
    });
  });
  // Test black and white shade values and orders in the list blackAndWhite.
  group('Verify ColorTools.blackAndWhite values and order', () {
    test('Test index 0 is blackShade', () {
      expect(ColorTools.blackAndWhite[0], ColorTools.blackShade);
    });
    test('Test index 1 is whiteShade', () {
      expect(ColorTools.blackAndWhite[1], ColorTools.whiteShade);
    });
    test('Test index 2 throws range error, no more colors!', () {
      expect(() => ColorTools.blackAndWhite[2], throwsRangeError);
    });
  });
  //
  // Test default English black and white shade names.
  group('Verify ColorTools English names for black and white shades.', () {
    test('Test Black shade English name', () {
      expect(ColorTools.blackShadeName, 'Black');
    });
    test('Test White shade English name', () {
      expect(ColorTools.whiteShadeName, 'White');
    });
  });
  //
  // Verify colors name maps equality
  group('Verify B&W Colors to color names map content', () {
    test('Test black and white to name map equality', () {
      expect(
          const MapEquality<ColorSwatch<Object>, String>().equals(
              ColorTools.blackAndWhiteNames, <ColorSwatch<Object>, String>{
            ColorTools.blackShade: 'Black',
            ColorTools.whiteShade: 'White',
          }),
          true);
    });
  });
  //
  // Test Color names for all B&W shade colors
  group('Test colors names for all B&W shade colors.', () {
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
      900
    ];
    for (final ColorSwatch<Object> swatch in ColorTools.blackAndWhite) {
      for (final int i in index) {
        test(
            'ColorTools.materialName No Index '
            '${ColorTools.blackAndWhiteNames[swatch]} '
            '[$i] (${swatch[i]}) returns '
            '${ColorTools.blackAndWhiteNames[swatch]}', () {
          expect(ColorTools.materialName(swatch[i]!, withIndex: false),
              ColorTools.blackAndWhiteNames[swatch]);
        });
        test(
            'ColorTools.materialName With Index '
            '${ColorTools.blackAndWhiteNames[swatch]} '
            '[$i] (${swatch[i]}) returns '
            '${ColorTools.blackAndWhiteNames[swatch]} [$i]}', () {
          expect(ColorTools.materialName(swatch[i]!),
              '${ColorTools.blackAndWhiteNames[swatch]} [$i]');
        });
        test(
            'ColorTools.materialNameAndCode '
            '${ColorTools.blackAndWhiteNames[swatch]} '
            '[$i] (${swatch[i]}) returns '
            '${ColorTools.materialNameAndCode(swatch[i]!)}', () {
          expect(
              ColorTools.materialNameAndCode(swatch[i]!),
              '${ColorTools.blackAndWhiteNames[swatch]} [$i] '
              '(0x${swatch[i]!.value.toRadixString(16).toUpperCase()})');
        });
      }
    }
  });
  //
  // Test that all black and whites shades return true with isBlackAndWhiteColor
  group(
      'Test that all ColorsTools.blackAndWhite return true with '
      'ColorTools.isBlackAndWhiteColor()', () {
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
      900
    ];
    for (final ColorSwatch<Object> swatch in ColorTools.blackAndWhite) {
      for (final int i in index) {
        test('Verify that ${swatch[i]} is a blackAndWhite color ', () {
          expect(ColorTools.isBlackAndWhiteColor(swatch[i]!), true);
        });
      }
    }
  });
  // Test that all indexed B&W color shades find correct swatch color.
  group('Test that all B&W index colors belongs to its swatch.', () {
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
      900
    ];
    for (final ColorSwatch<Object> swatch in ColorTools.blackAndWhite) {
      for (final int i in index) {
        test(
            'Color ${swatch[i]}[$i] returns '
            'blackAndWhiteSwatch($swatch)} ', () {
          expect(ColorTools.blackAndWhiteSwatch(swatch[i]!), swatch);
        });
      }
    }
  });
  //
  // CUSTOM COLOR TESTS
  //
  // Test that defined custom colors return true with isCustomColor
  group(
      'Test that defined custom color swatches return true with '
      'ColorTools.isCustomColor()', () {
    // Make a custom color swatch to name map for the reference values.
    final Map<ColorSwatch<Object>, String> refCustomColors =
        <ColorSwatch<Object>, String>{
      ColorTools.createPrimarySwatch(const Color(0xFF132B80)): 'RefPrimary',
      ColorTools.createAccentSwatch(const Color(0xFF03DAC6)): 'RefSecondary',
    };
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
      900
    ];
    for (final ColorSwatch<Object> swatch in refCustomColors.keys) {
      for (final int i in index) {
        if (swatch[i] != null) {
          test('Verify that ${swatch[i]}[$i] is a custom color ', () {
            expect(ColorTools.isCustomColor(swatch[i]!, refCustomColors), true);
          });
        }
      }
    }
  });
  // Test that all indexed custom color shades find correct swatch color.
  group('Test that all custom index colors belongs to its swatch.', () {
    // Make a custom color swatch to name map for the reference values.
    final Map<ColorSwatch<Object>, String> refCustomColors =
        <ColorSwatch<Object>, String>{
      ColorTools.createPrimarySwatch(const Color(0xFF132B80)): 'RefPrimary',
      ColorTools.createAccentSwatch(const Color(0xFF03DAC6)): 'RefSecondary',
    };
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
      900
    ];
    for (final ColorSwatch<Object> swatch in refCustomColors.keys) {
      for (final int i in index) {
        if (swatch[i] != null) {
          test(
              'Color ${swatch[i]}[$i] returns '
              'customSwatch($swatch)} ', () {
            expect(
                ColorTools.customSwatch(swatch[i]!, refCustomColors), swatch);
          });
        }
      }
    }
  });
  //
  // Verify colors name maps equality
  group('Verify Custom color swatch to color names map content', () {
    // Make a custom color swatch to name map for the reference values.
    final MaterialColor refPrimary =
        ColorTools.createPrimarySwatch(const Color(0xFF132B80));
    final MaterialAccentColor refAccent =
        ColorTools.createAccentSwatch(const Color(0xFF03DAC6));

    final Map<ColorSwatch<Object>, String> refCustomColors =
        <ColorSwatch<Object>, String>{
      refPrimary: 'RefPrimary',
      refAccent: 'RefSecondary'
    };
    test('Test custom colors swatch to name map equality', () {
      expect(
          const MapEquality<ColorSwatch<Object>, String>().equals(
              refCustomColors, <ColorSwatch<Object>, String>{
            refPrimary: 'RefPrimary',
            refAccent: 'RefSecondary'
          }),
          true);
    });
  });
  //
  // Test Color names for all primary colors
  group('Test color names for all defined Custom colors.', () {
    // Make a custom color swatch to name map for the reference values.
    final MaterialColor refPrimary =
        ColorTools.createPrimarySwatch(const Color(0xFF132B80));
    final MaterialAccentColor refAccent =
        ColorTools.createAccentSwatch(const Color(0xFF03DAC6));

    final Map<ColorSwatch<Object>, String> refCustomColors =
        <ColorSwatch<Object>, String>{
      refPrimary: 'RefPrimary',
      refAccent: 'RefSecondary'
    };
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
      900
    ];
    for (final ColorSwatch<Object> swatch in refCustomColors.keys) {
      for (final int i in index) {
        if (swatch[i] != null) {
          test(
              'ColorTools.materialName No Index '
              '${refCustomColors[swatch]} '
              '[$i] (${swatch[i]}) returns '
              '${refCustomColors[swatch]}', () {
            expect(
                ColorTools.materialName(swatch[i]!,
                    withIndex: false, colorSwatchNameMap: refCustomColors),
                refCustomColors[swatch]);
          });
          test(
              'ColorTools.materialName With Index '
              '${refCustomColors[swatch]} '
              '[$i] (${swatch[i]}) returns '
              '${refCustomColors[swatch]} [$i]}', () {
            expect(
                ColorTools.materialName(swatch[i]!,
                    colorSwatchNameMap: refCustomColors),
                '${refCustomColors[swatch]} [$i]');
          });
          test(
              'ColorTools.materialNameAndCode '
              '${refCustomColors[swatch]} '
              '[$i] (${swatch[i]}) returns '
              // ignore: lines_longer_than_80_chars
              '${ColorTools.materialNameAndCode(swatch[i]!, colorSwatchNameMap: refCustomColors)}',
              () {
            expect(
                ColorTools.materialNameAndCode(swatch[i]!,
                    colorSwatchNameMap: refCustomColors),
                '${refCustomColors[swatch]} [$i] '
                '(0x${swatch[i]!.value.toRadixString(16).toUpperCase()})');
          });
        }
      }
    }
  });
  //
  // Test name that color with exact color code
  group('Test nameThatColor function with exact color code match', () {
    for (final Color color in colorNames.keys) {
      test(
          'ColorTools.nameThatColor Color($color) '
          'has exact name ${colorNames[color]}', () {
        expect(ColorTools.nameThatColor(color), colorNames[color]);
      });
    }
  });
  //
  // Test name that color with RGB +1
  group('Test nameThatColor function with RGB value +1 for each RGB value', () {
    for (final Color color in colorNames.keys) {
      test(
          'ColorTools.nameThatColor Color(${colorPlusOneRGB(color)}) '
          '${ColorTools.nameThatColor(colorPlusOneRGB(color))} is same as '
          ' ${colorNames[color]}', () {
        expect(ColorTools.nameThatColor(colorPlusOneRGB(color)),
            colorNames[color]);
      });
    }
  });
}

// A custom color code modifier that changes the RGB value up a bit, but not
// enough to result in a different color
Color colorPlusOneRGB(Color color) {
  int red = color.red;
  if (red > 0x10 && red < 0xEF) red++;
  int green = color.green;
  if (green > 0x10 && green < 0xEF) green++;
  int blue = color.blue;
  if (blue > 0x11 && blue < 0xEE) blue++;
  return Color.fromARGB(0xFF, red, green, blue);
}

// A const list of 1566 named colors, this list matches the
// values in the private _ColorName class list in ColorTools.
final Map<Color, String> colorNames = <Color, String>{
  const Color(0xFF000000): 'Black',
  const Color(0xFF000080): 'Navy Blue',
  const Color(0xFF0000C8): 'Dark Blue',
  const Color(0xFF0000FF): 'Blue',
  const Color(0xFF000741): 'Stratos',
  const Color(0xFF001B1C): 'Swamp',
  const Color(0xFF002387): 'Resolution Blue',
  const Color(0xFF002900): 'Deep Fir',
  const Color(0xFF002E20): 'Burnham',
  const Color(0xFF002FA7): 'Klein Blue',
  const Color(0xFF003153): 'Prussian Blue',
  const Color(0xFF003366): 'Midnight Blue',
  const Color(0xFF003399): 'Smalt',
  const Color(0xFF003532): 'Deep Teal',
  const Color(0xFF003E40): 'Cyprus',
  const Color(0xFF004620): 'Kaitoke Green',
  const Color(0xFF0047AB): 'Cobalt',
  const Color(0xFF004816): 'Crusoe',
  const Color(0xFF004950): 'Sherpa Blue',
  const Color(0xFF0056A7): 'Endeavour',
  const Color(0xFF00581A): 'Camarone',
  const Color(0xFF0066CC): 'Science Blue',
  const Color(0xFF0066FF): 'Blue Ribbon',
  const Color(0xFF00755E): 'Tropical Rain Forest',
  const Color(0xFF0076A3): 'Allports',
  const Color(0xFF007BA7): 'Deep Cerulean',
  const Color(0xFF007EC7): 'Lochmara',
  const Color(0xFF007FFF): 'Azure Radiance',
  const Color(0xFF008080): 'Teal',
  const Color(0xFF0095B6): 'Bondi Blue',
  const Color(0xFF009DC4): 'Pacific Blue',
  const Color(0xFF00A693): 'Persian Green',
  const Color(0xFF00A86B): 'Jade',
  const Color(0xFF00CC99): 'Caribbean Green',
  const Color(0xFF00CCCC): "Robin's Egg Blue",
  const Color(0xFF00FF00): 'Green',
  const Color(0xFF00FF7F): 'Spring Green',
  const Color(0xFF00FFFF): 'Cyan Aqua',
  const Color(0xFF010D1A): 'Blue Charcoal',
  const Color(0xFF011635): 'Midnight',
  const Color(0xFF011D13): 'Holly',
  const Color(0xFF012731): 'Daintree',
  const Color(0xFF01361C): 'Cardin Green',
  const Color(0xFF01371A): 'County Green',
  const Color(0xFF013E62): 'Astronaut Blue',
  const Color(0xFF013F6A): 'Regal Blue',
  const Color(0xFF014B43): 'Aqua Deep',
  const Color(0xFF015E85): 'Orient',
  const Color(0xFF016162): 'Blue Stone',
  const Color(0xFF016D39): 'Fun Green',
  const Color(0xFF01796F): 'Pine Green',
  const Color(0xFF017987): 'Blue Lagoon',
  const Color(0xFF01826B): 'Deep Sea',
  const Color(0xFF01A368): 'Green Haze',
  const Color(0xFF022D15): 'English Holly',
  const Color(0xFF02402C): 'Sherwood Green',
  const Color(0xFF02478E): 'Congress Blue',
  const Color(0xFF024E46): 'Evening Sea',
  const Color(0xFF026395): 'Bahama Blue',
  const Color(0xFF02866F): 'Observatory',
  const Color(0xFF02A4D3): 'Cerulean',
  const Color(0xFF03163C): 'Tangaroa',
  const Color(0xFF032B52): 'Green Vogue',
  const Color(0xFF036A6E): 'Mosque',
  const Color(0xFF041004): 'Midnight Moss',
  const Color(0xFF041322): 'Black Pearl',
  const Color(0xFF042E4C): 'Blue Whale',
  const Color(0xFF044022): 'Zuccini',
  const Color(0xFF044259): 'Teal Blue',
  const Color(0xFF051040): 'Deep Cove',
  const Color(0xFF051657): 'Gulf Blue',
  const Color(0xFF055989): 'Venice Blue',
  const Color(0xFF056F57): 'Watercourse',
  const Color(0xFF062A78): 'Catalina Blue',
  const Color(0xFF063537): 'Tiber',
  const Color(0xFF069B81): 'Gossamer',
  const Color(0xFF06A189): 'Niagara',
  const Color(0xFF073A50): 'Tarawera',
  const Color(0xFF080110): 'Jaguar',
  const Color(0xFF081910): 'Black Bean',
  const Color(0xFF082567): 'Deep Sapphire',
  const Color(0xFF088370): 'Elf Green',
  const Color(0xFF08E8DE): 'Bright Turquoise',
  const Color(0xFF092256): 'Downriver',
  const Color(0xFF09230F): 'Palm Green',
  const Color(0xFF09255D): 'Madison',
  const Color(0xFF093624): 'Bottle Green',
  const Color(0xFF095859): 'Deep Sea Green',
  const Color(0xFF097F4B): 'Salem',
  const Color(0xFF0A001C): 'Black Russian',
  const Color(0xFF0A480D): 'Dark Fern',
  const Color(0xFF0A6906): 'Japanese Laurel',
  const Color(0xFF0A6F75): 'Atoll',
  const Color(0xFF0B0B0B): 'Cod Gray',
  const Color(0xFF0B0F08): 'Marshland',
  const Color(0xFF0B1107): 'Gordons Green',
  const Color(0xFF0B1304): 'Black Forest',
  const Color(0xFF0B6207): 'San Felix',
  const Color(0xFF0BDA51): 'Malachite',
  const Color(0xFF0C0B1D): 'Ebony',
  const Color(0xFF0C0D0F): 'Woodsmoke',
  const Color(0xFF0C1911): 'Racing Green',
  const Color(0xFF0C7A79): 'Surfie Green',
  const Color(0xFF0C8990): 'Blue Chill',
  const Color(0xFF0D0332): 'Black Rock',
  const Color(0xFF0D1117): 'Bunker',
  const Color(0xFF0D1C19): 'Aztec',
  const Color(0xFF0D2E1C): 'Bush',
  const Color(0xFF0E0E18): 'Cinder',
  const Color(0xFF0E2A30): 'Firefly',
  const Color(0xFF0F2D9E): 'Torea Bay',
  const Color(0xFF10121D): 'Vulcan',
  const Color(0xFF101405): 'Green Waterloo',
  const Color(0xFF105852): 'Eden',
  const Color(0xFF110C6C): 'Arapawa',
  const Color(0xFF120A8F): 'Ultramarine',
  const Color(0xFF123447): 'Elephant',
  const Color(0xFF126B40): 'Jewel',
  const Color(0xFF130000): 'Diesel',
  const Color(0xFF130A06): 'Asphalt',
  const Color(0xFF13264D): 'Blue Zodiac',
  const Color(0xFF134F19): 'Parsley',
  const Color(0xFF140600): 'Nero',
  const Color(0xFF1450AA): 'Tory Blue',
  const Color(0xFF151F4C): 'Bunting',
  const Color(0xFF1560BD): 'Denim',
  const Color(0xFF15736B): 'Genoa',
  const Color(0xFF161928): 'Mirage',
  const Color(0xFF161D10): 'Hunter Green',
  const Color(0xFF162A40): 'Big Stone',
  const Color(0xFF163222): 'Celtic',
  const Color(0xFF16322C): 'Timber Green',
  const Color(0xFF163531): 'Gable Green',
  const Color(0xFF171F04): 'Pine Tree',
  const Color(0xFF175579): 'Chathams Blue',
  const Color(0xFF182D09): 'Deep Forest Green',
  const Color(0xFF18587A): 'Blumine',
  const Color(0xFF19330E): 'Palm Leaf',
  const Color(0xFF193751): 'Nile Blue',
  const Color(0xFF1959A8): 'Fun Blue',
  const Color(0xFF1A1A68): 'Lucky Point',
  const Color(0xFF1AB385): 'Mountain Meadow',
  const Color(0xFF1B0245): 'Tolopea',
  const Color(0xFF1B1035): 'Haiti',
  const Color(0xFF1B127B): 'Deep Koamaru',
  const Color(0xFF1B1404): 'Acadia',
  const Color(0xFF1B2F11): 'Seaweed',
  const Color(0xFF1B3162): 'Biscay',
  const Color(0xFF1B659D): 'Matisse',
  const Color(0xFF1C1208): 'Crowshead',
  const Color(0xFF1C1E13): 'Rangoon Green',
  const Color(0xFF1C39BB): 'Persian Blue',
  const Color(0xFF1C402E): 'Everglade',
  const Color(0xFF1C7C7D): 'Elm',
  const Color(0xFF1D6142): 'Green Pea',
  const Color(0xFF1E0F04): 'Creole',
  const Color(0xFF1E1609): 'Karaka',
  const Color(0xFF1E1708): 'El Paso',
  const Color(0xFF1E385B): 'Cello',
  const Color(0xFF1E433C): 'Te Papa Green',
  const Color(0xFF1E90FF): 'Dodger Blue',
  const Color(0xFF1E9AB0): 'Eastern Blue',
  const Color(0xFF1F120F): 'Night Rider',
  const Color(0xFF1FC2C2): 'Java',
  const Color(0xFF20208D): 'Jacksons Purple',
  const Color(0xFF202E54): 'Cloud Burst',
  const Color(0xFF204852): 'Blue Dianne',
  const Color(0xFF211A0E): 'Eternity',
  const Color(0xFF220878): 'Deep Blue',
  const Color(0xFF228B22): 'Forest Green',
  const Color(0xFF233418): 'Mallard',
  const Color(0xFF240A40): 'Violet',
  const Color(0xFF240C02): 'Kilimanjaro',
  const Color(0xFF242A1D): 'Log Cabin',
  const Color(0xFF242E16): 'Black Olive',
  const Color(0xFF24500F): 'Green House',
  const Color(0xFF251607): 'Graphite',
  const Color(0xFF251706): 'Cannon Black',
  const Color(0xFF251F4F): 'Port Gore',
  const Color(0xFF25272C): 'Shark',
  const Color(0xFF25311C): 'Green Kelp',
  const Color(0xFF2596D1): 'Curious Blue',
  const Color(0xFF260368): 'Paua',
  const Color(0xFF26056A): 'Paris M',
  const Color(0xFF261105): 'Wood Bark',
  const Color(0xFF261414): 'Gondola',
  const Color(0xFF262335): 'Steel Gray',
  const Color(0xFF26283B): 'Ebony Clay',
  const Color(0xFF273A81): 'Bay of Many',
  const Color(0xFF27504B): 'Plantation',
  const Color(0xFF278A5B): 'Eucalyptus',
  const Color(0xFF281E15): 'Oil',
  const Color(0xFF283A77): 'Astronaut',
  const Color(0xFF286ACD): 'Mariner',
  const Color(0xFF290C5E): 'Violent Violet',
  const Color(0xFF292130): 'Bastille',
  const Color(0xFF292319): 'Zeus',
  const Color(0xFF292937): 'Charade',
  const Color(0xFF297B9A): 'Jelly Bean',
  const Color(0xFF29AB87): 'Jungle Green',
  const Color(0xFF2A0359): 'Cherry Pie',
  const Color(0xFF2A140E): 'Coffee Bean',
  const Color(0xFF2A2630): 'Baltic Sea',
  const Color(0xFF2A380B): 'Turtle Green',
  const Color(0xFF2A52BE): 'Cerulean Blue',
  const Color(0xFF2B0202): 'Sepia Black',
  const Color(0xFF2B194F): 'Valhalla',
  const Color(0xFF2B3228): 'Heavy Metal',
  const Color(0xFF2C0E8C): 'Blue Gem',
  const Color(0xFF2C1632): 'Revolver',
  const Color(0xFF2C2133): 'Bleached Cedar',
  const Color(0xFF2C8C84): 'Lochinvar',
  const Color(0xFF2D2510): 'Mikado',
  const Color(0xFF2D383A): 'Outer Space',
  const Color(0xFF2D569B): 'St Tropez',
  const Color(0xFF2E0329): 'Jacaranda',
  const Color(0xFF2E1905): 'Jacko Bean',
  const Color(0xFF2E3222): 'Rangitoto',
  const Color(0xFF2E3F62): 'Rhino',
  const Color(0xFF2E8B57): 'Sea Green',
  const Color(0xFF2EBFD4): 'Scooter',
  const Color(0xFF2F270E): 'Onion',
  const Color(0xFF2F3CB3): 'Governor Bay',
  const Color(0xFF2F519E): 'Sapphire',
  const Color(0xFF2F5A57): 'Spectra',
  const Color(0xFF2F6168): 'Casal',
  const Color(0xFF300529): 'Melanzane',
  const Color(0xFF301F1E): 'Cocoa Brown',
  const Color(0xFF302A0F): 'Woodrush',
  const Color(0xFF304B6A): 'San Juan',
  const Color(0xFF30D5C8): 'Turquoise',
  const Color(0xFF311C17): 'Eclipse',
  const Color(0xFF314459): 'Pickled Bluewood',
  const Color(0xFF315BA1): 'Azure',
  const Color(0xFF31728D): 'Calypso',
  const Color(0xFF317D82): 'Paradiso',
  const Color(0xFF32127A): 'Persian Indigo',
  const Color(0xFF32293A): 'Blackcurrant',
  const Color(0xFF323232): 'Mine Shaft',
  const Color(0xFF325D52): 'Stromboli',
  const Color(0xFF327C14): 'Bilbao',
  const Color(0xFF327DA0): 'Astral',
  const Color(0xFF33036B): 'Christalle',
  const Color(0xFF33292F): 'Thunder',
  const Color(0xFF33CC99): 'Shamrock',
  const Color(0xFF341515): 'Tamarind',
  const Color(0xFF350036): 'Mardi Gras',
  const Color(0xFF350E42): 'Valentino',
  const Color(0xFF350E57): 'Jagger',
  const Color(0xFF353542): 'Tuna',
  const Color(0xFF354E8C): 'Chambray',
  const Color(0xFF363050): 'Martinique',
  const Color(0xFF363534): 'Tuatara',
  const Color(0xFF363C0D): 'Waiouru',
  const Color(0xFF36747D): 'Ming',
  const Color(0xFF368716): 'La Palma',
  const Color(0xFF370202): 'Chocolate',
  const Color(0xFF371D09): 'Clinker',
  const Color(0xFF37290E): 'Brown Tumbleweed',
  const Color(0xFF373021): 'Birch',
  const Color(0xFF377475): 'Oracle',
  const Color(0xFF380474): 'Blue Diamond',
  const Color(0xFF381A51): 'Grape',
  const Color(0xFF383533): 'Dune',
  const Color(0xFF384555): 'Oxford Blue',
  const Color(0xFF384910): 'Clover',
  const Color(0xFF394851): 'Limed Spruce',
  const Color(0xFF396413): 'Dell',
  const Color(0xFF3A0020): 'Toledo',
  const Color(0xFF3A2010): 'Sambuca',
  const Color(0xFF3A2A6A): 'Jacarta',
  const Color(0xFF3A686C): 'William',
  const Color(0xFF3A6A47): 'Killarney',
  const Color(0xFF3AB09E): 'Keppel',
  const Color(0xFF3B000B): 'Temptress',
  const Color(0xFF3B0910): 'Aubergine',
  const Color(0xFF3B1F1F): 'Jon',
  const Color(0xFF3B2820): 'Treehouse',
  const Color(0xFF3B7A57): 'Amazon',
  const Color(0xFF3B91B4): 'Boston Blue',
  const Color(0xFF3C0878): 'Windsor',
  const Color(0xFF3C1206): 'Rebel',
  const Color(0xFF3C1F76): 'Meteorite',
  const Color(0xFF3C2005): 'Dark Ebony',
  const Color(0xFF3C3910): 'Camouflage',
  const Color(0xFF3C4151): 'Bright Gray',
  const Color(0xFF3C4443): 'Cape Cod',
  const Color(0xFF3C493A): 'Lunar Green',
  const Color(0xFF3D0C02): 'Bean  ',
  const Color(0xFF3D2B1F): 'Bistre',
  const Color(0xFF3D7D52): 'Goblin',
  const Color(0xFF3E0480): 'Kingfisher Daisy',
  const Color(0xFF3E1C14): 'Cedar',
  const Color(0xFF3E2B23): 'English Walnut',
  const Color(0xFF3E2C1C): 'Black Marlin',
  const Color(0xFF3E3A44): 'Ship Gray',
  const Color(0xFF3EABBF): 'Pelorous',
  const Color(0xFF3F2109): 'Bronze',
  const Color(0xFF3F2500): 'Cola',
  const Color(0xFF3F3002): 'Madras',
  const Color(0xFF3F307F): 'Minsk',
  const Color(0xFF3F4C3A): 'Cabbage Pont',
  const Color(0xFF3F583B): 'Tom Thumb',
  const Color(0xFF3F5D53): 'Mineral Green',
  const Color(0xFF3FC1AA): 'Puerto Rico',
  const Color(0xFF3FFF00): 'Harlequin',
  const Color(0xFF401801): 'Brown Pod',
  const Color(0xFF40291D): 'Cork',
  const Color(0xFF403B38): 'Masala',
  const Color(0xFF403D19): 'Thatch Green',
  const Color(0xFF405169): 'Fjord',
  const Color(0xFF40826D): 'Viridian',
  const Color(0xFF40A860): 'Chateau Green',
  const Color(0xFF410056): 'Ripe Plum',
  const Color(0xFF411E10): 'Paco',
  const Color(0xFF412010): 'Deep Oak',
  const Color(0xFF413C37): 'Merlin',
  const Color(0xFF414257): 'Gun Powder',
  const Color(0xFF414C7D): 'East Bay',
  const Color(0xFF4169E1): 'Royal Blue',
  const Color(0xFF41AA78): 'Ocean Green',
  const Color(0xFF420303): 'Burnt Maroon',
  const Color(0xFF423921): 'Lisbon Brown',
  const Color(0xFF427977): 'Faded Jade',
  const Color(0xFF431560): 'Scarlet Gum',
  const Color(0xFF433120): 'Iroko',
  const Color(0xFF433E37): 'Armadillo',
  const Color(0xFF434C59): 'River Bed',
  const Color(0xFF436A0D): 'Green Leaf',
  const Color(0xFF44012D): 'Barossa',
  const Color(0xFF441D00): 'Morocco Brown',
  const Color(0xFF444954): 'Mako',
  const Color(0xFF454936): 'Kelp',
  const Color(0xFF456CAC): 'San Marino',
  const Color(0xFF45B1E8): 'Picton Blue',
  const Color(0xFF460B41): 'Loulou',
  const Color(0xFF462425): 'Crater Brown',
  const Color(0xFF465945): 'Gray Asparagus',
  const Color(0xFF4682B4): 'Steel Blue',
  const Color(0xFF480404): 'Rustic Red',
  const Color(0xFF480607): 'Bulgarian Rose',
  const Color(0xFF480656): 'Clairvoyant',
  const Color(0xFF481C1C): 'Cocoa Bean',
  const Color(0xFF483131): 'Woody Brown',
  const Color(0xFF483C32): 'Taupe',
  const Color(0xFF49170C): 'Van Cleef',
  const Color(0xFF492615): 'Brown Derby',
  const Color(0xFF49371B): 'Metallic Bronze',
  const Color(0xFF495400): 'Verdun Green',
  const Color(0xFF496679): 'Blue Bayoux',
  const Color(0xFF497183): 'Bismark',
  const Color(0xFF4A2A04): 'Bracken',
  const Color(0xFF4A3004): 'Deep Bronze',
  const Color(0xFF4A3C30): 'Mondo',
  const Color(0xFF4A4244): 'Tundora',
  const Color(0xFF4A444B): 'Gravel',
  const Color(0xFF4A4E5A): 'Trout',
  const Color(0xFF4B0082): 'Pigment Indigo',
  const Color(0xFF4B5D52): 'Nandor',
  const Color(0xFF4C3024): 'Saddle',
  const Color(0xFF4C4F56): 'Abbey',
  const Color(0xFF4D0135): 'Blackberry',
  const Color(0xFF4D0A18): 'Cab Sav',
  const Color(0xFF4D1E01): 'Indian Tan',
  const Color(0xFF4D282D): 'Cowboy',
  const Color(0xFF4D282E): 'Livid Brown',
  const Color(0xFF4D3833): 'Rock',
  const Color(0xFF4D3D14): 'Punga',
  const Color(0xFF4D400F): 'Bronzetone',
  const Color(0xFF4D5328): 'Woodland',
  const Color(0xFF4E0606): 'Mahogany',
  const Color(0xFF4E2A5A): 'Bossanova',
  const Color(0xFF4E3B41): 'Matterhorn',
  const Color(0xFF4E420C): 'Bronze Olive',
  const Color(0xFF4E4562): 'Mulled Wine',
  const Color(0xFF4E6649): 'Axolotl',
  const Color(0xFF4E7F9E): 'Wedgewood',
  const Color(0xFF4EABD1): 'Shakespeare',
  const Color(0xFF4F1C70): 'Honey Flower',
  const Color(0xFF4F2398): 'Daisy Bush',
  const Color(0xFF4F69C6): 'Indigo',
  const Color(0xFF4F7942): 'Fern Green',
  const Color(0xFF4F9D5D): 'Fruit Salad',
  const Color(0xFF4FA83D): 'Apple',
  const Color(0xFF504351): 'Mortar',
  const Color(0xFF507096): 'Kashmir Blue',
  const Color(0xFF507672): 'Cutty Sark',
  const Color(0xFF50C878): 'Emerald',
  const Color(0xFF514649): 'Emperor',
  const Color(0xFF516E3D): 'Chalet Green',
  const Color(0xFF517C66): 'Como',
  const Color(0xFF51808F): 'Smalt Blue',
  const Color(0xFF52001F): 'Castro',
  const Color(0xFF520C17): 'Maroon Oak',
  const Color(0xFF523C94): 'Gigas',
  const Color(0xFF533455): 'Voodoo',
  const Color(0xFF534491): 'Victoria',
  const Color(0xFF53824B): 'Hippie Green',
  const Color(0xFF541012): 'Heath',
  const Color(0xFF544333): 'Judge Gray',
  const Color(0xFF54534D): 'Fuscous Gray',
  const Color(0xFF549019): 'Vida Loca',
  const Color(0xFF55280C): 'Cioccolato',
  const Color(0xFF555B10): 'Saratoga',
  const Color(0xFF556D56): 'Finlandia',
  const Color(0xFF5590D9): 'Havelock Blue',
  const Color(0xFF56B4BE): 'Fountain Blue',
  const Color(0xFF578363): 'Spring Leaves',
  const Color(0xFF583401): 'Saddle Brown',
  const Color(0xFF585562): 'Scarpa Flow',
  const Color(0xFF587156): 'Cactus',
  const Color(0xFF589AAF): 'Hippie Blue',
  const Color(0xFF591D35): 'Wine Berry',
  const Color(0xFF592804): 'Brown Bramble',
  const Color(0xFF593737): 'Congo Brown',
  const Color(0xFF594433): 'Millbrook',
  const Color(0xFF5A6E9C): 'Waikawa Gray',
  const Color(0xFF5A87A0): 'Horizon',
  const Color(0xFF5B3013): 'Jambalaya',
  const Color(0xFF5C0120): 'Bordeaux',
  const Color(0xFF5C0536): 'Mulberry Wood',
  const Color(0xFF5C2E01): 'Carnaby Tan',
  const Color(0xFF5C5D75): 'Comet',
  const Color(0xFF5D1E0F): 'Redwood',
  const Color(0xFF5D4C51): 'Don Juan',
  const Color(0xFF5D5C58): 'Chicago',
  const Color(0xFF5D5E37): 'Verdigris',
  const Color(0xFF5D7747): 'Dingley',
  const Color(0xFF5DA19F): 'Breaker Bay',
  const Color(0xFF5E483E): 'Kabul',
  const Color(0xFF5E5D3B): 'Hemlock',
  const Color(0xFF5F3D26): 'Irish Coffee',
  const Color(0xFF5F5F6E): 'Mid Gray',
  const Color(0xFF5F6672): 'Shuttle Gray',
  const Color(0xFF5FA777): 'Aqua Forest',
  const Color(0xFF5FB3AC): 'Tradewind',
  const Color(0xFF604913): 'Horses Neck',
  const Color(0xFF605B73): 'Smoky',
  const Color(0xFF606E68): 'Corduroy',
  const Color(0xFF6093D1): 'Danube',
  const Color(0xFF612718): 'Espresso',
  const Color(0xFF614051): 'Eggplant',
  const Color(0xFF615D30): 'Costa Del Sol',
  const Color(0xFF61845F): 'Glade Green',
  const Color(0xFF622F30): 'Buccaneer',
  const Color(0xFF623F2D): 'Quincy',
  const Color(0xFF624E9A): 'Butterfly Bush',
  const Color(0xFF625119): 'West Coast',
  const Color(0xFF626649): 'Finch',
  const Color(0xFF639A8F): 'Patina',
  const Color(0xFF63B76C): 'Fern',
  const Color(0xFF6456B7): 'Blue Violet',
  const Color(0xFF646077): 'Dolphin',
  const Color(0xFF646463): 'Storm Dust',
  const Color(0xFF646A54): 'Siam',
  const Color(0xFF646E75): 'Nevada',
  const Color(0xFF6495ED): 'Cornflower Blue',
  const Color(0xFF64CCDB): 'Viking',
  const Color(0xFF65000B): 'Rosewood',
  const Color(0xFF651A14): 'Cherrywood',
  const Color(0xFF652DC1): 'Purple Heart',
  const Color(0xFF657220): 'Fern Frond',
  const Color(0xFF65745D): 'Willow Grove',
  const Color(0xFF65869F): 'Hoki',
  const Color(0xFF660045): 'Pompadour',
  const Color(0xFF660099): 'Purple',
  const Color(0xFF66023C): 'Tyrian Purple',
  const Color(0xFF661010): 'Dark Tan',
  const Color(0xFF66B58F): 'Silver Tree',
  const Color(0xFF66FF00): 'Bright Green',
  const Color(0xFF66FF66): "Screamin' Green",
  const Color(0xFF67032D): 'Black Rose',
  const Color(0xFF675FA6): 'Scampi',
  const Color(0xFF676662): 'Ironside Gray',
  const Color(0xFF678975): 'Viridian Green',
  const Color(0xFF67A712): 'Christi',
  const Color(0xFF683600): 'Nutmeg Wood Finish',
  const Color(0xFF685558): 'Zambezi',
  const Color(0xFF685E6E): 'Salt Box',
  const Color(0xFF692545): 'Tawny Port',
  const Color(0xFF692D54): 'Finn',
  const Color(0xFF695F62): 'Scorpion',
  const Color(0xFF697E9A): 'Lynch',
  const Color(0xFF6A442E): 'Spice',
  const Color(0xFF6A5D1B): 'Himalaya',
  const Color(0xFF6A6051): 'Soya Bean',
  const Color(0xFF6B2A14): 'Hairy Heath',
  const Color(0xFF6B3FA0): 'Royal Purple',
  const Color(0xFF6B4E31): 'Shingle Fawn',
  const Color(0xFF6B5755): 'Dorado',
  const Color(0xFF6B8BA2): 'Bermuda Gray',
  const Color(0xFF6B8E23): 'Olive Drab',
  const Color(0xFF6C3082): 'Eminence',
  const Color(0xFF6CDAE7): 'Turquoise Blue',
  const Color(0xFF6D0101): 'Lonestar',
  const Color(0xFF6D5E54): 'Pine Cone',
  const Color(0xFF6D6C6C): 'Dove Gray',
  const Color(0xFF6D9292): 'Juniper',
  const Color(0xFF6D92A1): 'Gothic',
  const Color(0xFF6E0902): 'Red Oxide',
  const Color(0xFF6E1D14): 'Moccaccino',
  const Color(0xFF6E4826): 'Pickled Bean',
  const Color(0xFF6E4B26): 'Dallas',
  const Color(0xFF6E6D57): 'Kokoda',
  const Color(0xFF6E7783): 'Pale Sky',
  const Color(0xFF6F440C): 'Cafe Royale',
  const Color(0xFF6F6A61): 'Flint',
  const Color(0xFF6F8E63): 'Highland',
  const Color(0xFF6F9D02): 'Limeade',
  const Color(0xFF6FD0C5): 'Downy',
  const Color(0xFF701C1C): 'Persian Plum',
  const Color(0xFF704214): 'Sepia',
  const Color(0xFF704A07): 'Antique Bronze',
  const Color(0xFF704F50): 'Ferra',
  const Color(0xFF706555): 'Coffee',
  const Color(0xFF708090): 'Slate Gray',
  const Color(0xFF711A00): 'Cedar Wood Finish',
  const Color(0xFF71291D): 'Metallic Copper',
  const Color(0xFF714693): 'Affair',
  const Color(0xFF714AB2): 'Studio',
  const Color(0xFF715D47): 'Tobacco Brown',
  const Color(0xFF716338): 'Yellow Metal',
  const Color(0xFF716B56): 'Peat',
  const Color(0xFF716E10): 'Olivetone',
  const Color(0xFF717486): 'Storm Gray',
  const Color(0xFF718080): 'Sirocco',
  const Color(0xFF71D9E2): 'Aquamarine Blue',
  const Color(0xFF72010F): 'Venetian Red',
  const Color(0xFF724A2F): 'Old Copper',
  const Color(0xFF726D4E): 'Go Ben',
  const Color(0xFF727B89): 'Raven',
  const Color(0xFF731E8F): 'Seance',
  const Color(0xFF734A12): 'Raw Umber',
  const Color(0xFF736C9F): 'Kimberly',
  const Color(0xFF736D58): 'Crocodile',
  const Color(0xFF737829): 'Crete',
  const Color(0xFF738678): 'Xanadu',
  const Color(0xFF74640D): 'Spicy Mustard',
  const Color(0xFF747D63): 'Limed Ash',
  const Color(0xFF747D83): 'Rolling Stone',
  const Color(0xFF748881): 'Blue Smoke',
  const Color(0xFF749378): 'Laurel',
  const Color(0xFF74C365): 'Mantis',
  const Color(0xFF755A57): 'Russett',
  const Color(0xFF7563A8): 'Deluge',
  const Color(0xFF76395D): 'Cosmic',
  const Color(0xFF7666C6): 'Blue Marguerite',
  const Color(0xFF76BD17): 'Lima',
  const Color(0xFF76D7EA): 'Sky Blue',
  const Color(0xFF770F05): 'Dark Burgundy',
  const Color(0xFF771F1F): 'Crown of Thorns',
  const Color(0xFF773F1A): 'Walnut',
  const Color(0xFF776F61): 'Pablo',
  const Color(0xFF778120): 'Pacifika',
  const Color(0xFF779E86): 'Oxley',
  const Color(0xFF77DD77): 'Pastel Green',
  const Color(0xFF780109): 'Japanese Maple',
  const Color(0xFF782D19): 'Mocha',
  const Color(0xFF782F16): 'Peanut',
  const Color(0xFF78866B): 'Camouflage Green',
  const Color(0xFF788A25): 'Wasabi',
  const Color(0xFF788BBA): 'Ship Cove',
  const Color(0xFF78A39C): 'Sea Nymph',
  const Color(0xFF795D4C): 'Roman Coffee',
  const Color(0xFF796878): 'Old Lavender',
  const Color(0xFF796989): 'Rum',
  const Color(0xFF796A78): 'Fedora',
  const Color(0xFF796D62): 'Sandstone',
  const Color(0xFF79DEEC): 'Spray',
  const Color(0xFF7A013A): 'Siren',
  const Color(0xFF7A58C1): 'Fuchsia Blue',
  const Color(0xFF7A7A7A): 'Boulder',
  const Color(0xFF7A89B8): 'Wild Blue Yonder',
  const Color(0xFF7AC488): 'De York',
  const Color(0xFF7B3801): 'Red Beech',
  const Color(0xFF7B3F00): 'Cinnamon',
  const Color(0xFF7B6608): 'Yukon Gold',
  const Color(0xFF7B7874): 'Tapa',
  const Color(0xFF7B7C94): 'Waterloo ',
  const Color(0xFF7B8265): 'Flax Smoke',
  const Color(0xFF7B9F80): 'Amulet',
  const Color(0xFF7BA05B): 'Asparagus',
  const Color(0xFF7C1C05): 'Kenyan Copper',
  const Color(0xFF7C7631): 'Pesto',
  const Color(0xFF7C778A): 'Topaz',
  const Color(0xFF7C7B7A): 'Concord',
  const Color(0xFF7C7B82): 'Jumbo',
  const Color(0xFF7C881A): 'Trendy Green',
  const Color(0xFF7CA1A6): 'Gumbo',
  const Color(0xFF7CB0A1): 'Acapulco',
  const Color(0xFF7CB7BB): 'Neptune',
  const Color(0xFF7D2C14): 'Pueblo',
  const Color(0xFF7DA98D): 'Bay Leaf',
  const Color(0xFF7DC8F7): 'Malibu',
  const Color(0xFF7DD8C6): 'Bermuda',
  const Color(0xFF7E3A15): 'Copper Canyon',
  const Color(0xFF7F1734): 'Claret',
  const Color(0xFF7F3A02): 'Peru Tan',
  const Color(0xFF7F626D): 'Falcon',
  const Color(0xFF7F7589): 'Mobster',
  const Color(0xFF7F76D3): 'Moody Blue',
  const Color(0xFF7FFF00): 'Chartreuse',
  const Color(0xFF7FFFD4): 'Aquamarine',
  const Color(0xFF800000): 'Maroon',
  const Color(0xFF800B47): 'Rose Bud Cherry',
  const Color(0xFF801818): 'Falu Red',
  const Color(0xFF80341F): 'Red Robin',
  const Color(0xFF803790): 'Vivid Violet',
  const Color(0xFF80461B): 'Russet',
  const Color(0xFF807E79): 'Friar Gray',
  const Color(0xFF808000): 'Olive',
  const Color(0xFF808080): 'Gray',
  const Color(0xFF80B3AE): 'Gulf Stream',
  const Color(0xFF80B3C4): 'Glacier',
  const Color(0xFF80CCEA): 'Seagull',
  const Color(0xFF81422C): 'Nutmeg',
  const Color(0xFF816E71): 'Spicy Pink',
  const Color(0xFF817377): 'Empress',
  const Color(0xFF819885): 'Spanish Green',
  const Color(0xFF826F65): 'Sand Dune',
  const Color(0xFF828685): 'Gunsmoke',
  const Color(0xFF828F72): 'Battleship Gray',
  const Color(0xFF831923): 'Merlot',
  const Color(0xFF837050): 'Shadow',
  const Color(0xFF83AA5D): 'Chelsea Cucumber',
  const Color(0xFF83D0C6): 'Monte Carlo',
  const Color(0xFF843179): 'Plum',
  const Color(0xFF84A0A0): 'Granny Smith',
  const Color(0xFF8581D9): 'Chetwode Blue',
  const Color(0xFF858470): 'Bandicoot',
  const Color(0xFF859FAF): 'Bali Hai',
  const Color(0xFF85C4CC): 'Half Baked',
  const Color(0xFF860111): 'Red Devil',
  const Color(0xFF863C3C): 'Lotus',
  const Color(0xFF86483C): 'Ironstone',
  const Color(0xFF864D1E): 'Bull Shot',
  const Color(0xFF86560A): 'Rusty Nail',
  const Color(0xFF868974): 'Bitter',
  const Color(0xFF86949F): 'Regent Gray',
  const Color(0xFF871550): 'Disco',
  const Color(0xFF87756E): 'Americano',
  const Color(0xFF877C7B): 'Hurricane',
  const Color(0xFF878D91): 'Oslo Gray',
  const Color(0xFF87AB39): 'Sushi',
  const Color(0xFF885342): 'Spicy Mix',
  const Color(0xFF886221): 'Kumera',
  const Color(0xFF888387): 'Suva Gray',
  const Color(0xFF888D65): 'Avocado',
  const Color(0xFF893456): 'Camelot',
  const Color(0xFF893843): 'Solid Pink',
  const Color(0xFF894367): 'Cannon Pink',
  const Color(0xFF897D6D): 'Makara',
  const Color(0xFF8A3324): 'Burnt Umber',
  const Color(0xFF8A73D6): 'True V',
  const Color(0xFF8A8360): 'Clay Creek',
  const Color(0xFF8A8389): 'Monsoon',
  const Color(0xFF8A8F8A): 'Stack',
  const Color(0xFF8AB9F1): 'Jordy Blue',
  const Color(0xFF8B00FF): 'Electric Violet',
  const Color(0xFF8B0723): 'Monarch',
  const Color(0xFF8B6B0B): 'Corn Harvest',
  const Color(0xFF8B8470): 'Olive Haze',
  const Color(0xFF8B847E): 'Schooner',
  const Color(0xFF8B8680): 'Natural Gray',
  const Color(0xFF8B9C90): 'Mantle',
  const Color(0xFF8B9FEE): 'Portage',
  const Color(0xFF8BA690): 'Envy',
  const Color(0xFF8BA9A5): 'Cascade',
  const Color(0xFF8BE6D8): 'Riptide',
  const Color(0xFF8C055E): 'Cardinal Pink',
  const Color(0xFF8C472F): 'Mule Fawn',
  const Color(0xFF8C5738): 'Potters Clay',
  const Color(0xFF8C6495): 'Trendy Pink',
  const Color(0xFF8D0226): 'Paprika',
  const Color(0xFF8D3D38): 'Sanguine Brown',
  const Color(0xFF8D3F3F): 'Tosca',
  const Color(0xFF8D7662): 'Cement',
  const Color(0xFF8D8974): 'Granite Green',
  const Color(0xFF8D90A1): 'Manatee',
  const Color(0xFF8DA8CC): 'Polo Blue',
  const Color(0xFF8E0000): 'Red Berry',
  const Color(0xFF8E4D1E): 'Rope',
  const Color(0xFF8E6F70): 'Opium',
  const Color(0xFF8E775E): 'Domino',
  const Color(0xFF8E8190): 'Mamba',
  const Color(0xFF8EABC1): 'Nepal',
  const Color(0xFF8F021C): 'Pohutukawa',
  const Color(0xFF8F3E33): 'El Salva',
  const Color(0xFF8F4B0E): 'Korma',
  const Color(0xFF8F8176): 'Squirrel',
  const Color(0xFF8FD6B4): 'Vista Blue',
  const Color(0xFF900020): 'Burgundy',
  const Color(0xFF901E1E): 'Old Brick',
  const Color(0xFF907874): 'Hemp',
  const Color(0xFF907B71): 'Almond Frost',
  const Color(0xFF908D39): 'Sycamore',
  const Color(0xFF92000A): 'Sangria',
  const Color(0xFF924321): 'Cumin',
  const Color(0xFF926F5B): 'Beaver',
  const Color(0xFF928573): 'Stonewall',
  const Color(0xFF928590): 'Venus',
  const Color(0xFF9370DB): 'Medium Purple',
  const Color(0xFF93CCEA): 'Cornflower',
  const Color(0xFF93DFB8): 'Algae Green',
  const Color(0xFF944747): 'Copper Rust',
  const Color(0xFF948771): 'Arrowtown',
  const Color(0xFF950015): 'Scarlett',
  const Color(0xFF956387): 'Strikemaster',
  const Color(0xFF959396): 'Mountain Mist',
  const Color(0xFF960018): 'Carmine',
  const Color(0xFF964B00): 'Brown',
  const Color(0xFF967059): 'Leather',
  const Color(0xFF9678B6): 'Purple Mountain',
  const Color(0xFF967BB6): 'Lavender Purple',
  const Color(0xFF96A8A1): 'Pewter',
  const Color(0xFF96BBAB): 'Summer Green',
  const Color(0xFF97605D): 'Au Chico',
  const Color(0xFF9771B5): 'Wisteria',
  const Color(0xFF97CD2D): 'Atlantis',
  const Color(0xFF983D61): 'Vin Rouge',
  const Color(0xFF9874D3): 'Lilac Bush',
  const Color(0xFF98777B): 'Bazaar',
  const Color(0xFF98811B): 'Hacienda',
  const Color(0xFF988D77): 'Pale Oyster',
  const Color(0xFF98FF98): 'Mint Green',
  const Color(0xFF990066): 'Fresh Eggplant',
  const Color(0xFF991199): 'Violet Eggplant',
  const Color(0xFF991613): 'Tamarillo',
  const Color(0xFF991B07): 'Totem Pole',
  const Color(0xFF996666): 'Copper Rose',
  const Color(0xFF9966CC): 'Amethyst',
  const Color(0xFF997A8D): 'Mountbatten Pink',
  const Color(0xFF9999CC): 'Blue Bell',
  const Color(0xFF9A3820): 'Prairie Sand',
  const Color(0xFF9A6E61): 'Toast',
  const Color(0xFF9A9577): 'Gurkha',
  const Color(0xFF9AB973): 'Olivine',
  const Color(0xFF9AC2B8): 'Shadow Green',
  const Color(0xFF9B4703): 'Oregon',
  const Color(0xFF9B9E8F): 'Lemon Grass',
  const Color(0xFF9C3336): 'Stiletto',
  const Color(0xFF9D5616): 'Hawaiian Tan',
  const Color(0xFF9DACB7): 'Gull Gray',
  const Color(0xFF9DC209): 'Pistachio',
  const Color(0xFF9DE093): 'Granny Smith Apple',
  const Color(0xFF9DE5FF): 'Anakiwa',
  const Color(0xFF9E5302): 'Chelsea Gem',
  const Color(0xFF9E5B40): 'Sepia Skin',
  const Color(0xFF9EA587): 'Sage',
  const Color(0xFF9EA91F): 'Citron',
  const Color(0xFF9EB1CD): 'Rock Blue',
  const Color(0xFF9EDEE0): 'Morning Glory',
  const Color(0xFF9F381D): 'Cognac',
  const Color(0xFF9F821C): 'Reef Gold',
  const Color(0xFF9F9F9C): 'Star Dust',
  const Color(0xFF9FA0B1): 'Santas Gray',
  const Color(0xFF9FD7D3): 'Sinbad',
  const Color(0xFF9FDD8C): 'Feijoa',
  const Color(0xFFA02712): 'Tabasco',
  const Color(0xFFA1750D): 'Buttered Rum',
  const Color(0xFFA1ADB5): 'Hit Gray',
  const Color(0xFFA1C50A): 'Citrus',
  const Color(0xFFA1DAD7): 'Aqua Island',
  const Color(0xFFA1E9DE): 'Water Leaf',
  const Color(0xFFA2006D): 'Flirt',
  const Color(0xFFA23B6C): 'Rouge',
  const Color(0xFFA26645): 'Cape Palliser',
  const Color(0xFFA2AAB3): 'Gray Chateau',
  const Color(0xFFA2AEAB): 'Edward',
  const Color(0xFFA3807B): 'Pharlap',
  const Color(0xFFA397B4): 'Amethyst Smoke',
  const Color(0xFFA3E3ED): 'Blizzard Blue',
  const Color(0xFFA4A49D): 'Delta',
  const Color(0xFFA4A6D3): 'Wistful',
  const Color(0xFFA4AF6E): 'Green Smoke',
  const Color(0xFFA50B5E): 'Jazzberry Jam',
  const Color(0xFFA59B91): 'Zorba',
  const Color(0xFFA5CB0C): 'Bahia',
  const Color(0xFFA62F20): 'Roof Terracotta',
  const Color(0xFFA65529): 'Paarl',
  const Color(0xFFA68B5B): 'Barley Corn',
  const Color(0xFFA69279): 'Donkey Brown',
  const Color(0xFFA6A29A): 'Dawn',
  const Color(0xFFA72525): 'Mexican Red',
  const Color(0xFFA7882C): 'Luxor Gold',
  const Color(0xFFA85307): 'Rich Gold',
  const Color(0xFFA86515): 'Reno Sand',
  const Color(0xFFA86B6B): 'Coral Tree',
  const Color(0xFFA8989B): 'Dusty Gray',
  const Color(0xFFA899E6): 'Dull Lavender',
  const Color(0xFFA8A589): 'Tallow',
  const Color(0xFFA8AE9C): 'Bud',
  const Color(0xFFA8AF8E): 'Locust',
  const Color(0xFFA8BD9F): 'Norway',
  const Color(0xFFA8E3BD): 'Chinook',
  const Color(0xFFA9A491): 'Gray Olive',
  const Color(0xFFA9ACB6): 'Aluminium',
  const Color(0xFFA9B2C3): 'Cadet Blue',
  const Color(0xFFA9B497): 'Schist',
  const Color(0xFFA9BDBF): 'Tower Gray',
  const Color(0xFFA9BEF2): 'Perano',
  const Color(0xFFA9C6C2): 'Opal',
  const Color(0xFFAA375A): 'Night Shadz',
  const Color(0xFFAA4203): 'Fire',
  const Color(0xFFAA8B5B): 'Muesli',
  const Color(0xFFAA8D6F): 'Sandal',
  const Color(0xFFAAA5A9): 'Shady Lady',
  const Color(0xFFAAA9CD): 'Logan',
  const Color(0xFFAAABB7): 'Spun Pearl',
  const Color(0xFFAAD6E6): 'Regent St Blue',
  const Color(0xFFAAF0D1): 'Magic Mint',
  const Color(0xFFAB0563): 'Lipstick',
  const Color(0xFFAB3472): 'Royal Heath',
  const Color(0xFFAB917A): 'Sandrift',
  const Color(0xFFABA0D9): 'Cold Purple',
  const Color(0xFFABA196): 'Bronco',
  const Color(0xFFAC8A56): 'Limed Oak',
  const Color(0xFFAC91CE): 'East Side',
  const Color(0xFFAC9E22): 'Lemon Ginger',
  const Color(0xFFACA494): 'Napa',
  const Color(0xFFACA586): 'Hillary',
  const Color(0xFFACA59F): 'Cloudy',
  const Color(0xFFACACAC): 'Silver Chalice',
  const Color(0xFFACB78E): 'Swamp Green',
  const Color(0xFFACCBB1): 'Spring Rain',
  const Color(0xFFACDD4D): 'Conifer',
  const Color(0xFFACE1AF): 'Celadon',
  const Color(0xFFAD781B): 'Mandalay',
  const Color(0xFFADBED1): 'Casper',
  const Color(0xFFADDFAD): 'Moss Green',
  const Color(0xFFADE6C4): 'Padua',
  const Color(0xFFADFF2F): 'Green Yellow',
  const Color(0xFFAE4560): 'Hippie Pink',
  const Color(0xFFAE6020): 'Desert',
  const Color(0xFFAE809E): 'Bouquet',
  const Color(0xFFAF4035): 'Medium Carmine',
  const Color(0xFFAF4D43): 'Apple Blossom',
  const Color(0xFFAF593E): 'Brown Rust',
  const Color(0xFFAF8751): 'Driftwood',
  const Color(0xFFAF8F2C): 'Alpine',
  const Color(0xFFAF9F1C): 'Lucky',
  const Color(0xFFAFA09E): 'Martini',
  const Color(0xFFAFB1B8): 'Bombay',
  const Color(0xFFAFBDD9): 'Pigeon Post',
  const Color(0xFFB04C6A): 'Cadillac',
  const Color(0xFFB05D54): 'Matrix',
  const Color(0xFFB05E81): 'Tapestry',
  const Color(0xFFB06608): 'Mai Tai',
  const Color(0xFFB09A95): 'Del Rio',
  const Color(0xFFB0E0E6): 'Powder Blue',
  const Color(0xFFB0E313): 'Inch Worm',
  const Color(0xFFB10000): 'Bright Red',
  const Color(0xFFB14A0B): 'Vesuvius',
  const Color(0xFFB1610B): 'Pumpkin Skin',
  const Color(0xFFB16D52): 'Santa Fe',
  const Color(0xFFB19461): 'Teak',
  const Color(0xFFB1E2C1): 'Fringy Flower',
  const Color(0xFFB1F4E7): 'Ice Cold',
  const Color(0xFFB20931): 'Shiraz',
  const Color(0xFFB2A1EA): 'Biloba Flower',
  const Color(0xFFB32D29): 'Tall Poppy',
  const Color(0xFFB35213): 'Fiery Orange',
  const Color(0xFFB38007): 'Hot Toddy',
  const Color(0xFFB3AF95): 'Taupe Gray',
  const Color(0xFFB3C110): 'La Rioja',
  const Color(0xFFB43332): 'Well Read',
  const Color(0xFFB44668): 'Blush',
  const Color(0xFFB4CFD3): 'Jungle Mist',
  const Color(0xFFB57281): 'Turkish Rose',
  const Color(0xFFB57EDC): 'Lavender',
  const Color(0xFFB5A27F): 'Mongoose',
  const Color(0xFFB5B35C): 'Olive Green',
  const Color(0xFFB5D2CE): 'Jet Stream',
  const Color(0xFFB5ECDF): 'Cruise',
  const Color(0xFFB6316C): 'Hibiscus',
  const Color(0xFFB69D98): 'Thatch',
  const Color(0xFFB6B095): 'Heathered Gray',
  const Color(0xFFB6BAA4): 'Eagle',
  const Color(0xFFB6D1EA): 'Spindle',
  const Color(0xFFB6D3BF): 'Gum Leaf',
  const Color(0xFFB7410E): 'Rust',
  const Color(0xFFB78E5C): 'Muddy Waters',
  const Color(0xFFB7A214): 'Sahara',
  const Color(0xFFB7A458): 'Husk',
  const Color(0xFFB7B1B1): 'Nobel',
  const Color(0xFFB7C3D0): 'Heather',
  const Color(0xFFB7F0BE): 'Madang',
  const Color(0xFFB81104): 'Milano Red',
  const Color(0xFFB87333): 'Copper',
  const Color(0xFFB8B56A): 'Gimblet',
  const Color(0xFFB8C1B1): 'Green Spring',
  const Color(0xFFB8C25D): 'Celery',
  const Color(0xFFB8E0F9): 'Sail',
  const Color(0xFFB94E48): 'Chestnut',
  const Color(0xFFB95140): 'Crail',
  const Color(0xFFB98D28): 'Marigold',
  const Color(0xFFB9C46A): 'Wild Willow',
  const Color(0xFFB9C8AC): 'Rainee',
  const Color(0xFFBA0101): 'Guardsman Red',
  const Color(0xFFBA450C): 'Rock Spray',
  const Color(0xFFBA6F1E): 'Bourbon',
  const Color(0xFFBA7F03): 'Pirate Gold',
  const Color(0xFFBAB1A2): 'Nomad',
  const Color(0xFFBAC7C9): 'Submarine',
  const Color(0xFFBAEEF9): 'Charlotte',
  const Color(0xFFBB3385): 'Medium Red Violet',
  const Color(0xFFBB8983): 'Brandy Rose',
  const Color(0xFFBBD009): 'Rio Grande',
  const Color(0xFFBBD7C1): 'Surf',
  const Color(0xFFBCC9C2): 'Powder Ash',
  const Color(0xFFBD5E2E): 'Tuscany',
  const Color(0xFFBD978E): 'Quicksand',
  const Color(0xFFBDB1A8): 'Silk',
  const Color(0xFFBDB2A1): 'Malta',
  const Color(0xFFBDB3C7): 'Chatelle',
  const Color(0xFFBDBBD7): 'Lavender Gray',
  const Color(0xFFBDBDC6): 'French Gray',
  const Color(0xFFBDC8B3): 'Clay Ash',
  const Color(0xFFBDC9CE): 'Loblolly',
  const Color(0xFFBDEDFD): 'French Pass',
  const Color(0xFFBEA6C3): 'London Hue',
  const Color(0xFFBEB5B7): 'Pink Swan',
  const Color(0xFFBEDE0D): 'Fuego',
  const Color(0xFFBF5500): 'Rose of Sharon',
  const Color(0xFFBFB8B0): 'Tide',
  const Color(0xFFBFBED8): 'Blue Haze',
  const Color(0xFFBFC1C2): 'Silver Sand',
  const Color(0xFFBFC921): 'Key Lime Pie',
  const Color(0xFFBFDBE2): 'Ziggurat',
  const Color(0xFFBFFF00): 'Lime',
  const Color(0xFFC02B18): 'Thunderbird',
  const Color(0xFFC04737): 'Mojo',
  const Color(0xFFC08081): 'Old Rose',
  const Color(0xFFC0C0C0): 'Silver',
  const Color(0xFFC0D3B9): 'Pale Leaf',
  const Color(0xFFC0D8B6): 'Pixie Green',
  const Color(0xFFC1440E): 'Tia Maria',
  const Color(0xFFC154C1): 'Fuchsia Pink',
  const Color(0xFFC1A004): 'Buddha Gold',
  const Color(0xFFC1B7A4): 'Bison Hide',
  const Color(0xFFC1BAB0): 'Tea',
  const Color(0xFFC1BECD): 'Gray Suit',
  const Color(0xFFC1D7B0): 'Sprout',
  const Color(0xFFC1F07C): 'Sulu',
  const Color(0xFFC26B03): 'Indochine',
  const Color(0xFFC2955D): 'Twine',
  const Color(0xFFC2BDB6): 'Cotton Seed',
  const Color(0xFFC2CAC4): 'Pumice',
  const Color(0xFFC2E8E5): 'Jagged Ice',
  const Color(0xFFC32148): 'Maroon Flush',
  const Color(0xFFC3B091): 'Indian Khaki',
  const Color(0xFFC3BFC1): 'Pale Slate',
  const Color(0xFFC3C3BD): 'Gray Nickel',
  const Color(0xFFC3CDE6): 'Periwinkle Gray',
  const Color(0xFFC3D1D1): 'Tiara',
  const Color(0xFFC3DDF9): 'Tropical Blue',
  const Color(0xFFC41E3A): 'Cardinal',
  const Color(0xFFC45655): 'Fuzzy Wuzzy Brown',
  const Color(0xFFC45719): 'Orange Roughy',
  const Color(0xFFC4C4BC): 'Mist Gray',
  const Color(0xFFC4D0B0): 'Coriander',
  const Color(0xFFC4F4EB): 'Mint Tulip',
  const Color(0xFFC54B8C): 'Mulberry',
  const Color(0xFFC59922): 'Nugget',
  const Color(0xFFC5994B): 'Tussock',
  const Color(0xFFC5DBCA): 'Sea Mist',
  const Color(0xFFC5E17A): 'Yellow Green',
  const Color(0xFFC62D42): 'Brick Red',
  const Color(0xFFC6726B): 'Contessa',
  const Color(0xFFC69191): 'Oriental Pink',
  const Color(0xFFC6A84B): 'Roti',
  const Color(0xFFC6C3B5): 'Ash',
  const Color(0xFFC6C8BD): 'Kangaroo',
  const Color(0xFFC6E610): 'Las Palmas',
  const Color(0xFFC7031E): 'Monza',
  const Color(0xFFC71585): 'Red Violet',
  const Color(0xFFC7BCA2): 'Coral Reef',
  const Color(0xFFC7C1FF): 'Melrose',
  const Color(0xFFC7C4BF): 'Cloud',
  const Color(0xFFC7C9D5): 'Ghost',
  const Color(0xFFC7CD90): 'Pine Glade',
  const Color(0xFFC7DDE5): 'Botticelli',
  const Color(0xFFC88A65): 'Antique Brass',
  const Color(0xFFC8A2C8): 'Lilac',
  const Color(0xFFC8A528): 'Hokey Pokey',
  const Color(0xFFC8AABF): 'Lily',
  const Color(0xFFC8B568): 'Laser',
  const Color(0xFFC8E3D7): 'Edgewater',
  const Color(0xFFC96323): 'Piper',
  const Color(0xFFC99415): 'Pizza',
  const Color(0xFFC9A0DC): 'Light Wisteria',
  const Color(0xFFC9B29B): 'Rodeo Dust',
  const Color(0xFFC9B35B): 'Sundance',
  const Color(0xFFC9B93B): 'Earls Green',
  const Color(0xFFC9C0BB): 'Silver Rust',
  const Color(0xFFC9D9D2): 'Conch',
  const Color(0xFFC9FFA2): 'Reef',
  const Color(0xFFC9FFE5): 'Aero Blue',
  const Color(0xFFCA3435): 'Flush Mahogany',
  const Color(0xFFCABB48): 'Turmeric',
  const Color(0xFFCADCD4): 'Paris White',
  const Color(0xFFCAE00D): 'Bitter Lemon',
  const Color(0xFFCAE6DA): 'Skeptic',
  const Color(0xFFCB8FA9): 'Viola',
  const Color(0xFFCBCAB6): 'Foggy Gray',
  const Color(0xFFCBD3B0): 'Green Mist',
  const Color(0xFFCBDBD6): 'Nebula',
  const Color(0xFFCC3333): 'Persian Red',
  const Color(0xFFCC5501): 'Burnt Orange',
  const Color(0xFFCC7722): 'Ochre',
  const Color(0xFFCC8899): 'Puce',
  const Color(0xFFCCCAA8): 'Thistle Green',
  const Color(0xFFCCCCFF): 'Periwinkle',
  const Color(0xFFCCFF00): 'Electric Lime',
  const Color(0xFFCD5700): 'Tenn',
  const Color(0xFFCD5C5C): 'Chestnut Rose',
  const Color(0xFFCD8429): 'Brandy Punch',
  const Color(0xFFCDF4FF): 'Onahau',
  const Color(0xFFCEB98F): 'Sorrell Brown',
  const Color(0xFFCEBABA): 'Cold Turkey',
  const Color(0xFFCEC291): 'Yuma',
  const Color(0xFFCEC7A7): 'Chino',
  const Color(0xFFCFA39D): 'Eunry',
  const Color(0xFFCFB53B): 'Old Gold',
  const Color(0xFFCFDCCF): 'Tasman',
  const Color(0xFFCFE5D2): 'Surf Crest',
  const Color(0xFFCFF9F3): 'Humming Bird',
  const Color(0xFFCFFAF4): 'Scandal',
  const Color(0xFFD05F04): 'Red Stage',
  const Color(0xFFD06DA1): 'Hopbush',
  const Color(0xFFD07D12): 'Meteor',
  const Color(0xFFD0BEF8): 'Perfume',
  const Color(0xFFD0C0E5): 'Prelude',
  const Color(0xFFD0F0C0): 'Tea Green',
  const Color(0xFFD18F1B): 'Geebung',
  const Color(0xFFD1BEA8): 'Vanilla',
  const Color(0xFFD1C6B4): 'Soft Amber',
  const Color(0xFFD1D2CA): 'Celeste',
  const Color(0xFFD1D2DD): 'Mischka',
  const Color(0xFFD1E231): 'Pear',
  const Color(0xFFD2691E): 'Hot Cinnamon',
  const Color(0xFFD27D46): 'Raw Sienna',
  const Color(0xFFD29EAA): 'Careys Pink',
  const Color(0xFFD2B48C): 'Tan',
  const Color(0xFFD2DA97): 'Deco',
  const Color(0xFFD2F6DE): 'Blue Romance',
  const Color(0xFFD2F8B0): 'Gossip',
  const Color(0xFFD3CBBA): 'Sisal',
  const Color(0xFFD3CDC5): 'Swirl',
  const Color(0xFFD47494): 'Charm',
  const Color(0xFFD4B6AF): 'Clam Shell',
  const Color(0xFFD4BF8D): 'Straw',
  const Color(0xFFD4C4A8): 'Akaroa',
  const Color(0xFFD4CD16): 'Bird Flower',
  const Color(0xFFD4D7D9): 'Iron',
  const Color(0xFFD4DFE2): 'Geyser',
  const Color(0xFFD4E2FC): 'Hawkes Blue',
  const Color(0xFFD54600): 'Grenadier',
  const Color(0xFFD591A4): 'Can Can',
  const Color(0xFFD59A6F): 'Whiskey',
  const Color(0xFFD5D195): 'Winter Hazel',
  const Color(0xFFD5F6E3): 'Granny Apple',
  const Color(0xFFD69188): 'My Pink',
  const Color(0xFFD6C562): 'Tacha',
  const Color(0xFFD6CEF6): 'Moon Raker',
  const Color(0xFFD6D6D1): 'Quill Gray',
  const Color(0xFFD6FFDB): 'Snowy Mint',
  const Color(0xFFD7837F): 'New York Pink',
  const Color(0xFFD7C498): 'Pavlova',
  const Color(0xFFD7D0FF): 'Fog',
  const Color(0xFFD84437): 'Valencia',
  const Color(0xFFD87C63): 'Japonica',
  const Color(0xFFD8BFD8): 'Thistle',
  const Color(0xFFD8C2D5): 'Maverick',
  const Color(0xFFD8FCFA): 'Foam',
  const Color(0xFFD94972): 'Cabaret',
  const Color(0xFFD99376): 'Burning Sand',
  const Color(0xFFD9B99B): 'Cameo',
  const Color(0xFFD9D6CF): 'Timberwolf',
  const Color(0xFFD9DCC1): 'Tana',
  const Color(0xFFD9E4F5): 'Link Water',
  const Color(0xFFD9F7FF): 'Mabel',
  const Color(0xFFDA3287): 'Cerise',
  const Color(0xFFDA5B38): 'Flame Pea',
  const Color(0xFFDA6304): 'Bamboo',
  const Color(0xFFDA6A41): 'Red Damask',
  const Color(0xFFDA70D6): 'Orchid',
  const Color(0xFFDA8A67): 'Copperfield',
  const Color(0xFFDAA520): 'Golden Grass',
  const Color(0xFFDAECD6): 'Zanah',
  const Color(0xFFDAF4F0): 'Iceberg',
  const Color(0xFFDAFAFF): 'Oyster Bay',
  const Color(0xFFDB5079): 'Cranberry',
  const Color(0xFFDB9690): 'Petite Orchid',
  const Color(0xFFDB995E): 'Di Serria',
  const Color(0xFFDBDBDB): 'Alto',
  const Color(0xFFDBFFF8): 'Frosted Mint',
  const Color(0xFFDC143C): 'Crimson',
  const Color(0xFFDC4333): 'Punch',
  const Color(0xFFDCB20C): 'Galliano',
  const Color(0xFFDCB4BC): 'Blossom',
  const Color(0xFFDCD747): 'Wattle',
  const Color(0xFFDCD9D2): 'Westar',
  const Color(0xFFDCDDCC): 'Moon Mist',
  const Color(0xFFDCEDB4): 'Caper',
  const Color(0xFFDCF0EA): 'Swans Down',
  const Color(0xFFDDD6D5): 'Swiss Coffee',
  const Color(0xFFDDF9F1): 'White Ice',
  const Color(0xFFDE3163): 'Cerise Red',
  const Color(0xFFDE6360): 'Roman',
  const Color(0xFFDEA681): 'Tumbleweed',
  const Color(0xFFDEBA13): 'Gold Tips',
  const Color(0xFFDEC196): 'Brandy',
  const Color(0xFFDECBC6): 'Wafer',
  const Color(0xFFDED4A4): 'Sapling',
  const Color(0xFFDED717): 'Barberry',
  const Color(0xFFDEE5C0): 'Beryl Green',
  const Color(0xFFDEF5FF): 'Pattens Blue',
  const Color(0xFFDF73FF): 'Heliotrope',
  const Color(0xFFDFBE6F): 'Apache',
  const Color(0xFFDFCD6F): 'Chenin',
  const Color(0xFFDFCFDB): 'Lola',
  const Color(0xFFDFECDA): 'Willow Brook',
  const Color(0xFFDFFF00): 'Chartreuse Yellow',
  const Color(0xFFE0B0FF): 'Mauve',
  const Color(0xFFE0B646): 'Anzac',
  const Color(0xFFE0B974): 'Harvest Gold',
  const Color(0xFFE0C095): 'Calico',
  const Color(0xFFE0FFFF): 'Baby Blue',
  const Color(0xFFE16865): 'Sunglo',
  const Color(0xFFE1BC64): 'Equator',
  const Color(0xFFE1C0C8): 'Pink Flare',
  const Color(0xFFE1E6D6): 'Periglacial Blue',
  const Color(0xFFE1EAD4): 'Kidnapper',
  const Color(0xFFE1F6E8): 'Tara',
  const Color(0xFFE25465): 'Mandy',
  const Color(0xFFE2725B): 'Terracotta',
  const Color(0xFFE28913): 'Golden Bell',
  const Color(0xFFE292C0): 'Shocking',
  const Color(0xFFE29418): 'Dixie',
  const Color(0xFFE29CD2): 'Light Orchid',
  const Color(0xFFE2D8ED): 'Snuff',
  const Color(0xFFE2EBED): 'Mystic',
  const Color(0xFFE2F3EC): 'Apple Green',
  const Color(0xFFE30B5C): 'Razzmatazz',
  const Color(0xFFE32636): 'Alizarin Crimson',
  const Color(0xFFE34234): 'Cinnabar',
  const Color(0xFFE3BEBE): 'Cavern Pink',
  const Color(0xFFE3F5E1): 'Peppermint',
  const Color(0xFFE3F988): 'Mindaro',
  const Color(0xFFE47698): 'Deep Blush',
  const Color(0xFFE49B0F): 'Gamboge',
  const Color(0xFFE4C2D5): 'Melanie',
  const Color(0xFFE4CFDE): 'Twilight',
  const Color(0xFFE4D1C0): 'Bone',
  const Color(0xFFE4D422): 'Sunflower',
  const Color(0xFFE4D5B7): 'Grain Brown',
  const Color(0xFFE4D69B): 'Zombie',
  const Color(0xFFE4F6E7): 'Frostee',
  const Color(0xFFE4FFD1): 'Snow Flurry',
  const Color(0xFFE52B50): 'Amaranth',
  const Color(0xFFE5841B): 'Zest',
  const Color(0xFFE5CCC9): 'Dust Storm',
  const Color(0xFFE5D7BD): 'Stark White',
  const Color(0xFFE5D8AF): 'Hampton',
  const Color(0xFFE5E0E1): 'Bon Jour',
  const Color(0xFFE5E5E5): 'Mercury',
  const Color(0xFFE5F9F6): 'Polar',
  const Color(0xFFE64E03): 'Trinidad',
  const Color(0xFFE6BE8A): 'Gold Sand',
  const Color(0xFFE6BEA5): 'Cashmere',
  const Color(0xFFE6D7B9): 'Double Spanish White',
  const Color(0xFFE6E4D4): 'Satin Linen',
  const Color(0xFFE6F2EA): 'Harp',
  const Color(0xFFE6F8F3): 'Off Green',
  const Color(0xFFE6FFE9): 'Hint of Green',
  const Color(0xFFE6FFFF): 'Tranquil',
  const Color(0xFFE77200): 'Mango Tango',
  const Color(0xFFE7730A): 'Christine',
  const Color(0xFFE79F8C): "Tony's Pink",
  const Color(0xFFE79FC4): 'Kobi',
  const Color(0xFFE7BCB4): 'Rose Fog',
  const Color(0xFFE7BF05): 'Corn',
  const Color(0xFFE7CD8C): 'Putty',
  const Color(0xFFE7ECE6): 'Gray Nurse',
  const Color(0xFFE7F8FF): 'Lily White',
  const Color(0xFFE7FEFF): 'Bubbles',
  const Color(0xFFE89928): 'Fire Bush',
  const Color(0xFFE8B9B3): 'Shilo',
  const Color(0xFFE8E0D5): 'Pearl Bush',
  const Color(0xFFE8EBE0): 'Green White',
  const Color(0xFFE8F1D4): 'Chrome White',
  const Color(0xFFE8F2EB): 'Gin',
  const Color(0xFFE8F5F2): 'Aqua Squeeze',
  const Color(0xFFE96E00): 'Clementine',
  const Color(0xFFE97451): 'Burnt Sienna',
  const Color(0xFFE97C07): 'Tahiti Gold',
  const Color(0xFFE9CECD): 'Oyster Pink',
  const Color(0xFFE9D75A): 'Confetti',
  const Color(0xFFE9E3E3): 'Ebb',
  const Color(0xFFE9F8ED): 'Ottoman',
  const Color(0xFFE9FFFD): 'Clear Day',
  const Color(0xFFEA88A8): 'Carissma',
  const Color(0xFFEAAE69): 'Porsche',
  const Color(0xFFEAB33B): 'Tulip Tree',
  const Color(0xFFEAC674): 'Rob Roy',
  const Color(0xFFEADAB8): 'Raffia',
  const Color(0xFFEAE8D4): 'White Rock',
  const Color(0xFFEAF6EE): 'Panache',
  const Color(0xFFEAF6FF): 'Solitude',
  const Color(0xFFEAF9F5): 'Aqua Spring',
  const Color(0xFFEAFFFE): 'Dew',
  const Color(0xFFEB9373): 'Apricot',
  const Color(0xFFEBC2AF): 'Zinnwaldite',
  const Color(0xFFECA927): 'Fuel Yellow',
  const Color(0xFFECC54E): 'Ronchi',
  const Color(0xFFECC7EE): 'French Lilac',
  const Color(0xFFECCDB9): 'Just Right',
  const Color(0xFFECE090): 'Wild Rice',
  const Color(0xFFECEBBD): 'Fall Green',
  const Color(0xFFECEBCE): 'Aths Special',
  const Color(0xFFECF245): 'Starship',
  const Color(0xFFED0A3F): 'Red Ribbon',
  const Color(0xFFED7A1C): 'Tango',
  const Color(0xFFED9121): 'Carrot Orange',
  const Color(0xFFED989E): 'Sea Pink',
  const Color(0xFFEDB381): 'Tacao',
  const Color(0xFFEDC9AF): 'Desert Sand',
  const Color(0xFFEDCDAB): 'Pancho',
  const Color(0xFFEDDCB1): 'Chamois',
  const Color(0xFFEDEA99): 'Primrose',
  const Color(0xFFEDF5DD): 'Frost',
  const Color(0xFFEDF5F5): 'Aqua Haze',
  const Color(0xFFEDF6FF): 'Zumthor',
  const Color(0xFFEDF9F1): 'Narvik',
  const Color(0xFFEDFC84): 'Honeysuckle',
  const Color(0xFFEE82EE): 'Lavender Magenta',
  const Color(0xFFEEC1BE): 'Beauty Bush',
  const Color(0xFFEED794): 'Chalky',
  const Color(0xFFEED9C4): 'Almond',
  const Color(0xFFEEDC82): 'Flax',
  const Color(0xFFEEDEDA): 'Bizarre',
  const Color(0xFFEEE3AD): 'Double Colonial White',
  const Color(0xFFEEEEE8): 'Cararra',
  const Color(0xFFEEEF78): 'Manz',
  const Color(0xFFEEF0C8): 'Tahuna Sands',
  const Color(0xFFEEF0F3): 'Athens Gray',
  const Color(0xFFEEF3C3): 'Tusk',
  const Color(0xFFEEF4DE): 'Loafer',
  const Color(0xFFEEF6F7): 'Catskill White',
  const Color(0xFFEEFDFF): 'Twilight Blue',
  const Color(0xFFEEFF9A): 'Jonquil',
  const Color(0xFFEEFFE2): 'Rice Flower',
  const Color(0xFFEF863F): 'Jaffa',
  const Color(0xFFEFEFEF): 'Gallery',
  const Color(0xFFEFF2F3): 'Porcelain',
  const Color(0xFFF091A9): 'Mauvelous',
  const Color(0xFFF0D52D): 'Golden Dream',
  const Color(0xFFF0DB7D): 'Golden Sand',
  const Color(0xFFF0DC82): 'Buff',
  const Color(0xFFF0E2EC): 'Prim',
  const Color(0xFFF0E68C): 'Khaki',
  const Color(0xFFF0EEFD): 'Selago',
  const Color(0xFFF0EEFF): 'Titan White',
  const Color(0xFFF0F8FF): 'Alice Blue',
  const Color(0xFFF0FCEA): 'Feta',
  const Color(0xFFF18200): 'Gold Drop',
  const Color(0xFFF19BAB): 'Wewak',
  const Color(0xFFF1E788): 'Sahara Sand',
  const Color(0xFFF1E9D2): 'Parchment',
  const Color(0xFFF1E9FF): 'Blue Chalk',
  const Color(0xFFF1EEC1): 'Mint Julep',
  const Color(0xFFF1F1F1): 'Seashell',
  const Color(0xFFF1F7F2): 'Saltpan',
  const Color(0xFFF1FFAD): 'Tidal',
  const Color(0xFFF1FFC8): 'Chiffon',
  const Color(0xFFF2552A): 'Flamingo',
  const Color(0xFFF28500): 'Tangerine',
  const Color(0xFFF2C3B2): "Mandy's Pink",
  const Color(0xFFF2F2F2): 'Concrete',
  const Color(0xFFF2FAFA): 'Black Squeeze',
  const Color(0xFFF34723): 'Pomegranate',
  const Color(0xFFF3AD16): 'Buttercup',
  const Color(0xFFF3D69D): 'New Orleans',
  const Color(0xFFF3D9DF): 'Vanilla Ice',
  const Color(0xFFF3E7BB): 'Sidecar',
  const Color(0xFFF3E9E5): 'Dawn Pink',
  const Color(0xFFF3EDCF): 'Wheatfield',
  const Color(0xFFF3FB62): 'Canary',
  const Color(0xFFF3FBD4): 'Orinoco',
  const Color(0xFFF3FFD8): 'Carla',
  const Color(0xFFF400A1): 'Hollywood Cerise',
  const Color(0xFFF4A460): 'Sandy brown',
  const Color(0xFFF4C430): 'Saffron',
  const Color(0xFFF4D81C): 'Ripe Lemon',
  const Color(0xFFF4EBD3): 'Janna',
  const Color(0xFFF4F2EE): 'Pampas',
  const Color(0xFFF4F4F4): 'Wild Sand',
  const Color(0xFFF4F8FF): 'Zircon',
  const Color(0xFFF57584): 'Froly',
  const Color(0xFFF5C85C): 'Cream Can',
  const Color(0xFFF5C999): 'Manhattan',
  const Color(0xFFF5D5A0): 'Maize',
  const Color(0xFFF5DEB3): 'Wheat',
  const Color(0xFFF5E7A2): 'Sandwisp',
  const Color(0xFFF5E7E2): 'Pot Pourri',
  const Color(0xFFF5E9D3): 'Albescent White',
  const Color(0xFFF5EDEF): 'Soft Peach',
  const Color(0xFFF5F3E5): 'Ecru White',
  const Color(0xFFF5F5DC): 'Beige',
  const Color(0xFFF5FB3D): 'Golden Fizz',
  const Color(0xFFF5FFBE): 'Australian Mint',
  const Color(0xFFF64A8A): 'French Rose',
  const Color(0xFFF653A6): 'Brilliant Rose',
  const Color(0xFFF6A4C9): 'Illusion',
  const Color(0xFFF6F0E6): 'Merino',
  const Color(0xFFF6F7F7): 'Black Haze',
  const Color(0xFFF6FFDC): 'Spring Sun',
  const Color(0xFFF7468A): 'Violet Red',
  const Color(0xFFF77703): 'Chilean Fire',
  const Color(0xFFF77FBE): 'Persian Pink',
  const Color(0xFFF7B668): 'Rajah',
  const Color(0xFFF7C8DA): 'Azalea',
  const Color(0xFFF7DBE6): 'We Peep',
  const Color(0xFFF7F2E1): 'Quarter Spanish White',
  const Color(0xFFF7F5FA): 'Whisper',
  const Color(0xFFF7FAF7): 'Snow Drift',
  const Color(0xFFF8B853): 'Casablanca',
  const Color(0xFFF8C3DF): 'Chantilly',
  const Color(0xFFF8D9E9): 'Cherub',
  const Color(0xFFF8DB9D): 'Marzipan',
  const Color(0xFFF8DD5C): 'Energy Yellow',
  const Color(0xFFF8E4BF): 'Givry',
  const Color(0xFFF8F0E8): 'White Linen',
  const Color(0xFFF8F4FF): 'Magnolia',
  const Color(0xFFF8F6F1): 'Spring Wood',
  const Color(0xFFF8F7DC): 'Coconut Cream',
  const Color(0xFFF8F7FC): 'White Lilac',
  const Color(0xFFF8F8F7): 'Desert Storm',
  const Color(0xFFF8F99C): 'Texas',
  const Color(0xFFF8FACD): 'Corn Field',
  const Color(0xFFF8FDD3): 'Mimosa',
  const Color(0xFFF95A61): 'Carnation',
  const Color(0xFFF9BF58): 'Saffron Mango',
  const Color(0xFFF9E0ED): 'Carousel Pink',
  const Color(0xFFF9E4BC): 'Dairy Cream',
  const Color(0xFFF9E663): 'Portica',
  const Color(0xFFF9EAF3): 'Amour',
  const Color(0xFFF9F8E4): 'Rum Swizzle',
  const Color(0xFFF9FF8B): 'Dolly',
  const Color(0xFFF9FFF6): 'Sugar Cane',
  const Color(0xFFFA7814): 'Ecstasy',
  const Color(0xFFFA9D5A): 'Tan Hide',
  const Color(0xFFFAD3A2): 'Corvette',
  const Color(0xFFFADFAD): 'Peach Yellow',
  const Color(0xFFFAE600): 'Turbo',
  const Color(0xFFFAEAB9): 'Astra',
  const Color(0xFFFAECCC): 'Champagne',
  const Color(0xFFFAF0E6): 'Linen',
  const Color(0xFFFAF3F0): 'Fantasy',
  const Color(0xFFFAF7D6): 'Citrine White',
  const Color(0xFFFAFAFA): 'Alabaster',
  const Color(0xFFFAFDE4): 'Hint of Yellow',
  const Color(0xFFFAFFA4): 'Milan',
  const Color(0xFFFB607F): 'Brink Pink',
  const Color(0xFFFB8989): 'Geraldine',
  const Color(0xFFFBA0E3): 'Lavender Rose',
  const Color(0xFFFBA129): 'Sea Buckthorn',
  const Color(0xFFFBAC13): 'Sun',
  const Color(0xFFFBAED2): 'Lavender Pink',
  const Color(0xFFFBB2A3): 'Rose Bud',
  const Color(0xFFFBBEDA): 'Cupid',
  const Color(0xFFFBCCE7): 'Classic Rose',
  const Color(0xFFFBCEB1): 'Apricot Peach',
  const Color(0xFFFBE7B2): 'Banana Mania',
  const Color(0xFFFBE870): 'Marigold Yellow',
  const Color(0xFFFBE96C): 'Festival',
  const Color(0xFFFBEA8C): 'Sweet Corn',
  const Color(0xFFFBEC5D): 'Candy Corn',
  const Color(0xFFFBF9F9): 'Hint of Red',
  const Color(0xFFFBFFBA): 'Shalimar',
  const Color(0xFFFC0FC0): 'Shocking Pink',
  const Color(0xFFFC80A5): 'Tickle Me Pink',
  const Color(0xFFFC9C1D): 'Tree Poppy',
  const Color(0xFFFCC01E): 'Lightning Yellow',
  const Color(0xFFFCD667): 'Goldenrod',
  const Color(0xFFFCD917): 'Candlelight',
  const Color(0xFFFCDA98): 'Cherokee',
  const Color(0xFFFCF4D0): 'Double Pearl Lusta',
  const Color(0xFFFCF4DC): 'Pearl Lusta',
  const Color(0xFFFCF8F7): 'Vista White',
  const Color(0xFFFCFBF3): 'Bianca',
  const Color(0xFFFCFEDA): 'Moon Glow',
  const Color(0xFFFCFFE7): 'China Ivory',
  const Color(0xFFFCFFF9): 'Ceramic',
  const Color(0xFFFD0E35): 'Torch Red',
  const Color(0xFFFD5B78): 'Wild Watermelon',
  const Color(0xFFFD7B33): 'Crusta',
  const Color(0xFFFD7C07): 'Sorbus',
  const Color(0xFFFD9FA2): 'Sweet Pink',
  const Color(0xFFFDD5B1): 'Light Apricot',
  const Color(0xFFFDD7E4): 'Pig Pink',
  const Color(0xFFFDE1DC): 'Cinderella',
  const Color(0xFFFDE295): 'Golden Glow',
  const Color(0xFFFDE910): 'Lemon',
  const Color(0xFFFDF5E6): 'Old Lace',
  const Color(0xFFFDF6D3): 'Half Colonial White',
  const Color(0xFFFDF7AD): 'Drover',
  const Color(0xFFFDFEB8): 'Pale Prim',
  const Color(0xFFFDFFD5): 'Cumulus',
  const Color(0xFFFE28A2): 'Persian Rose',
  const Color(0xFFFE4C40): 'Sunset Orange',
  const Color(0xFFFE6F5E): 'Bittersweet',
  const Color(0xFFFE9D04): 'California',
  const Color(0xFFFEA904): 'Yellow Sea',
  const Color(0xFFFEBAAD): 'Melon',
  const Color(0xFFFED33C): 'Bright Sun',
  const Color(0xFFFED85D): 'Dandelion',
  const Color(0xFFFEDB8D): 'Salomie',
  const Color(0xFFFEE5AC): 'Cape Honey',
  const Color(0xFFFEEBF3): 'Remy',
  const Color(0xFFFEEFCE): 'Oasis',
  const Color(0xFFFEF0EC): 'Bridesmaid',
  const Color(0xFFFEF2C7): 'Beeswax',
  const Color(0xFFFEF3D8): 'Bleach White',
  const Color(0xFFFEF4CC): 'Pipi',
  const Color(0xFFFEF4DB): 'Half Spanish White',
  const Color(0xFFFEF4F8): 'Wisp Pink',
  const Color(0xFFFEF5F1): 'Provincial Pink',
  const Color(0xFFFEF7DE): 'Half Dutch White',
  const Color(0xFFFEF8E2): 'Solitaire',
  const Color(0xFFFEF8FF): 'White Pointer',
  const Color(0xFFFEF9E3): 'Off Yellow',
  const Color(0xFFFEFCED): 'Orange White',
  const Color(0xFFFF0000): 'Red',
  const Color(0xFFFF007F): 'Rose',
  const Color(0xFFFF00CC): 'Purple Pizzazz',
  const Color(0xFFFF00FF): 'Magenta / Fuchsia',
  const Color(0xFFFF2400): 'Scarlet',
  const Color(0xFFFF3399): 'Wild Strawberry',
  const Color(0xFFFF33CC): 'Razzle Dazzle Rose',
  const Color(0xFFFF355E): 'Radical Red',
  const Color(0xFFFF3F34): 'Red Orange',
  const Color(0xFFFF4040): 'Coral Red',
  const Color(0xFFFF4D00): 'Vermilion',
  const Color(0xFFFF4F00): 'International Orange',
  const Color(0xFFFF6037): 'Outrageous Orange',
  const Color(0xFFFF6600): 'Blaze Orange',
  const Color(0xFFFF66FF): 'Pink Flamingo',
  const Color(0xFFFF681F): 'Orange',
  const Color(0xFFFF69B4): 'Hot Pink',
  const Color(0xFFFF6B53): 'Persimmon',
  const Color(0xFFFF6FFF): 'Blush Pink',
  const Color(0xFFFF7034): 'Burning Orange',
  const Color(0xFFFF7518): 'Pumpkin',
  const Color(0xFFFF7D07): 'Flamenco',
  const Color(0xFFFF7F00): 'Flush Orange',
  const Color(0xFFFF7F50): 'Coral',
  const Color(0xFFFF8C69): 'Salmon',
  const Color(0xFFFF9000): 'Pizazz',
  const Color(0xFFFF910F): 'West Side',
  const Color(0xFFFF91A4): 'Pink Salmon',
  const Color(0xFFFF9933): 'Neon Carrot',
  const Color(0xFFFF9966): 'Atomic Tangerine',
  const Color(0xFFFF9980): 'Vivid Tangerine',
  const Color(0xFFFF9E2C): 'Sunshade',
  const Color(0xFFFFA000): 'Orange Peel',
  const Color(0xFFFFA194): 'Mona Lisa',
  const Color(0xFFFFA500): 'Web Orange',
  const Color(0xFFFFA6C9): 'Carnation Pink',
  const Color(0xFFFFAB81): 'Hit Pink',
  const Color(0xFFFFAE42): 'Yellow Orange',
  const Color(0xFFFFB0AC): 'Cornflower Lilac',
  const Color(0xFFFFB1B3): 'Sundown',
  const Color(0xFFFFB31F): 'My Sin',
  const Color(0xFFFFB555): 'Texas Rose',
  const Color(0xFFFFB7D5): 'Cotton Candy',
  const Color(0xFFFFB97B): 'Macaroni and Cheese',
  const Color(0xFFFFBA00): 'Selective Yellow',
  const Color(0xFFFFBD5F): 'Koromiko',
  const Color(0xFFFFBF00): 'Amber',
  const Color(0xFFFFC0A8): 'Wax Flower',
  const Color(0xFFFFC0CB): 'Pink',
  const Color(0xFFFFC3C0): 'Your Pink',
  const Color(0xFFFFC901): 'Supernova',
  const Color(0xFFFFCBA4): 'Flesh',
  const Color(0xFFFFCC33): 'Sunglow',
  const Color(0xFFFFCC5C): 'Golden Tainoi',
  const Color(0xFFFFCC99): 'Peach Orange',
  const Color(0xFFFFCD8C): 'Chardonnay',
  const Color(0xFFFFD1DC): 'Pastel Pink',
  const Color(0xFFFFD2B7): 'Romantic',
  const Color(0xFFFFD38C): 'Grandis',
  const Color(0xFFFFD700): 'Gold',
  const Color(0xFFFFD801): 'School bus Yellow',
  const Color(0xFFFFD8D9): 'Cosmos',
  const Color(0xFFFFDB58): 'Mustard',
  const Color(0xFFFFDCD6): 'Peach Schnapps',
  const Color(0xFFFFDDAF): 'Caramel',
  const Color(0xFFFFDDCD): 'Tuft Bush',
  const Color(0xFFFFDDCF): 'Watusi',
  const Color(0xFFFFDDF4): 'Pink Lace',
  const Color(0xFFFFDEAD): 'Navajo White',
  const Color(0xFFFFDEB3): 'Frangipani',
  const Color(0xFFFFE1DF): 'Pippin',
  const Color(0xFFFFE1F2): 'Pale Rose',
  const Color(0xFFFFE2C5): 'Negroni',
  const Color(0xFFFFE5A0): 'Cream Brulee',
  const Color(0xFFFFE5B4): 'Peach',
  const Color(0xFFFFE6C7): 'Tequila',
  const Color(0xFFFFE772): 'Kournikova',
  const Color(0xFFFFEAC8): 'Sandy Beach',
  const Color(0xFFFFEAD4): 'Karry',
  const Color(0xFFFFEC13): 'Broom',
  const Color(0xFFFFEDBC): 'Colonial White',
  const Color(0xFFFFEED8): 'Derby',
  const Color(0xFFFFEFA1): 'Vis Vis',
  const Color(0xFFFFEFC1): 'Egg White',
  const Color(0xFFFFEFD5): 'Papaya Whip',
  const Color(0xFFFFEFEC): 'Fair Pink',
  const Color(0xFFFFF0DB): 'Peach Cream',
  const Color(0xFFFFF0F5): 'Lavender blush',
  const Color(0xFFFFF14F): 'Gorse',
  const Color(0xFFFFF1B5): 'Buttermilk',
  const Color(0xFFFFF1D8): 'Pink Lady',
  const Color(0xFFFFF1EE): 'Forget Me Not',
  const Color(0xFFFFF1F9): 'Tutu',
  const Color(0xFFFFF39D): 'Picasso',
  const Color(0xFFFFF3F1): 'Chardon',
  const Color(0xFFFFF46E): 'Paris Daisy',
  const Color(0xFFFFF4CE): 'Barley White',
  const Color(0xFFFFF4DD): 'Egg Sour',
  const Color(0xFFFFF4E0): 'Sazerac',
  const Color(0xFFFFF4E8): 'Serenade',
  const Color(0xFFFFF4F3): 'Chablis',
  const Color(0xFFFFF5EE): 'Seashell Peach',
  const Color(0xFFFFF5F3): 'Sauvignon',
  const Color(0xFFFFF6D4): 'Milk Punch',
  const Color(0xFFFFF6DF): 'Varden',
  const Color(0xFFFFF6F5): 'Rose White',
  const Color(0xFFFFF8D1): 'Baja White',
  const Color(0xFFFFF9E2): 'Gin Fizz',
  const Color(0xFFFFF9E6): 'Early Dawn',
  const Color(0xFFFFFACD): 'Lemon Chiffon',
  const Color(0xFFFFFAF4): 'Bridal Heath',
  const Color(0xFFFFFBDC): 'Scotch Mist',
  const Color(0xFFFFFBF9): 'Soapstone',
  const Color(0xFFFFFC99): 'Witch Haze',
  const Color(0xFFFFFCEA): 'Buttery White',
  const Color(0xFFFFFCEE): 'Island Spice',
  const Color(0xFFFFFDD0): 'Cream',
  const Color(0xFFFFFDE6): 'Chilean Heath',
  const Color(0xFFFFFDE8): 'Travertine',
  const Color(0xFFFFFDF3): 'Orchid White',
  const Color(0xFFFFFDF4): 'Quarter Pearl Lusta',
  const Color(0xFFFFFEE1): 'Half and Half',
  const Color(0xFFFFFEEC): 'Apricot White',
  const Color(0xFFFFFEF0): 'Rice Cake',
  const Color(0xFFFFFEF6): 'Black White',
  const Color(0xFFFFFEFD): 'Romance',
  const Color(0xFFFFFF00): 'Yellow',
  const Color(0xFFFFFF66): 'Laser Lemon',
  const Color(0xFFFFFF99): 'Pale Canary',
  const Color(0xFFFFFFB4): 'Portafino',
  const Color(0xFFFFFFF0): 'Ivory',
  const Color(0xFFFFFFFF): 'White',
};
