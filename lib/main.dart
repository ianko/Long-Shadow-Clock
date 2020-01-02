import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/customizer.dart';
import 'package:long_shadows_clock/photos_bucket.dart';
import 'package:long_shadows_clock/long_shadows_clock.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load the images inside the assets directory
  await PhotosBucket.instance.initialize();

  // A temporary measure until Platform supports web and TargetPlatform supports
  // macOS.
  if (!kIsWeb && Platform.isMacOS) {
    // TODO(gspencergoog): Update this when TargetPlatform includes macOS.
    // https://github.com/flutter/flutter/issues/31366
    // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override.
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  runApp(ClockCustomizer((model) => LongShadowsClock(model)));
}
