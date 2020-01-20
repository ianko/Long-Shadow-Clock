import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

class LongShadowText extends StatefulWidget {
  const LongShadowText(
    this.text, {
    @required this.style,
    this.size = 100,
    this.density = 1.0,
    @required this.colorStart,
    @required this.colorEnd,
    this.angle = 135.0,
  });

  final String text;
  final TextStyle style;
  final int size;
  final double density;
  final Color colorStart;
  final Color colorEnd;

  /// The angle is in degrees clockwise from the positive x-axis.
  final double angle;

  @override
  _LongShadowTextState createState() => _LongShadowTextState();

  bool hasIdenticalShadow(LongShadowText other) {
    return style == other.style &&
        size == other.size &&
        density == other.density &&
        colorStart == other.colorStart &&
        colorEnd == other.colorEnd;
  }
}

class _LongShadowTextState extends State<LongShadowText> {
  final tween = MultiTrackTween([
    Track<Color>('start').add(
      const Duration(seconds: 30),
      ColorTween(
        begin: Colors.red,
        end: Colors.black,
      ),
    ),
    Track<Color>('end').add(
      const Duration(seconds: 30),
      ColorTween(
        begin: Colors.black,
        end: Colors.yellow,
      ),
    )
  ]);

  List<Shadow> _generateShadows(Color start, Color end) {
    final direction = radians(widget.angle);

    return List.generate((widget.size * widget.density).floor(), (i) {
      final step = i.toDouble() / widget.density;

      return Shadow(
        offset: Offset.fromDirection(direction) * step,
        color: Color.lerp(start, end, step / widget.size),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, dynamic animation) {
        return Text(
          widget.text,
          style: widget.style.copyWith(
              shadows: _generateShadows(animation['start'], animation['end'])),
        );
      },
    );
  }
}
