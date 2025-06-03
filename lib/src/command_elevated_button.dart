/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project. 
 */

import 'package:flutter/material.dart';

import '../user_command.dart';

class CommandElevatedButton extends StatelessWidget {
  final Command command;
  final CommandElevatedButtonStyle style;

  const CommandElevatedButton(
    this.command, {
    super.key,
    this.style = const CommandElevatedButtonStyle(),
  });

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
        child: ElevatedButton(
          onPressed: command.action,
          style: styleWithDefaults,
          child: Text(command.name),
        ),
      );
    } else {
      return ConstrainedBox(
        constraints: styleWithDefaults.constraints!,
        child: ElevatedButton.icon(
          onPressed: command.action,
          label: Text(command.name),
          icon: Icon(command.icon),
          style: styleWithDefaults,
        ),
      );
    }
  }
}

class CommandElevatedButtonStyle extends CommandButtonStyle {
  const CommandElevatedButtonStyle({
    super.constraints,
    super.foregroundColor,
    super.alignment,
    super.animationDuration,
    super.backgroundColor,
    super.elevation,
    super.enableFeedback,
    super.mouseCursor,
    super.overlayColor,
    super.padding,
    super.shadowColor,
    super.shape,
    super.side,
    super.splashFactory,
    super.textStyle,
    super.visualDensity,
  });
}
