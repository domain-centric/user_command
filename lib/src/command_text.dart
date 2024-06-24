/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project.
 */

import 'dart:ui' as ui show TextHeightBehavior;

import 'package:flutter/material.dart';

import 'command.dart';

/// A text for a [Command].
class CommandText extends StatelessWidget {
  final String Function() name;
  final CommandTextStyle style;

  CommandText(Command command,
      {Key? key, this.style = const CommandTextStyle()})
      : name = Command.stringFunction(command.name),
        super(key: key);

  CommandText.forText(String name,
      {Key? key, this.style = const CommandTextStyle()})
      : name = Command.stringFunction(name),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    CommandTextStyle styleWithDefaults = style.withDefaults(context);
    return Text(
      name(),
      style: styleWithDefaults.textStyle,
      textDirection: styleWithDefaults.textDirection,
      key: key,
      maxLines: styleWithDefaults.maxLines,
      overflow: styleWithDefaults.overflow,
      softWrap: styleWithDefaults.softWrap,
      strutStyle: styleWithDefaults.strutStyle,
      textAlign: styleWithDefaults.textAlign,
      textHeightBehavior: styleWithDefaults.textHeightBehavior,
      textScaleFactor: styleWithDefaults.textScaleFactor,
      textWidthBasis: styleWithDefaults.textWidthBasis,
    );
  }
}

/// Styling for the [CommandText].
/// The color defaults to the theme's textTheme.bodyText1.color
class CommandTextStyle {
  final InlineSpan? textSpan;
  final TextStyle? textStyle;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final ui.TextHeightBehavior? textHeightBehavior;

  const CommandTextStyle(
      {this.textSpan,
      this.textStyle,
      this.strutStyle,
      this.textAlign,
      this.textDirection,
      this.softWrap,
      this.overflow,
      this.textScaleFactor,
      this.maxLines,
      this.semanticsLabel,
      this.textWidthBasis,
      this.textHeightBehavior});

  /// Creates a copy of [CommandTextStyle] where the current fields
  /// can be replaced with the new values, unless they are null.
  CommandTextStyle copyWith({
    InlineSpan? textSpan,
    TextStyle? textStyle,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    ui.TextHeightBehavior? textHeightBehavior,
  }) =>
      CommandTextStyle(
        textSpan: textSpan ?? this.textSpan,
        textStyle: textStyle ?? this.textStyle,
        strutStyle: strutStyle ?? this.strutStyle,
        textAlign: textAlign ?? this.textAlign,
        textDirection: textDirection ?? this.textDirection,
        softWrap: softWrap ?? this.softWrap,
        overflow: overflow ?? this.overflow,
        textScaleFactor: textScaleFactor ?? this.textScaleFactor,
        maxLines: maxLines ?? this.maxLines,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
        textWidthBasis: textWidthBasis ?? this.textWidthBasis,
        textHeightBehavior: textHeightBehavior ?? this.textHeightBehavior,
      );

  /// Creates a copy of [CommandTextStyle] with default field values
  /// unless they already had a value.
  CommandTextStyle withDefaults(BuildContext context) => copyWith(
        textStyle: textStyle ?? _defaultTextStyle(context),
      );

  TextStyle _defaultTextStyle(BuildContext context) =>
      DefaultTextStyle.of(context)
          .style
          .copyWith(color: _defaultColor(context));

  Color _defaultColor(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!.color!;
}
