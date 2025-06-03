/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project.
 */

import 'package:flutter/material.dart';

import 'command.dart';
import 'command_icon.dart';
import 'command_style.dart';
import 'command_text.dart';

class CommandPopupMenu {
  CommandPopupMenu(
    BuildContext context,
    List<Command> commands, {
    String? title,
    CommandPopupMenuStyle style = const CommandPopupMenuStyle(),
    Command? selectedCommand,
    bool useRootNavigator = false,
  }) {
    List<Command> visibleCommands = commands
        .where((command) => command.visible)
        .toList();

    CommandPopupMenuStyle styleWithDefaults = style.withDefaults(context);

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
        items: createItems(context, title, visibleCommands, styleWithDefaults),
      ).then((command) {
        if (command != null) {
          command.action();
        }
      });
    }
  }

  List<PopupMenuItem<Command>> createItems(
    BuildContext context,
    String? title,
    List<Command> visibleCommands,
    CommandPopupMenuStyle styleWithDefaults,
  ) {
    return [
      if (title != null && title.isNotEmpty)
        CommandPopupMenuTitle(title, style: styleWithDefaults.titleStyle!),
      ...visibleCommands.map(
        (command) =>
            CommandPopupMenuItem(command, style: styleWithDefaults.itemStyle!),
      ),
    ];
  }
}

class CommandPopupMenuStyle {
  /// The position where the [CommandPopupMenu] will appear
  /// Note that the [CommandPopupMenu] may reposition it self
  /// if it would not fit on the screen.
  final RelativeRect? position;
  final double? elevation;
  final ShapeBorder? shape;
  final Color? color;
  final String? semanticLabel;
  final CommandPopupMenuTitleStyle? titleStyle;
  final CommandPopupMenuItemStyle? itemStyle;

  const CommandPopupMenuStyle({
    this.position,
    this.elevation,
    this.shape,
    this.color,
    this.semanticLabel,
    this.titleStyle,
    this.itemStyle,
  });

  /// Creates a copy of [CommandPopupMenuStyle] where the current fields
  /// can be replaced with the new values, unless they are null.
  CommandPopupMenuStyle copyWith({
    final RelativeRect? position,
    final double? elevation,
    final ShapeBorder? shape,
    final Color? color,
    final String? semanticLabel,
    final CommandPopupMenuTitleStyle? titleStyle,
    final CommandPopupMenuItemStyle? itemStyle,
  }) => CommandPopupMenuStyle(
    position: position ?? this.position,
    elevation: elevation ?? this.elevation,
    shape: shape ?? this.shape,
    color: color ?? this.color,
    semanticLabel: semanticLabel ?? this.semanticLabel,
    titleStyle: titleStyle ?? this.titleStyle,
    itemStyle: itemStyle ?? this.itemStyle,
  );

  /// Creates a copy of [CommandPopupMenuStyle] with default field values
  /// unless they already had a value.
  CommandPopupMenuStyle withDefaults(BuildContext context) => copyWith(
    position: position ?? _positionInMiddleOfScreen(context),
    elevation: elevation ?? CommandStyle.elevation,
    shape: shape ?? CommandStyle.roundedRectangleBorder,
    titleStyle: titleStyle ?? const CommandPopupMenuTitleStyle(),
    itemStyle: itemStyle ?? const CommandPopupMenuItemStyle(),
  );

  RelativeRect _positionInMiddleOfScreen(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double assumedPopUpWidth = 220;
    return RelativeRect.fromLTRB(
      (screenWidth - assumedPopUpWidth) / 2,
      100,
      screenWidth,
      100,
    );
  }
}

class CommandPopupMenuItem extends PopupMenuItem<Command> {
  final CommandPopupMenuItemStyle style;

  CommandPopupMenuItem(
    Command command, {
    super.key,
    this.style = const CommandPopupMenuItemStyle(),
  }) : super(
         value: command,
         child: Row(
           children: [
             CommandIcon(command, style: style.iconStyle),
             SizedBox(width: style.spaceBetweenIconAndText),
             CommandText(command, style: style.textStyle),
           ],
         ),
       );
}

class CommandPopupMenuItemStyle {
  final CommandIconStyle iconStyle;
  final double spaceBetweenIconAndText;
  final CommandTextStyle textStyle;

  const CommandPopupMenuItemStyle({
    this.iconStyle = const CommandIconStyle(),
    this.spaceBetweenIconAndText = 10,
    this.textStyle = const CommandTextStyle(),
  });

  /// Creates a copy of [CommandPopupMenuItemStyle] where the current fields
  /// can be replaced with the new values, unless they are null.
  CommandPopupMenuItemStyle copyWith({
    CommandIconStyle? iconStyle,
    double? spaceBetweenIconAndText,
    CommandTextStyle? textStyle,
  }) => CommandPopupMenuItemStyle(
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

  CommandPopupMenuTitle(
    String title, {
    super.key,
    this.style = const CommandPopupMenuTitleStyle(),
  }) : super(child: CommandText.forText(title, style: style), enabled: false);
}

class CommandPopupMenuTitleStyle extends CommandTextStyle {
  const CommandPopupMenuTitleStyle({
    super.textSpan,
    TextStyle? style,
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.softWrap,
    super.overflow,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
  }) : super(textStyle: style);

  /// Creates a copy of [CommandTextStyle] with default field values
  /// unless they already had a value.
  @override
  CommandTextStyle withDefaults(BuildContext context) =>
      copyWith(textStyle: textStyle ?? _defaultStyle(context));

  TextStyle _defaultStyle(BuildContext context) =>
      DefaultTextStyle.of(context).style.copyWith(
        color: _defaultColor(context),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  Color _defaultColor(BuildContext context) =>
      Theme.of(context).textTheme.labelMedium!.color!;
}
