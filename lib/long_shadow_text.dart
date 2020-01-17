import 'dart:ui';
import 'package:flutter/material.dart';

const _kColors = <Color>[
  Color(0xFF4285F4),
  Color(0xFFDB4437),
  Color(0xFFF4B400),
  Color(0xFF0F9D58),
];

class LongShadowText extends StatelessWidget {
  const LongShadowText.big(
    this.text, {
    Key key,
    FontStyle style,
    this.color,
    this.shadowBeginColor,
    this.shadowEndColor,
  })  : style = style ?? const TextStyle(fontSize: 150.0),
        _shadowSize = 300,
        _padding = 40.0,
        _offset = const Offset(-1.4, 1.6),
        super(key: key);

  const LongShadowText.medium(
    this.text, {
    Key key,
    FontStyle style,
    this.color,
    this.shadowBeginColor,
    this.shadowEndColor,
  })  : style = style ?? const TextStyle(fontSize: 100.0, height: 0.8),
        _shadowSize = 400,
        _padding = 55.0,
        _offset = const Offset(-1.2, 1.2),
        super(key: key);

  const LongShadowText.small(
    this.text, {
    Key key,
    FontStyle style,
    this.color,
    this.shadowBeginColor,
    this.shadowEndColor,
  })  : style = style ?? const TextStyle(fontSize: 65.0),
        _shadowSize = 500,
        _padding = 65.0,
        _offset = const Offset(-1.2, 1.2),
        super(key: key);

  final Object text;
  final TextStyle style;
  final Color color;
  final Color shadowBeginColor;
  final Color shadowEndColor;
  final int _shadowSize;
  final double _padding;
  final Offset _offset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shadows = <Shadow>[];
    final blocks = (_shadowSize / _kColors.length).floor();

    for (var i = _shadowSize - 1; i >= 0; i--) {
      final index = (i / blocks).floor();

      shadows.add(Shadow(
        offset: _offset * (i / 5),
        color: _kColors[index],
      ));
    }

    return Container(
      padding: EdgeInsets.only(left: _padding),
      child: Text(
        text.toString().padLeft(2, '0'),
        style: style.copyWith(
          color: color ?? theme.primaryColor,
          fontFamily: 'BungeeShade',
          fontFeatures: const [FontFeature.tabularFigures()],
          // shadows: shadows,
          shadows: [
            for (var i = _shadowSize; i >= 0; i--)
              Shadow(
                offset: _offset * (i / 5),
                color: Color.lerp(
                  shadowBeginColor ?? theme.primaryColorLight,
                  shadowEndColor ?? theme.primaryColorDark,
                  i / _shadowSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
