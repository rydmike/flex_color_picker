import 'package:flutter/material.dart';
import 'package:test/test.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

void main() {
  //
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
    test('Test index 19 throws range error', () {
      expect(() => ColorTools.primaryColors[19], throwsRangeError);
    });
  });
  //
  //
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
    test('Test index 16 throws range error', () {
      expect(() => ColorTools.accentColors[16], throwsRangeError);
    });
  });
  //
  //
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
  //
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
