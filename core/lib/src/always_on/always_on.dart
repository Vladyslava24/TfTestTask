import 'dart:async';
import 'package:wakelock/wakelock.dart';

///  Class use package Wakelock and provide service
class AlwaysOn {
  static AlwaysOn? _instance;

  factory AlwaysOn() => _instance ??= AlwaysOn._();

  AlwaysOn._();

  Future<void> enable() async {
    await Wakelock.enable();
  }

  Future<void> disable() async {
    await Wakelock.disable();
  }
}