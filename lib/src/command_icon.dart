/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project.
 */

import 'package:flutter/material.dart';

import 'command.dart';

/// An icon for a [Command].
/// It will be a placeholder if command has no icon defined.
class CommandIcon extends StatelessWidget {
  final Command command;
  final CommandIconStyle style;

  const CommandIcon(this.command,
      {Key? key, this.style = const CommandIconStyle()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    IconData? iconData = command.icon;
    if (iconData == null) {
      return buildPlaceHolderIcon(context);
    } else {
      return buildIcon(context, iconData, style);
    }
  }

  Icon buildIcon(
      BuildContext context, IconData iconData, CommandIconStyle style) {
    var styleWithDefaultValues = style.withDefaults(context);
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

  const CommandIconStyle(
      {this.size, this.color, this.semanticLabel, this.textDirection});

  /// Creates a copy of [CommandIconStyle] where the current fields
  /// can be replaced with the new values, unless they are null.
  CommandIconStyle copyWith(
          {double? size,
          Color? color,
          String? semanticLabel,
          TextDirection? textDirection}) =>
      CommandIconStyle(
          size: size ?? this.size,
          color: color ?? this.color,
          semanticLabel: semanticLabel ?? this.semanticLabel,
          textDirection: textDirection ?? this.textDirection);

  /// Creates a copy of [CommandIconStyle] with default field values
  /// unless they already had a value
  CommandIconStyle withDefaults(BuildContext context) =>
      copyWith(color: color ?? _defaultColor(context));

  Color _defaultColor(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!.color!;
}
