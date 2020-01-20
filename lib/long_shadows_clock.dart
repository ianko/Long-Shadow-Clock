import 'dart:async';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_shadows_clock/clock_digits.dart';
import 'package:long_shadows_clock/date_bar.dart';

const _kFwdDuration = Duration(milliseconds: 350);
const _kRwdDuration = Duration(milliseconds: 450);

class LongShadowsClock extends StatefulWidget {
  const LongShadowsClock(this.model);

  final ClockModel model;

  @override
  _LongShadowsClockState createState() => _LongShadowsClockState();
}

class _LongShadowsClockState extends State<LongShadowsClock>
    with TickerProviderStateMixin {
  AnimationController _hourController;
  AnimationController _minuteController;
  AnimationController _secondController;
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();

    _hourController = AnimationController(
      vsync: this,
      duration: _kFwdDuration,
      reverseDuration: _kRwdDuration,
    );

    _minuteController = AnimationController(
      vsync: this,
      duration: _kFwdDuration,
      reverseDuration: _kRwdDuration,
    );

    _secondController = AnimationController(
      vsync: this,
      duration: _kFwdDuration,
      reverseDuration: _kRwdDuration,
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
    widget.model.dispose();
    _hourController?.dispose();
    _minuteController?.dispose();
    _secondController?.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {});
  }

  Future<void> _updateTime() async {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        const Duration(seconds: 1) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });

    if (_dateTime.second % 10 == 0) {
      _secondController.forward();
    }

    if (_dateTime.second == 0) {
      _minuteController.forward();
    }

    if (_dateTime.minute == 0 && _dateTime.second == 0) {
      _hourController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hourFormat = widget.model.is24HourFormat ? 'HH' : 'hh';

    return ClipRect(
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
                  ClockDigits.big(DateFormat(hourFormat).format(_dateTime),
                      animation: _hourController),
                  ClockDigits.medium(_dateTime.minute,
                      animation: _minuteController),
                  ClockDigits.small(_dateTime.second,
                      animation: _secondController),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
