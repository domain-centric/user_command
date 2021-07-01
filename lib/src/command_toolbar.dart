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
    CommandToolbarButtonStyle styleWithDefaults =
    style.withDefaultValues(context);

    IconData? iconData = command.icon;
    if (iconData == null) {
      return ConstrainedBox(
        constraints: styleWithDefaults.constraints!
        //wont be null after style.withDefaultValues
        ,
        child: TextButton(
          child: Text(command.name)
          // we are not using CommandText because we are using styleWithDefaults.textStyle instead
          ,
          style: styleWithDefaults,
          onPressed: () {
            command.action();
          },
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: styleWithDefaults.constraints!
        //wont be null after style.withDefaultValues
        ,
        child: TextButton.icon(
          style: styleWithDefaults,
          label: Text(
            command.name,
          )
          // we are not using CommandText because we are using styleWithDefaults.textStyle instead
          ,
          icon: Icon(command.icon),
          // we are not using CommandIcon because we are using styleWithDefaults.textStyle instead
          onPressed: () {
            command.action();
          },
        ),
      );
    }
  }
}


class CommandToolbarButtonStyle extends ButtonStyle {
  final BoxConstraints?
  constraints; //todo do we need this? see minimumSize and tapTargetSize

  const CommandToolbarButtonStyle({this.constraints,
    MaterialStateProperty<Color?>? foregroundColor,
    AlignmentGeometry? alignment,
    Duration? animationDuration,
    MaterialStateProperty<Color?>? backgroundColor,
    MaterialStateProperty<double?>? elevation,
    bool? enableFeedback,
    MaterialStateProperty<Size?>? fixedSize,
    MaterialStateProperty<Size?>? minimumSize,
    MaterialStateProperty<MouseCursor?>? mouseCursor,
    MaterialStateProperty<Color?>? overlayColor,
    MaterialStateProperty<EdgeInsetsGeometry?>? padding,
    MaterialStateProperty<Color?>? shadowColor,
    MaterialStateProperty<OutlinedBorder?>? shape,
    MaterialStateProperty<BorderSide?>? side,
    InteractiveInkFeatureFactory? splashFactory,
    MaterialTapTargetSize? tapTargetSize,
    MaterialStateProperty<TextStyle?>? textStyle,
    VisualDensity? visualDensity})
      : super(
      foregroundColor: foregroundColor,
      alignment: alignment,
      animationDuration: animationDuration,
      backgroundColor: backgroundColor,
      elevation: elevation,
      enableFeedback: enableFeedback,
      fixedSize: fixedSize,
      minimumSize: minimumSize,
      mouseCursor: mouseCursor,
      overlayColor: overlayColor,
      padding: padding,
      shadowColor: shadowColor,
      shape: shape,
      side: side,
      splashFactory: splashFactory,
      tapTargetSize: tapTargetSize,
      textStyle: textStyle,
      visualDensity: visualDensity);

  /// Use given values, but if they are null use default values where needed,
  /// based on the current theme
  CommandToolbarButtonStyle withDefaultValues(BuildContext context) {
    Color defaultForegroundColor =
    Theme.of(context).textTheme.bodyText1!.color!;
    return CommandToolbarButtonStyle(
        constraints: constraints ?? defaultConstraints(),
        foregroundColor: foregroundColor ??
            MaterialStateProperty.all<Color>(defaultForegroundColor),
        alignment: alignment,
        animationDuration: animationDuration,
        backgroundColor: backgroundColor,
        elevation: elevation,
        enableFeedback: enableFeedback,
        fixedSize: fixedSize,
        minimumSize: minimumSize,
        mouseCursor: mouseCursor,
        overlayColor:
        overlayColor ?? _TextButtonDefaultOverlay(defaultForegroundColor),
        padding: padding ?? defaultPadding(),
        shadowColor: shadowColor,
        shape: shape ?? defaultShape(),
        side: side,
        splashFactory: splashFactory,
        tapTargetSize: tapTargetSize,
        textStyle: textStyle,
        visualDensity: visualDensity);
  }

  BoxConstraints defaultConstraints() => BoxConstraints(
    minHeight: CommandStyle.minTouchTargetHeight,
  );

  MaterialStateProperty<EdgeInsetsGeometry?> defaultPadding() =>
      MaterialStateProperty.all<EdgeInsetsGeometry?>(EdgeInsets.fromLTRB(
          CommandStyle.spacing, 0, CommandStyle.spacing, 0));

  MaterialStateProperty<OutlinedBorder?> defaultShape() =>
      MaterialStateProperty.all<OutlinedBorder?>(
          CommandStyle.roundedRectangleBorder);
}


/// Inspired by [TextButton.styleFrom()]
@immutable
class _TextButtonDefaultOverlay extends MaterialStateProperty<Color?> {
  _TextButtonDefaultOverlay(this.primary);

  final Color primary;

  @override
  Color? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.hovered))
      return primary.withOpacity(0.04);
    if (states.contains(MaterialState.focused) ||
        states.contains(MaterialState.pressed))
      return primary.withOpacity(0.12);
    return null;
  }
}
