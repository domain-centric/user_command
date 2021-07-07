/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project. 
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../user_command.dart';

/// The [CommandPopupMenuWrapper] has a [Widget] and opens a [CommandPopupMenu]
/// when the user clicks somewhere on the child [Widget]
/// The [CommandPopupMenu] will position it self right under the the click position.
/// The [CommandPopupMenu] may reposition it self if it would not fit on the screen.
class CommandPopupMenuWrapper extends StatelessWidget {
  final Widget child;
  final List<Command> commands;
  final CommandPopupMenuStyle style;
  final String? popupMenuTitle;

  CommandPopupMenuWrapper(
      {required this.child,
      required this.commands,
      this.style = const CommandPopupMenuStyle(),
      this.popupMenuTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      onTapDown: (location) {
        CommandPopupMenu(context, commands,
            style: style.copyWith(
                position: calculatePopUpMenuPosition(context, location)),
            title: popupMenuTitle);
      },
    );
  }

  RelativeRect calculatePopUpMenuPosition(
      BuildContext context, TapDownDetails location) {
    Size screenSize = MediaQuery.of(context).size;
    RelativeRect position = RelativeRect.fromLTRB(
      location.globalPosition.dx,
      location.globalPosition.dy,
      screenSize.width,
      screenSize.height,
    );
    return position;
  }
}
