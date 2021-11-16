import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../pods/pods_reset.dart';
import '../../widgets/platform_alert_dialog.dart';

class ResetSettingsButton extends ConsumerWidget {
  const ResetSettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    assert(debugCheckHasMaterialLocalizations(context),
        'A context with Material localizations is required');
    // Get the Material localizations.
    final MaterialLocalizations translate = MaterialLocalizations.of(context);
    return OutlinedButton(
      // Button disabled when we have selected custom surface, because we
      // cannot (no point) copy custom surface colors to itself.
      onPressed: () async {
        final bool? didReset = await PlatformAlertDialog(
          title: 'Reset Settings',
          content: 'Reset all FlexColorPicker settings to default values?',
          defaultActionText: translate.okButtonLabel,
          cancelActionText: translate.cancelButtonLabel,
        ).show(context, useRootNavigator: true);
        // TODO(rydmike): Potential lint rule false positive?
        // Based on this: https://dart-lang.github.io/linter/lints/use_build_context_synchronously.html
        // The rule should only apply to stateful widget. This Widget is
        // Stateless, can't use proposed mounted check in a stateless widget!
        // Thus we ignore the new experimental lint rule for now.
        // ignore: use_ build_context_synchronously
        if (didReset ?? false) resetSettings(ref);
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
