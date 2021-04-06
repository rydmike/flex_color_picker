import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// Custom Hive adapters, for additional data type storage.

//*****************************************************************************
class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(BinaryReader reader) {
    final int value = reader.readInt();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.value);
  }

  @override
  int get typeId => 150;
}

//*****************************************************************************

class ColorPickerTypeAdapter extends TypeAdapter<ColorPickerType> {
  @override
  ColorPickerType read(BinaryReader reader) {
    final int index = reader.readInt();
    return ColorPickerType.values[index];
  }

  @override
  void write(BinaryWriter writer, ColorPickerType obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 151;
}

//*****************************************************************************

class CrossAxisAlignmentAdapter extends TypeAdapter<CrossAxisAlignment> {
  @override
  CrossAxisAlignment read(BinaryReader reader) {
    final int index = reader.readInt();
    return CrossAxisAlignment.values[index];
  }

  @override
  void write(BinaryWriter writer, CrossAxisAlignment obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 152;
}

//*****************************************************************************

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  ThemeMode read(BinaryReader reader) {
    final int index = reader.readInt();
    return ThemeMode.values[index];
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 153;
}

//*****************************************************************************

class ColorPickerCopyFormatAdapter extends TypeAdapter<ColorPickerCopyFormat> {
  @override
  ColorPickerCopyFormat read(BinaryReader reader) {
    final int index = reader.readInt();
    return ColorPickerCopyFormat.values[index];
  }

  @override
  void write(BinaryWriter writer, ColorPickerCopyFormat obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 154;
}
