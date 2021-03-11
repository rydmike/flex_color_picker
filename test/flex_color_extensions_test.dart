import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

// ignore_for_file: unnecessary_nullable_for_final_variable_declarations

void main() {
  //****************************************************************************
  // FlexPickerNoNullColorExtensions unit tests.
  //
  // Color.hexAlpha function, reference value and edge cases tests.
  //****************************************************************************
  group('FCE5: WITH non nullable Color extension Color.hexCode ', () {
    const Color col1 = Color(0xFFB00020);
    const Color col2 = Color(0x0F03DAC6);
    const Color col3 = Color(0xF0CF6679);
    const Color col4 = Color(0x00CF6679);
    const Color white = Color(0xFFFFFFFF);
    const Color black = Color(0xFF000000);
    const Color transparent = Color(0x00000000);
    test('FCE5.01: GIVEN $col1 EXPECT "FFB00020".', () {
      expect(col1.hexAlpha, 'FFB00020');
    });
    test('FCE5.02: GIVEN $col2 EXPECT "0F03DAC6".', () {
      expect(col2.hexAlpha, '0F03DAC6');
    });
    test('FCE5.03: GIVEN $col3 EXPECT "F0CF6679".', () {
      expect(col3.hexAlpha, 'F0CF6679');
    });
    test('FCE5.04: GIVEN $col4 EXPECT "00CF6679".', () {
      expect(col4.hexAlpha, '00CF6679');
    });
    test('FCE5.05: GIVEN $white EXPECT "FFFFFFFF".', () {
      expect(white.hexAlpha, 'FFFFFFFF');
    });
    test('FCE5.06: GIVEN $black EXPECT "FF000000".', () {
      expect(black.hexAlpha, 'FF000000');
    });
    test('FCE5.07: GIVEN $transparent EXPECT "00000000".', () {
      expect(transparent.hexAlpha, '00000000');
    });
  });

  //****************************************************************************
  // FlexPickerNoNullColorExtensions unit tests.
  //
  // Color.hex function, reference value and edge cases tests.
  //****************************************************************************
  group('FCE6: WITH non nullable Color extension Color.hex ', () {
    const Color col1 = Color(0xFFB00020);
    const Color col2 = Color(0x0F03DAC6);
    const Color col3 = Color(0xF0CF6679);
    const Color col4 = Color(0x00CF6679);
    const Color white = Color(0xFFFFFFFF);
    const Color black = Color(0xFF000000);
    const Color transparent = Color(0x00000000);
    test('FCE6.01: GIVEN $col1 EXPECT "B00020".', () {
      expect(col1.hex, 'B00020');
    });
    test('FCE6.02: GIVEN $col2 EXPECT "03DAC6".', () {
      expect(col2.hex, '03DAC6');
    });
    test('FCE6.03: GIVEN $col3 EXPECT "CF6679".', () {
      expect(col3.hex, 'CF6679');
    });
    test('FCE6.04: GIVEN $col4 EXPECT "CF6679".', () {
      expect(col4.hex, col4.hex);
    });
    test('FCE6.05: GIVEN $white EXPECT "FFFFFF".', () {
      expect(white.hex, 'FFFFFF');
    });
    test('FCE6.06: GIVEN $black EXPECT "000000".', () {
      expect(black.hex, '000000');
    });
    test('FCE5.07: GIVEN $transparent EXPECT "000000".', () {
      expect(transparent.hex, '000000');
    });
  });

  //****************************************************************************
  // FlexPickerNoNullStringExtensions unit tests.
  //
  // Color.dotTail function, reference value and edge cases tests.
  //****************************************************************************
  group('FSE1: WITH non nullable String extension String.dotTail', () {
    const String enumStr1 = 'FlexColor.material';
    const String enumStr2 = 'FlexColor';
    const String enumStr3 = 'FlexColor.';
    const String enumStr4 = '.material';
    const String enumStr5 = 'FlexColor.1.2.hey';
    // const String? nullStr = null;
    test('FSE1.01: GIVEN "$enumStr1".dotTail EXPECT "material".', () {
      expect(enumStr1.dotTail, 'material');
    });
    test('FSE1.02: GIVEN "$enumStr2".dotTail EXPECT "FlexColor".', () {
      expect(enumStr2.dotTail, 'FlexColor');
    });
    test('FSE1.03: GIVEN "$enumStr3".dotTail EXPECT "".', () {
      expect(enumStr3.dotTail, '');
    });
    test('FSE1.04: GIVEN "$enumStr4".dotTail EXPECT "material".', () {
      expect(enumStr4.dotTail, 'material');
    });
    test('FSE1.05: GIVEN "$enumStr5".dotTail EXPECT "hey".', () {
      expect(enumStr5.dotTail, 'hey');
    });
  });

  //****************************************************************************
  // FlexPickerNullableStringExtensions unit tests.
  //
  // Color.dotTailMaybeNull function, reference value and edge cases tests.
  //****************************************************************************
  group('FSE1n: WITH nullable String extension String.dotTail', () {
    const String? enumStr1 = 'FlexColor.material';
    const String? enumStr2 = 'FlexColor';
    const String? enumStr3 = 'FlexColor.';
    const String? enumStr4 = '.material';
    const String? enumStr5 = 'FlexColor.1.2.hey';
    const String? nullStr = null;
    test('FSE1n.01: GIVEN "$enumStr1".dotTail EXPECT "material".', () {
      expect(enumStr1.dotTailMaybeNull, 'material');
    });
    test('FSE1n.02: GIVEN "$enumStr2".dotTail EXPECT "FlexColor".', () {
      expect(enumStr2.dotTailMaybeNull, 'FlexColor');
    });
    test('FSE1n.03: GIVEN "$enumStr3".dotTail EXPECT "".', () {
      expect(enumStr3.dotTailMaybeNull, '');
    });
    test('FSE1n.04: GIVEN "$enumStr4".dotTail EXPECT "material".', () {
      expect(enumStr4.dotTailMaybeNull, 'material');
    });
    test('FSE1n.05: GIVEN "$enumStr5".dotTail EXPECT "hey".', () {
      expect(enumStr5.dotTailMaybeNull, 'hey');
    });
    test('FSE1n.06: GIVEN <$nullStr>.dotTail EXPECT "null".', () {
      expect(nullStr.dotTailMaybeNull, isNull);
    });
  });

  //****************************************************************************
  // FlexPickerNoNullStringExtensions unit tests.
  //
  // Color.capitalize function, reference value and edge cases tests.
  //****************************************************************************
  group('FSE2: WITH non nullable String extension String.capitalize', () {
    const String str1 = 'hello you';
    const String str2 = 'HELLO you';
    const String str3 = 'h';
    const String str4 = '.mop floor';
    const String emptyStr = '';
    const String blankStr = '  ';
    // const String? nullStr = null;
    test('FSE2.01: GIVEN "$str1".capitalize EXPECT "Hello you".', () {
      expect(str1.capitalize, 'Hello you');
    });
    test('FSE2.02: GIVEN "$str2".capitalize EXPECT "HELLO you".', () {
      expect(str2.capitalize, 'HELLO you');
    });
    test('FSE2.03: GIVEN "$str3".capitalize EXPECT "H".', () {
      expect(str3.capitalize, 'H');
    });
    test('FSE2.04: GIVEN "$str4".capitalize EXPECT ".mop floor".', () {
      expect(str4.capitalize, '.mop floor');
    });
    test('FSE2.05: GIVEN "$emptyStr".capitalize EXPECT "".', () {
      expect(emptyStr.capitalize, '');
    });
    test('FSE2.06: GIVEN "$blankStr".capitalize EXPECT "$blankStr".', () {
      expect(blankStr.capitalize, blankStr);
    });
  });

  //****************************************************************************
  // FlexPickerNullableStringExtensions unit tests.
  //
  // Color.capitalizeMaybeNull function, reference value and edge cases tests.
  //****************************************************************************
  group('FSE2n: WITH nullable String extension String.capitalize', () {
    const String? str1 = 'hello you';
    const String? str2 = 'HELLO you';
    const String? str3 = 'h';
    const String? str4 = '.mop floor';
    const String? emptyStr = '';
    const String blankStr = '  ';
    const String? nullStr = null;
    test('FSE2n.01: GIVEN "$str1".capitalize EXPECT "Hello you".', () {
      expect(str1.capitalizeMaybeNull, 'Hello you');
    });
    test('FSE2n.02: GIVEN "$str2".capitalize EXPECT "HELLO you".', () {
      expect(str2.capitalizeMaybeNull, 'HELLO you');
    });
    test('FSE2n.03: GIVEN "$str3".capitalize EXPECT "H".', () {
      expect(str3.capitalizeMaybeNull, 'H');
    });
    test('FSE2n.04: GIVEN "$str4".capitalize EXPECT ".mop floor".', () {
      expect(str4.capitalizeMaybeNull, '.mop floor');
    });
    test('FSE2n.05: GIVEN "$emptyStr".capitalize EXPECT "".', () {
      expect(emptyStr.capitalizeMaybeNull, '');
    });
    test('FSE2n.06: GIVEN "$blankStr".capitalize EXPECT "$blankStr".', () {
      expect(blankStr.capitalizeMaybeNull, blankStr);
    });
    test('FSE2n.07: GIVEN <$nullStr>.capitalize EXPECT <null>.', () {
      expect(nullStr.capitalizeMaybeNull, isNull);
    });
  });

  //****************************************************************************
  // FlexPickerNoNullStringExtensions unit tests.
  //
  // Color.toColor function, reference value and edge cases tests.
  //****************************************************************************
  group('FSE3: WITH non nullable String extension String.toColor', () {
    const String str1 = 'FF6200EE'; // -> Color(0xFF6200EE)
    const String str2 = 'F06200EE'; // -> Color(0xF06200EE)
    const String str3 = '0F6200EE'; // -> Color(0x0F6200EE)
    const String str4 = '006200EE'; // -> Color(0x006200EE)
    const String str5 = '6200EE'; // -> Color(0xFF6200EE)
    const String str6 = '#6200EE'; // -> Color(0xFF6200EE)
    const String str7 = '#620#0#EE'; // -> Color(0xFF6200EE)
    const String str8 = '#FF6200EE'; // -> Color(0xFF6200EE)
    const String str9 = '#0F620#0#EE'; // -> Color(0x0F6200EE)
    const String str10 = 'EE'; // -> Color(0xFF0000EE)
    const String str11 = '12Z456'; // -> Color(0xFF000000)
    const String str12 = '12Z45678'; // -> Color(0xFF000000)
    const String str13 = 'E'; // -> Color(0xFF00000E)
    const String str14 = 'A2C'; // -> Color(0xFFAA22CC)
    const String str15 = 'A2EE'; // -> Color(0xFF00A2EE)
    const String str16 = '1234567C8910A'; // -> Color(0x67C8910A)
    const String str17 = '1#23#45#678#9#10A#'; // -> Color(0x5678910A)
    const String str18 = '0x1BCEE'; // -> Color(0xFF01BCEE)
    const String str19 = '0x841B0xCE0xE#'; // -> Color(0xF841BCEE)
    const String str20 = '00000000'; // -> Color(0x00000000)
    const String emptyStr = ''; // -> Color(0xFF000000)
    const String blankStr = '  '; // -> Color(0xFF000000)
    final String tooLongStr = '123'.padLeft(201, '5'); // -> Color(0xFF000000)
    const String zeroX = '0x0x'; // -> Color(0xFF000000)

    test('FSE3.01: GIVEN "$str1".toColor EXPECT "Color(0xFF6200EE)".', () {
      expect(str1.toColor, const Color(0xFF6200EE));
    });
    test('FSE3.02: GIVEN "$str2".toColor EXPECT "Color(0xF06200EE)".', () {
      expect(str2.toColor, const Color(0xF06200EE));
    });
    test('FSE3.03: GIVEN "$str3".toColor EXPECT "Color(0x0F6200EE)".', () {
      expect(str3.toColor, const Color(0x0F6200EE));
    });
    test('FSE3.04: GIVEN "$str4".toColor EXPECT "Color(0x006200EE)".', () {
      expect(str4.toColor, const Color(0x006200EE));
    });
    test('FSE3.05: GIVEN "$str5".toColor EXPECT "Color(0xFF6200EE)".', () {
      expect(str5.toColor, const Color(0xFF6200EE));
    });
    test('FSE3.06: GIVEN "$str6".toColor EXPECT "Color(0xFF6200EE)".', () {
      expect(str6.toColor, const Color(0xFF6200EE));
    });
    test('FSE3.07: GIVEN "$str7".toColor EXPECT "Color(0xFF6200EE)".', () {
      expect(str7.toColor, const Color(0xFF6200EE));
    });
    test('FSE3.08: GIVEN "$str8".toColor EXPECT "Color(0xFF6200EE)".', () {
      expect(str8.toColor, const Color(0xFF6200EE));
    });
    test('FSE3.09: GIVEN "$str9".toColor EXPECT "Color(0x0F6200EE)".', () {
      expect(str9.toColor, const Color(0x0F6200EE));
    });
    test('FSE3.10: GIVEN "$str10".toColor EXPECT "Color(0xFF0000EE)".', () {
      expect(str10.toColor, const Color(0xFF0000EE));
    });
    test('FSE3.11: GIVEN "$str11".toColor EXPECT "Color(0xFF000000)".', () {
      expect(str11.toColor, const Color(0xFF000000));
    });
    test('FSE3.12: GIVEN "$str12".toColor EXPECT "Color(0xFF000000)".', () {
      expect(str12.toColor, const Color(0xFF000000));
    });
    test('FSE3.13: GIVEN "$str13".toColor EXPECT "Color(0xFF00000E)".', () {
      expect(str13.toColor, const Color(0xFF00000E));
    });
    test('FSE3.14: GIVEN "$str14".toColor EXPECT "Color(0xFFAA22CC)".', () {
      expect(str14.toColor, const Color(0xFFAA22CC));
    });
    test('FSE3.15: GIVEN "$str15".toColor EXPECT "Color(0xFF00A2EE)".', () {
      expect(str15.toColor, const Color(0xFF00A2EE));
    });
    test('FSE3.16: GIVEN "$str16".toColor EXPECT "Color(0x67C8910A)".', () {
      expect(str16.toColor, const Color(0x67C8910A));
    });
    test('FSE3.17: GIVEN "$str17".toColor EXPECT "Color(0x5678910A)".', () {
      expect(str17.toColor, const Color(0x5678910A));
    });
    test('FSE3.18: GIVEN "$str18".toColor EXPECT "Color(0xFF01BCEE)".', () {
      expect(str18.toColor, const Color(0xFF01BCEE));
    });
    test('FSE3.19: GIVEN "$str19".toColor EXPECT "Color(0xF841BCEE)".', () {
      expect(str19.toColor, const Color(0xF841BCEE));
    });
    test('FSE3.20: GIVEN "$str20".toColor EXPECT "Color(0x00000000)".', () {
      expect(str20.toColor, const Color(0x00000000));
    });
    test('FSE3.21: GIVEN "$emptyStr".toColor EXPECT "Color(0xFF000000)".', () {
      expect(emptyStr.toColor, const Color(0xFF000000));
    });
    test('FSE3.22: GIVEN "$blankStr".toColor EXPECT "Color(0xFF000000)".', () {
      expect(blankStr.toColor, const Color(0xFF000000));
    });
    test(
        'FSE3.24: GIVEN "${tooLongStr.length}" chars, too '
        'long input EXPECT "Color(0x00000000)".', () {
      expect(tooLongStr.toColor, const Color(0xFF000000));
    });
    test('FSE3.23: GIVEN "$zeroX".toColor EXPECT "Color(0xFF000000)".', () {
      expect(zeroX.toColor, const Color(0xFF000000));
    });
  });

  //****************************************************************************
  // FlexPickerNoNullStringExtensions unit tests.
  //
  // Color.toColorShort(bool) function tests.
  //****************************************************************************
  group(
      'FSE3maybe: WITH non nullable String extension '
      'String.toColorShort', () {
    const String str1 = 'A2C';

    test(
        'FSE3maybe.1: GIVEN "$str1".toColorShort(true) '
        'EXPECT "Color(0xFFAA22CC)".', () {
      expect(str1.toColorShort(true), const Color(0xFFAA22CC));
    });
    test(
        'FSE3maybe.2: GIVEN "$str1".toColorShort(false) '
        'EXPECT "Color(0xFF000A2C)".', () {
      expect(str1.toColorShort(false), const Color(0xFF000A2C));
    });
  });

  //****************************************************************************
  // FlexPickerNullableStringExtensions unit tests.
  //
  // Color.toColorMaybeNull function, reference value and edge cases tests.
  //****************************************************************************

  group('FSE3n: WITH nullable String extension String.toColor', () {
    const String? str1 = 'FF6200EE'; // -> Color(0xFF6200EE)
    const String? str2 = 'F06200EE'; // -> Color(0xF06200EE)
    const String? str3 = '0F6200EE'; // -> Color(0x0F6200EE)
    const String? str4 = '006200EE'; // -> Color(0x006200EE)
    const String? str5 = '6200EE'; // -> Color(0xFF6200EE)
    const String? str6 = '#6200EE'; // -> Color(0xFF6200EE)
    const String? str7 = '#620#0#EE'; // -> Color(0xFF6200EE)
    const String? str8 = '#FF6200EE'; // -> Color(0xFF6200EE)
    const String? str9 = '#0F620#0#EE'; // -> Color(0x0F6200EE)
    const String? str10 = 'EE'; // -> Color(0xFF0000EE)
    const String? str11 = '12Z456'; // -> Null
    const String? str12 = '12Z45678'; // -> Null
    const String? str13 = 'E'; // -> Color(0xFF00000E)
    const String? str14 = 'A2C'; // -> Color(0xFFAA22CC)
    const String? str15 = 'A2EE'; // -> Color(0xFF00A2EE)
    const String? str16 = '1234567C8910A'; // -> Color(0x67C8910A)
    const String? str17 = '1#23#45#678#9#10A#'; // -> Color(0x5678910A)
    const String? str18 = '0x1BCEE'; // -> Color(0xFF01BCEE)
    const String? str19 = '0x841B0xCE0xE#'; // -> Color(0xF841BCEE)
    const String? str20 = '00000000'; // -> Color(0x00000000)
    const String? emptyStr = ''; // -> Null
    const String? blankStr = '  '; // -> Null
    const String? zeroX = '0x0x'; // -> Null
    final String? tooLongStr = '123'.padLeft(201, '5'); // -> Null
    const String? nullStr = null; // -> Null

    test('FSE3n.01: GIVEN "$str1".toColor EXPECT "Color(0xFF6200EE)".', () {
      expect(str1.toColorMaybeNull, const Color(0xFF6200EE));
    });
    test('FSE3n.02: GIVEN "$str2".toColor EXPECT "Color(0xF06200EE)".', () {
      expect(str2.toColorMaybeNull, const Color(0xF06200EE));
    });
    test('FSE3n.03: GIVEN "$str3".toColor EXPECT "Color(0x0F6200EE)".', () {
      expect(str3.toColorMaybeNull, const Color(0x0F6200EE));
    });
    test('FSE3n.04: GIVEN "$str4".toColor EXPECT "Color(0x006200EE)".', () {
      expect(str4.toColorMaybeNull, const Color(0x006200EE));
    });
    test('FSE3n.05: GIVEN "$str5".toColor EXPECT "Color(0xFF6200EE)".', () {
      expect(str5.toColorMaybeNull, const Color(0xFF6200EE));
    });
    test('FSE3n.06: GIVEN "$str6".toColor EXPECT "Color(0xFF6200EE)".', () {
      expect(str6.toColorMaybeNull, const Color(0xFF6200EE));
    });
    test('FSE3n.07: GIVEN "$str7".toColor EXPECT "Color(0xFF6200EE)".', () {
      expect(str7.toColorMaybeNull, const Color(0xFF6200EE));
    });
    test('FSE3n.08: GIVEN "$str8".toColor EXPECT "Color(0xFF6200EE)".', () {
      expect(str8.toColorMaybeNull, const Color(0xFF6200EE));
    });
    test('FSE3n.09: GIVEN "$str9".toColor EXPECT "Color(0x0F6200EE)".', () {
      expect(str9.toColorMaybeNull, const Color(0x0F6200EE));
    });
    test('FSE3n.10: GIVEN "$str10".toColor EXPECT "Color(0xFF0000EE)".', () {
      expect(str10.toColorMaybeNull, const Color(0xFF0000EE));
    });
    test('FSE3n.11: GIVEN "$str11".toColor EXPECT "null".', () {
      expect(str11.toColorMaybeNull, isNull);
    });
    test('FSE3n.12: GIVEN "$str12".toColor EXPECT "null".', () {
      expect(str12.toColorMaybeNull, isNull);
    });
    test('FSE3n.13: GIVEN "$str13".toColor EXPECT "Color(0xFF00000E)".', () {
      expect(str13.toColorMaybeNull, const Color(0xFF00000E));
    });
    test('FSE3n.14: GIVEN "$str14".toColor EXPECT "Color(0xFFAA22CC)".', () {
      expect(str14.toColorMaybeNull, const Color(0xFFAA22CC));
    });
    test('FSE3n.15: GIVEN "$str15".toColor EXPECT "Color(0xFF00A2EE)".', () {
      expect(str15.toColorMaybeNull, const Color(0xFF00A2EE));
    });
    test('FSE3n.16: GIVEN "$str16".toColor EXPECT "Color(0x67C8910A)".', () {
      expect(str16.toColorMaybeNull, const Color(0x67C8910A));
    });
    test('FSE3n.17: GIVEN "$str17".toColor EXPECT "Color(0x5678910A)".', () {
      expect(str17.toColorMaybeNull, const Color(0x5678910A));
    });
    test('FSE3n.18: GIVEN "$str18".toColor EXPECT "Color(0xFF01BCEE)".', () {
      expect(str18.toColorMaybeNull, const Color(0xFF01BCEE));
    });
    test('FSE3n.19: GIVEN "$str19".toColor EXPECT "Color(0xF841BCEE)".', () {
      expect(str19.toColorMaybeNull, const Color(0xF841BCEE));
    });
    test('FSE3n.20: GIVEN "$str20".toColor EXPECT "Color(0x00000000)".', () {
      expect(str20.toColorMaybeNull, const Color(0x00000000));
    });
    test('FSE3n.21: GIVEN "$emptyStr".toColor EXPECT "null".', () {
      expect(emptyStr.toColorMaybeNull, isNull);
    });
    test('FSE3n.22: GIVEN "$blankStr".toColor EXPECT "null".', () {
      expect(blankStr.toColorMaybeNull, isNull);
    });
    test('FSE3n.23: GIVEN "$zeroX".toColor EXPECT "null".', () {
      expect(zeroX.toColorMaybeNull, isNull);
    });
    test(
        'FSE3n.24: GIVEN "${tooLongStr?.length}" chars, too '
        'long input EXPECT "null".', () {
      expect(tooLongStr.toColorMaybeNull, isNull);
    });
    test('FSE3n.25: GIVEN "$nullStr".toColor EXPECT "null".', () {
      expect(nullStr.toColorMaybeNull, isNull);
    });
  });

  //****************************************************************************
  // FlexPickerNoNullStringExtensions unit tests.
  //
  // Color.toColorShortMaybeNull(bool) function tests.
  //****************************************************************************
  group(
      'FSE3n-maybe: WITH non nullable String extension '
      'String.toColorShortMaybeNull', () {
    const String str1 = 'A2C';

    test(
        'FSEn-3maybe.1: GIVEN "$str1".toColorShortMaybeNull(true) '
        'EXPECT "Color(0xFFAA22CC)".', () {
      expect(str1.toColorShortMaybeNull(true), const Color(0xFFAA22CC));
    });
    test(
        'FSE3n-maybe.2: GIVEN "$str1".toColorShortMaybeNull(false) '
        'EXPECT "Color(0xFF000A2C)".', () {
      expect(str1.toColorShortMaybeNull(false), const Color(0xFF000A2C));
    });
  });
}
