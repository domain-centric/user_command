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
  static final minTouchTargetHeight = 48.0;

  ///From [Material design][https://material.io/design/layout/spacing-methods.html#touch-targets]:
  ///touch targets should be at least 48 x 48 dp with at least 8dp of space between targets.
  ///
  /// TODO: can this be less for less dense application (e.g. with mouse)?
  static final spacing = 20.0;

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

  // TODO move to ButtonStyle
  // static ThemeData _genericTheme(
  //         {required MaterialColor primarySwatch,
  //         required Brightness brightness}) =>
  //     ThemeData(
  //         primarySwatch: primarySwatch,
  //         brightness: brightness,
  //         visualDensity: VisualDensity.adaptivePlatformDensity,
  //         textButtonTheme: TextButtonThemeData(
  //             style: TextButton.styleFrom(
  //               ///Adding padding because these buttons are too small by default
  //               ///From [Material design][https://material.io/design/layout/spacing-methods.html#touch-targets]:
  //               ///Touch targets apply to any device that receives both touch and non-touch input.
  //               ///To balance information density and usability,
  //               ///touch targets should be at least 48 x 48 dp with at least 8dp of space between targets.
  //                 padding: EdgeInsets.all(spacing),
  //                 /// We use a bigger radius. See [rounding]
  //                 shape: roundedRectangleBorder)));


}
