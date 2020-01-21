import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:long_shadows_clock/config.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

/// It's basically a `Text` that will build a long shadow and animate
/// a rainbow shadow on command.
class LongShadowText extends StatefulWidget {
  const LongShadowText(
    this.text, {
    Key key,
    @required this.style,
    @required this.colorStart,
    @required this.colorEnd,
    this.density = 1.0,
    this.angle = 135.0,
    this.animation,
  }) : super(key: key);

  /// The main text to show.
  final String text;

  /// The text style.
  ///
  /// If no `shadows` is present, this widget will not build a long shadow.
  final TextStyle style;

  /// In a gradient long shadow, the start color is the one closest to the text.
  final Color colorStart;

  /// In a gradient long shadow, the start color is the one farthest to the text.
  ///
  /// If you don't want a gradient shadow, just set the same as the `colorStart`.
  final Color colorEnd;

  /// Optional controller to trigger the rainbow animation.
  final AnimationController animation;

  /// How dense do you want the shadow to be?
  /// Higher density will be smoother (less aliasing), but slower to render.
  final double density;

  /// The angle is in degrees clockwise from the positive x-axis.
  final double angle;

  @override
  _LongShadowTextState createState() => _LongShadowTextState();

  bool _hasIdenticalShadowAs(LongShadowText other) {
    return style == other.style &&
        density == other.density &&
        colorStart == other.colorStart &&
        colorEnd == other.colorEnd;
  }
}

class _LongShadowTextState extends State<LongShadowText> {
  Animation _animation;
  List<Shadow> _regularShadow;
  List<Color> _rainbowColors;
  bool get hasAnimation => widget.animation != null;

  @override
  void initState() {
    super.initState();
    _regularShadow = _buildRegularShadow();

    if (hasAnimation) {
      widget.animation.addStatusListener(_onAnimationStatusChanged);
      _animation = CurvedAnimation(
        parent: widget.animation,
        curve: Curves.decelerate,
        reverseCurve: Curves.easeOutQuint,
      );
    }
  }

  @override
  void didUpdateWidget(LongShadowText oldWidget) {
    super.didUpdateWidget(oldWidget);

    _rainbowColors = Theme.of(context).brightness == Brightness.light
        ? kRainbowColorsLight
        : kRainbowColorsDark;

    if (!widget._hasIdenticalShadowAs(oldWidget)) {
      _regularShadow = _buildRegularShadow();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.animation?.removeStatusListener(_onAnimationStatusChanged);
  }

  void _onAnimationStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      widget.animation.reverse();
    }
  }

  List<Shadow> _buildRegularShadow() {
    if (widget.style.shadows == null || widget.style.shadows.isEmpty) {
      return null;
    }

    final shadowCount = (widget.style.shadows.length * widget.density).floor();
    final direction = Offset.fromDirection(radians(widget.angle));

    return List.generate(shadowCount, (i) {
      final step = i / widget.density;

      return Shadow(
        offset: direction * step,
        color: Color.lerp(
          widget.colorStart,
          widget.colorEnd,
          step / widget.style.shadows.length,
        ),
      );
    });
  }

  List<Shadow> _buildShadows() {
    if (!hasAnimation || !widget.animation.isAnimating) {
      return _regularShadow;
    }

    if (widget.style.shadows == null || widget.style.shadows.isEmpty) {
      return null;
    }

    final shadowCount = (widget.style.shadows.length * widget.density).floor();
    final colorsBlock = shadowCount / _rainbowColors.length;
    final direction = Offset.fromDirection(radians(widget.angle));
    final startIndex = shadowCount * _animation.value;
    var nextColorIndex = 0;

    return List.generate(shadowCount, (i) {
      final step = (i + startIndex) / widget.density;

      if (i % colorsBlock == 0) {
        nextColorIndex++;
      }

      if (nextColorIndex >= _rainbowColors.length) {
        nextColorIndex = 0;
      }

      return Shadow(
        offset: direction * step,
        color: _rainbowColors[nextColorIndex],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation ?? kAlwaysDismissedAnimation,
      builder: (context, child) {
        return Text(
          widget.text,
          style: widget.style.copyWith(shadows: _buildShadows()),
        );
      },
    );
  }
}
