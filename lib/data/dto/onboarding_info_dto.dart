import 'package:flutter/foundation.dart';
import 'package:totalfit/ui/screen/onboarding/model/goal.dart';
import 'package:totalfit/ui/screen/onboarding/model/reason.dart';

class OnboardingInfoDto {
  final Reason reason;
  final List<Goal> goals;
  final List<String> habits;

  OnboardingInfoDto({
    @required this.reason,
    @required this.goals,
    @required this.habits,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map.putIfAbsent("focusOn", () => reason.toBackendKey());
    map.putIfAbsent("goals", () => goals.map((e) => e.toBackendKey()).toList());
    map.putIfAbsent("habitsIdes", () => habits);
    return map;
  }
}
