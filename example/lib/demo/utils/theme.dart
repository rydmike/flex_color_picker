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
      // TODO(rydmike): Remove commented deprecated API.
      // toggleableActiveColor: colorSchemeLight.secondary,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme:
          outlinedButtonTheme(colorSchemeLight, Colors.black38),
      textButtonTheme: textButtonTheme,
      toggleButtonsTheme: toggleButtonsThemeData(colorSchemeLight),
      tooltipTheme: tooltipTheme(false),
      visualDensity: VisualDensity.standard,
    );
  }

  // Light theme color scheme.
  static ColorScheme get colorSchemeLight => const ColorScheme.light().copyWith(
        primary: App.primaryLight,
        primaryContainer: App.primaryContainerLight,
        secondary: App.secondaryLight,
        secondaryContainer: App.secondaryContainerLight,
        surface: App.surfaceLight,
        background: App.backgroundLight,
        onPrimary: App.onPrimaryLight,
        onSecondary: App.onSecondaryLight,
      );

  /// The used dark theme.
  static ThemeData get dark {
    return ThemeData.from(
      colorScheme: colorSchemeDark,
      textTheme: textTheme,
    ).copyWith(
      scaffoldBackgroundColor: App.scaffoldBackgroundDark,
      // TODO(rydmike): Remove commented deprecated API.
      // toggleableActiveColor: colorSchemeDark.secondary,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      elevatedButtonTheme: elevatedButtonTheme,
      outlinedButtonTheme: outlinedButtonTheme(colorSchemeDark, Colors.white38),
      textButtonTheme: textButtonTheme,
      toggleButtonsTheme: toggleButtonsThemeData(colorSchemeDark),
      tooltipTheme: tooltipTheme(true),
      visualDensity: VisualDensity.standard,
    );
  }

  // Dark theme color scheme.
  static ColorScheme get colorSchemeDark => const ColorScheme.dark().copyWith(
        primary: App.primaryDark,
        primaryContainer: App.primaryContainerDark,
        secondary: App.secondaryDark,
        secondaryContainer: App.secondaryContainerDark,
        surface: App.surfaceDark,
        background: App.backgroundDark,
        onPrimary: App.onPrimaryDark,
        onSecondary: App.onSecondaryDark,
      );

  static TextTheme get textTheme => TextTheme(
        displayLarge: GoogleFonts.roboto(
            fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -1.5),
        displayMedium: GoogleFonts.roboto(
            fontSize: 48, fontWeight: FontWeight.w300, letterSpacing: -0.5),
        displaySmall:
            GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
        headlineMedium: GoogleFonts.roboto(
            fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        headlineSmall:
            GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
        titleLarge: GoogleFonts.roboto(
            fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
        bodyLarge: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
        bodyMedium: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
        titleMedium: GoogleFonts.roboto(
            fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
        titleSmall: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
        labelLarge: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
        bodySmall: GoogleFonts.roboto(
            fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
        labelSmall: GoogleFonts.roboto(
            fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
      );

  /// Theme definitions give ElevatedButton a Stadium rounded design.
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: roundButtonPadding,
        minimumSize: minButtonSize,
      ));

  /// Theme definitions give OutlinedButton a Stadium rounded design.
  static OutlinedButtonThemeData outlinedButtonTheme(
          ColorScheme scheme, Color disabledColor) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          // side: BorderSide(
          //   color: borderColor,
          //   width: App.outlineThickness,
          // ),
          padding: roundButtonPadding,
          minimumSize: minButtonSize,
        ).copyWith(
          side: MaterialStateProperty.resolveWith<BorderSide?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return BorderSide(
                  color: disabledColor,
                  width: 0.5,
                );
              }
              if (states.contains(MaterialState.error)) {
                return BorderSide(
                  color: scheme.error,
                  width: App.outlineThickness,
                );
              }
              return BorderSide(
                  color: scheme.primary, width: App.outlineThickness);
            },
          ),
        ),
      );

  /// Theme definitions give TextButton a Stadium rounded design.
  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
          style: TextButton.styleFrom(
        shape: const StadiumBorder(),
        padding: roundButtonPadding,
        minimumSize: minButtonSize,
      ));

  /// The stadium rounded buttons generally need a bit more padding to look
  /// good, adjust here to tune the padding for all of them globally in the app.
  /// Currently using the default padding the old buttons had.
  static const EdgeInsets roundButtonPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  /// The old buttons had a minimum size that looked better, we keep that.
  static const Size minButtonSize = Size(88, 36);

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
        waitDuration: const Duration(milliseconds: 1200),
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
      case TargetPlatform.iOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
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
