import 'package:flutter/widgets.dart';

class ProfileStatisticsState {
  final int totalPoints;
  final String totalTime;
  final int totalWorkouts;

  ProfileStatisticsState({
    @required this.totalPoints,
    @required this.totalTime,
    @required this.totalWorkouts,
  });

  ProfileStatisticsState copyWith({
    int totalPoints,
    String totalTime,
    int totalWorkouts,
  }) {
    return ProfileStatisticsState(
      totalPoints: totalPoints ?? this.totalPoints,
      totalTime: totalTime ?? this.totalTime,
      totalWorkouts: totalWorkouts ?? this.totalWorkouts,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileStatisticsState &&
          runtimeType == other.runtimeType &&
          totalPoints == other.totalPoints &&
          totalTime == other.totalTime &&
          totalWorkouts == other.totalWorkouts;

  @override
  int get hashCode =>
      totalPoints.hashCode ^
      totalPoints.hashCode ^
      totalTime.hashCode ^
      totalWorkouts.hashCode;
}
