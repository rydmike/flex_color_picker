import 'package:flutter/material.dart';

/// Type definition for a builder function used by IfWrapper.
typedef IfWrapBuilder = Widget Function(BuildContext context, Widget child);

/// A builder that if the [condition] is true, will run its builder and the
/// child will be wrapped by the builder, if false it just returns the child.
///
/// A convenient way to wrap a widget with another widget, but only if
/// the condition is true. It can save you from having to define a large widget,
/// assign it to a Widget itself wrapped with another widget.
///
/// Widget widgetA = WidgetX(...);
/// if (condition) widgetA = WidgetY(child: widgetA);
///
/// Becomes:
/// IfWrapper(condition: condition,
///   builder: (context, child) {
///     return WidgetY(child: child) }
///   child: child
/// );
class IfWrapper extends StatelessWidget {
  const IfWrapper({
    final Key? key,
    required this.condition,
    required this.builder,
    required this.child,
    this.ifFalse,
  }) : super(key: key);

  /// if [condition] evaluates to true, the builder will be run and the child
  /// will be wrapped. If false, only the child is returned.
  final bool condition;

  /// How to display the widget if [condition] is true;
  final IfWrapBuilder builder;
  final IfWrapBuilder? ifFalse;

  /// The widget to be conditionally wrapped, it will be returned alone without
  /// the wrapping Widget if [condition] is false.
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    if (condition) {
      return builder(context, child);
    } else if (ifFalse != null) {
      return ifFalse!(context, child);
    } else {
      return child;
    }
  }
}
