import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// Hive box name, used for the Hive box that store all settings.
const String kHiveBox = 'picker_settings';

// A ref to the used Hive box store, it must be opened before used, which it
// will be since we open it once at the start of the app and don't close it
// anywhere in this color picker demo app.
final Box<dynamic> hiveStore = Hive.box<dynamic>(kHiveBox);

// Register all custom Hive data adapters.
void registerHiveAdapters() {
  Hive.registerAdapter(ColorAdapter());
  Hive.registerAdapter(ColorPickerTypeAdapter());
  Hive.registerAdapter(CrossAxisAlignmentAdapter());
  Hive.registerAdapter(ThemeModeAdapter());
  Hive.registerAdapter(ColorPickerCopyFormatAdapter());
  Hive.registerAdapter(ColorPickerActionButtonOrderAdapter());
}

// A Hive data type adapter for class Color.
class ColorAdapter extends TypeAdapter<Color> {
  @override
  Color read(BinaryReader reader) {
    final int value = reader.readInt();
    return Color(value);
  }

  @override
  void write(BinaryWriter writer, Color obj) {
    writer.writeInt(obj.value32bit);
  }

  @override
  int get typeId => 150;
}

// A Hive data type adapter for enum ColorPickerType.
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

// A Hive data type adapter for enum CrossAxisAlignment.
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

// A Hive data type adapter for enum ThemeMode.
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

// A Hive data type adapter for enum ColorPickerCopyFormat.
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

// A Hive data type adapter for enum ColorPickerActionButtonOrder.
class ColorPickerActionButtonOrderAdapter
    extends TypeAdapter<ColorPickerActionButtonOrder> {
  @override
  ColorPickerActionButtonOrder read(BinaryReader reader) {
    final int index = reader.readInt();
    return ColorPickerActionButtonOrder.values[index];
  }

  @override
  void write(BinaryWriter writer, ColorPickerActionButtonOrder obj) {
    writer.writeInt(obj.index);
  }

  @override
  int get typeId => 155;
}
