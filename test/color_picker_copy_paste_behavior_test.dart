import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //****************************************************************************
  // ColorPickerCopyPasteBehavior unit tests.
  //
  // Basic object tests: identity, equality and none equal.
  //****************************************************************************
  group('CPCPB1: WITH ColorPickerCopyPasteBehavior ', () {
    // m1, is just default constructor.
    const ColorPickerCopyPasteBehavior m1 = ColorPickerCopyPasteBehavior();
    // m2, has same definition as m1.
    const ColorPickerCopyPasteBehavior m2 = ColorPickerCopyPasteBehavior();
    // m3, is different from m1 and m2.
    const ColorPickerCopyPasteBehavior m3 =
        ColorPickerCopyPasteBehavior(copyTooltip: 'COPY ME');

    test(
        'CPCPB1.1a: GIVEN same ColorPickerCopyPasteBehavior objects '
        'EXPECT them to have equality', () {
      expect(m1, equals(m1));
    });
    test(
        'CPCPB1.1b: GIVEN same ColorPickerCopyPasteBehavior objects '
        'EXPECT them to have identity', () {
      expect(identical(m1, m1), true);
    });
    test(
        'CPCPB1.2a: GIVEN two equal ColorPickerCopyPasteBehavior objects '
        'EXPECT them to have equality', () {
      expect(m1, equals(m2));
    });
    test(
        'CPCPB1.2a: GIVEN two equal ColorPickerCopyPasteBehavior objects '
        'EXPECT them to have identity', () {
      expect(identical(m1, m2), true);
    });
    test(
        'CPCPB1.3: GIVEN two equal ColorPickerCopyPasteBehavior objects '
        'EXPECT them to have equality with operator', () {
      expect(m1 == m2, true);
    });
    test(
        'CPCPB1.4: GIVEN none equal ColorPickerCopyPasteBehavior objects '
        'EXPECT them to be unequal', () {
      expect(m1, isNot(m3));
    });
    test(
        'CPCPB1.5: GIVEN none equal ColorPickerCopyPasteBehavior objects '
        'EXPECT them to be unequal with operator', () {
      expect(m1 != m3, true);
    });

    //**************************************************************************
    // ColorPickerCopyPasteBehavior unit tests.
    //
    // toString and hashcode.
    //**************************************************************************

    // m4, is fully custom defined and totally different from m1 and m2.
    const ColorPickerCopyPasteBehavior m4 = ColorPickerCopyPasteBehavior(
      ctrlC: false,
      ctrlV: false,
      copyButton: true,
      pasteButton: true,
      copyIcon: Icons.android,
      pasteIcon: Icons.close,
      copyTooltip: 'COPY',
      pasteTooltip: 'PASTE',
      copyFormat: ColorPickerCopyFormat.numHexAARRGGBB,
      longPressMenu: true,
      secondaryMenu: true,
      secondaryOnDesktopLongOnDevice: true,
      secondaryOnDesktopLongOnDeviceAndWeb: true,
      editFieldCopyButton: false,
      menuIconThemeData:
          IconThemeData(opacity: 50, size: 30, color: Colors.black),
      menuThemeData: PopupMenuThemeData(
        color: Colors.white,
        shape: RoundedRectangleBorder(),
        elevation: 3,
        textStyle: TextStyle(fontSize: 12),
        enableFeedback: true,
      ),
      menuWidth: 85,
      menuItemHeight: 35,
      snackBarParseError: true,
      snackBarMessage: 'Something went wrong',
      snackBarDuration: Duration(milliseconds: 1500),
      feedbackParseError: true,
      parseShortHexCode: true,
      editUsesParsedPaste: true,
    );

    test(
        'CPCPB2.1: Test toString implemented via debugFillProperties '
        'EXPECT exact print string value.', () {
      expect(m4.toString(), equalsIgnoringHashCodes(
          // ignore: lines_longer_than_80_chars
          'ColorPickerCopyPasteBehavior#00000(ctrlC: false, ctrlV: false, copyButton: true, pasteButton: true, copyIcon: IconData(U+0E085), pasteIcon: IconData(U+0E16A), copyTooltip: "COPY", pasteTooltip: "PASTE", copyFormat: numHexAARRGGBB, longPressMenu: true, secondaryMenu: true, secondaryOnDesktopLongOnDevice: true, secondaryOnDesktopLongOnDeviceAndWeb: true, editFieldCopyButton: false, menuIconThemeData: IconThemeData#00000(color: Color(0xff000000), opacity: 1.0, size: 30.0), menuThemeData: PopupMenuThemeData#00000(color: Color(0xffffffff), shape: RoundedRectangleBorder(BorderSide(Color(0xff000000), 0.0, BorderStyle.none), BorderRadius.zero), elevation: 3.0, text style: TextStyle(inherit: true, size: 12.0), enableFeedback: true), menuWidth: 85.0, menuItemHeight: 35.0, snackBarParseError: true, snackBarMessage: "Something went wrong", snackBarDuration: 0:00:01.500000, feedbackParseError: true, parseShortHexCode: true, editUsesParsedPaste: true)'));
    });
    test(
        'CPCPB2.2: Test toStringShort implemented via debugFillProperties '
        'EXPECT exact short printout.', () {
      expect(m4.toStringShort(),
          equalsIgnoringHashCodes('ColorPickerCopyPasteBehavior#00000'));
    });
    test('CPCPB2.3: Test hashCode has value.', () {
      expect(m4.hashCode, isNotNull);
    });
    test('CPCPB2.4: Test hashCode copyWith has same exact value.', () {
      expect(m4.hashCode, equals(m4.copyWith().hashCode));
    });

    //**************************************************************************
    // ColorPickerCopyPasteBehavior unit tests.
    //
    // Test copyWith, full and null.
    //**************************************************************************

    test(
        'CPCPB3.1: GIVEN a ColorPickerCopyPasteBehavior object EXPECT it to be '
        'equal to an unequal object when made equal with copyWith.', () {
      expect(
        m4,
        m1.copyWith(
          ctrlC: false,
          ctrlV: false,
          copyButton: true,
          pasteButton: true,
          copyIcon: Icons.android,
          pasteIcon: Icons.close,
          copyTooltip: 'COPY',
          pasteTooltip: 'PASTE',
          copyFormat: ColorPickerCopyFormat.numHexAARRGGBB,
          longPressMenu: true,
          secondaryMenu: true,
          secondaryOnDesktopLongOnDevice: true,
          secondaryOnDesktopLongOnDeviceAndWeb: true,
          editFieldCopyButton: false,
          menuIconThemeData:
              const IconThemeData(opacity: 50, size: 30, color: Colors.black),
          menuThemeData: const PopupMenuThemeData(
            color: Colors.white,
            shape: RoundedRectangleBorder(),
            elevation: 3,
            textStyle: TextStyle(fontSize: 12),
            enableFeedback: true,
          ),
          menuWidth: 85,
          menuItemHeight: 35,
          snackBarParseError: true,
          snackBarMessage: 'Something went wrong',
          snackBarDuration: const Duration(milliseconds: 1500),
          feedbackParseError: true,
          parseShortHexCode: true,
          editUsesParsedPaste: true,
        ),
      );
    });
    test(
        'CPCPB3.2: GIVEN a ColorPickerCopyPasteBehavior object EXPECT it to '
        'be unchanged after an empty copyWith.', () {
      expect(m4.copyWith(), m4);
    });

    test(
        'CPCPB3.3: GIVEN two identical but different '
        'ColorPickerCopyPasteBehavior '
        'object EXPECT them to be'
        'be equal after an all null copyWith on 2nd one', () {
      expect(
          m2.copyWith(
            ctrlC: null,
            ctrlV: null,
            copyButton: null,
            pasteButton: null,
            copyIcon: null,
            pasteIcon: null,
            copyTooltip: null,
            pasteTooltip: null,
            copyFormat: null,
            longPressMenu: null,
            secondaryMenu: null,
            secondaryOnDesktopLongOnDevice: null,
            secondaryOnDesktopLongOnDeviceAndWeb: null,
            editFieldCopyButton: null,
            menuIconThemeData: null,
            menuThemeData: null,
            menuWidth: null,
            menuItemHeight: null,
            snackBarParseError: null,
            snackBarMessage: null,
            snackBarDuration: null,
            feedbackParseError: null,
            parseShortHexCode: null,
            editUsesParsedPaste: null,
          ),
          m1.copyWith());
    });
    test(
        'CPCPB3.4: GIVEN a ColorPickerCopyPasteBehavior object EXPECT it to be '
        'equal to an equal object when copied with identical values.', () {
      expect(
        m4.copyWith(
          ctrlC: false,
          ctrlV: false,
          copyButton: true,
          pasteButton: true,
          copyIcon: Icons.android,
          pasteIcon: Icons.close,
          copyTooltip: 'COPY',
          pasteTooltip: 'PASTE',
          copyFormat: ColorPickerCopyFormat.numHexAARRGGBB,
          longPressMenu: true,
          secondaryMenu: true,
          secondaryOnDesktopLongOnDevice: true,
          secondaryOnDesktopLongOnDeviceAndWeb: true,
          editFieldCopyButton: false,
          menuIconThemeData:
              const IconThemeData(opacity: 50, size: 30, color: Colors.black),
          menuThemeData: const PopupMenuThemeData(
            color: Colors.white,
            shape: RoundedRectangleBorder(),
            elevation: 3,
            textStyle: TextStyle(fontSize: 12),
            enableFeedback: true,
          ),
          menuWidth: 85,
          menuItemHeight: 35,
          snackBarParseError: true,
          snackBarMessage: 'Something went wrong',
          snackBarDuration: const Duration(milliseconds: 1500),
          feedbackParseError: true,
          parseShortHexCode: true,
          editUsesParsedPaste: true,
        ),
        m4,
      );
    });
  });
}
