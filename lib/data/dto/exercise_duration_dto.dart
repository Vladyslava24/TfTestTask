import 'package:flutter/material.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:workout_data_legacy/data.dart';

class ExerciseDurationDto {
  final int exerciseDuration;
  final String exerciseName;
  final WorkoutPhase workoutPhase;

  ExerciseDurationDto({@required this.exerciseDuration, @required this.exerciseName, @required this.workoutPhase});

  ExerciseDurationDto.fromMap(jsonMap)
      : exerciseDuration = jsonMap['exerciseDuration'],
        exerciseName = jsonMap['exerciseName'],
        workoutPhase = WorkoutPhase.fromString(jsonMap['workoutStage']);

  Map<String, dynamic> toJson() =>
      {'exerciseDuration': exerciseDuration, 'exerciseName': exerciseName, 'workoutStage': workoutPhase.toString()};

  int get hashCode => exerciseDuration.hashCode ^ exerciseName.hashCode ^ workoutPhase.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ExerciseDurationDto &&
      runtimeType == other.runtimeType &&
      exerciseDuration == other.exerciseDuration &&
      exerciseName == other.exerciseName &&
      workoutPhase == other.workoutPhase;
}

Map<Exercise, int> getStageExerciseDurationMap(List<Exercise> stageExercises, List<ExerciseDurationDto> dtos) {
  Map<Exercise, int> map = {};

  stageExercises.forEach((e) {
    ExerciseDurationDto dto = dtos.firstWhere((element) => element.exerciseName == e.name, orElse: () => null);
    if (dto != null) {
      map.putIfAbsent(e, () => dto.exerciseDuration);
    }
  });

  return map;
}
