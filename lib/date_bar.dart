import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const _alternateStyle = <TextStyle>[
  TextStyle(fontWeight: FontWeight.w900),
  TextStyle(fontWeight: FontWeight.w400),
];

class DateBar extends StatelessWidget {
  const DateBar({Key key, this.date}) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weekDay = DateFormat('EEEE').format(date).toUpperCase();
    final dayOrdinal = _getOrdinalDates(date.day).toUpperCase();
    final month = DateFormat('MMMM').format(date).toUpperCase();
    final year = DateFormat('y').format(date);

    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w100,
        letterSpacing: 2.5,
        color: theme.primaryColor,
      ),
      child: ClipRect(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2.5),
          color: theme.appBarTheme.color,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Text(weekDay, style: _alternateStyle[0]),
              const SizedBox(width: 10.0),
              Text(month, style: _alternateStyle[1]),
              const SizedBox(width: 10.0),
              Text(dayOrdinal, style: _alternateStyle[0]),
              const SizedBox(width: 10.0),
              Text(year, style: _alternateStyle[1]),
            ],
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
