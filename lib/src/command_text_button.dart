/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project. 
 */

import 'package:flutter/material.dart';

import '../user_command.dart';

class CommandTextButton extends StatelessWidget {
  final Command command;
  final CommandTextButtonStyle style;

  const CommandTextButton(this.command,
      {Key? key, this.style = const CommandTextButtonStyle()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!command.visible) {
      return emptySizeBox;
    }
    CommandButtonStyle styleWithDefaults = style.withDefaults(context);
    IconData? iconData = command.icon;
    if (iconData == null) {
      return ConstrainedBox(
        constraints: styleWithDefaults.constraints!,
        child: TextButton(
          onPressed: command.action,
          style: styleWithDefaults,
          child: Text(command.name),
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: styleWithDefaults.constraints!,
        child: TextButton.icon(
          onPressed: command.action,
          label: Text(command.name),
          icon: Icon(command.icon),
          style: styleWithDefaults,
        ),
      );
    }
  }
}

class CommandTextButtonStyle extends CommandButtonStyle {
  const CommandTextButtonStyle(
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
}
