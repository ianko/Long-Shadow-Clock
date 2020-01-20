import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

const _kColorCycle = <Color>[
  Color(0xFF4285F4),
  Color(0xFFDB4437),
  Color(0xFFF4B400),
  Color(0xFF0F9D58),
];

class LongShadowText extends StatefulWidget {
  const LongShadowText(
    this.text, {
    @required this.style,
    this.size = 100,
    this.density = 1.0,
    @required this.colorStart,
    @required this.colorEnd,
    this.angle = 135.0,
    @required this.animation,
  });

  final String text;
  final TextStyle style;
  final int size;
  final double density;
  final Color colorStart;
  final Color colorEnd;
  final AnimationController animation;

  /// The angle is in degrees clockwise from the positive x-axis.
  final double angle;

  @override
  _LongShadowTextState createState() => _LongShadowTextState();

  bool hasIdenticalShadowAs(LongShadowText other) {
    return style == other.style &&
        size == other.size &&
        density == other.density &&
        colorStart == other.colorStart &&
        colorEnd == other.colorEnd;
  }
}

class _LongShadowTextState extends State<LongShadowText> {
  Animation _animation;
  List<Shadow> _regularShadow;

  @override
  void initState() {
    super.initState();
    _regularShadow = _buildRegularShadow();
    widget.animation.addStatusListener(_onAnimationStatusChanged);

    _animation = CurvedAnimation(
      parent: widget.animation,
      curve: Curves.decelerate,
      reverseCurve: Curves.easeOutQuint,
    );
  }

  @override
  void didUpdateWidget(LongShadowText oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.hasIdenticalShadowAs(oldWidget)) {
      _regularShadow = _buildRegularShadow();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.animation.removeStatusListener(_onAnimationStatusChanged);
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.completed:
        widget.animation.reverse();
        break;
      default:
    }
  }

  List<Shadow> _buildRegularShadow() {
    final shadowCount = (widget.size * widget.density).floor();
    final direction = Offset.fromDirection(radians(widget.angle));

    return List.generate(shadowCount, (i) {
      final step = i / widget.density;

      return Shadow(
        offset: direction * step,
        color: Color.lerp(
          widget.colorStart,
          widget.colorEnd,
          step / widget.size,
        ),
      );
    });
  }

  List<Shadow> _buildShadows() {
    if (!widget.animation.isAnimating) {
      return _regularShadow;
    }

    final shadowCount = (widget.size * widget.density).floor();
    final colorsBlock = shadowCount / _kColorCycle.length;
    final direction = Offset.fromDirection(radians(widget.angle));
    final startIndex = shadowCount * _animation.value;
    var nextColorIndex = 0;

    return List.generate(shadowCount, (i) {
      final step = (i + startIndex) / widget.density;

      if (i % colorsBlock == 0) {
        nextColorIndex++;
      }

      if (nextColorIndex >= _kColorCycle.length) {
        nextColorIndex = 0;
      }

      return Shadow(
        offset: direction * step,
        color: _kColorCycle[nextColorIndex],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          widget.text,
          style: widget.style.copyWith(shadows: _buildShadows()),
        );
      },
    );
  }
}
