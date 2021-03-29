import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

/// App contains consts, colors and static helper functions used in the app.
class App {
  // This class is not meant to be instantiated or extended, this constructor
  // prevents external instantiation and extension.
  App._();

  // Just a simple way to leave a trace of what version we built the Flutter
  // Web demo with inside the app. Shown on the start screen in the demo,
  // so people testing it don't have to ask.
  static const String appName = 'FlexColorPicker';
  static const String version = '2.0.0-nullsafety.5';
  static const String packageVersion = 'FlexColorScheme package $version';
  static const String packageUrl = 'https://pub.dev/packages/flex_color_picker';
  static const String flutterVersion = 'Channel dev 2.1.0-12.1.pre, CanvasKit';
  static const String copyright = '© 2020, 2021';
  static const String author = 'Mike Rydstrom';
  static const String license = 'BSD 3-Clause License';
  static const String icon = 'assets/images/app_icon.png';

  // Max width of the body content when used on a wide screen.
  static const double maxBodyWidth = 2100;
  static const double minColumnWidth = 390;

  // Light theme colors
  static const Color primaryLight = Color(0xFF184782);
  static const Color primaryVariantLight = Color(0xFF0E2B4E);
  static const Color secondaryLight = Color(0xFFE59A18);
  static const Color secondaryVariantLight = Color(0xFFF0B03F);
  static const Color backgroundLight = Color(0xFFF9F9F9);
  static const Color surfaceLight = Color(0xFFFBFBFB);
  static const Color scaffoldBackgroundLight = Color(0xFFFDFDFD);

  // Dark theme colors
  static const Color primaryDark = Color(0xFF587BA1);
  static const Color primaryVariantDark = Color(0xFFF0F7FE);
  static const Color secondaryDark = Color(0xFFEBB251);
  static const Color secondaryVariantDark = Color(0xFFFDF4E4);
  static const Color backgroundDark = Color(0xFF121517);
  static const Color surfaceDark = Color(0xFF131517);
  static const Color scaffoldBackgroundDark = Color(0xFF131517);

  // Custom example colors for our custom picker.
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

  // A custom color swatch, to name map, for the above custom colors.
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

  // Compute text color for the three 'OnChange' chips.
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
}
