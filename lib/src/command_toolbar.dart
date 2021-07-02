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
  final CommandToolbarStyle style;

  CommandToolbar(this.commands, {this.style = const CommandToolbarStyle()});

  @override
  Widget build(BuildContext context) {
    CommandToolbarStyle styleWithDefaults = style.withDefaults(context);

    List<Command> visibleCommands =
        commands.where((command) => command.visible).toList();
    return Visibility(
        visible: visibleCommands.isNotEmpty,
        child: Material(
          elevation: styleWithDefaults.elevation!,
          child: Container(
              padding: styleWithDefaults.padding,
              color: styleWithDefaults.backGroundColor,
              height: styleWithDefaults.height,
              child: Align(
                alignment: styleWithDefaults.alignment!,
                child: OverflowView.flexible(
                    spacing: styleWithDefaults.buttonSpacing!,
                    children: visibleCommands
                        .map((command) => CommandToolbarButton(
                              command,
                              style: styleWithDefaults.buttonStyle!,
                            ))
                        .toList(),
                    builder: (context, remaining) {
                      //return Text('remaining: ');
                      return CommandToolBarMoreButton(
                          visibleCommands
                              .skip(visibleCommands.length - remaining)
                              .toList(),
                          styleWithDefaults);
                    }),
              )),
        ));
  }
}

class CommandToolbarStyle {
  final double? elevation;
  final EdgeInsets? padding;
  final Color? backGroundColor;
  final double? height;
  final Alignment? alignment;
  final double? buttonSpacing;
  final CommandToolbarButtonStyle? buttonStyle;
  final CommandPopupMenuStyle? overFlowMenuStyle;

  const CommandToolbarStyle(
      {this.elevation,
      this.padding,
      this.backGroundColor,
      this.height,
      this.alignment,
      this.buttonSpacing,
      this.buttonStyle,
      this.overFlowMenuStyle});

  /// Creates a copy of [CommandToolbarStyle] where the current fields
  /// can be replaced with the new values, unless they are null.
  CommandToolbarStyle copyWith({
    final double? elevation,
    final EdgeInsets? padding,
    final Color? backGroundColor,
    final double? height,
    final Alignment? alignment,
    final double? buttonSpacing,
    final CommandToolbarButtonStyle? buttonStyle,
    final CommandPopupMenuStyle? overFlowPopupMenuStyle,
  }) =>
      CommandToolbarStyle(
          elevation: elevation ?? this.elevation,
          padding: padding ?? this.padding,
          backGroundColor: backGroundColor ?? this.backGroundColor,
          height: height ?? this.height,
          alignment: alignment ?? this.alignment,
          buttonSpacing: buttonSpacing ?? this.buttonSpacing,
          buttonStyle: buttonStyle ?? this.buttonStyle,
          overFlowMenuStyle: overFlowPopupMenuStyle ?? this.overFlowMenuStyle);

  /// Creates a copy of [withDefaults] with default field values
  /// unless they already had a value.
  CommandToolbarStyle withDefaults(BuildContext context) => copyWith(
      elevation: elevation ?? CommandStyle.elevation,
      padding: padding ?? _defaultPadding(),
      backGroundColor: backGroundColor ?? _defaultBackGroundColor(context),
      height: height ?? CommandStyle.touchTargetHeight,
      alignment: alignment ?? _defaultAlignment(),
      buttonSpacing: buttonSpacing ?? CommandStyle.spacing,
      buttonStyle: buttonStyle ?? CommandToolbarButtonStyle(),
      overFlowPopupMenuStyle: overFlowMenuStyle ?? CommandPopupMenuStyle());

  EdgeInsets _defaultPadding() =>
      EdgeInsets.fromLTRB(CommandStyle.spacing, 0, CommandStyle.spacing, 0);

  Color _defaultBackGroundColor(BuildContext context) =>
      Theme.of(context).dialogBackgroundColor;

  Alignment _defaultAlignment() => Alignment.centerRight;
}

class CommandToolBarMoreButton extends StatelessWidget {
  final List<Command> remainingVisibleCommands;
  final CommandToolbarStyle styleWithDefaults;
  final buttonKey = GlobalKey();

  CommandToolBarMoreButton(
      this.remainingVisibleCommands, this.styleWithDefaults);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: CommandStyle.touchTargetHeight),
      child: TextButton(
        key: buttonKey,
        style: styleWithDefaults.buttonStyle!.withDefaults(context),
        child: Icon(Icons.more_horiz),
        onPressed: () {
          CommandPopupMenu(
            context,
            remainingVisibleCommands,
            style: styleWithDefaults.overFlowMenuStyle!.copyWith(
                position: _calculatePopUpMenuPosition(),
                shape: _defaultShape()),
          );
        },
      ),
    );
  }

  RoundedRectangleBorder _defaultShape() {
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: CommandStyle.radius, bottomRight: CommandStyle.radius));
  }

  RelativeRect? _calculatePopUpMenuPosition() {
    var buttonKeyContext = buttonKey.currentContext;
    if (buttonKeyContext != null) {
      final RenderBox box = buttonKeyContext.findRenderObject() as RenderBox;
      Offset buttonPosition = box.localToGlobal(Offset.zero);
      Size buttonSize = box.size;
      Size screenSize = MediaQuery.of(buttonKeyContext).size;
      return RelativeRect.fromLTRB(
          screenSize.width,
          buttonPosition.dy + buttonSize.height,
          screenSize.width - buttonPosition.dx - buttonSize.width,
          screenSize.height);
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
    CommandButtonStyle styleWithDefaults = style.withDefaults(context);

    IconData? iconData = command.icon;
    if (iconData == null) {
      return ConstrainedBox(
        constraints: styleWithDefaults.constraints!,
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
        constraints: styleWithDefaults.constraints!,
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

  /// Creates a copy of [CommandButtonStyle] with default field values
  /// unless they already had a value.7
  @override
  CommandButtonStyle withDefaults(BuildContext context) {
    Color foregroundColor = _foreGroundColor(context);
    return super.withDefaults(context).copyWith2(
        foregroundColor: _DefaultForegroundColor(foregroundColor),
        overlayColor: _DefaultOverlayColor(foregroundColor));
  }

  Color _foreGroundColor(BuildContext context) =>
      Theme.of(context).textTheme.bodyText1!.color!;
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
