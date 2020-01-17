import 'package:flutter/material.dart';

final lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: const Color(0xFF484E58),
  appBarTheme: const AppBarTheme(color: Color(0xFF868A96)),
  primaryColor: const Color(0xFFFFFFFF),
  primaryColorLight: const Color(0xFFEF3340),
  primaryColorDark: const Color(0xFF000C20),
);

final darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF000000),
  appBarTheme: const AppBarTheme(color: Color(0xFF0C2144)),
  primaryColor: const Color(0xFFBBC8DE),
  primaryColorLight: const Color(0xFF192E41),
  primaryColorDark: const Color(0xFF010307),
);
