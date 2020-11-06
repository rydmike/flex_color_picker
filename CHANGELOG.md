# Changelog

All notable changes to the **ColorPicker** will be documented in this file.

## [1.1.0] - November 6, 2020
* New API: Added `showColorValue` to optionally display the int value of the selected color. This can be used to assist developers when they need to see or copy selected color values as int numbers.
* New APIs: Exposed previously missing static color names in the API for all the accent and B&W color names in `ColorTools`. All the color name values default to English color names, but can now be changed to translated strings to provide Material color names in other languages as well.
* Updated the live Web demo to demonstrate the `showColorValue` property.
* Example and documentation updated.

## [1.0.0] - November 5, 2020
* First official release.
* Example and documentation updated.
* Updated the live Web demo version to use the released package.
* New API: Added `shouldUpdate` to the color wheel picker, as a fix for an issue where black selection changed hue to red. This is a lower level API that is not needed unless you make your own picker for scratch and you want to use the wheel picker in your picker.
* Final API name tweaks before version 1.0.0 release:
* Renamed: API `createPrimaryColor` -> `createPrimarySwatch`
* Renamed: API `createAccentColor` -> `createAccentSwatch`
* Renamed: API `colorNameAndHexCode` -> `materialNameAndCode`
* Renamed: API `colorName` -> `materialName`
* Renamed: API `colorHexCode` -> `colorCode`


## [1.0.0-dev.5] - November 5, 2020

* Added a feature on the wheel color picker that enables entry of a hex RGB value to select a color.
* API changes to support separate display of Material color name `showMaterialName` and selected color code `showColorCode`, plus defining their text styles `materialNameTextStyle` and `colorCodeTextStyle`.
* New API `showColorName` to display an English color name for any selected color, not just the Material color names or custom named color swatches. It has text style that can be defined as well `colorNameTextStyle`.
* New API `colorCodeIcon` that exposes the color code copy icon, so it can be customized.
* New API `enableTooltips` to enable current and future tooltips used in the picker. Currently, only the copy color code button has a tooltip.
* A new method introduced in ColorTools called `nameThatColor(Color color)`. It returns a name for any color passed to it. Only supports English names. Based on a Dart port of http://chir.ag/projects/ntc, it contains 1566 colors and their names. It matches the given color to the closest similar color in the list and returns its name.
* Example and documentation updated.

## [1.0.0-dev.4] - November 2, 2020

* Update to try to get the images to show up on pub.dev.
* Minor documentation corrections.

## [1.0.0-dev.3] - November 2, 2020

* Significant API name changes and cleanup. Decided to implement previously planned changes before the official release, even if it will also impact our own usage of the package when we move to using the published version.

## [1.0.0-dev.2] - October 30, 2020

* First development pre-release on pub.dev.

## To do list and planned feature updates

- [x] Review and update the API.
- [x] Review and correct documentation mistakes and typos, first pass anyway.
- [x] Fix doc images that show up OK in Github readme.md, but not on pub.dev.
- [x] For the color wheel picker, add text input to get a given color based on entered HEX code.
- [x] Add "name that color" function that can give a name to "any" color in English.
- [x] Release version 1.0.0.
- [x] Publish version 1.0.0 on pub.dev.
- [ ] Version 1.1.x: Add first set of tests for the ColorPicker and its supporting classes.
- [ ] Version 1.1.y: Finalize the tests.
- [ ] Maybe version 2.0.x: Add more color picker types.
- [ ] Maybe version 2.x.x: Add a color selected with the wheel color selector to the custom colors section.
- [ ] Maybe version 2.x.x: Store colors added to the custom colors section.
