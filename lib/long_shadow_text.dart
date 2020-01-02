import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _kOffsetDirection = Offset(1.2, 1.2);

class LongShadowText extends StatelessWidget {
  LongShadowText.big(
    this.text, {
    Key key,
    FontStyle style,
    this.color = Colors.white,
    this.shadowBeginColor = Colors.red,
    this.shadowEndColor = Colors.black,
  })  : style = style ??
            GoogleFonts.oswald(fontSize: 150.0, fontWeight: FontWeight.w700),
        _shadowSize = 80,
        _rightPadding = 40.0,
        super(key: key);

  LongShadowText.medium(
    this.text, {
    Key key,
    FontStyle style,
    this.color = Colors.white,
    this.shadowBeginColor = Colors.red,
    this.shadowEndColor = Colors.black,
  })  : style = style ??
            GoogleFonts.oswald(fontSize: 80.0, fontWeight: FontWeight.w400),
        _shadowSize = 80,
        _rightPadding = 55.0,
        super(key: key);

  LongShadowText.small(
    this.text, {
    Key key,
    FontStyle style,
    this.color = Colors.white,
    this.shadowBeginColor = Colors.red,
    this.shadowEndColor = Colors.black,
  })  : style = style ??
            GoogleFonts.oswald(fontSize: 40.0, fontWeight: FontWeight.w400),
        _shadowSize = 80,
        _rightPadding = 60.0,
        super(key: key);

  final Object text;
  final TextStyle style;
  final Color color;
  final Color shadowBeginColor;
  final Color shadowEndColor;
  final int _shadowSize;
  final double _rightPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: _rightPadding),
      child: Text(
        text.toString().padLeft(2, '0'),
        style: style.copyWith(
          height: 0.96,
          color: color,
          shadows: [
            for (var i = _shadowSize; i >= 0; i--)
              Shadow(
                offset: _kOffsetDirection * i.toDouble(),
                color: Color.lerp(
                  shadowBeginColor,
                  shadowEndColor,
                  i.toDouble() / _shadowSize,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
