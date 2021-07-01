import 'dart:ui' as ui show TextHeightBehavior;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'command.dart';
import 'command_icon.dart';
import 'command_style.dart';
import 'command_text.dart';

class CommandPopupMenu {

  CommandPopupMenu(BuildContext context,
      List<Command> commands, {
        String? title,
        CommandPopupMenuStyle style = const CommandPopupMenuStyle(),
        Command? selectedCommand,
        bool useRootNavigator = false,
      }) {
    List<Command> visibleCommands =
    commands.where((command) => command.visible).toList();

    CommandPopupMenuStyle styleWithDefaults = style.withDefaultValues(context);

    if (visibleCommands.isNotEmpty) {
      showMenu<Command>(
          context: context,
          //style parameters
          position: styleWithDefaults.position!,
          elevation: styleWithDefaults.elevation,
          color: styleWithDefaults.color,
          semanticLabel: styleWithDefaults.semanticLabel,
          shape: styleWithDefaults.shape,
          //other parameters
          initialValue: selectedCommand,
          useRootNavigator: useRootNavigator,
          items: createItems(
              context, title, visibleCommands, styleWithDefaults))
          .then((command) => command!.action());
    }
  }


  List<PopupMenuItem<Command>> createItems(BuildContext context, String? title,
      List<Command> visibleCommands, CommandPopupMenuStyle styleWithDefaults) {
    return [
      if (title != null && title.isNotEmpty) CommandPopupMenuTitle(
          title, style: styleWithDefaults.titleStyle),
      ...visibleCommands
          .map((command) =>
          CommandPopupMenuItem(command, style: styleWithDefaults.itemStyle))
          .toList()
    ];
  }
}

class CommandPopupMenuStyle {
  final RelativeRect? position;
  final double? elevation;
  final ShapeBorder? shape;
  final Color? color;
  final String? semanticLabel;
  final CommandPopupMenuTitleStyle titleStyle;
  final CommandPopupMenuItemStyle itemStyle;

  const CommandPopupMenuStyle(
      {this.position , this.elevation, this.shape, this.color,
        this.semanticLabel, this.titleStyle = const CommandPopupMenuTitleStyle(), this.itemStyle = const CommandPopupMenuItemStyle()});

  ///Use default values unless they are already have a value
  CommandPopupMenuStyle withDefaultValues(BuildContext context) =>
      CommandPopupMenuStyle(
        position: position ?? positionInMiddleOfScreen(context),
        elevation: elevation,
        shape: shape ?? CommandStyle.roundedRectangleBorder,
        color: color,
        semanticLabel: semanticLabel,
        titleStyle: titleStyle,
        itemStyle: itemStyle,
      );

  RelativeRect positionInMiddleOfScreen(BuildContext context) {
    double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    double assumedPopUpWidth = 220;
    return RelativeRect.fromLTRB(
        (screenWidth - assumedPopUpWidth) / 2, 100, screenWidth, 100);
  }
}

class CommandPopupMenuItem extends PopupMenuItem<Command> {
  final CommandPopupMenuItemStyle style;

  CommandPopupMenuItem(Command command,
      {this.style = const CommandPopupMenuItemStyle()})
      : super(
      value: command,
      child: Row(children: [
        CommandIcon(
          command,
          style: style.iconStyle,
        ),
        SizedBox(
          width: style.spaceBetweenIconAndText,
        ),
        CommandText(
          command,
          style: style.textStyle,
        )
      ]));
}

class CommandPopupMenuItemStyle {
  final CommandIconStyle iconStyle;
  final double spaceBetweenIconAndText;
  final CommandTextStyle textStyle;

  const CommandPopupMenuItemStyle({this.iconStyle = const CommandIconStyle(),
    this.spaceBetweenIconAndText = 10,
    this.textStyle = const CommandTextStyle()});

  ///Convenience method to override a value
  CommandPopupMenuItemStyle copyWith({
    CommandIconStyle? iconStyle,
    double? spaceBetweenIconAndText,
    CommandTextStyle? textStyle,
  }) =>
      CommandPopupMenuItemStyle(
        iconStyle: iconStyle ?? this.iconStyle,
        spaceBetweenIconAndText:
        spaceBetweenIconAndText ?? this.spaceBetweenIconAndText,
        textStyle: textStyle ?? this.textStyle,
      );

/// No need to get default styles using context because [iconStyle] and [textStyle]
/// will get their default values themselves.
/// We therefore have no CommandPopupMenuItemStyle withDefaultValues(BuildContext context) method
}

/// A title that is displayed on top of the [CommandPopupMenu].
/// it is not clickable.
class CommandPopupMenuTitle extends PopupMenuItem<Command> {
  final CommandPopupMenuTitleStyle style;

  CommandPopupMenuTitle(String title,
      {this.style = const CommandPopupMenuTitleStyle()})
      : super(
    child: CommandText.forText(title, style: style),
    enabled: false,
  );

  static createTitle(String title, CommandPopupMenuTitleStyle style) =>
      Text(title);
}

class CommandPopupMenuTitleStyle extends CommandTextStyle {

  const CommandPopupMenuTitleStyle({InlineSpan? textSpan,
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
    ui.TextHeightBehavior? textHeightBehavior,}) : super(
      textSpan: textSpan,
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior
  )
  ;

  ///Use default values unless they are already have a value
  CommandTextStyle withDefaultValues(BuildContext context) =>
      CommandTextStyle(
        textSpan: textSpan,
        style: style ??
            DefaultTextStyle
                .of(context)
                .style
                .copyWith(
                color: _defaultColor(context),
                fontSize: 18,
                fontWeight: FontWeight.bold),
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
