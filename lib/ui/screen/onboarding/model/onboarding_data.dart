import 'package:flutter/foundation.dart';
import 'package:totalfit/data/dto/response/feed_program_list_item_response.dart';
import 'package:totalfit/ui/screen/onboarding/model/goal.dart';
import 'package:totalfit/ui/screen/onboarding/model/reason.dart';
import 'package:totalfit/ui/utils/utils.dart';

class OnBoardingData {
  final String name;
  final String gender;
  final String birthday;
  final int height;
  final int weight;
  final int desiredWeight;
  final Reason reason;
  final List<String> habits;
  final List<Goal> goals;
  final LevelType level;
  final int duration;
  final List<String> workoutDays;
  final List<String> equipment;
  final String preferredHighMetric;
  final String preferredWeightMetric;

  OnBoardingData(
      {@required this.name,
      @required this.gender,
      @required this.birthday,
      @required this.height,
      @required this.weight,
      @required this.desiredWeight,
      @required this.reason,
      @required this.habits,
      @required this.goals,
      @required this.level,
      @required this.duration,
      @required this.workoutDays,
      @required this.preferredHighMetric,
      @required this.preferredWeightMetric,
      @required this.equipment});

  factory OnBoardingData.initial() {
    return OnBoardingData(
        name: null,
        gender: null,
        birthday: null,
        height: null,
        weight: null,
        desiredWeight: null,
        reason: null,
        habits: null,
        goals: null,
        level: null,
        duration: null,
        workoutDays: null,
        preferredHighMetric: null,
        preferredWeightMetric: null,
        equipment: null);
  }

  OnBoardingData copyWith({
    String name,
    String gender,
    String birthday,
    int height,
    int weight,
    int desiredWeight,
    String preferredHighMetric,
    String preferredWeightMetric,
    Reason reason,
    List<String> habits,
    List<Goal> goals,
    LevelType level,
    int duration,
    List<String> workoutDays,
    List<String> equipment,
  }) {
    return OnBoardingData(
        name: name ?? this.name,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        desiredWeight: desiredWeight ?? this.desiredWeight,
        reason: reason ?? this.reason,
        habits: habits ?? this.habits,
        goals: goals ?? this.goals,
        level: level ?? this.level,
        duration: duration ?? this.duration,
        preferredHighMetric: preferredHighMetric ?? this.preferredHighMetric,
        preferredWeightMetric: preferredWeightMetric ?? this.preferredWeightMetric,
        workoutDays: workoutDays ?? this.workoutDays,
        equipment: equipment ?? this.equipment);
  }

  @override
  bool operator ==(Object other) =>
      other is OnBoardingData &&
      runtimeType == other.runtimeType &&
      name == other.name &&
      gender == other.gender &&
      birthday == other.birthday &&
      height == other.height &&
      weight == other.weight &&
      desiredWeight == other.desiredWeight &&
      reason == other.reason &&
      deepEquals(habits, other.habits) &&
      deepEquals(goals, other.goals) &&
      deepEquals(workoutDays, other.workoutDays) &&
      deepEquals(equipment, other.equipment) &&
      level == other.level &&
      duration == other.duration &&
      preferredHighMetric == other.preferredHighMetric &&
      preferredWeightMetric == other.preferredWeightMetric;

  @override
  int get hashCode =>
      name.hashCode ^
      gender.hashCode ^
      birthday.hashCode ^
      name.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      desiredWeight.hashCode ^
      reason.hashCode ^
      level.hashCode ^
      duration.hashCode ^
      duration.hashCode ^
      preferredHighMetric.hashCode ^
      preferredWeightMetric.hashCode ^
      deepHash(habits) ^
      deepHash(goals) ^
      deepHash(workoutDays) ^
      deepHash(equipment);
}
