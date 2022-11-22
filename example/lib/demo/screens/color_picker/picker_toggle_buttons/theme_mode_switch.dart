import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../pods/pods.dart';

@immutable
class ThemeModeSwitch extends ConsumerWidget {
  const ThemeModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeModePod);
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
          ref.read(themeModePod.notifier).state = ThemeMode.light;
        } else if (newIndex == 1) {
          ref.read(themeModePod.notifier).state = ThemeMode.system;
        } else {
          ref.read(themeModePod.notifier).state = ThemeMode.dark;
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
