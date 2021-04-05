import 'package:flutter/material.dart';

import '../../pods/pods_reset.dart';
import '../../widgets/platform_alert_dialog.dart';

class ResetSettingsButton extends StatelessWidget {
  const ResetSettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // Button disabled when we have selected custom surface, because we
      // cannot (no point) copy custom surface colors to itself.
      onPressed: () async {
        final bool? didReset = await const PlatformAlertDialog(
          title: 'Reset Settings',
          content: 'Reset all FlexColorPicker settings to default values?',
          defaultActionText: 'Ok',
          cancelActionText: 'Cancel',
        ).show(context, useRootNavigator: true);
        if (didReset ?? false) resetSettings(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Text(
          'Reset settings',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
