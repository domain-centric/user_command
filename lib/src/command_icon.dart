/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project.
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'command.dart';

/// An icon for a [Command].
/// It will be a placeholder if command has no icon defined.
class CommandIcon extends StatelessWidget {
  final Command command;
  final Key? key;
  final CommandIconStyle style;

  const CommandIcon(this.command,
      {this.key, this.style = const CommandIconStyle()});

  @override
  Widget build(BuildContext context) {
    IconData? iconData = command.icon;
    if (iconData == null) {
      return buildPlaceHolderIcon(context);
    } else {
      return buildIcon(context, iconData, style);
    }
  }

  Icon buildIcon(BuildContext context, IconData iconData, CommandIconStyle style) {
    var styleWithDefaultValues = style.withDefaultValues(context);
    return Icon(iconData,
        key: key,
        size: styleWithDefaultValues.size,
        color: styleWithDefaultValues.color,
        semanticLabel: styleWithDefaultValues.semanticLabel,
        textDirection: styleWithDefaultValues.textDirection);
  }

  Widget buildPlaceHolderIcon(BuildContext context) => buildIcon(
      context,
      //just any random icon will do, because it will be transparent
      Icons.adjust,
      style.copyWith(color: Colors.transparent));
}

/// Styling for the [CommandIcon].
/// The color defaults to the theme's textTheme.bodyText1.color
class CommandIconStyle {
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  const CommandIconStyle({this.size, this.color, this.semanticLabel, this.textDirection});

  ///Convenience method to override a value
  CommandIconStyle copyWith({double? size,
    Color? color,
    String? semanticLabel,
    TextDirection? textDirection}) =>
      CommandIconStyle(
          size: size ?? this.size,
          color: color ?? this.color,
          semanticLabel: semanticLabel ?? this.semanticLabel,
          textDirection: textDirection ?? this.textDirection);

  ///Use default values unless they are already have a value
  CommandIconStyle withDefaultValues(BuildContext context) => CommandIconStyle(
      size: size,
      color: color ?? _defaultColor(context),
      semanticLabel: semanticLabel,
      textDirection: textDirection);

  Color _defaultColor(BuildContext context) =>
      Theme.of(context).textTheme.bodyText1!.color!;
}
