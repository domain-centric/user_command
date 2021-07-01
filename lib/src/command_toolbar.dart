/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:overflow_view/overflow_view.dart';

import 'command.dart';
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
            height: CommandStyle.touchTargetHeight,
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
      constraints: BoxConstraints(minHeight: CommandStyle.touchTargetHeight),
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
            style: CommandPopupMenuStyle(
                position: calculatePopUpMenuPosition(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: CommandStyle.radius,
                        bottomRight: CommandStyle.radius))),
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
  final CommandToolbarButtonStyle style;

  CommandToolbarButton(this.command,
      {this.style = const CommandToolbarButtonStyle()});

  @override
  Widget build(BuildContext context) {
    CommandButtonStyle styleWithDefaults = style.withDefaultValues(context);

    IconData? iconData = command.icon;
    if (iconData == null) {
      return ConstrainedBox(
        constraints:
            // wont be null after style.withDefaultValues
            styleWithDefaults.constraints!,
        child: TextButton(
          child:
              // not using CommandText because we are using styleWithDefaults.textStyle instead
              Text(command.name),
          style: styleWithDefaults,
          onPressed: () {
            command.action();
          },
        ),
      );
    } else {
      return ConstrainedBox(
        constraints:
            // wont be null after style.withDefaultValues
            styleWithDefaults.constraints!,
        child: TextButton.icon(
          style: styleWithDefaults,
          label:
              // not using CommandText because we are using styleWithDefaults.textStyle instead
              Text(
            command.name,
          ),
          icon:
              // using CommandIcon because we are using styleWithDefaults.textStyle instead
              Icon(command.icon),
          onPressed: () {
            command.action();
          },
        ),
      );
    }
  }
}

@immutable
class CommandToolbarButtonStyle extends CommandButtonStyle {
  const CommandToolbarButtonStyle(
      {BoxConstraints? constraints,
      MaterialStateProperty<Color?>? foregroundColor,
      AlignmentGeometry? alignment,
      Duration? animationDuration,
      MaterialStateProperty<Color?>? backgroundColor,
      MaterialStateProperty<double?>? elevation,
      bool? enableFeedback,
      MaterialStateProperty<MouseCursor?>? mouseCursor,
      MaterialStateProperty<Color?>? overlayColor,
      MaterialStateProperty<EdgeInsetsGeometry?>? padding,
      MaterialStateProperty<Color?>? shadowColor,
      MaterialStateProperty<OutlinedBorder?>? shape,
      MaterialStateProperty<BorderSide?>? side,
      InteractiveInkFeatureFactory? splashFactory,
      MaterialStateProperty<TextStyle?>? textStyle,
      VisualDensity? visualDensity})
      : super(
            constraints: constraints,
            foregroundColor: foregroundColor,
            animationDuration: animationDuration,
            visualDensity: visualDensity,
            textStyle: textStyle,
            splashFactory: splashFactory,
            side: side,
            shape: shape,
            shadowColor: shadowColor,
            padding: padding,
            overlayColor: overlayColor,
            mouseCursor: mouseCursor,
            enableFeedback: enableFeedback,
            elevation: elevation,
            backgroundColor: backgroundColor,
            alignment: alignment);

  CommandButtonStyle withDefaultValues(BuildContext context) {
    Color foregroundColor = Theme.of(context).textTheme.bodyText1!.color!;
    return overrideDefaultValues(
        defaultForegroundColor: _DefaultForegroundColor(foregroundColor),
        defaultOverlayColor: _DefaultOverlayColor(foregroundColor));
  }
}

/// Inspired by [TextButton.styleFrom()]
@immutable
class _DefaultForegroundColor extends MaterialStateProperty<Color?> {
  _DefaultForegroundColor(this.color);

  final Color color;

  @override
  Color? resolve(Set<MaterialState> states) {
    return color;
  }
}

/// Inspired by [TextButton.styleFrom()]
@immutable
class _DefaultOverlayColor extends MaterialStateProperty<Color?> {
  _DefaultOverlayColor(this.color);

  final Color color;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered)) return color.withOpacity(0.04);
    if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed)) return color.withOpacity(0.12);
    return null;
  }
}
