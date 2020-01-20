import 'dart:async';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_shadows_clock/clock_digits.dart';
import 'package:long_shadows_clock/date_bar.dart';

class LongShadowsClock extends StatefulWidget {
  const LongShadowsClock(this.model);

  final ClockModel model;

  @override
  _LongShadowsClockState createState() => _LongShadowsClockState();
}

class _LongShadowsClockState extends State<LongShadowsClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
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
                  ClockDigits.big(DateFormat(hourFormat).format(_dateTime)),
                  ClockDigits.medium(_dateTime.minute),
                  ClockDigits.small(_dateTime.second),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
