/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project. 
 */

import 'package:flutter/material.dart';

import '../user_command.dart';

enum AnchorPosition { left, right }

/// The [CommandPopupMenuButton] is a button that opens a [CommandPopupMenu] when it is clicked.
/// The [CommandPopupMenu] will position it self underneath this button.
/// The [CommandPopupMenu] may reposition it self if it would not fit on the screen.
class CommandPopupMenuButton extends StatelessWidget {
  final IconData iconData;
  final List<Command> commands;
  final CommandPopupMenuButtonStyle style;
  final GlobalKey buttonKey = GlobalKey();

  /// The [anchorWidgetKey] is the key of the widget that the popup menu
  /// relatively positions to.
  /// This is the [CommandPopupMenuButton]'s [buttonKey] by default.
  /// You could choose to provide the key of an alternative widget, e.g. when
  /// the [CommandPopupMenuButton] in nested into another widget such as an
  /// [TextField]
  final GlobalKey? anchorWidgetKey;
  final AnchorPosition anchorPosition;

  CommandPopupMenuButton(
      {Key? key,
      required this.iconData,
      required this.commands,
      this.style = const CommandPopupMenuButtonStyle(),
      this.anchorWidgetKey,
      this.anchorPosition = AnchorPosition.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var iconButtonStyle = style.iconButtonStyle.withDefaults(context);
    var menuStyle = style.menuStyle.withDefaults(context);
    return ConstrainedBox(
      constraints: iconButtonStyle.constraints!,
      child: TextButton(
          key: buttonKey,
          style: iconButtonStyle,
          onPressed: () {
            CommandPopupMenu(
              context,
              commands,
              style: menuStyle.copyWith(
                  position: _calculatePopUpMenuPosition(),
                  shape: _defaultShape()),
            );
          },
          child: Icon(iconData)),
    );
  }

  RoundedRectangleBorder _defaultShape() {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: CommandStyle.radius, bottomRight: CommandStyle.radius));
  }

  RelativeRect? _calculatePopUpMenuPosition() {
    var anchorWidgetContext = anchorWidgetKey == null
        ? buttonKey.currentContext
        : anchorWidgetKey!.currentContext;
    if (anchorWidgetContext != null) {
      final RenderBox box = anchorWidgetContext.findRenderObject() as RenderBox;
      Offset widgetPosition = box.localToGlobal(Offset.zero);
      Size buttonSize = box.size;
      Size screenSize = MediaQuery.of(anchorWidgetContext).size;
      return RelativeRect.fromLTRB(
          anchorPosition == AnchorPosition.left
              ? widgetPosition.dx
              : screenSize.width,
          widgetPosition.dy + buttonSize.height,
          anchorPosition == AnchorPosition.left
              ? screenSize.width
              : screenSize.width - widgetPosition.dx - buttonSize.width,
          screenSize.height);
    }
    return null;
  }
}

class CommandPopupMenuButtonStyle {
  final CommandButtonStyle iconButtonStyle;
  final CommandPopupMenuStyle menuStyle;

  const CommandPopupMenuButtonStyle(
      {this.iconButtonStyle = const CommandToolbarButtonStyle(),
      this.menuStyle = const CommandPopupMenuStyle()});
}

class CommandPopupMenuIconButtonStyle extends CommandToolbarButtonStyle {
  const CommandPopupMenuIconButtonStyle(
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
