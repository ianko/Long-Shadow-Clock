import 'package:flutter/material.dart';

/// Colors configuration when in `Brightness.light` mode.
final lightTheme = _baseTheme.copyWith(
  brightness: Brightness.light,
  // clock background color.
  scaffoldBackgroundColor: const Color(0xFF484E58),
  // date bar background color.
  appBarTheme: const AppBarTheme(color: Color(0xFF868A96)),
  // default text color.
  primaryColor: const Color(0xFFFFFFFF),
  // shadow start color.
  primaryColorLight: const Color(0xFFEF3340),
  // shadow end color.
  primaryColorDark: const Color(0xFF000C20),
  // text sizes and cofigurations (see [_baseTheme] below).
  textTheme: _baseTheme.textTheme.copyWith(
    // Hour text.
    display1: _baseTheme.textTheme.display1.copyWith(
      color: const Color(0xFFFFFFFF),
    ),
    // Minutes text.
    display2: _baseTheme.textTheme.display2.copyWith(
      color: const Color(0xFFFFFFFF),
    ),
    // Seconds text.
    display3: _baseTheme.textTheme.display3.copyWith(
      color: const Color(0xFFFFFFFF),
    ),
    // text on top bar showing the date.
    headline: _baseTheme.textTheme.headline.copyWith(
      color: const Color(0xFFFFFFFF),
    ),
  ),
);

/// Colors configuration when in `Brightness.dark` mode.
final darkTheme = _baseTheme.copyWith(
  brightness: Brightness.dark,
  // clock background color.
  scaffoldBackgroundColor: const Color(0xFF000000),
  // date bar background color.
  appBarTheme: const AppBarTheme(color: Color(0xFF0C2144)),
  // default text color.
  primaryColor: const Color(0xFFBBC8DE),
  // shadow start color.
  primaryColorLight: const Color(0xFF192E41),
  // shadow end color.
  primaryColorDark: const Color(0xFF010307),
  // text sizes and cofigurations (see [_baseTheme] below).
  textTheme: _baseTheme.textTheme.copyWith(
    // Hour text.
    display1: _baseTheme.textTheme.display1.copyWith(
      color: const Color(0xFFBBC8DE),
    ),
    // Minutes text.
    display2: _baseTheme.textTheme.display2.copyWith(
      color: const Color(0xFFBBC8DE),
    ),
    // Seconds text.
    display3: _baseTheme.textTheme.display3.copyWith(
      color: const Color(0xFFBBC8DE),
    ),
    // text on top bar showing the date.
    headline: _baseTheme.textTheme.headline.copyWith(
      color: const Color(0xFFBBC8DE),
    ),
  ),
);

/// Base `ThemeData` to be inherited and customized per brightness.
final _baseTheme = ThemeData(
  textTheme: TextTheme(
    display1: TextStyle(
      fontSize: 150.0,
      fontFamily: 'BungeeShade',
      shadows: List.generate(350, (_) => null, growable: false),
    ),
    display2: TextStyle(
      fontSize: 120.0,
      fontFamily: 'BungeeShade',
      shadows: List.generate(300, (_) => null, growable: false),
    ),
    display3: TextStyle(
      fontSize: 80.0,
      fontFamily: 'BungeeShade',
      shadows: List.generate(220, (_) => null, growable: false),
    ),
    headline: const TextStyle(
      fontSize: 10.0,
      letterSpacing: 2.5,
      wordSpacing: 5.0,
    ),
  ),
);
