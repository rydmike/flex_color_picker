import 'package:flutter/material.dart';

import 'maybe_tooltip.dart';
import 'switch_list_tile_adaptive.dart';

/// This simple wrapper of the SwitchListTile.adaptive widget, is used to
/// wrap it with a tooltip and show the provided tooltip if one is provided
/// and tooltipEnabled is true.
class SwitchTileTooltip extends StatelessWidget {
  /// Const default constructor.
  const SwitchTileTooltip({
    super.key,
    required this.value,
    required this.onChanged,
    this.title,
    this.subtitle,
    this.tooltip,
    this.tooltipEnabled = false,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget? title;
  final Widget? subtitle;
  final String? tooltip;
  final bool tooltipEnabled;

  @override
  Widget build(BuildContext context) {
    return MaybeTooltip(
      condition: tooltipEnabled,
      tooltip: tooltip,
      child: SwitchListTileAdaptive(
        value: value,
        onChanged: onChanged,
        title: title,
        subtitle: subtitle,
      ),
    );
  }
}
