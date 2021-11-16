import 'package:flex_color_picker/src/models/color_picker_action_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  //****************************************************************************
  // ColorPickerActionButtons unit tests.
  //
  // Basic object tests: identity, equality and none equal.
  //****************************************************************************
  group('CPAB1: WITH ColorPickerActionButtons ', () {
    // m1, is just default constructor.
    const ColorPickerActionButtons m1 = ColorPickerActionButtons();
    // m2, has same definition as m1.
    const ColorPickerActionButtons m2 = ColorPickerActionButtons();
    // m3, is different from m1 and m2.
    const ColorPickerActionButtons m3 =
        ColorPickerActionButtons(okTooltip: 'GOGO');

    test(
        'CPAB1.1a: GIVEN same ColorPickerActionButtons objects '
        'EXPECT them to have equality', () {
      expect(m1, equals(m1));
    });
    test(
        'CPAB1.1b: GIVEN same ColorPickerActionButtons objects '
        'EXPECT them to have identity', () {
      expect(identical(m1, m1), true);
    });
    test(
        'CPAB1.2: GIVEN two equal ColorPickerActionButtons objects '
        'EXPECT them to have equality', () {
      expect(m1, equals(m2));
    });
    test(
        'CPAB1.2a: GIVEN two equal ColorPickerActionButtons objects '
        'EXPECT them to have identity', () {
      expect(identical(m1, m2), true);
    });
    test(
        'CPAB1.3: GIVEN two equal ColorPickerActionButtons objects '
        'EXPECT them to have equality with operator', () {
      expect(m1 == m2, true);
    });
    test(
        'CPAB1.4: GIVEN none equal ColorPickerActionButtons objects '
        'EXPECT them to be unequal', () {
      expect(m1, isNot(m3));
    });
    test(
        'CPAB1.5: GIVEN none equal ColorPickerActionButtons objects '
        'EXPECT them to be unequal with operator', () {
      expect(m1 != m3, true);
    });

    //**************************************************************************
    // ColorPickerActionButtons unit tests.
    //
    // toString and hashcode.
    //**************************************************************************

    // m4, is fully custom defined and totally different from m1 and m2.
    const ColorPickerActionButtons m4 = ColorPickerActionButtons(
      okButton: true,
      closeButton: true,
      okIcon: Icons.android,
      closeIcon: Icons.cancel,
      closeIsLast: false,
      okTooltip: 'GO',
      closeTooltip: 'OFF',
      closeTooltipIsClose: false,
      toolIconsThemeData:
          IconThemeData(opacity: 50, size: 30, color: Colors.black),
      visualDensity: VisualDensity.comfortable,
      padding: EdgeInsets.all(2),
      alignment: Alignment.topLeft,
      splashRadius: 30,
      constraints: BoxConstraints(minHeight: 46, minWidth: 46),
      dialogActionButtons: false,
      dialogActionIcons: true,
      dialogCancelButtonLabel: 'DONE',
      dialogCancelButtonType: ColorPickerActionButtonType.outlined,
      dialogOkButtonLabel: 'OKAY',
      dialogOkButtonType: ColorPickerActionButtonType.elevated,
      useRootNavigator: false,
    );

    test(
        'CPAB2.1: Test toString implemented via debugFillProperties '
        'EXPECT exact print string value.', () {
      expect(m4.toString(), equalsIgnoringHashCodes(
          // ignore: lines_longer_than_80_chars
          'ColorPickerActionButtons#00000(okButton: true, closeButton: true, okIcon: IconData(U+0E085), closeIcon: IconData(U+0E139), closeIsLast: false, okTooltip: "GO", closeTooltip: "OFF", closeTooltipIsClose: false, toolIconsThemeData: IconThemeData#00000(color: Color(0xff000000), opacity: 1.0, size: 30.0), visualDensity: VisualDensity#00000(h: -1.0, v: -1.0)(horizontal: -1.0, vertical: -1.0), alignment: Alignment.topLeft, splashRadius: 30.0, constraints: BoxConstraints(46.0<=w<=Infinity, 46.0<=h<=Infinity), dialogActionButtons: false, dialogActionIcons: true, dialogCancelButtonLabel: "DONE", dialogCancelButtonType: outlined, dialogOkButtonLabel: "OKAY", dialogOkButtonType: elevated, useRootNavigator: false)'));
    });
    test(
        'CPAB2.2: Test toStringShort implemented via debugFillProperties '
        'EXPECT exact short printout.', () {
      expect(m4.toStringShort(),
          equalsIgnoringHashCodes('ColorPickerActionButtons#00000'));
    });
    test('CPAB2.3: Test hashCode has value.', () {
      expect(m4.hashCode, isNotNull);
    });
    test('CPAB2.4: Test hashCode copyWith has same exact value.', () {
      expect(m4.hashCode, equals(m4.copyWith().hashCode));
    });

    //**************************************************************************
    // ColorPickerActionButtons unit tests.
    //
    // Test copyWith, full and null.
    //**************************************************************************

    test(
        'CPAB3.1: GIVEN a ColorPickerActionButtons object EXPECT it to be '
        'equal to an unequal object when made equal with copyWith.', () {
      expect(
        m1.copyWith(
          okButton: true,
          closeButton: true,
          okIcon: Icons.android,
          closeIcon: Icons.cancel,
          closeIsLast: false,
          okTooltip: 'GO',
          closeTooltip: 'OFF',
          closeTooltipIsClose: false,
          toolIconsThemeData:
              const IconThemeData(opacity: 50, size: 30, color: Colors.black),
          visualDensity: VisualDensity.comfortable,
          padding: const EdgeInsets.all(2),
          alignment: Alignment.topLeft,
          splashRadius: 30,
          constraints: const BoxConstraints(minHeight: 46, minWidth: 46),
          dialogActionButtons: false,
          dialogActionIcons: true,
          dialogCancelButtonLabel: 'DONE',
          dialogCancelButtonType: ColorPickerActionButtonType.outlined,
          dialogOkButtonLabel: 'OKAY',
          dialogOkButtonType: ColorPickerActionButtonType.elevated,
          useRootNavigator: false,
        ),
        equals(m4),
      );
    });
    test(
        'CPAB3.2: GIVEN a ColorPickerActionButtons object EXPECT it to '
        'be unchanged after an empty copyWith.', () {
      expect(m4.copyWith(), m4);
    });
    test(
        'CPAB3.3: GIVEN two identical but different ColorPickerActionButtons '
        'objects EXPECT them to '
        'be equal after an all null copyWith', () {
      expect(
          m1.copyWith(
            okButton: null,
            closeButton: null,
            okIcon: null,
            closeIcon: null,
            closeIsLast: null,
            okTooltip: null,
            closeTooltip: null,
            closeTooltipIsClose: null,
            toolIconsThemeData: null,
            visualDensity: null,
            padding: null,
            alignment: null,
            splashRadius: null,
            constraints: null,
            dialogActionButtons: null,
            dialogActionIcons: null,
            dialogCancelButtonLabel: null,
            dialogCancelButtonType: null,
            dialogOkButtonLabel: null,
            dialogOkButtonType: null,
            useRootNavigator: null,
          ),
          equals(m2));
    });
    test(
        'CPAB3.4: GIVEN a ColorPickerActionButtons object EXPECT it to be '
        'equal to an equal object when copied with identical values.', () {
      expect(
        m4.copyWith(
          okButton: true,
          closeButton: true,
          okIcon: Icons.android,
          closeIcon: Icons.cancel,
          closeIsLast: false,
          okTooltip: 'GO',
          closeTooltip: 'OFF',
          closeTooltipIsClose: false,
          toolIconsThemeData:
              const IconThemeData(opacity: 50, size: 30, color: Colors.black),
          visualDensity: VisualDensity.comfortable,
          padding: const EdgeInsets.all(2),
          alignment: Alignment.topLeft,
          splashRadius: 30,
          constraints: const BoxConstraints(minHeight: 46, minWidth: 46),
          dialogActionButtons: false,
          dialogActionIcons: true,
          dialogCancelButtonLabel: 'DONE',
          dialogCancelButtonType: ColorPickerActionButtonType.outlined,
          dialogOkButtonLabel: 'OKAY',
          dialogOkButtonType: ColorPickerActionButtonType.elevated,
          useRootNavigator: false,
        ),
        equals(m4),
      );
    });
    test(
        'CPAB3.5: GIVEN two identical but different ColorPickerActionButtons '
        'objects EXPECT them to '
        'be equal after an equal copyWith', () {
      expect(
          m1.copyWith(
            okButton: true,
            closeButton: null,
            okIcon: null,
            closeIcon: null,
            closeIsLast: null,
            okTooltip: null,
            closeTooltip: null,
            closeTooltipIsClose: null,
            toolIconsThemeData: null,
            visualDensity: null,
            padding: null,
            alignment: null,
            splashRadius: null,
            constraints: null,
            dialogActionButtons: null,
            dialogActionIcons: null,
            dialogCancelButtonLabel: null,
            dialogCancelButtonType: null,
            dialogOkButtonLabel: null,
            dialogOkButtonType: null,
            useRootNavigator: null,
          ),
          equals(m2.copyWith(okButton: true)));
    });
  });
}
