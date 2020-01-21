import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:long_shadows_clock/clock/long_shadows_clock.dart';
import 'package:long_shadows_clock/themes.dart';

Future<void> main() async {
  // A temporary measure until Platform supports web and TargetPlatform supports
  // macOS.
  if (!kIsWeb && Platform.isMacOS) {
    // TODO(gspencergoog): Update this when TargetPlatform includes macOS.
    // https://github.com/flutter/flutter/issues/31366
    // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override.
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  runApp(const _ThemedApp());
}

class _ThemedApp extends StatelessWidget {
  const _ThemedApp();

  @override
  Widget build(BuildContext context) {
    return ClockCustomizer((model) {
      return Builder(
        builder: (context) {
          return Theme(
            data: Theme.of(context).brightness == Brightness.light
                ? lightTheme
                : darkTheme,
            child: LongShadowsClock(model),
          );
        },
      );
    });
  }
}
