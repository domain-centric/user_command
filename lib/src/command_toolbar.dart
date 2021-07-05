/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:overflow_view/overflow_view.dart';
import 'package:user_command/src/command_popup_menu_button.dart';

import 'command.dart';
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
                      return CommandPopupMenuButton(
                          iconData: Icons.more_horiz,
                          commands: visibleCommands
                              .skip(visibleCommands.length - remaining)
                              .toList(),
                          style: styleWithDefaults.overFlowMenuStyle!);
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
  final CommandPopupMenuButtonStyle? overFlowMenuStyle;

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
    final CommandPopupMenuButtonStyle? overFlowPopupMenuStyle,
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
      overFlowPopupMenuStyle:
          overFlowMenuStyle ?? CommandPopupMenuButtonStyle());

  EdgeInsets _defaultPadding() =>
      EdgeInsets.fromLTRB(CommandStyle.spacing, 0, CommandStyle.spacing, 0);

  Color _defaultBackGroundColor(BuildContext context) =>
      Theme.of(context).dialogBackgroundColor;

  Alignment _defaultAlignment() => Alignment.centerRight;
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
              onPressed: command.action));
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
          onPressed: command.action,
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
        foregroundColor:
            this.foregroundColor ?? _DefaultForegroundColor(foregroundColor),
        overlayColor:
            this.overlayColor ?? _DefaultOverlayColor(foregroundColor));
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
