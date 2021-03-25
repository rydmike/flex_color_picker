import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pods.dart';

@immutable
class ThemeModeSwitch extends ConsumerWidget {
  const ThemeModeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ThemeMode themeMode = watch(themeModePod).state;
    final List<bool> isSelected = <bool>[
      themeMode == ThemeMode.light,
      themeMode == ThemeMode.system,
      themeMode == ThemeMode.dark,
    ];
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (int newIndex) {
        for (int index = 0; index < isSelected.length; index++) {
          if (index == newIndex) {
            isSelected[index] = true;
          } else {
            isSelected[index] = false;
          }
        }
        if (newIndex == 0) {
          context.read(themeModePod).state = ThemeMode.light;
        } else if (newIndex == 1) {
          context.read(themeModePod).state = ThemeMode.system;
        } else {
          context.read(themeModePod).state = ThemeMode.dark;
        }
      },
      children: const <Widget>[
        Icon(Icons.wb_sunny),
        Icon(Icons.phone_iphone),
        Icon(Icons.bedtime),
      ],
    );
  }
}
