import 'dart:async';
import 'package:vibration/vibration.dart';

///  Class use Flutter favorite package vibration and provide service
class Vibrator {
  static Vibrator? _instance;

  factory Vibrator() => _instance ??= Vibrator._();

  Vibrator._();

  Future<void> vibrate() async {
    final bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator != null && hasVibrator) {
      Vibration.vibrate(amplitude: 128);
    }
  }
}