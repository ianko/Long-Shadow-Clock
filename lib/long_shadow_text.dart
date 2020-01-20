import 'package:flutter/material.dart';
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
  List<Shadow> _shadows;

  @override
  void initState() {
    super.initState();
    _generateShadows();
  }

  @override
  void didUpdateWidget(LongShadowText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.hasIdenticalShadow(oldWidget)) {
      _generateShadows();
    }
  }

  void _generateShadows() {
    final direction = radians(widget.angle);

    _shadows = List.generate((widget.size * widget.density).floor(), (i) {
      final step = i.toDouble() / widget.density;

      return Shadow(
        offset: Offset.fromDirection(direction, widget.density) * step,
        color: Color.lerp(
          widget.colorStart,
          widget.colorEnd,
          step / widget.size,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: widget.style.copyWith(shadows: _shadows),
    );
  }
}
