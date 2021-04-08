import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'platform_widget.dart';

/// A platform adaptive implementation of an AlertDialog.
class PlatformAlertDialog extends PlatformWidget {
  const PlatformAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.defaultActionText,
    this.cancelActionText,
  }) : super(key: key);

  final String title;
  final String content;
  final String defaultActionText;
  final String? cancelActionText;

  Future<bool?> show(BuildContext context,
      {bool useRootNavigator = false}) async {
    final TargetPlatform _platform = Theme.of(context).platform;

    return (_platform == TargetPlatform.iOS ||
            _platform == TargetPlatform.macOS)
        ? await showCupertinoDialog<bool>(
            useRootNavigator: useRootNavigator,
            context: context,
            builder: (BuildContext builder) => this,
          )
        : await showDialog<bool>(
            useRootNavigator: useRootNavigator,
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => this,
          );
  }

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
      actionsPadding: const EdgeInsetsDirectional.only(end: 10),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    final List<Widget> actions = <Widget>[];
    if (cancelActionText != null) {
      actions.add(
        PlatformAlertDialogAction(
          onPressed: () => Navigator.of(context).pop(false),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(cancelActionText?.toUpperCase() ?? ''),
          ),
        ),
      );
    }
    actions.add(
      PlatformAlertDialogAction(
        onPressed: () => Navigator.of(context).pop(true),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(defaultActionText.toUpperCase()),
        ),
      ),
    );
    return actions;
  }
}

class PlatformAlertDialogAction extends PlatformWidget {
  const PlatformAlertDialogAction({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    return CupertinoDialogAction(
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
