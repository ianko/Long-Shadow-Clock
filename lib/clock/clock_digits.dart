import 'package:flutter/material.dart';
import 'package:long_shadows_clock/clock/long_shadow_text.dart';

/// The digits text. This will help with configuring the [LongShadowText]
/// according with the different text sizes.
class ClockDigits extends StatelessWidget {
  const ClockDigits.big(
    this.digits, {
    Key key,
    @required this.style,
    this.animation,
  })  : assert(digits is String || digits is int),
        _shadowDensity = 1.0,
        _padding = 55.0,
        super(key: key);

  const ClockDigits.medium(
    this.digits, {
    Key key,
    @required this.style,
    this.animation,
  })  : assert(digits is String || digits is int),
        _shadowDensity = 1.5,
        _padding = 65.0,
        super(key: key);

  const ClockDigits.small(
    this.digits, {
    Key key,
    @required this.style,
    this.animation,
  })  : assert(digits is String || digits is int),
        _shadowDensity = 2.0,
        _padding = 80.0,
        super(key: key);

  /// An integer or String reprensting the digits of the clock.
  final Object digits;

  /// Required style for this clock digits.
  final TextStyle style;

  /// Optional controller to trigger the rainbow animation.
  final AnimationController animation;

  /// Distance of the digits to the border of screen.
  final double _padding;

  /// Depending on `fontSize`, of `fontFanily`, we may need to create a denser shadow.
  final double _shadowDensity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(left: _padding),
      child: LongShadowText(
        digits.toString().padLeft(2, '0'),
        animation: animation,
        density: _shadowDensity,
        colorStart: theme.primaryColorLight,
        colorEnd: theme.primaryColorDark,
        style: style,
      ),
    );
  }
}
