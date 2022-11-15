/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project. 
 */

import 'package:flutter/material.dart';

import '../user_command.dart';

enum PopupMenuEvent { onTap, onLongPress }

/// The [CommandPopupMenuWrapper] has a [Widget] and opens a [CommandPopupMenu]
/// when the user clicks somewhere on the child [Widget]
/// The [CommandPopupMenu] will position it self right under the the click position.
/// The [CommandPopupMenu] may reposition it self if it would not fit on the screen.
class CommandPopupMenuWrapper extends StatelessWidget {
  ///Note that the Inkwell may not be visible when the child has a color. Use the CommandPopupMenuStyle.backGroundColor instead!
  final Widget child;
  final List<Command> commands;
  final CommandPopupMenuWrapperStyle style;
  final PopupMenuEvent event;
  final String? popupMenuTitle;

  const CommandPopupMenuWrapper(
      {Key? key,
      required this.child,
      required this.commands,
      this.event = PopupMenuEvent.onTap,
      this.style = const CommandPopupMenuWrapperStyle(),
      this.popupMenuTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Needed to show Inkwell when having back ground color issues
        Material(
      color: style.backgroundColor,
      child: InkWell(
        overlayColor: createOverlayColor(),
        onTap: () {
          //Needed to show the Inkwell ripple effect
        },
        child:
            // Needed a GestureDetector inside a Inkwell because the later is missing
            // the onTapUp parameter, which we need to show the Inkwell ripple.
            GestureDetector(
          child: child,
          onTapUp: (TapUpDetails details) {
            showPopupMenu(
                context, PopupMenuEvent.onTap, details.globalPosition);
          },
          onLongPressStart: (LongPressStartDetails details) {
            showPopupMenu(
                context, PopupMenuEvent.onLongPress, details.globalPosition);
          },
        ),
      ),
    );
  }

  MaterialStateProperty<Color?>? createOverlayColor() {
    return style.overlayColor == null
        ? null
        : DefaultOverlayColor(style.overlayColor!);
  }

  RelativeRect calculatePopUpMenuPosition(
      BuildContext context, Offset globalPosition) {
    Size screenSize = MediaQuery.of(context).size;
    RelativeRect position = RelativeRect.fromLTRB(
      globalPosition.dx,
      globalPosition.dy,
      screenSize.width,
      screenSize.height,
    );
    return position;
  }

  void showPopupMenu(
      BuildContext context, PopupMenuEvent event, Offset globalPosition) {
    if (this.event == event) {
      CommandPopupMenu(context, commands,
          style: style.menuStyle.copyWith(
              position: calculatePopUpMenuPosition(context, globalPosition)),
          title: popupMenuTitle);
    }
  }
}

class CommandPopupMenuWrapperStyle {
  final Color? backgroundColor;
  final Color? rippleColor;
  final Color? overlayColor;
  final CommandPopupMenuStyle menuStyle;

  const CommandPopupMenuWrapperStyle({
    this.backgroundColor,
    this.rippleColor,
    this.overlayColor,
    this.menuStyle = const CommandPopupMenuStyle(),
  });
}
