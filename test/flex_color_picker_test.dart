import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:test/test.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

void main() {
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
  // Test default English primary color names
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
  group('Verify Colors to color names map content', () {
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
      900
    ];

    for (final ColorSwatch<Object> swatch in Colors.primaries) {
      for (final int i in index) {
        test('Verify that ${swatch[i]} is a primary color ', () {
          expect(ColorTools.isPrimaryColor(swatch[i]), true);
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
        test('Verify that ${swatch[i]} is an accent color ', () {
          expect(ColorTools.isAccentColor(swatch[i]), true);
        });
      }
    }
  });
}
