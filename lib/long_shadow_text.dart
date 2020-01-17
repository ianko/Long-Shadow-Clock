import 'dart:ui';

import 'package:flutter/material.dart';

const _kOffsetDirection = Offset(-1.15, 1.15);

class LongShadowText extends StatelessWidget {
  const LongShadowText.big(
    this.text, {
    Key key,
    FontStyle style,
    this.color = Colors.white,
    this.shadowBeginColor = Colors.red,
    this.shadowEndColor = Colors.black,
  })  : style = style ?? const TextStyle(fontSize: 150.0),
        _shadowSize = 500,
        _padding = 40.0,
        super(key: key);

  const LongShadowText.medium(
    this.text, {
    Key key,
    FontStyle style,
    this.color = Colors.white,
    this.shadowBeginColor = Colors.red,
    this.shadowEndColor = Colors.black,
  })  : style = style ?? const TextStyle(fontSize: 100.0, height: 0.8),
        _shadowSize = 500,
        _padding = 55.0,
        super(key: key);

  const LongShadowText.small(
    this.text, {
    Key key,
    FontStyle style,
    this.color = Colors.white,
    this.shadowBeginColor = Colors.red,
    this.shadowEndColor = Colors.black,
  })  : style = style ?? const TextStyle(fontSize: 60.0),
        _shadowSize = 500,
        _padding = 60.0,
        super(key: key);

  final Object text;
  final TextStyle style;
  final Color color;
  final Color shadowBeginColor;
  final Color shadowEndColor;
  final int _shadowSize;
  final double _padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: _padding),
      child: Text(
        text.toString().padLeft(2, '0'),
        style: style.copyWith(
          color: color,
          fontFamily: 'BungeeShade',
          shadows: [
            for (var i = _shadowSize; i >= 0; i--)
              Shadow(
                offset: _kOffsetDirection * (i / 5),
                color: Color.lerp(
                  shadowBeginColor,
                  shadowEndColor,
                  i / _shadowSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
