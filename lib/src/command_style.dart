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
  ///From [Material design][https://material.io/design/layout/spacing-methods.html#touch-targets]:
  ///Touch targets apply to any device that receives both touch and non-touch input.
  ///To balance information density and usability,
  ///touch targets should be at least 48 x 48 dp with at least 8dp of space between targets.
  ///
  /// TODO: can this be less for less dense application (e.g. with mouse)?
  static const touchTargetHeight = 48.0;

  ///From [Material design][https://material.io/design/layout/spacing-methods.html#touch-targets]:
  ///touch targets should be at least 48 x 48 dp with at least 8dp of space between targets.
  ///
  /// TODO: can this be less for less dense application (e.g. with mouse)?
  static const spacing = 20.0;

  ///Rounded shapes are important:
  ///- Rounded corners look visually appealing. TODO ADD REFERENCE
  ///  There are actual psychological studies to back this theory.
  ///  This is a classical conditioning principle where our brain is
  ///  conditioned to think sharp objects can be harmful.
  ///  A real-life example where sharp corners are considered harmful
  ///  is when you’re baby-proofing your house by using rounded fittings
  ///  on sharp table corners.
  ///- It helps to increase the optical space between buttons. More space is better TODO ADD REFERENCE
  ///- It seems to be the latest trend. TODO ADD REFERENCE
  ///- TODO check if true and add refrerence: rounded shapes are faster to process by the brain?
  ///
  /// TODO: not too round so these shapes are not confused with [Chip]s
  /// But we prefer a little more than the Material Design default (4?)

  static final rounding = 16.0;
  static final Radius radius = Radius.circular(rounding);
  static final RoundedRectangleBorder roundedRectangleBorder =
      RoundedRectangleBorder(borderRadius: BorderRadius.all(radius));
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

  /// Creates a [CommandButtonStyle] with given values, but overridden with
  /// default values where needed if the original values are null.
  /// These default values should come from the current theme.
  ///
  /// not using fixedSize: use constraints instead
  /// not using minimumSize: use constraints instead
  /// not using tapTargetSize: use constraints instead,
  CommandButtonStyle overrideDefaultValues(
      {MaterialStateProperty<Color?>? defaultForegroundColor,
      AlignmentGeometry? defaultAlignment,
      Duration? defaultAnimationDuration,
      MaterialStateProperty<Color?>? defaultBackgroundColor,
      MaterialStateProperty<double?>? defaultElevation,
      bool? defaultEnableFeedback,
      MaterialStateProperty<MouseCursor?>? defaultMouseCursor,
      MaterialStateProperty<Color?>? defaultOverlayColor,
      MaterialStateProperty<Color?>? defaultShadowColor,
      MaterialStateProperty<BorderSide?>? defaultSide,
      InteractiveInkFeatureFactory? defaultSplashFactory,
      MaterialStateProperty<TextStyle?>? defaultTextStyle,
      VisualDensity? defaultVisualDensity}) {
    return CommandButtonStyle(
        constraints: constraints ?? defaultConstraints(),
        foregroundColor: foregroundColor ?? defaultForegroundColor,
        alignment: alignment ?? defaultAlignment,
        animationDuration: animationDuration ?? defaultAnimationDuration,
        backgroundColor: backgroundColor ?? defaultBackgroundColor,
        elevation: elevation ?? defaultElevation,
        enableFeedback: enableFeedback ?? defaultEnableFeedback,
        mouseCursor: mouseCursor ?? defaultMouseCursor,
        overlayColor: overlayColor ?? defaultOverlayColor,
        padding: padding ?? defaultPadding(),
        shadowColor: shadowColor ?? defaultShadowColor,
        shape: shape ?? defaultShape(),
        side: side ?? defaultSide,
        splashFactory: splashFactory ?? defaultSplashFactory,
        textStyle: textStyle ?? defaultTextStyle,
        visualDensity: visualDensity ?? defaultVisualDensity);
  }

  BoxConstraints defaultConstraints() => BoxConstraints(
        minHeight: CommandStyle.touchTargetHeight,
      );

  MaterialStateProperty<EdgeInsetsGeometry?> defaultPadding() =>
      MaterialStateProperty.all<EdgeInsetsGeometry?>(EdgeInsets.fromLTRB(
          CommandStyle.spacing, 0, CommandStyle.spacing, 0));

  MaterialStateProperty<OutlinedBorder?> defaultShape() =>
      MaterialStateProperty.all<OutlinedBorder?>(
          CommandStyle.roundedRectangleBorder);
}