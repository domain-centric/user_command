/*
 * Copyright (c) 2021 by Nils ten Hoeve. See LICENSE file in project.
 */

import 'package:flutter/material.dart';

/// Styling is a matter of taste.
/// Google's [material design][https://material.io/design] is arguably
/// one of the best and most used styling guide lines out there.
///
/// For the [Command] widgets we use a common set of style values that are defined in this class
/// Google's [material design][https://material.io/design] should be followed as much as possible
/// Deviations must be explained in the doc comments (behind ///)

class CommandStyle {
  /// From [Material design][https://material.io/design/layout/spacing-methods.html#touch-targets]:
  /// Touch targets apply to any device that receives both touch and non-touch input.
  /// To balance information density and usability,
  /// touch targets should be at least 48 x 48 dp with at least 8dp of space between targets.
  static const touchTargetHeight = 48.0;

  /// From [Material design][https://material.io/design/layout/spacing-methods.html#touch-targets]:
  /// touch targets should be at least 48 x 48 dp with at least 8dp of space between targets.
  static const spacing = 20.0;

  /// We use Rounded corners because:
  ///
  /// - Rounded Corners are Easy on the Eyes (and the Brain)
  ///   It takes less cognitive load to see rounded rectangles than it does to
  ///   see sharp-cornered ones. (See https://designmodo.com/rounded-corners/)
  /// - We’ve Been Trained to Trust Rounded Corners:
  ///   There are actual psychological studies to back this theory.
  ///   This is a classical conditioning principle where our brain is
  ///   conditioned to think sharp objects can be harmful.
  ///   A real-life example where sharp corners are considered harmful
  ///   is when you’re baby-proofing your house by using rounded fittings
  ///   on sharp table corners. (See https://designmodo.com/rounded-corners/)
  /// - It helps to increase the optical space between elements.
  ///   (See https://www.interaction-design.org/literature/article/the-power-of-white-space)
  ///
  /// We prefer a little more than the Material Design default (=4)
  /// But not too round so these shapes are not confused with [Chip]s.

  static const rounding = 16.0;
  static const Radius radius = Radius.circular(rounding);
  static const RoundedRectangleBorder roundedRectangleBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.all(radius));

  static const elevation = 4.0;
}

class CommandButtonStyle extends ButtonStyle {
  /// Constrains the button size since fixedSize, minimumSize and tapTargetSize parameters
  /// did not work as expected
  final BoxConstraints? constraints;

  /// not using fixedSize: use constraints instead
  /// not using minimumSize: use constraints instead
  /// not using tapTargetSize: use constraints instead,
  const CommandButtonStyle({
    this.constraints,
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
  }) : super(
         fixedSize: null,
         //use constraints instead
         minimumSize: null,
         //use constraints instead
         tapTargetSize: null,
       );

  /// [copyWith2] does the same as the [super.copyWith] method, but also copies
  /// the size constraints
  ///
  /// Creates a copy of [CommandButtonStyle] where the current fields
  /// can be replaced with the new values, unless they are null.
  ///
  /// not using fixedSize: use constraints instead
  /// not using minimumSize: use constraints instead
  /// not using tapTargetSize: use constraints instead,
  CommandButtonStyle copyWith2({
    BoxConstraints? constraints,
    WidgetStateProperty<Color?>? foregroundColor,
    AlignmentGeometry? alignment,
    Duration? animationDuration,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<double?>? elevation,
    bool? enableFeedback,
    WidgetStateProperty<MouseCursor?>? mouseCursor,
    WidgetStateProperty<Color?>? overlayColor,
    WidgetStateProperty<EdgeInsetsGeometry?>? padding,
    WidgetStateProperty<Color?>? shadowColor,
    WidgetStateProperty<BorderSide?>? side,
    WidgetStateProperty<OutlinedBorder?>? shape,
    InteractiveInkFeatureFactory? splashFactory,
    WidgetStateProperty<TextStyle?>? textStyle,
    VisualDensity? visualDensity,
  }) => CommandButtonStyle(
    constraints: constraints ?? this.constraints,
    foregroundColor: foregroundColor ?? this.foregroundColor,
    alignment: alignment ?? this.alignment,
    animationDuration: animationDuration ?? this.animationDuration,
    backgroundColor: backgroundColor ?? this.backgroundColor,
    elevation: elevation ?? this.elevation,
    enableFeedback: enableFeedback ?? this.enableFeedback,
    mouseCursor: mouseCursor ?? this.mouseCursor,
    overlayColor: overlayColor ?? this.overlayColor,
    padding: padding ?? this.padding,
    shadowColor: shadowColor ?? this.shadowColor,
    shape: shape ?? this.shape,
    side: side ?? this.side,
    splashFactory: splashFactory ?? this.splashFactory,
    textStyle: textStyle ?? this.textStyle,
    visualDensity: visualDensity ?? this.visualDensity,
  );

  /// Creates a copy of [CommandButtonStyle] with default field values
  /// unless they already had a value.
  CommandButtonStyle withDefaults(BuildContext context) => copyWith2(
    constraints: constraints ?? _defaultConstraints(),
    padding: padding ?? _defaultPadding(),
    shape: shape ?? _defaultShape(),
  );

  BoxConstraints _defaultConstraints() => const BoxConstraints(
    minHeight: CommandStyle.touchTargetHeight,
    maxHeight: CommandStyle.touchTargetHeight,
  );

  WidgetStateProperty<EdgeInsetsGeometry?> _defaultPadding() =>
      WidgetStateProperty.all<EdgeInsetsGeometry?>(
        const EdgeInsets.symmetric(horizontal: CommandStyle.spacing),
      );

  WidgetStateProperty<OutlinedBorder?> _defaultShape() =>
      WidgetStateProperty.all<OutlinedBorder?>(
        CommandStyle.roundedRectangleBorder,
      );
}

/// Used for rendering an empty [SizedBox], e.g. when the [Command] is not visible.
const emptySizeBox = SizedBox.shrink();

/// Inspired by [TextButton.styleFrom()]
class DefaultForegroundColor extends WidgetStateProperty<Color?> {
  DefaultForegroundColor(this.color);

  final Color color;

  @override
  Color? resolve(Set<WidgetState> states) {
    return color;
  }
}

/// Inspired by [TextButton.styleFrom()]
class DefaultOverlayColor extends WidgetStateProperty<Color?> {
  DefaultOverlayColor(this.color);

  final Color color;

  @override
  Color? resolve(Set<WidgetState> states) {
    if (states.contains(WidgetState.hovered)) {
      return color.withValues(alpha: 255 * 0.04);
    }
    if (states.contains(WidgetState.focused) ||
        states.contains(WidgetState.pressed)) {
      return color.withValues(alpha: 255 * 0.12);
    }
    return null;
  }
}
