import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:overflow_view/overflow_view.dart';

import 'command.dart';
import 'command_icon.dart';
import 'command_popupmenu.dart';
import 'command_style.dart';

class CommandToolbar extends StatelessWidget {
  final List<Command> commands;

  CommandToolbar(this.commands);

  @override
  Widget build(BuildContext context) {
    Color backGroundColor = Theme.of(context).dialogBackgroundColor;

    List<Command> visibleCommands =
        commands.where((command) => command.visible).toList();
    return Visibility(
        visible: visibleCommands.isNotEmpty,
        child: Container(
            padding: EdgeInsets.fromLTRB(
                CommandStyle.spacing, 0, CommandStyle.spacing, 0),
            color: backGroundColor,
            height: CommandStyle.minTouchTargetHeight,
            child: Align(
              alignment: Alignment.centerRight,
              child: OverflowView.flexible(
                  spacing: CommandStyle.spacing,
                  children: visibleCommands
                      .map((command) => CommandToolbarButton(command))
                      .toList(),
                  builder: (context, remaining) {
                    //return Text('remaining: ');
                    return CommandToolBarMoreButton(visibleCommands, remaining);
                  }),
            )));
  }
}

class CommandToolBarMoreButton extends StatelessWidget {
  final List<Command> visibleCommands;
  final int remaining;
  final buttonKey = GlobalKey();

  CommandToolBarMoreButton(this.visibleCommands, this.remaining);

  @override
  Widget build(BuildContext context) {
    Color foreGroundColor = Theme.of(context).textTheme.bodyText1!.color!;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: CommandStyle.minTouchTargetHeight),
      child: TextButton(
        key: buttonKey,
        style: TextButton.styleFrom(
            primary: foreGroundColor,
            shape: CommandStyle.roundedRectangleBorder),
        child: Icon(Icons.more_horiz),
        onPressed: () {
          CommandPopupMenu(
            context,
            visibleCommands.skip(visibleCommands.length - remaining).toList(),
            position: calculatePopUpMenuPosition(),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: CommandStyle.radius,
                    bottomRight: CommandStyle.radius)),
          );
        },
      ),
    );
  }

  RelativeRect? calculatePopUpMenuPosition() {
    var buttonKeyContext = buttonKey.currentContext;
    if (buttonKeyContext != null) {
      final RenderBox box = buttonKeyContext.findRenderObject() as RenderBox;
      Offset buttonPosition = box.localToGlobal(Offset.zero);
      Size buttonSize = box.size;
      Size screenSize = MediaQuery.of(buttonKeyContext).size;
      return RelativeRect.fromLTRB(screenSize.width,
          buttonPosition.dy + buttonSize.height + 2, 0, screenSize.height);
    }
    return null;
  }
}

class CommandToolbarButton extends StatelessWidget {
  final Command command;

  CommandToolbarButton(this.command);

  @override
  Widget build(BuildContext context) {
    Color foreGroundColor = Theme.of(context).textTheme.bodyText1!.color!;
    IconData? iconData = command.icon;
    final buttonStyle = TextButton.styleFrom(
        primary: foreGroundColor,
        padding: EdgeInsets.all(20),
        shape: CommandStyle.roundedRectangleBorder);
    if (iconData == null) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: CommandStyle.minTouchTargetHeight,
        ),
        child: TextButton(
          child: Text(
            command.name,
          ),
          style: buttonStyle,
          onPressed: () {
            command.action();
          },
        ),
      );
    } else {

      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: CommandStyle.minTouchTargetHeight,
        ),
        child: TextButton.icon(
          style: buttonStyle,
          label: Text(
            command.name,
          ),
          icon: CommandIcon(command),
          onPressed: () {
            command.action();
          },
        ),
      );
    }
  }
}
