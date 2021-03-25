import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

/// App contains consts, colors and static helper functions used in the app.
class App {
  // This class is not meant to be instantiated or extended, this constructor
  // prevents external instantiation and extension.
  App._();

  // Just a simple way to leave a trace of what version you built a Flutter
// Web demo with inside the app. You can also show it in the demo,
// like in this example, so people testing it don't have to ask.
  static const String flutterVersion = 'Channel dev 2.1.0-12.1.pre SKIA';
  static const String colorPickerVersion = '2.0.0-nullsafety.5';

  // Max width of the body content when used on a wide screen.
  static const double maxBodyWidth = 2100;
  static const double minColumnWidth = 390;

  // Light theme colors
  static const Color primaryLight = Color(0xFF3B5998);
  static const Color primaryVariantLight = Color(0xFF3F729B);
  static const Color secondaryLight = Color(0xFF55ACEE);
  static const Color secondaryVariantLight = Color(0xFFA2D1F6);

  // Dark theme colors
  static const Color primaryDark = Color(0xFF8B9DC3);
  static const Color primaryVariantDark = Color(0xFF799CB9);
  static const Color secondaryDark = Color(0xFFA0D1F5);
  static const Color secondaryVariantDark = Color(0xFF607D93);

  // Some custom example colors for our custom picker.
  static const Color guideNewPrimary = Color(0xFF6200EE);
  static const Color guideNewPrimaryVariant = Color(0xFF3700B3);
  static const Color guideNewSecondary = Color(0xFF03DAC6);
  static const Color guideNewSecondaryVariant = Color(0xFF018786);
  static const Color guideNewError = Color(0xFFB00020);
  static const Color guideNewErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);
  static const Color clearBlue = Color(0xFF3db5e0);
  static const Color darkPink = Color(0xFFa33e94);
  static const Color redWine = Color(0xFFad0c1c);
  static const Color grassGreen = Color(0xFF3bb87f);
  static const Color moneyGreen = Color(0xFF869962);
  static const Color mandarinOrange = Color(0xFFdb7a25);
  static const Color brightOrange = Color(0xFFff5319);
  static const Color brightGreen = Color(0xFF00ab25);
  static const Color blueJean = Color(0xFF4f75b8);
  static const Color deepBlueSea = Color(0xFF132b80);

  // Make a custom color swatch to name map from the above custom colors.
  static Map<ColorSwatch<Object>, String> get colorsNameMap =>
      <ColorSwatch<Object>, String>{
        ColorTools.createPrimarySwatch(guideNewPrimary): 'Guide Purple',
        ColorTools.createPrimarySwatch(guideNewPrimaryVariant):
            'Guide Purple Variant',
        ColorTools.createAccentSwatch(guideNewSecondary): 'Guide Teal',
        ColorTools.createAccentSwatch(guideNewSecondaryVariant):
            'Guide Teal Variant',
        ColorTools.createPrimarySwatch(guideNewError): 'Guide Error',
        ColorTools.createPrimarySwatch(guideNewErrorDark): 'Guide Error Dark',
        ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
        ColorTools.createPrimarySwatch(clearBlue): 'Clear blue',
        ColorTools.createPrimarySwatch(darkPink): 'Dark pink',
        ColorTools.createPrimarySwatch(redWine): 'Red wine',
        ColorTools.createPrimarySwatch(grassGreen): 'Grass green',
        ColorTools.createPrimarySwatch(moneyGreen): 'Money green',
        ColorTools.createPrimarySwatch(mandarinOrange): 'Mandarin orange',
        ColorTools.createPrimarySwatch(brightOrange): 'Bright orange',
        ColorTools.createPrimarySwatch(brightGreen): 'Bright green',
        ColorTools.createPrimarySwatch(blueJean): 'Washed jean blue',
        ColorTools.createPrimarySwatch(deepBlueSea): 'Deep blue sea',
      };

  static Map<ColorSwatch<Object>, String> get colorsNameMap2 =>
      <ColorSwatch<Object>, String>{
        const MaterialColor(0xFFfae738, <int, Color>{
          50: Color(0xFFfffee9),
          100: Color(0xFFfff9c6),
          200: Color(0xFFfff59f),
          300: Color(0xFFfff178),
          400: Color(0xFFfdec59),
          500: Color(0xFFfae738),
          600: Color(0xFFf3dd3d),
          700: Color(0xFFdfc735),
          800: Color(0xFFcbb02f),
          900: Color(0xFFab8923),
        }): 'Alpine',
        ColorTools.createPrimarySwatch(const Color(0xFFBC350F)): 'Rust',
        ColorTools.createAccentSwatch(const Color(0xFFB062DB)): 'Lavender',
      };

  // Compute text color for the 'OnEvent' chips.
  static Color getChipTextColor(Color background, bool isLight) {
    final bool isLightBackground =
        ThemeData.estimateBrightnessForColor(background) == Brightness.light;
    return isLight
        ? (isLightBackground || background.opacity < 0.5)
            ? Colors.black
            : Colors.white
        : (!isLightBackground || background.opacity < 0.5)
            ? Colors.white
            : Colors.black;
  }

  // static Color onColor(Color color) {
  //   return ThemeData.estimateBrightnessForColor(primaryLight) ==
  //           Brightness.light
  //       ? Colors.black
  //       : Colors.white;
  // }
}
