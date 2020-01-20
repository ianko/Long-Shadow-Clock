import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:long_shadows_clock/long_shadow_text.dart';

class ClockDigits extends StatelessWidget {
  const ClockDigits.big(this.digits, {Key key})
      : _fontSize = 150.0,
        _shadowSize = 300,
        _padding = 40.0,
        super(key: key);

  const ClockDigits.medium(this.digits, {Key key})
      : _fontSize = 100.0,
        _shadowSize = 250,
        _padding = 55.0,
        super(key: key);

  const ClockDigits.small(this.digits, {Key key})
      : _fontSize = 65.0,
        _shadowSize = 200,
        _padding = 65.0,
        super(key: key);

  final Object digits;
  final double _fontSize;
  final double _padding;
  final int _shadowSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(left: _padding),
      child: LongShadowText(
        digits.toString().padLeft(2, '0'),
        size: _shadowSize,
        density: 2.0,
        colorStart: theme.primaryColorLight,
        colorEnd: theme.primaryColorDark,
        style: TextStyle(
          color: theme.primaryColor,
          fontFamily: 'BungeeShade',
          fontSize: _fontSize,
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}
