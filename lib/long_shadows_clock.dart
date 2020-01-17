import 'dart:async';
import 'dart:ui';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_shadows_clock/long_shadow_text.dart';
import 'package:long_shadows_clock/photos_bucket.dart';

class LongShadowsClock extends StatefulWidget {
  const LongShadowsClock(this.model);

  final ClockModel model;

  @override
  _LongShadowsClockState createState() => _LongShadowsClockState();
}

class _LongShadowsClockState extends State<LongShadowsClock> {
  String _currentPhoto;
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentPhoto = PhotosBucket.instance.next();
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

      if (_dateTime.second == 0) {
        _currentPhoto = PhotosBucket.instance.next();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final hour =
        DateFormat(widget.model.is24HourFormat ? 'HH' : 'hh').format(_dateTime);

    return ClipRect(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(_currentPhoto),
          ),
        ),
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
                  LongShadowText.big(hour),
                  LongShadowText.medium(_dateTime.minute),
                  LongShadowText.small(_dateTime.second),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateBar extends StatelessWidget {
  const DateBar({Key key, this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final weekDay = DateFormat('EEEE').format(date);
    final dayOrdinal = _getOrdinalDates(date.day);
    final month = DateFormat('MMMM ').format(date);
    final year = DateFormat('y').format(date);

    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w100,
        letterSpacing: 2.5,
        color: Colors.white,
      ),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 2.5),
            decoration: BoxDecoration(
              color: Colors.white12,
              backgroundBlendMode: BlendMode.screen,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                Text(
                  weekDay.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text('$month $dayOrdinal, $year'.toUpperCase()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String _getOrdinalDates(int day) {
  final ordinals = ['th', 'st', 'nd', 'rd'];
  var suffix = ordinals[0];
  final digit = day % 10;
  if ((digit > 0 && digit < 4) && (day < 11 || day > 13)) {
    suffix = ordinals[digit];
  }
  return '$day$suffix';
}
