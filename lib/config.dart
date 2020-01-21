import 'dart:ui';

/// Duration of the rainbow animation when animating in forward.
const kFwdAnimDuration = Duration(milliseconds: 350);

/// Duration of the rainbow animation when animating in reverse.
const kRwdAnimDuration = Duration(milliseconds: 450);

/// Rainbow colors when in `Brightness.light` mode.
const kRainbowColorsLight = <Color>[
  Color(0xFF4285F4),
  Color(0xFFDB4437),
  Color(0xFFF4B400),
  Color(0xFF0F9D58),
];

/// Rainbow colors when in `Brightness.dark` mode.
const kRainbowColorsDark = <Color>[
  Color(0xFF632F30),
  Color(0xFF1E3D58),
  Color(0xFFBF8422),
  Color(0xFF2F5233),
];
