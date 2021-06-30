import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'command.dart';
import 'command_icon.dart';
import 'command_style.dart';
import 'command_text.dart';

class CommandPopupMenu {
  final List<Command> commands;

  CommandPopupMenu(
    BuildContext context,
    this.commands, {
    String? title,
    Command? selectedCommand,
    RelativeRect? position,
    double? elevation,
    ShapeBorder? shape,
    Color? color,
    String? semanticLabel,
    bool useRootNavigator = false,
  }) {
    if (position == null) {
      position = positionInMiddleOfScreen(context);
    }

    List<Command> visibleCommands =
        commands.where((command) => command.visible).toList();

    if (visibleCommands.isNotEmpty) {
      showMenu<Command>(
              context: context,
              position: position,
              initialValue: selectedCommand,
              elevation: elevation,
              color: color,
              semanticLabel: semanticLabel,
              useRootNavigator: useRootNavigator,
              shape:
                  (shape == null) ? CommandStyle.roundedRectangleBorder : shape,
              items: createItems(context, title, visibleCommands))
          .then((command) => command!.action());
    }
  }

  RelativeRect positionInMiddleOfScreen(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double assumedPopUpWidth = 220;
    return RelativeRect.fromLTRB(
        (screenWidth - assumedPopUpWidth) / 2, 100, screenWidth, 100);
  }

  List<PopupMenuItem<Command>> createItems(
      BuildContext context, String? title, List<Command> visibleCommands) {
    return [
      if (title != null && title.isNotEmpty) createTitle(context, title),
      ...visibleCommands
          .map((command) => CommandPopupMenuItem(command))
          .toList()
    ];
  }

  PopupMenuItem<Command> createTitle(BuildContext context, String title) =>
      PopupMenuItem(
        child: Text(title),
        enabled: false,
        textStyle: Theme.of(context).textTheme.headline6,
      );
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

  const CommandPopupMenuItemStyle(
      {this.iconStyle = const CommandIconStyle(),
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

  /// No need to get default styles using contect because [iconStyle] and [textStyle]
  /// will get their default values themselves.
  /// We therefore have no CommandPopupMenuItemStyle withDefaultValues(BuildContext context) method
}
