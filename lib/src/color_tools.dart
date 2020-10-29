import 'package:flutter/material.dart';

/// Color tool functions used e.g. by ColorPicker. The functions are wrapped in
/// the [ColorTools] class to name space them. These color helpers can be used
/// on their own outside the ColorPicker widget if so desired.
///
/// There are helpers for:
/// * Get English names for the colors.
/// * Find if a color belongs to a color swatch.
/// * Get the swatch a color belongs to.
/// * Create material and accent like swatches of a color.
class ColorTools {
  // Private constructor, does not show up in code completion, useful when
  // there are only static functions and we have nothing to construct.
  ColorTools._();

  /// A list of the standard Material Primary color swatches.
  ///
  /// This Material colors swatch list also exists in the Flutter
  /// SDK in colors.dart as a static const [Colors.primaries],
  /// but that list excludes grey and we needed that included too,
  /// hence this custom version.
  static const List<ColorSwatch<Object>> primaryColors = <ColorSwatch<Object>>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey
  ];

  // Static string name for all the material primary colors
  /// English name for Material red color.
  static String redName = 'Red';

  /// English name for Material pink color.
  static String pinkName = 'Pink';

  /// English name for Material purple color.
  static String purpleName = 'Purple';

  /// English name for Material deep purple color.
  static String deepPurpleName = 'Deep purple';

  /// English name for Material indigo color.
  static String indigoName = 'Indigo';

  /// English name for Material blue color.
  static String blueName = 'Blue';

  /// English name for Material light blue color.
  static String lightBlueName = 'Light blue';

  /// English name for Material cyan color.
  static String cyanName = 'Cyan';

  /// English name for Material teal color.
  static String tealName = 'Teal';

  /// English name for Material green color.
  static String greenName = 'Green';

  /// English name for Material light green color.
  static String lightGreenName = 'Light green';

  /// English name for Material lime color.
  static String limeName = 'Lime';

  /// English name for Material yellow color.
  static String yellowName = 'Yellow';

  /// English name for Material amber color.
  static String amberName = 'Amber';

  /// English name for Material orange color.
  static String orangeName = 'Orange';

  /// English name for Material deep orange color.
  static String deepOrangeName = 'Deep orange';

  /// English name for Material brown color.
  static String brownName = 'Brown';

  /// English name for Material grey color.
  static String greyName = 'Grey';

  /// English name for Material blue grey color.
  static String blueGreyName = 'Blue-grey';

  /// Static map of Material Primary colors swatches and their English names.
  ///
  /// Use the [ColorSwatch] as key to get its English name string as
  /// defined by the Material standard.
  static Map<ColorSwatch<Object>, String> primaryColorNames =
      <ColorSwatch<Object>, String>{
    Colors.red: redName,
    Colors.pink: pinkName,
    Colors.purple: purpleName,
    Colors.deepPurple: deepPurpleName,
    Colors.indigo: indigoName,
    Colors.blue: blueName,
    Colors.lightBlue: lightBlueName,
    Colors.cyan: cyanName,
    Colors.teal: tealName,
    Colors.green: greenName,
    Colors.lightGreen: lightGreenName,
    Colors.lime: limeName,
    Colors.yellow: yellowName,
    Colors.amber: amberName,
    Colors.orange: orangeName,
    Colors.deepOrange: deepOrangeName,
    Colors.brown: brownName,
    Colors.grey: greyName,
    Colors.blueGrey: blueGreyName,
  };

  /// A list of the standard Material Accent color swatches.
  ///
  /// This Material colors swatch list also exists in the Flutter
  /// framework in colors.dart as a static const [Colors.accents], since we
  /// used a custom version for the primary material colors, we might
  /// as well use one for the accents too.
  static const List<ColorSwatch<Object>> accentColors = <ColorSwatch<Object>>[
    Colors.redAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.deepPurpleAccent,
    Colors.indigoAccent,
    Colors.blueAccent,
    Colors.lightBlueAccent,
    Colors.cyanAccent,
    Colors.tealAccent,
    Colors.greenAccent,
    Colors.lightGreenAccent,
    Colors.limeAccent,
    Colors.yellowAccent,
    Colors.amberAccent,
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
  ];

  /// Static map of Material Accent colors swatches and their English names.
  ///
  /// Use [ColorSwatch] as key to get its English name string as defined
  /// by the Material standard
  static Map<ColorSwatch<Object>, String> accentColorsNames =
      <ColorSwatch<Object>, String>{
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
  };

  /// A color swatch for almost black colors, ending in black.
  ///
  /// These are none transparent shades of close to black values, useful when
  /// you want slightly off-black values that are not transparent.
  static const ColorSwatch<Object> blackShade = ColorSwatch<Object>(
    0xFF141414,
    <int, Color>{
      50: Color(0xFF121212),
      100: Color(0xFF111111),
      200: Color(0xFF101010),
      300: Color(0xFF0E0E0E),
      400: Color(0xFF0C0C0C),
      500: Color(0xFF0A0A0A),
      600: Color(0xFF080808),
      700: Color(0xFF050505),
      800: Color(0xFF030303),
      900: Color(0xFF000000),
    },
  );

  /// A color swatch for almost white colors, starting in white.
  ///
  /// These are none transparent shades of close to white values, useful when
  /// you want slightly off-white values that are not transparent.
  static const ColorSwatch<Object> whiteShade = ColorSwatch<Object>(
    0xFFEFEFEF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFEFEFE),
      200: Color(0xFFFDFDFD),
      300: Color(0xFFFCFCFC),
      400: Color(0xFFFBFBFB),
      500: Color(0xFFFAFAFA),
      600: Color(0xFFF9F9F9),
      700: Color(0xFFF8F8F8),
      800: Color(0xFFF7F7F7),
      900: Color(0xFFF6F6F6),
    },
  );

  /// The [blackShade] and [whiteShade] in a color swatch list
  static const List<ColorSwatch<Object>> blackAndWhite = <ColorSwatch<Object>>[
    blackShade,
    whiteShade,
  ];

  /// Static map of black and white shades and their English names.
  ///
  /// Use [ColorSwatch] as key to get its English name string as defined
  /// by the Material standard
  static Map<ColorSwatch<Object>, String> blackAndWhiteNames =
      <ColorSwatch<Object>, String>{
    blackShade: 'Black',
    whiteShade: 'White',
  };

  /// A combined list of both color material primary and accent swatches.
  ///
  /// Can be used if you want a color picker that mixes and includes both the
  /// the primary material colors and the accent colors in the same picker.
  /// The related colors are grouped after each other so that they come in
  /// logical color order.
  static const List<ColorSwatch<Object>> bothPrimaryAndAccentColors =
      <ColorSwatch<Object>>[
    Colors.red,
    Colors.redAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.purple,
    Colors.purpleAccent,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.blue,
    Colors.blueAccent,
    Colors.lightBlue,
    Colors.lightBlueAccent,
    Colors.cyan,
    Colors.cyanAccent,
    Colors.teal,
    Colors.tealAccent,
    Colors.green,
    Colors.greenAccent,
    Colors.lightGreen,
    Colors.lightGreenAccent,
    Colors.lime,
    Colors.limeAccent,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.amber,
    Colors.amberAccent,
    Colors.orange,
    Colors.orangeAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey
  ];

  /// Check if a color is included in any Material primary color swatch.
  ///
  /// If the color is a Material primary color, return true, otherwise false.
  static bool isPrimaryColor(Color color) {
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
      850,
      900
    ];
    for (final ColorSwatch<Object> swatch in primaryColors) {
      for (final int i in index) {
        if (swatch[i] == color) {
          return true; // Color found in a swatch so we return true
        }
      }
    }
    // Did not find the given color in any standard Material color swatch,
    // so we return false
    return false;
  }

  /// Returns a Material primary color swatch for the color given to it.
  ///
  /// If the color is a part of a standard material primary color swatch,
  /// then the standard primary color swatch will be returned.
  /// If the color is not a Material standard primary color, it will create a
  /// material swatch for the given color using the given color
  /// as the mid [500] value and return this created custom primary color Swatch.
  /// This color swatch can then be used as a primary Material color swatch.
  static MaterialColor primarySwatch(Color color) {
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
      850,
      900
    ];
    for (final ColorSwatch<Object> swatch in primaryColors) {
      for (final int i in index) {
        if (swatch[i] == color) {
          return swatch
              as MaterialColor; // Color found in a swatch so we return it
        }
      }
    }
    // Did not find the given color in a standard Material color swatch,
    // so make a custom material swatch based on the given color and return it.
    return createPrimaryColor(color);
  }

  // Found this little Material shade calculation gem here:
  // https://medium.com/@filipvk/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
  // Originally made by by Filip Velickovic https://filipvk.bitbucket.io/
  //
  /// Create a Material color primary swatch from a given single color.
  ///
  /// The provided color is used as the Material swatch default color [500] in
  /// the returned swatch, with lighter hues for lower index and darker hues for
  /// higher indexes.
  /// If you give this function a standard Material color [500] value,
  /// eg Colors.red[500] it will not return the same swatch as Colors.red.
  /// This function is an approximation and gives an automated way of creating
  /// a material like primary swatch.
  /// The official Material colors contain hand tuned hues. To get
  /// an official Material swatch from a color use [primarySwatch] that
  /// returns the real Material swatch first for a color, if it is a standard
  /// Material primary color and then a Material like swatch, if it was
  /// not a standard material primary color hue.
  static MaterialColor createPrimaryColor(Color color) {
    final List<double> strengths = <double>[
      0.05,
      0.1,
      0.2,
      0.3,
      0.4,
      0.5,
      0.6,
      0.7,
      0.8,
      0.9
    ];
    final Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;
    for (final double strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  /// Check if a color is included in any Material Accent color swatch
  ///
  /// If the color is a Material Accent color, return true, otherwise false.
  static bool isAccentColor(Color color) {
    final List<int> index = <int>[100, 200, 400, 700];
    for (final ColorSwatch<Object> swatch in accentColors) {
      for (final int i in index) {
        if (swatch[i] == color) {
          return true; // Color found in a swatch so we return true
        }
      }
    }
    // Did not find the given color in any standard Material color swatch,
    // so we return false
    return false;
  }

  /// Returns a Material accent color swatch for the color given to it.
  ///
  /// If the color is a part of a standard material accent color swatch,
  /// then the standard accent color swatch will be returned.
  /// If the color is not a Material standard accent color, it will create a
  /// material swatch for the given color using the given color
  /// as [200] value and return this created custom color accent Swatch.
  /// This color swatch can then be used as a accent Material color swatch.
  static MaterialAccentColor accentSwatch(Color color) {
    final List<int> index = <int>[100, 200, 400, 700];
    for (final ColorSwatch<Object> swatch in accentColors) {
      for (final int i in index) {
        if (swatch[i] == color) {
          return swatch
              as MaterialAccentColor; // Found in a swatch, return swatch
        }
      }
    }
    // Did not find the given color in a standard Material accent swatch,
    // so lets make our own accent swatch based on the given color
    return createAccentColor(color);
  }

  // This is an accentSwatch version made based on this gem:
  // https://medium.com/@filipvk/creating-a-custom-color-swatch-in-flutter-554bcdcb27f3
  // Which was originally made by Filip Velickovic https://filipvk.bitbucket.io/
  //
  /// Create an Accent color swatch from a given single color.
  ///
  /// The provided color is used as the Accent swatch default color [200] in the
  /// returned swatch with lighter hues for lower index and darker hues
  /// for higher indexes.
  static MaterialAccentColor createAccentColor(Color color) {
    final List<double> strengths = <double>[0.1, 0.2, 0.4, 0.7];
    final Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;
    for (final double strength in strengths) {
      final double ds = 0.2 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
          r + ((ds < 0 ? r : (255 - r)) * ds).round(),
          g + ((ds < 0 ? g : (255 - g)) * ds).round(),
          b + ((ds < 0 ? b : (255 - b)) * ds).round(),
          1);
    }
    return MaterialAccentColor(color.value, swatch);
  }

  /// Check if a color is included in the custom black and white swatches
  ///
  /// If the color is a black or white swatch, return true, otherwise false.
  static bool isBlackAndWhiteColor(Color color) {
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
    for (final ColorSwatch<Object> swatch in blackAndWhite) {
      for (final int i in index) {
        if (swatch[i] == color) {
          return true; // Color found in a swatch so we return true
        }
      }
    }
    // Did not find the given color in any black or white swatch, return false
    return false;
  }

  /// Returns a black or white color swatch for the color given to it.
  ///
  /// If the color is a part of a black and white color swatch,
  /// then the Black or White color swatch will be returned.
  /// If the color is not in these swatches, it will create a
  /// primary material swatch for the given color using the given color
  /// as the mid [500] value and return this created custom primary color Swatch.
  /// This color swatch can then be used as a primary Material color swatch.
  static ColorSwatch<Object> blackAndWhiteSwatch(Color color) {
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
      850,
      900
    ];
    for (final ColorSwatch<Object> swatch in blackAndWhite) {
      for (final int i in index) {
        if (swatch[i] == color) {
          return swatch; // Color found in a swatch so we return it
        }
      }
    }
    // Did not find the given color in a standard Material color swatch,
    // so make a custom material swatch based on the given color and return it.
    return createPrimaryColor(color);
  }

  /// Check if a color is included in a custom color swatches.
  ///
  /// If the color is a custom swatch, return true, otherwise false.
  static bool isCustomColor(
      Color color, Map<ColorSwatch<Object>, String> customSwatch) {
    if (customSwatch != null) {
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
      for (final ColorSwatch<Object> swatch in customSwatch.keys) {
        for (final int i in index) {
          if (swatch[i] == color) {
            return true; // Color found in a swatch so we return true
          }
        }
      }
    }
    // Did not find the given color in any black or white swatch, return false
    return false;
  }

  /// Returns the custom color swatch for the color given to it.
  ///
  /// If the color is a part of a custom color swatch,
  /// then the custom color swatch will be returned.
  /// If the color is not in these swatches, it will create a
  /// primary material swatch for the given color using the given color
  /// as the mid [500] value and return this created custom primary color Swatch.
  /// This color swatch can then be used as a primary Material color swatch.
  static ColorSwatch<Object> customSwatch(
      Color color, Map<ColorSwatch<Object>, String> customSwatch) {
    if (customSwatch != null) {
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
      for (final ColorSwatch<Object> swatch in customSwatch.keys) {
        for (final int i in index) {
          if (swatch[i] == color) {
            return swatch; // Color found in a swatch so we return it
          }
        }
      }
    }
    // Did not find the given color in the custom color swatch,
    // so make a custom material swatch based on the given color and return it.
    return createPrimaryColor(color);
  }

  /// Returns the official Material color name for the color passed to it,
  /// including the shade index and Flutter style HexCode.
  ///
  /// If it is not a Material color or one of the Accents colors, only the
  /// Flutter style Hex code is returned.
  /// This function is used by the ColorPicker class to show selected color
  /// names and their shade index. The function also accepts an optional
  /// color swatch to name map that can be used to look-up name of custom
  /// material like color swatches.
  static String colorNameAndHexCode(Color color,
      {Map<ColorSwatch<Object>, String> colorSwatchNameMap}) {
    final String _name =
        colorName(color, colorSwatchNameMap: colorSwatchNameMap);

    if (_name == '') {
      // This is not a material color, we just return it's Flutter like HEX code
      return '(0x${colorHexCode(color)})';
    } else {
      return '$_name (0x${colorHexCode(color)})';
    }
  }

  // IMPORTANT: The name getter does not work if the color value has been
  // assigned from a material color without choosing the swatch! Is it because
  // the none index value is an int? Maybe, why is that so anyway?
  // After adding the check:
  // || swatch[i].value == color.value
  // to the: if (swatch[i] == color || swatch[i].value == color.value)
  // the [colorName] function works even if the Color value has been assigned
  // from swatch color like so: _passColor = Colors.red;
  // and not from its index, like so: _passColor = Colors.red[500];
  // which also works. This is a bit weird, as the extra check was not needed
  // or did not even work on the above checks where we look if a color is in
  // a swatch in e.g. the isPrimaryColor function.
  //
  /// The function returns the official Material color
  /// name for the color passed to it.
  ///
  /// It includes the shade index if the flag [withIndex] is true.
  /// If the given color is not a material color or one of the accents colors,
  /// an empty string is returned. I can also take as input a custom color
  /// swatch to name map, and return a custom name for any color found in
  /// any of the custom color swatches in the map.
  static String colorName(Color color,
      {Map<ColorSwatch<Object>, String> colorSwatchNameMap,
      bool withIndex = true}) {
    List<int> index = <int>[
      50,
      100,
      200,
      300,
      400,
      500,
      600,
      700,
      850,
      800,
      900
    ];

    // If it is a black or white shade, return name, shade and HEX string.
    for (final ColorSwatch<Object> swatch in blackAndWhiteNames.keys) {
      for (final int i in index) {
        if (swatch[i] == color) {
          if (withIndex) {
            return '${blackAndWhiteNames[swatch]} [$i]';
          } else {
            return blackAndWhiteNames[swatch];
          }
        }
      }
    }

    // If it is a primary color, return name, shade and HEX string.
    // We also check the 850 index that is used by grey color!
    for (final ColorSwatch<Object> swatch in primaryColorNames.keys) {
      for (final int i in index) {
        if (swatch[i] == color) {
          if (withIndex) {
            return '${primaryColorNames[swatch]} [$i]';
          } else {
            return primaryColorNames[swatch];
          }
        }
      }
    }

    // If it is an accent color, return name, shade and HEX string.
    index = <int>[100, 200, 400, 700];
    for (final ColorSwatch<Object> swatch in accentColorsNames.keys) {
      for (final int i in index) {
        if (swatch[i] == color) {
          if (withIndex) {
            return '${accentColorsNames[swatch]} [$i]';
          } else {
            return accentColorsNames[swatch];
          }
        }
      }
    }

    // If we have a custom color and name map passed, we will check if the color
    // exists in it as well and what name it has in the map.
    if (colorSwatchNameMap != null) {
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
      for (final ColorSwatch<Object> swatch in colorSwatchNameMap.keys) {
        for (final int i in index) {
          if (swatch[i] == color) {
            if (withIndex) {
              return '${colorSwatchNameMap[swatch]} [$i]';
            } else {
              return colorSwatchNameMap[swatch];
            }
          }
        }
      }
    }
    // If all the above did not yield a name, it has no defined name
    // then we just return an empty string
    return '';
  }

  /// Return the color value as a HexCode string in uppercase.
  static String colorHexCode(Color color) {
    return color.value.toRadixString(16).toUpperCase();
  }
}
