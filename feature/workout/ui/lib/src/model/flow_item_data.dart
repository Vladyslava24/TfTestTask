import 'package:workout_use_case/use_case.dart';

class StageTimeEditData {
  int duration;
  int? editedForTimeDuration;
  WorkoutStage workoutStage;

  StageTimeEditData({
    required this.duration,
    this.editedForTimeDuration,
    required this.workoutStage,
  });

  StageTimeEditData copyWith({
    int? duration,
    int? editedForTimeDuration,
    WorkoutStage? workoutStage,
  }) {
    return StageTimeEditData(
        duration: duration ?? this.duration,
        workoutStage: workoutStage ?? this.workoutStage,
        editedForTimeDuration:
            editedForTimeDuration ?? this.editedForTimeDuration);
  }
}

class StageRoundCountEditData {
  int roundCount;
  int? editedRoundCount;
  List<ExerciseDuration> stageExerciseDuration;
  WorkoutStage workoutStage;

  StageRoundCountEditData(
      {required this.roundCount,
      this.editedRoundCount,
      required this.workoutStage,
      required this.stageExerciseDuration});

  StageRoundCountEditData copyWith(
      {int? roundCount,
      int? editedRoundCount,
        WorkoutStage? workoutStage,
      List<ExerciseDuration>? stageExerciseDuration}) {
    return StageRoundCountEditData(
        roundCount: roundCount ?? this.roundCount,
        workoutStage: workoutStage ?? this.workoutStage,
        stageExerciseDuration:
            stageExerciseDuration ?? this.stageExerciseDuration,
        editedRoundCount: editedRoundCount ?? this.editedRoundCount);
  }
}
