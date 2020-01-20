import 'dart:ui';
import 'package:flutter/material.dart';

const _kColorCycle = <Color>[
  Color(0xFF4285F4),
  Color(0xFFDB4437),
  Color(0xFFF4B400),
  Color(0xFF0F9D58),
];

class LongShadowText extends StatefulWidget {
  const LongShadowText.big(
    this.text, {
    Key key,
    FontStyle style,
    this.color,
    this.shadowBeginColor,
    this.shadowEndColor,
    @required this.animation,
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
    @required this.animation,
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
    @required this.animation,
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
  final AnimationController animation;
  final int _shadowSize;
  final double _padding;
  final Offset _offset;

  @override
  _LongShadowTextState createState() => _LongShadowTextState();
}

class _LongShadowTextState extends State<LongShadowText> {
  List<Shadow> _regularShadows;
  List<Shadow> _rainbowShadows;

  @override
  void initState() {
    super.initState();

    widget.animation.addStatusListener(_onAnimationStatusChanged);
    // _animation = StepTween(begin: 0, end: _kColorCycle.length - 1)
    //     .chain(CurveTween(curve: Curves.fastLinearToSlowEaseIn))
    //     .animate(widget.animation);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final theme = Theme.of(context);

    _regularShadows ??= List.generate(widget._shadowSize, (i) {
      return Shadow(
        offset: widget._offset * (i / 5),
        color: Color.lerp(
          widget.shadowBeginColor ?? theme.primaryColorLight,
          widget.shadowEndColor ?? theme.primaryColorDark,
          i / widget._shadowSize,
        ),
      );
    }).reversed.toList();

    _rainbowShadows = List.from(_regularShadows);
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
        widget.animation.reset();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.only(left: widget._padding),
          child: Text(
            widget.text.toString().padLeft(2, '0'),
            style: widget.style.copyWith(
              color: widget.color ?? Theme.of(context).primaryColor,
              fontFamily: 'BungeeShade',
              fontFeatures: const [FontFeature.tabularFigures()],
              shadows: _buildShadows(),
            ),
          ),
        );
      },
    );
  }

  List<Shadow> _buildShadows() {
    if (!widget.animation.isAnimating) {
      return _regularShadows;
    }

    // for (var i = _rainbowShadows.length - 1; i >= 0; i--) {
    //   final walk =
    //       lerpDouble(0, _rainbowShadows.length, widget.animation.value).toInt();
    //   final colorCycleIndex = (i / 100).floor() % 4;
    //   final nextColor = _kColorCycle[colorCycleIndex];
    //   final shifted = (i - walk + (widget.animation.value * 100))
    //       .clamp(0, _rainbowShadows.length - 1)
    //       .ceil();

    //   _rainbowShadows[shifted] = Shadow(
    //     offset: _regularShadows[shifted].offset,
    //     color: nextColor,
    //   );
    // }

    var nextColorIndex = 0;
    int lastColorIndex;

    for (var i = 0; i < _rainbowShadows.length; i++) {
      final walk =
          lerpDouble(0, _rainbowShadows.length, widget.animation.value).toInt();
      if ((i / 40) % 3 == 0) {
        nextColorIndex++;
      }

      if (nextColorIndex >= _kColorCycle.length) {
        nextColorIndex = 0;
      }

      final shifted = (i + (widget.animation.value * 100) - walk)
          .clamp(0, _rainbowShadows.length - 1)
          .ceil();

      if (lastColorIndex == null || lastColorIndex != nextColorIndex) {
        lastColorIndex = nextColorIndex;
        print('[[ $shifted ]] $lastColorIndex');
      }

      _rainbowShadows[shifted] = Shadow(
        offset: _regularShadows[shifted].offset,
        color: _kColorCycle[nextColorIndex],
      );
    }

    return _rainbowShadows.toList();

    // final colorsBlockSize = widget._shadowSize / _kColorCycle.length;

    // var i = 0;
    // return _regularShadows.map((shadow) {
    //   final colorIndex = (i++ / colorsBlockSize).floor();

    //   return Shadow(
    //     offset: shadow.offset,
    //     color: _kColorCycle[colorIndex],
    //   );
    // }).toList();
  }
}
