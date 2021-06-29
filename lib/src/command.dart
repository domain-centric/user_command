import 'package:flutter/widgets.dart';

/// A [Command] is a unified definition of a user command.
/// A [Command] has a (dynamic):
/// - name
/// - (optional) icon
/// - (optional) visibility
/// - an action (code to execute when the user clicks on the command)
///
/// [Command]s can be used in:
/// - [CommandToolbarButton] (e.g. Within a [CommandToolbar])
/// - [CommandPopupMenuItem] (e.g. Within a [CommandPopupMenuItem])
/// Etc...
class Command {
  String Function() _nameFunction;
  IconData? Function() _iconFunction;
  bool Function() _visibleFunction;
  void Function() action;

  Command({
    required String name,
    IconData? icon,
    bool visible = true,
    required this.action,
  })  : _nameFunction = stringFunction(name),
        _iconFunction = iconFunction(icon),
        _visibleFunction = booleanFunction(visible);

  Command.dynamic({
    required String Function() name,
    required IconData? Function() icon,
    required bool Function() visible,
    required this.action,
  })  : _nameFunction = name,
        _iconFunction = icon,
        _visibleFunction = visible;

  static String Function() stringFunction(String value) => () => value;

  static bool Function() booleanFunction(bool value) => () => value;

  static IconData? Function() iconFunction(IconData? value) => () => value;

  String get name => _nameFunction();

  IconData? get icon => _iconFunction();

  bool get visible => _visibleFunction();

  void execute() {
    action();
  }
}
