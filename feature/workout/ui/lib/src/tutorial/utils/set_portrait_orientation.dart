import 'package:flutter/services.dart';

Future<void> setPortraitOrientation() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}