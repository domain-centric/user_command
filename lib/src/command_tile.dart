/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project.
 */

import 'package:flutter/material.dart';
import 'package:user_command/src/command.dart';
import 'package:user_command/src/command_icon.dart';
import 'package:user_command/src/command_text.dart';

class CommandTile extends StatelessWidget {
  final Command command;
  final CommandTileStyle style;
  final Key? key;

  /// Whether this list tile is interactive.
  ///
  /// If false, this list tile is styled with the disabled color from the
  /// current [Theme] and the [onTap] and [onLongPress] callbacks are
  /// inoperative.
  final bool enabled;

  /// If this tile is also [enabled] then icons and text are rendered with the same color.
  ///
  /// By default the selected color is the theme's primary color. The selected color
  /// can be overridden with a [ListTileTheme].
  ///
  /// {@tool dartpad --template=stateful_widget_scaffold}
  ///
  /// Here is an example of using a [StatefulWidget] to keep track of the
  /// selected index, and using that to set the `selected` property on the
  /// corresponding [ListTile].
  ///
  /// ```dart
  ///   int _selectedIndex = 0;
  ///
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return ListView.builder(
  ///       itemCount: 10,
  ///       itemBuilder: (BuildContext context, int index) {
  ///         return ListTile(
  ///           title: Text('Item $index'),
  ///           selected: index == _selectedIndex,
  ///           onTap: () {
  ///             setState(() {
  ///               _selectedIndex = index;
  ///             });
  ///           },
  ///         );
  ///       },
  ///     );
  ///   }
  /// ```
  /// {@end-tool}
  final bool selected;

  /// {@macro flutter.widgets.Focus.autofocus}
  final bool autofocus;

  CommandTile(
    this.command, {
    this.style = const CommandTileStyle(),
    this.key,
    this.enabled = true,
    this.selected = false,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) => ListTile(
        key: key,
        leading: CommandIcon(command, style: style.iconStyle),
        title: CommandText(
          command,
          style: style.titleStyle,
        ),
        onTap: command.action,
      );
}

class CommandTileStyle {
  final CommandIconStyle iconStyle;
  final CommandTextStyle titleStyle;

  /// Whether this list tile is intended to display three lines of text.
  ///
  /// If true, then [subtitle] must be non-null (since it is expected to give
  /// the second and third lines of text).
  ///
  /// If false, the list tile is treated as having one line if the subtitle is
  /// null and treated as having two lines if the subtitle is non-null.
  ///
  /// When using a [Text] widget for [title] and [subtitle], you can enforce
  /// line limits using [Text.maxLines].
  final bool isThreeLine;

  /// Whether this list tile is part of a vertically dense list.
  ///
  /// If this property is null then its value is based on [ListTileTheme.dense].
  ///
  /// Dense list tiles default to a smaller height.
  final bool? dense;

  /// Defines how compact the list tile's layout will be.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all
  ///    widgets within a [Theme].
  final VisualDensity? visualDensity;

  /// The tile's shape.
  ///
  /// Defines the tile's [InkWell.customBorder] and [Ink.decoration] shape.
  ///
  /// If this property is null then [ListTileTheme.shape] is used.
  /// If that's null then a rectangular [Border] will be used.
  final ShapeBorder? shape;

  /// The tile's internal padding.
  ///
  /// Insets a [ListTile]'s contents: its [leading], [title], [subtitle],
  /// and [trailing] widgets.
  ///
  /// If null, `EdgeInsets.symmetric(horizontal: 16.0)` is used.
  final EdgeInsetsGeometry? contentPadding;

  /// The cursor for a mouse pointer when it enters or is hovering over the
  /// widget.
  ///
  /// If [mouseCursor] is a [MaterialStateProperty<MouseCursor>],
  /// [MaterialStateProperty.resolve] is used for the following [MaterialState]s:
  ///
  ///  * [MaterialState.selected].
  ///  * [MaterialState.disabled].
  ///
  /// If this property is null, [MaterialStateMouseCursor.clickable] will be used.
  final MouseCursor? mouseCursor;

  /// The color for the tile's [Material] when it has the input focus.
  final Color? focusColor;

  /// The color for the tile's [Material] when a pointer is hovering over it.
  final Color? hoverColor;

  /// {@macro flutter.widgets.Focus.focusNode}
  final FocusNode? focusNode;

  /// {@template flutter.material.ListTile.tileColor}
  /// Defines the background color of `ListTile` when [selected] is false.
  ///
  /// When the value is null, the `tileColor` is set to [ListTileTheme.tileColor]
  /// if it's not null and to [Colors.transparent] if it's null.
  /// {@endtemplate}
  final Color? tileColor;

  /// Defines the background color of `ListTile` when [selected] is true.
  ///
  /// When the value if null, the `selectedTileColor` is set to [ListTileTheme.selectedTileColor]
  /// if it's not null and to [Colors.transparent] if it's null.
  final Color? selectedTileColor;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// The horizontal gap between the titles and the leading/trailing widgets.
  ///
  /// If null, then the value of [ListTileTheme.horizontalTitleGap] is used. If
  /// that is also null, then a default value of 16 is used.
  final double? horizontalTitleGap;

  /// The minimum padding on the top and bottom of the title and subtitle widgets.
  ///
  /// If null, then the value of [ListTileTheme.minVerticalPadding] is used. If
  /// that is also null, then a default value of 4 is used.
  final double? minVerticalPadding;

  /// The minimum width allocated for the [ListTile.leading] widget.
  ///
  /// If null, then the value of [ListTileTheme.minLeadingWidth] is used. If
  /// that is also null, then a default value of 40 is used.
  final double? minLeadingWidth;

  const CommandTileStyle(
      {this.iconStyle = const CommandIconStyle(),
      this.titleStyle = const CommandTextStyle(),
      this.isThreeLine = false,
      this.dense,
      this.visualDensity,
      this.shape,
      this.contentPadding,
      this.mouseCursor,
      this.focusColor,
      this.hoverColor,
      this.focusNode,
      this.tileColor,
      this.selectedTileColor,
      this.enableFeedback,
      this.horizontalTitleGap,
      this.minVerticalPadding,
      this.minLeadingWidth});
}
