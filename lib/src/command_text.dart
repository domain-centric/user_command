import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui show TextHeightBehavior;

import 'command.dart';

/// A text for a [Command].
class CommandText extends StatelessWidget {
  final Command command;
  final Key? key;
  final CommandTextStyle style;

  CommandText(this.command, {this.key, this.style = const CommandTextStyle()});

  @override
  Widget build(BuildContext context) {
    CommandTextStyle commandTextStyle = style.withDefaultValues(context);
    return Text(command.name, style: commandTextStyle.style,
      textDirection: commandTextStyle.textDirection,
      key: key,
      maxLines: commandTextStyle.maxLines,
      overflow: commandTextStyle.overflow,
      softWrap: commandTextStyle.softWrap,
      strutStyle: commandTextStyle.strutStyle,
      textAlign: commandTextStyle.textAlign,
      textHeightBehavior: commandTextStyle.textHeightBehavior,
      textScaleFactor: commandTextStyle.textScaleFactor,
      textWidthBasis: commandTextStyle.textWidthBasis,);
  }

}

/// Styling for the [CommandText].
/// The color defaults to the theme's textTheme.bodyText1.color
class CommandTextStyle {
  final InlineSpan? textSpan;
  final TextStyle? style;
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


  const CommandTextStyle({this.textSpan, this.style, this.strutStyle,
    this.textAlign,
    this.textDirection, this.softWrap, this.overflow, this.textScaleFactor,
    this.maxLines, this.semanticsLabel, this.textWidthBasis,
    this.textHeightBehavior});

  ///Convenience method to override a value
  CommandTextStyle copyWith({
    InlineSpan? textSpan,
    TextStyle? style,
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
        style: style ?? this.style,
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

  ///Use default values unless they are already have a value
  CommandTextStyle withDefaultValues(BuildContext context) =>
      CommandTextStyle(
        textSpan: textSpan,
        style: style ?? DefaultTextStyle
            .of(context)
            .style
            .copyWith(color: _defaultColor(context)),
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        softWrap: softWrap,
        overflow: overflow,
        textScaleFactor: textScaleFactor,
        maxLines: maxLines,
        semanticsLabel: semanticsLabel,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
      );

  Color _defaultColor(BuildContext context) =>
      Theme
          .of(context)
          .textTheme
          .bodyText1!
          .color!;
}


