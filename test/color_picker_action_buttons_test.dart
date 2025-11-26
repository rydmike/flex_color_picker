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
    // toString and hashCode.
    //**************************************************************************

    // m4, is fully custom defined and totally different from m1 and m2.
    final ColorPickerActionButtons m4 = ColorPickerActionButtons(
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
      dialogActionOnlyOkButton: true,
      dialogActionOrder: ColorPickerActionButtonOrder.adaptive,
      dialogActionIcons: true,
      dialogCancelButtonLabel: 'DONE',
      dialogCancelButtonType: ColorPickerActionButtonType.outlined,
      dialogCancelButtonStyle: TextButton.styleFrom(
        foregroundColor: Colors.red,
        backgroundColor: Colors.yellow,
      ),
      dialogOkButtonLabel: 'OKAY',
      dialogOkButtonType: ColorPickerActionButtonType.elevated,
      dialogOkButtonStyle: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
      useRootNavigator: false,
    );

    test(
        'CPAB2.1: Test toString implemented via debugFillProperties '
        'EXPECT contains key properties.', () {
      final String result = m4.toString();
      expect(result, contains('okButton: true'));
      expect(result, contains('closeButton: true'));
      expect(result, contains('dialogActionOrder: adaptive'));
      expect(result, contains('dialogCancelButtonType: outlined'));
      expect(result, contains('dialogOkButtonType: elevated'));
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
          dialogActionOnlyOkButton: true,
          dialogActionOrder: ColorPickerActionButtonOrder.adaptive,
          dialogActionIcons: true,
          dialogCancelButtonLabel: 'DONE',
          dialogCancelButtonType: ColorPickerActionButtonType.outlined,
          dialogCancelButtonStyle: TextButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.yellow,
          ),
          dialogOkButtonLabel: 'OKAY',
          dialogOkButtonType: ColorPickerActionButtonType.elevated,
          dialogOkButtonStyle: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
          useRootNavigator: false,
        ),
        equals(m4),
      );
    });
    test(
        'CPAB3.2a: GIVEN a ColorPickerActionButtons object EXPECT it to '
        'be unchanged after an empty copyWith.', () {
      expect(
        m4.copyWith(),
        equals(m4),
      );
    });
    test(
        'CPAB3.2b: GIVEN a ColorPickerActionButtons object EXPECT it to '
        'be unchanged after an empty copyWith.', () {
      expect(
        m4.copyWith(okButton: false),
        equals(m4.copyWith(okButton: false)),
      );
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
            dialogActionOnlyOkButton: null,
            dialogActionOrder: null,
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
          dialogActionOnlyOkButton: true,
          dialogActionOrder: ColorPickerActionButtonOrder.adaptive,
          dialogActionIcons: true,
          dialogCancelButtonLabel: 'DONE',
          dialogCancelButtonType: ColorPickerActionButtonType.outlined,
          dialogCancelButtonStyle: TextButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.yellow,
          ),
          dialogOkButtonLabel: 'OKAY',
          dialogOkButtonType: ColorPickerActionButtonType.elevated,
          dialogOkButtonStyle: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
          ),
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
            dialogActionOnlyOkButton: null,
            dialogActionOrder: null,
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

  //****************************************************************************
  // ColorPickerActionButtons unit tests for ButtonStyle properties.
  //
  // Test that ButtonStyle properties work correctly.
  //****************************************************************************
  group('CPAB4: WITH ColorPickerActionButtons ButtonStyle properties', () {
    // Test that ButtonStyle can be set and retrieved
    test(
        'CPAB4.1: GIVEN ColorPickerActionButtons with ButtonStyle '
        'EXPECT the styles to be set correctly', () {
      final ButtonStyle okStyle = ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      );
      final ButtonStyle cancelStyle = TextButton.styleFrom(
        foregroundColor: Colors.red,
        backgroundColor: Colors.yellow,
      );

      final ColorPickerActionButtons buttons = ColorPickerActionButtons(
        dialogOkButtonStyle: okStyle,
        dialogCancelButtonStyle: cancelStyle,
      );

      expect(buttons.dialogOkButtonStyle, equals(okStyle));
      expect(buttons.dialogCancelButtonStyle, equals(cancelStyle));
    });

    test(
        'CPAB4.2: GIVEN ColorPickerActionButtons without ButtonStyle '
        'EXPECT null styles', () {
      const ColorPickerActionButtons buttons = ColorPickerActionButtons();

      expect(buttons.dialogOkButtonStyle, isNull);
      expect(buttons.dialogCancelButtonStyle, isNull);
    });

    test(
        'CPAB4.3: GIVEN ColorPickerActionButtons copyWith ButtonStyle '
        'EXPECT the new styles to be applied', () {
      const ColorPickerActionButtons original = ColorPickerActionButtons();

      final ButtonStyle newOkStyle = FilledButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.green,
      );
      final ButtonStyle newCancelStyle = OutlinedButton.styleFrom(
        foregroundColor: Colors.purple,
      );

      final ColorPickerActionButtons modified = original.copyWith(
        dialogOkButtonStyle: newOkStyle,
        dialogCancelButtonStyle: newCancelStyle,
      );

      expect(modified.dialogOkButtonStyle, equals(newOkStyle));
      expect(modified.dialogCancelButtonStyle, equals(newCancelStyle));
    });

    test(
        'CPAB4.4: GIVEN two ColorPickerActionButtons with same ButtonStyle '
        'EXPECT them to be equal', () {
      final ButtonStyle style1 = TextButton.styleFrom(
        foregroundColor: Colors.red,
      );
      final ButtonStyle style2 = TextButton.styleFrom(
        foregroundColor: Colors.red,
      );

      final ColorPickerActionButtons buttons1 = ColorPickerActionButtons(
        dialogOkButtonStyle: style1,
      );
      final ColorPickerActionButtons buttons2 = ColorPickerActionButtons(
        dialogOkButtonStyle: style2,
      );

      expect(
          buttons1.dialogOkButtonStyle, equals(buttons2.dialogOkButtonStyle));
    });

    test(
        'CPAB4.5: GIVEN ColorPickerActionButtons with different ButtonStyles '
        'EXPECT them to be unequal', () {
      final ButtonStyle style1 = TextButton.styleFrom(
        foregroundColor: Colors.red,
      );
      final ButtonStyle style2 = TextButton.styleFrom(
        foregroundColor: Colors.blue,
      );

      final ColorPickerActionButtons buttons1 = ColorPickerActionButtons(
        dialogOkButtonStyle: style1,
      );
      final ColorPickerActionButtons buttons2 = ColorPickerActionButtons(
        dialogOkButtonStyle: style2,
      );

      expect(buttons1, isNot(equals(buttons2)));
    });

    test(
        'CPAB4.6: GIVEN ColorPickerActionButtons copyWith null ButtonStyle '
        'EXPECT original styles to be retained', () {
      final ButtonStyle originalStyle = ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      );

      final ColorPickerActionButtons original = ColorPickerActionButtons(
        dialogOkButtonStyle: originalStyle,
      );

      final ColorPickerActionButtons modified = original.copyWith();

      expect(modified.dialogOkButtonStyle, equals(originalStyle));
    });
  });
}
