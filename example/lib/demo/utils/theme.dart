import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';

/// The theme for this app.
class AppTheme {
  // This constructor prevents external instantiation and extension.
  AppTheme._();

  /// The used light theme.
  static ThemeData get light {
    return ThemeData.from(
      colorScheme: colorSchemeLight,
      textTheme: textTheme,
    ).copyWith(
      scaffoldBackgroundColor: App.scaffoldBackgroundLight,
      toggleableActiveColor: colorSchemeLight.secondary,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme(App.primaryLight),
      textButtonTheme: textButtonTheme,
      toggleButtonsTheme: toggleButtonsThemeData(colorSchemeLight),
      tooltipTheme: tooltipTheme(false),
      visualDensity: VisualDensity.standard,
    );
  }

  // Light theme color scheme.
  static ColorScheme get colorSchemeLight => const ColorScheme.light().copyWith(
        primary: App.primaryLight,
        primaryVariant: App.primaryVariantLight,
        secondary: App.secondaryLight,
        secondaryVariant: App.secondaryVariantLight,
        surface: App.surfaceLight,
        background: App.backgroundLight,
      );

  /// The used dark theme.
  static ThemeData get dark {
    return ThemeData.from(
      colorScheme: colorSchemeDark,
      textTheme: textTheme,
    ).copyWith(
      scaffoldBackgroundColor: App.scaffoldBackgroundDark,
      toggleableActiveColor: colorSchemeDark.secondary,
      appBarTheme: const AppBarTheme(
        backgroundColor: App.scaffoldBackgroundDark,
        foregroundColor: Colors.white,
        elevation: 0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme(App.primaryDark),
      textButtonTheme: textButtonTheme,
      toggleButtonsTheme: toggleButtonsThemeData(colorSchemeDark),
      tooltipTheme: tooltipTheme(true),
      visualDensity: VisualDensity.standard,
    );
  }

  // Dark theme color scheme.
  static ColorScheme get colorSchemeDark => const ColorScheme.dark().copyWith(
        primary: App.primaryDark,
        primaryVariant: App.primaryVariantDark,
        secondary: App.secondaryDark,
        secondaryVariant: App.secondaryVariantDark,
      );

  // TODO: Investigate potential GoogleFonts issue on Windows platform.
  // Making a custom text theme here, via on-line GoogleFonts load. Intended to
  // use something else than "Roboto", but they were all a little bit
  // broken on Windows platform, not sure why. Need to download and try as
  // assets and compare to that method and also compare to Web builds.
  // Tested like this with: 'sourceSansPro', 'lato' and 'notoSans' all in
  // theory nice fonts, but all were a tiny bit broken with clearly faulty
  // pixels in some letters on Windows builds. Did not test Web builds with
  // them yet used via GoogleFonts. Anyway sticking to plain old "roboto" for
  // now. At least with this setup will get the "Roboto" font on all platforms.
  // If no font is specified, we will get platform dependent default font,
  // just want the same font here for ALL platforms to ensure a consistent
  // result in this demo.
  static TextTheme get textTheme => TextTheme(
        headline1: GoogleFonts.roboto(
            fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        headline2: GoogleFonts.roboto(
            fontSize: 48, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        headline3:
            GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
        headline4: GoogleFonts.roboto(
            fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        headline5:
            GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
        headline6: GoogleFonts.roboto(
            fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        bodyText1: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        bodyText2: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        subtitle1: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        subtitle2: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        button: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
        caption: GoogleFonts.roboto(
            fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        overline: GoogleFonts.roboto(
            fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
      );

  /// Theme definitions give ElevatedButton a Stadium rounded design.
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: roundButtonPadding,
        minimumSize: const Size(App.roundButtonMinSize, App.roundButtonMinSize),
      ));

  /// Theme definitions give OutlinedButton a Stadium rounded design.
  static OutlinedButtonThemeData outlinedButtonTheme(Color borderColor) =>
      OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: BorderSide(
          color: borderColor,
          width: App.outlineThickness,
        ),
        padding: roundButtonPadding,
        minimumSize: const Size(App.roundButtonMinSize, App.roundButtonMinSize),
      ));

  /// Theme definitions give TextButton a Stadium rounded design.
  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
          style: TextButton.styleFrom(
        shape: const StadiumBorder(),
        padding: roundButtonPadding,
        minimumSize: const Size(App.roundButtonMinSize, App.roundButtonMinSize),
      ));

  /// The stadium rounded buttons need a bit more padding to look.
  static const EdgeInsets roundButtonPadding =
      EdgeInsets.symmetric(horizontal: 21);

  /// ToggleButtons theme
  static ToggleButtonsThemeData toggleButtonsThemeData(
          ColorScheme colorScheme) =>
      ToggleButtonsThemeData(
        color: colorScheme.onSurface,
        selectedColor: colorScheme.onPrimary,
        fillColor: colorScheme.secondary.withOpacity(0.94),
        hoverColor: colorScheme.primary.withOpacity(0.2),
        focusColor: colorScheme.primary.withOpacity(0.3),
        borderWidth: App.outlineThickness,
        borderColor: colorScheme.primary,
        selectedBorderColor: colorScheme.primary,
        constraints: const BoxConstraints(
          minWidth: App.borderRadius,
          maxWidth: App.borderRadius * 2,
          minHeight: App.borderRadius,
          maxHeight: App.borderRadius,
        ),
        borderRadius: BorderRadius.circular(App.borderRadius),
      );

  /// Use an alternative tooltip style.
  static TooltipThemeData tooltipTheme(bool isDark) => TooltipThemeData(
        padding: const EdgeInsets.fromLTRB(8, 4, 8, 5),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        textStyle: TextStyle(
          color: isDark ? Colors.black : Colors.white,
          fontSize: tooltipFontSize,
        ),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFFCFCFCF).withOpacity(0.94)
              : const Color(0xFF444444).withOpacity(0.93),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(
            color: isDark ? const Color(0x1FFFFFFF) : const Color(0x1F000000),
          ),
        ),
      );

  /// The current default theme for Material themed Tooltips are poor design
  /// choices for desktop https://material.io/components/tooltips#specs.
  /// See issue: https://github.com/flutter/flutter/issues/71429
  /// The font size of 10 dp is just too small for desktops with pixel density
  /// 1.0. Normally I use 12dp on desktop, but reading the API tooltips at
  /// 13 dp was a bit nicer.
  static double get tooltipFontSize {
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return 13;
      default:
        return 14;
    }
  }

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

  // Helper for system overlay style for AnnotatedRegion.
  static SystemUiOverlayStyle overlayStyle(bool isLight) =>
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
        statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
        systemNavigationBarColor:
            isLight ? App.scaffoldBackgroundLight : App.scaffoldBackgroundDark,
        systemNavigationBarIconBrightness:
            isLight ? Brightness.dark : Brightness.light,
      );
}
