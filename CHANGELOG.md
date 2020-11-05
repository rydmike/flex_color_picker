# Changelog

All notable changes to the **ColorPicker** will be documented in this file.

## [1.0.0] - November 5, 2020
* First official release.
* Still pending minor check before publishing it on pub.dev. This row will be deleted when published on pub.dev.
* Updated the Live web demo version to use the released package.

## [1.0.0-dev.5] - November 5, 2020

* Added a feature on the wheel color picker that enables entry of a hex RGB value to select a color.
* API changes to support separate display of Material color name `showMaterialName` and selected color code `showColorCode`, plus defining their text styles `materialNameTextStyle` and `colorCodeTextStyle`.
* New API `showColorName` to display an English color name for any selected color, not just the Material color names or custom named color swatches. It has text style that can be defined as well `colorNameTextStyle`.
* New API `colorCodeIcon` that exposes the color code icon so it can be customized.
* New API `enableTooltips` to enable current and future tooltips used in the picker. Currently only the copy color code button has a tooltip.
* A new method was introduced in ColorTools called `nameThatColor(Color color)`. It returns a name for any color passed to it, only supports English names. It is based on a Dart port of http://chir.ag/projects/ntc.
* Updated the example.
* Documentation updates.

## [1.0.0-dev.4] - November 2, 2020

* Update to try to get the images to show up on pub.dev.
* Minor documentation corrections.

## [1.0.0-dev.3] - November 2, 2020

* Significant API name changes and cleanup. Decided to implement previously planned changes before the official release, even if it will also impact our own usage of the package when we move to using the published version.

## [1.0.0-dev.2] - October 30, 2020

* First release on pub.dev

## To do list and planned feature updates

- [x] Review and update the API.
- [x] Review and correct documentation mistakes and typos, first pass anyway.
- [x] Fix doc images that show up OK in Github readme.md, but not on pub.dev.
- [x] For the color wheel picker, add text input to get a given color based on entered HEX code.
- [x] Add "name that color" function that can give a name to "any" color in English.
- [x] Release version 1.0.0.
- [ ] Publish version 1.0.0 on pub.dev.
- [ ] Version 1.0.x: Add first set of tests for the ColorPicker and its supporting classes.
- [ ] Version 1.1.0: Finalize the tests.
- [ ] Maybe version 2.0.x: Add more color picker types.
- [ ] Maybe version 2.x.x: Add a color selected with the wheel color selector to the custom colors section.
- [ ] Maybe version 2.x.x: Store colors added to the custom colors section.
