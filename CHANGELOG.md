# Changelog

All notable changes to the **FlexColorPicker** package will be documented in this file.

## [2.0.0-nullsafety.1] - February NN, 2021
* New property: selectedPickerTypeColor. Sets the thumb color of the selected picker type.
* New property: colorCodePrefixStyle. Defines the text style of the prefix for the color code.
  If not defined it default to same style as colorCodeTextStyle.
* New property: title. A Widget used as an app bar type of Widget above the heading. Can
  included select and close/cancel icon buttons when used as dialog.
* Dialog without Cancel and Select buttons, the app bar buttons must be enabled to remove them.  
* Copy/paste improvements.
* Maybe: Enable transparency toggle.
* Maybe: Optional Toggle buttons picker selector instead of cupertino slider
  
## [2.0.0-nullsafety.0] - February 15, 2021
* First version with null safety.
* A workaround to https://github.com/flutter/flutter/issues/71687 was introduced. The issue has not been resolved.
  However, the workaround allows for the Wrap implementation that was changed to a Row in version 1.1.2, to be used
  again.
* The almost full API configurable Web example and demo, was included in the package in "example/lib/demo/mina.dart" together
  with the previous default example in "example/lib/main.dart". Previously this Web example was in a separate GitHub
  repository. The example was updated to make it responsive, to offer better usability on Web.

## [1.1.3] - December 22, 2020
* Fixed the faulty documentation and comment for showPickerDialog parameter insetPadding.
* Fixed the faulty default value for showPickerDialog parameter insetPadding, the new default
  value is the same as Flutter and Material default
  `EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0)`, as it should have been.
* Minor documentation style correction.

## [1.1.2] - December 5, 2020
* Temporary: The Wrap implementation for showing the color code and integer value was changed to a Row due to a regression in Flutter SDK causing a crash issue on channels dev and master when showing the ColorPicker in a Dialog. For more info see here: https://github.com/flutter/flutter/issues/71687
When the issue is resolved, the implementation will be reverted to Wrap again. Using a Wrap has the added benefit of breaking the color code display+input field, and the rarely used int value, into two rows in case a large font is used in a narrow view when they are both configured to be shown. The Row may overflow in some rare cases. If you do not plan to use the ColorPicker with channels and versions affected by the issue, you can still use the previous version 1.1.1 to keep using the Wrap implementation if you need it. With normal styling it is typically not needed.
* Fixed that the provided `TextStyle` via property `colorCodeTextStyle` was not also applied to the shown color integer value when `showColorValue` was set to `true`, as stated in API doc and intended.

## [1.1.1] - November 11, 2020
* Updated the example app and documentation. The update includes updated screenshots and updated animated gifs.
* Unit tests for ColorTools added, widget tests still pending for later updates.

## [1.1.0] - November 6, 2020
* New API: Added `showColorValue` to optionally display the int value of the selected color. This can be used to assist developers when they need to see or copy selected color values as int numbers.
* New APIs: Exposed previously missing static color names in the API for all the accent and B&W color names in `ColorTools`. All the color name values default to English color names, but can now be changed to translated strings to provide Material color names in other languages as well.
* Updated the live Web demo to demonstrate the `showColorValue` property.
* Example and documentation updated.

## [1.0.0] - November 5, 2020
* First official release.
* Example and documentation updated.
* Updated the live Web demo version to use the released package.
* New API: Added `shouldUpdate` to the color wheel picker, as a fix for an issue where black selection changed hue to red. This is a lower level API that is not needed unless you make your own picker from scratch, and you want to use the wheel picker in your own picker.
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

---

# Planned Updates and New Features

These are the topics I currently have on the TODO list for this package. Have a new suggestion and idea?
Feel free to open a [suggestion or issue](https://github.com/rydmike/flex_color_picker/issues) in the repo.

### TODO

- Add more tests.
- Finalize tests.
- Improve existing copy/paste feature.
- Add support for transparent on colors.  
- Add GitHub actions for test, analyze, coverage, build and web demo deployment.
- Additional controls for selecting active picker, custom slider and ToggleButtons.  
- Add one more color picker types "advanced".

### MAYBE
- Add a color selected with the wheel color selector to the custom colors section.
- Store colors added to the custom colors section.

### COMPLETED

- Review and update the API.
- Review and correct documentation mistakes and typos, first pass anyway.
- Fix doc images that show up OK in Github readme.md, but not on pub.dev.
- For the color wheel picker, add text input to get a given color based on entered HEX code.
- Add "name that color" function that can give a name to "any" color in English.
- Release version 1.0.0.
- Publish version 1.0.0 on pub.dev.
- Version 1.1.1: Add first set of tests for the ColorPicker, so far only unit tests for ColorTools, more tests will be added later. ColorTools has 4694 tests.
- Version 2.0.0-nullsafety.0: Add null safe version.

