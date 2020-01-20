import 'dart:async';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_shadows_clock/date_bar.dart';
import 'package:long_shadows_clock/long_shadow_text.dart';

const _kAnimationDuration = Duration(milliseconds: 1000);

class LongShadowsClock extends StatefulWidget {
  const LongShadowsClock(this.model);

  final ClockModel model;

  @override
  _LongShadowsClockState createState() => _LongShadowsClockState();
}

class _LongShadowsClockState extends State<LongShadowsClock>
    with TickerProviderStateMixin {
  DateTime _dateTime = DateTime.now();
  Timer _timer;
  AnimationController _hourController;
  AnimationController _minuteController;
  AnimationController _secondController;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();

    _hourController = AnimationController(
      vsync: this,
      duration: _kAnimationDuration,
    );

    _minuteController = AnimationController(
      vsync: this,
      duration: _kAnimationDuration,
    );

    _secondController = AnimationController(
      vsync: this,
      duration: _kAnimationDuration,
    );
  }

  @override
  void didUpdateWidget(LongShadowsClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    _hourController?.dispose();
    _minuteController?.dispose();
    _secondController?.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {});
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        const Duration(seconds: 1) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final hourFormat = widget.model.is24HourFormat ? 'HH' : 'hh';

    return GestureDetector(
      onTap: () => _secondController.forward(),
      child: ClipRect(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              DateBar(date: _dateTime),
              Positioned.fill(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    LongShadowText.big(
                      DateFormat(hourFormat).format(_dateTime),
                      animation: _hourController,
                    ),
                    LongShadowText.medium(
                      _dateTime.minute,
                      animation: _minuteController,
                    ),
                    LongShadowText.small(
                      _dateTime.second,
                      animation: _secondController,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
