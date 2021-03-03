import 'package:flutter/material.dart';
import '../universal_widgets/context_popup_menu.dart';

/// Enum to handle copy and paste commands.
enum CopyPasteCommands {
  /// Copy command
  copy,

  /// Paste command
  paste,
}

/// A cut, copy paste long press menu.
@immutable
class LongPressCopyPasteMenu extends StatelessWidget {
  /// Default const constructor.
  const LongPressCopyPasteMenu({
    Key? key,
    this.menuWidth = 80,
    this.menuItemHeight = 30,
    this.copyLabel,
    this.copyIcon = Icons.copy,
    this.pasteLabel,
    this.pasteIcon = Icons.paste,
    this.menuIconThemeData,
    this.menuThemeData,
    required this.onSelected,
    this.onOpen,
    required this.child,
  }) : super(key: key);

  /// The width of the menu.
  ///
  /// Defaults to 80 dp.
  final double menuWidth;

  /// The height of each menu item.
  ///
  /// Defaults to 30 dp.
  final double menuItemHeight;

  /// Text label used for the copy action in the menu.
  ///
  /// If null, defaults to MaterialLocalizations.of(context).copyButtonLabel.
  final String? copyLabel;

  /// Icon used for the copy action in the menu.
  ///
  /// Defaults to [Icons.copy].
  final IconData copyIcon;

  /// Text label used for the paste action in the menu.
  ///
  /// If null, defaults to MaterialLocalizations.of(context).pasteButtonLabel.
  final String? pasteLabel;

  /// Icon used for the paste action in the menu.
  ///
  /// Defaults to [Icons.paste].
  final IconData pasteIcon;

  /// The theme for the menu icons.
  ///
  /// The menu is compact, so icons are small by design.
  ///
  /// Uses any none null property in passed in [IconThemeData]. If the
  /// passed value is null, or any property in it is null, then it uses
  /// property values from `Theme.of(context).iconTheme`, if they are not
  /// null. For any null value, the following fallback defaults are used:
  ///   color: remains null, so default [IconThemeData] color behavior is kept.
  ///   size: 16
  ///   opacity: 0.90
  final IconThemeData? menuIconThemeData;

  /// The theme of the popup menu.
  ///
  /// Uses any none null property in passed in [PopupMenuThemeData]. If the
  /// passed value is null, or any property in it is null, then it uses
  /// property values from `Theme.of(context).popupMenuTheme`, if they are not
  /// null. For any null value, the following fallback defaults are used:
  ///   color: theme.cardColor.withOpacity(0.9)
  ///   shape: RoundedRectangleBorder(
  ///            borderRadius: BorderRadius.circular(8),
  ///            side: BorderSide(
  ///            color: theme.dividerColor))
  ///   elevation: 3
  ///   textStyle: theme.textTheme.bodyText2!
  ///   enableFeedback: true
  final PopupMenuThemeData? menuThemeData;

  /// ValueChanged callback with selected item in the long press menu.
  /// Is null if menu closed without selection by clicking outside the menu.
  final ValueChanged<CopyPasteCommands?> onSelected;

  /// Optional void callback, called when the long press menu is opened.
  /// A way to tell when a long press opened the menu.
  final VoidCallback? onOpen;

  /// The child that gets the CopyPaste long press menu.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);

    // This is a merge of provided menuThemeData, with surrounding theme, with
    // fallback to default values.
    final PopupMenuThemeData _effectiveMenuTheme =
        _theme.popupMenuTheme.copyWith(
      color: menuThemeData?.color ??
          _theme.popupMenuTheme.color ??
          _theme.cardColor.withOpacity(0.9),
      shape: menuThemeData?.shape ??
          _theme.popupMenuTheme.shape ??
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: _theme.dividerColor)),
      elevation:
          menuThemeData?.elevation ?? _theme.popupMenuTheme.elevation ?? 3,
      textStyle: menuThemeData?.textStyle ??
          _theme.popupMenuTheme.textStyle ??
          _theme.textTheme.bodyText2!,
      enableFeedback: menuThemeData?.enableFeedback ??
          _theme.popupMenuTheme.enableFeedback ??
          true,
    );

    // This is a merge of provided iconThemeData, with surrounding theme, with
    // fallback to default values, color has no default, remains as null.
    final IconThemeData _effectiveIconTheme = _theme.iconTheme.copyWith(
      color: menuIconThemeData?.color ?? _theme.iconTheme.color,
      size: menuIconThemeData?.size ?? _theme.iconTheme.size ?? 16,
      opacity: menuIconThemeData?.opacity ?? _theme.iconTheme.opacity ?? 0.90,
    );

    // Get the Material localizations.
    final MaterialLocalizations translate = MaterialLocalizations.of(context);

    return Theme(
      data: _theme.copyWith(
          popupMenuTheme: _effectiveMenuTheme, iconTheme: _effectiveIconTheme),
      child: ContextPopupMenu<CopyPasteCommands>(
        items: <PopupMenuEntry<CopyPasteCommands>>[
          PopupMenuItem<CopyPasteCommands>(
            value: CopyPasteCommands.copy,
            height: menuItemHeight,
            child: SizedBox(
              width: menuWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(copyLabel ?? translate.copyButtonLabel),
                  Icon(copyIcon),
                ],
              ),
            ),
          ),
          PopupMenuItem<CopyPasteCommands>(
            value: CopyPasteCommands.paste,
            height: menuItemHeight,
            child: SizedBox(
              width: menuWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(pasteLabel ?? translate.pasteButtonLabel),
                  Icon(pasteIcon),
                ],
              ),
            ),
          ),
        ],
        onSelected: onSelected,
        onOpen: onOpen,
        child: child,
      ),
    );
  }
}
