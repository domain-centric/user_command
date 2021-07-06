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
  ///
  /// TODO: can this be less for less dense application (e.g. with mouse)?
  static const touchTargetHeight = 48.0;

  /// From [Material design][https://material.io/design/layout/spacing-methods.html#touch-targets]:
  /// touch targets should be at least 48 x 48 dp with at least 8dp of space between targets.
  ///
  /// TODO: can this be less for less dense application (e.g. with mouse)?
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

  static final rounding = 16.0;
  static final Radius radius = Radius.circular(rounding);
  static final RoundedRectangleBorder roundedRectangleBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.all(radius));

  static final elevation = 4.0;
}

class CommandButtonStyle extends ButtonStyle {
  /// Constrains the button size since fixedSize, minimumSize and tapTargetSize parameters
  /// did not work as expected
  final BoxConstraints? constraints;

  /// not using fixedSize: use constraints instead
  /// not using minimumSize: use constraints instead
  /// not using tapTargetSize: use constraints instead,
  const CommandButtonStyle(
      {this.constraints,
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
            foregroundColor: foregroundColor,
            alignment: alignment,
            animationDuration: animationDuration,
            backgroundColor: backgroundColor,
            elevation: elevation,
            enableFeedback: enableFeedback,
            //use constraints instead
            fixedSize: null,
            //use constraints instead
            minimumSize: null,
            mouseCursor: mouseCursor,
            overlayColor: overlayColor,
            padding: padding,
            shadowColor: shadowColor,
            shape: shape,
            side: side,
            splashFactory: splashFactory,
            //use constraints instead
            tapTargetSize: null,
            textStyle: textStyle,
            visualDensity: visualDensity);

  /// [copyWith2] does the same as the [super.copyWith] method, but also copies
  /// the size constraints
  ///
  /// Creates a copy of [CommandButtonStyle] where the current fields
  /// can be replaced with the new values, unless they are null.
  ///
  /// not using fixedSize: use constraints instead
  /// not using minimumSize: use constraints instead
  /// not using tapTargetSize: use constraints instead,
  CommandButtonStyle copyWith2(
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
          MaterialStateProperty<BorderSide?>? side,
          MaterialStateProperty<OutlinedBorder?>? shape,
          InteractiveInkFeatureFactory? splashFactory,
          MaterialStateProperty<TextStyle?>? textStyle,
          VisualDensity? visualDensity}) =>
      CommandButtonStyle(
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
          visualDensity: visualDensity ?? this.visualDensity);

  /// Creates a copy of [CommandButtonStyle] with default field values
  /// unless they already had a value.
  CommandButtonStyle withDefaults(BuildContext context) => copyWith2(
        constraints: constraints ?? _defaultConstraints(),
        padding: padding ?? _defaultPadding(),
        shape: shape ?? _defaultShape(),
      );

  BoxConstraints _defaultConstraints() => const BoxConstraints(
      minHeight: CommandStyle.touchTargetHeight,
      maxHeight: CommandStyle.touchTargetHeight);

  MaterialStateProperty<EdgeInsetsGeometry?> _defaultPadding() =>
      MaterialStateProperty.all<EdgeInsetsGeometry?>(
          EdgeInsets.symmetric(horizontal: CommandStyle.spacing));

  MaterialStateProperty<OutlinedBorder?> _defaultShape() =>
      MaterialStateProperty.all<OutlinedBorder?>(
          CommandStyle.roundedRectangleBorder);
}

/// Used for rendering an empty [SizedBox], e.g. when the [Command] is not visible.
const emptySizeBox = SizedBox.shrink();