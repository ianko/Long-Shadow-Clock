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

    return Container(
      width: double.infinity,
      color: theme.appBarTheme.color,
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(text: '$weekDay ', style: _alternateStyle[0]),
            TextSpan(text: '$month ', style: _alternateStyle[1]),
            TextSpan(text: '$dayOrdinal ', style: _alternateStyle[0]),
            TextSpan(text: '$year', style: _alternateStyle[1]),
          ],
        ),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 10.0,
          letterSpacing: 2.5,
          wordSpacing: 5.0,
          color: theme.primaryColor,
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
