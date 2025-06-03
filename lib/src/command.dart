/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project.
 */

import 'package:flutter/widgets.dart';
import 'package:user_command/src/command_elevated_button.dart';
import 'package:user_command/src/command_list_view.dart';
import 'package:user_command/src/command_outlined_button.dart';
import 'package:user_command/src/command_popup_menu_button.dart';
import 'package:user_command/src/command_popup_menu_wrapper.dart';
import 'package:user_command/src/command_text_button.dart';

/// The [Command] class is a unified definition of a user command.
/// A [Command] has a (dynamic):
/// - name
/// - (optional) icon
/// - (optional) visibility
/// - an action (code to execute when the user clicks on the command)
///
/// Note that the [Command] class has no disabled state, because [disabled buttons suck](https://axesslab.com/disabled-buttons-suck/).
///
/// [Command]s can be used in the following widgets:
/// - [CommandTextButton]
/// - [CommandElevatedButton]
/// - [CommandOutlinedButton]
/// - [CommandPopupMenuItem] (e.g. Within a [CommandPopupMenu])
/// - [CommandPopupMenuButton]
/// - [CommandPopupMenuWrapper]
/// - [CommandToolbarButton] (e.g. Within a [CommandToolbar])
/// - [CommandTile] (e.g. Within a [CommandListView])
/// Etc...
///
/// These [Command] widgets all have a single style class that:
/// - uses reasonable formatting defaults when no style parameters are given.
/// - contains style parameters for all the formatting:
///   - sizing
///   - colors
///   - fonts
///   - padding
///   - aligning
///   - elevation
///   - etc
///
///
class Command {
  final String Function() _nameFunction;
  final IconData? Function() _iconFunction;
  final bool Function() _visibleFunction;
  void Function() action;

  ///Creates a [Command] with static values
  Command({
    required String name,
    IconData? icon,
    bool visible = true,
    required this.action,
  }) : _nameFunction = stringFunction(name),
       _iconFunction = iconFunction(icon),
       _visibleFunction = booleanFunction(visible);

  /// Creates a [Command] with dynamic values. These are ([anonymous][https://dart.dev/guides/language/language-tour#anonymous-functions]) functions
  /// that are called when the [Command] widget is build.
  Command.dynamic({
    required String Function() name,
    required IconData? Function() icon,
    required bool Function() visible,
    required this.action,
  }) : _nameFunction = name,
       _iconFunction = icon,
       _visibleFunction = visible;

  static String Function() stringFunction(String value) =>
      () => value;

  static bool Function() booleanFunction(bool value) =>
      () => value;

  static IconData? Function() iconFunction(IconData? value) =>
      () => value;

  String get name => _nameFunction();

  IconData? get icon => _iconFunction();

  bool get visible => _visibleFunction();

  void execute() {
    action();
  }
}
