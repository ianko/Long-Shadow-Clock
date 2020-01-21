import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:long_shadows_clock/utils/date_utils.dart';

/// Alternate the `fontWeight` styles for each date part.
const _kAlternateStyle = <TextStyle>[
  TextStyle(fontWeight: FontWeight.w900),
  TextStyle(fontWeight: FontWeight.w400),
];

/// The top bar showing the full date.
class DateBar extends StatelessWidget {
  const DateBar({Key key, this.date}) : super(key: key);

  /// Current `DateTime`.
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final weekDay = DateFormat('EEEE').format(date).toUpperCase();
    final dayOrdinal = ordinalDay(date.day).toUpperCase();
    final month = DateFormat('MMMM').format(date).toUpperCase();
    final year = DateFormat('y').format(date);

    return Container(
      width: double.infinity,
      color: theme.appBarTheme.color,
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            TextSpan(text: '$weekDay ', style: _kAlternateStyle[0]),
            TextSpan(text: '$month ', style: _kAlternateStyle[1]),
            TextSpan(text: '$dayOrdinal ', style: _kAlternateStyle[0]),
            TextSpan(text: '$year', style: _kAlternateStyle[1]),
          ],
        ),
        textAlign: TextAlign.center,
        style: theme.textTheme.headline,
      ),
    );
  }
}
