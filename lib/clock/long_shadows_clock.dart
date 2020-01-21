import 'dart:async';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_shadows_clock/clock/clock_digits.dart';
import 'package:long_shadows_clock/clock/date_bar.dart';
import 'package:long_shadows_clock/config.dart';

/// Main Screen of the app.
class LongShadowsClock extends StatefulWidget {
  const LongShadowsClock(this.model);

  /// This is the model that contains the customization options for the clock.
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
      duration: kFwdAnimDuration,
      reverseDuration: kRwdAnimDuration,
    );

    _minuteController = AnimationController(
      vsync: this,
      duration: kFwdAnimDuration,
      reverseDuration: kRwdAnimDuration,
    );

    _secondController = AnimationController(
      vsync: this,
      duration: kFwdAnimDuration,
      reverseDuration: kRwdAnimDuration,
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

  void _updateModel() => setState(() {});

  Future<void> _updateTime() async {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        const Duration(seconds: 1) -
            Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });

    // animate the seconds digits on multiples of 10 seconds.
    if (_dateTime.second % 10 == 0) {
      _secondController.forward();
    }

    // animate the minutes digits every new minute.
    if (_dateTime.second == 0) {
      _minuteController.forward();
    }

    // animate the hours digits every new hour.
    if (_dateTime.minute == 0 && _dateTime.second == 0) {
      _hourController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hourFormat = widget.model.is24HourFormat ? 'HH' : 'hh';

    // clip the shadows to prevent an overflow
    return ClipRect(
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            // DATE
            DateBar(date: _dateTime),

            Positioned.fill(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // HOUR
                  ClockDigits.big(
                    DateFormat(hourFormat).format(_dateTime),
                    style: theme.textTheme.display1,
                    animation: _hourController,
                  ),

                  // MINUTE
                  ClockDigits.medium(
                    _dateTime.minute,
                    style: theme.textTheme.display2,
                    animation: _minuteController,
                  ),

                  // SECOND
                  ClockDigits.small(
                    _dateTime.second,
                    style: theme.textTheme.display3,
                    animation: _secondController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
