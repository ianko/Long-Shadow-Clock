/// Get the day of the month specified by an ordinal value.
/// Examples:
/// ```dart
/// ordinalDay(1); // returns 1st
/// ordinalDay(2); // returns 2nd
/// ordinalDay(3); // returns 3rd
/// ordinalDay(20); // returns 20th
/// ```
String ordinalDay(int day) {
  final ordinals = ['th', 'st', 'nd', 'rd'];
  var suffix = ordinals[0];
  final digit = day % 10;
  if ((digit > 0 && digit < 4) && (day < 11 || day > 13)) {
    suffix = ordinals[digit];
  }
  return '$day$suffix';
}
