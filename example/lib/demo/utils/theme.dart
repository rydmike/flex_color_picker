import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

/// The theme for this app.
class AppTheme {
  AppTheme._();

  /// The used light theme.
  static ThemeData get light {
    final ColorScheme colorSchemeLight =
        ColorScheme.fromSeed(seedColor: App.seedColor);
    return ThemeData.from(
      colorScheme: ColorScheme.fromSeed(seedColor: App.seedColor),
      useMaterial3: true,
    ).copyWith(
      scaffoldBackgroundColor: App.scaffoldBackgroundLight,
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
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }

  /// The used dark theme.
  static ThemeData get dark {
    final ColorScheme colorSchemeDark = ColorScheme.fromSeed(
        seedColor: App.seedColor, brightness: Brightness.dark);
    return ThemeData.from(
      colorScheme: colorSchemeDark,
      useMaterial3: true,
      // textTheme: textTheme,
    ).copyWith(
      scaffoldBackgroundColor: App.scaffoldBackgroundDark,
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
      typography: Typography.material2021(platform: defaultTargetPlatform),
    );
  }

  /// Theme definitions give ElevatedButton a Stadium rounded design.
  static ElevatedButtonThemeData get elevatedButtonTheme =>
      ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        padding: roundButtonPadding,
      ));

  /// Theme definitions give OutlinedButton a Stadium rounded design.
  static OutlinedButtonThemeData outlinedButtonTheme(
          ColorScheme scheme, Color disabledColor) =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: roundButtonPadding,
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
                color: scheme.primary,
                width: App.outlineThickness,
              );
            },
          ),
        ),
      );

  /// Theme definitions give TextButton a Stadium rounded design.
  static TextButtonThemeData get textButtonTheme => TextButtonThemeData(
          style: TextButton.styleFrom(
        // shape: const StadiumBorder(),
        padding: roundButtonPadding,
      ));

  /// The stadium rounded buttons generally need a bit more padding to look
  /// good, adjust here to tune the padding for all of them globally in the app.
  static const EdgeInsets roundButtonPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 4);

  /// ToggleButtons theme
  static ToggleButtonsThemeData toggleButtonsThemeData(
          ColorScheme colorScheme) =>
      ToggleButtonsThemeData(
        color: colorScheme.onSurface,
        selectedColor: colorScheme.onPrimaryContainer,
        fillColor: colorScheme.primaryContainer,
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
        waitDuration: const Duration(milliseconds: 1200),
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

  /// Custom tooltip font size.
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
