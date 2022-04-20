import 'package:workout_use_case/use_case.dart';

class ExerciseData {
  final ExerciseModel exercise;
  final WorkoutStage stage;
  final WorkoutStageType stageType;
  final int workoutStageDuration;

  const ExerciseData({
    required this.exercise,
    required this.stage,
    required this.stageType,
    required this.workoutStageDuration
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseData &&
          runtimeType == other.runtimeType &&
          exercise == other.exercise &&
          stageType == other.stageType &&
          workoutStageDuration == other.workoutStageDuration &&
          stage == other.stage;

  @override
  int get hashCode =>
    exercise.hashCode ^
    stage.hashCode ^
    workoutStageDuration.hashCode ^
    stageType.hashCode;
}
