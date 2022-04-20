import 'package:workout_data_legacy/data.dart';
import 'package:totalfit/data/dto/exercise_duration_dto.dart';
import 'package:totalfit/data/workout_phase.dart';

abstract class AbstractStageTimer {
  final Map<Exercise, int> exercisesDuration;
  int restDuration = 0;

  AbstractStageTimer(this.exercisesDuration, this.restDuration);

  int getStageDuration() {
    int duration = 0;
    exercisesDuration.forEach((key, value) {
      duration += value;
    });

    return duration += restDuration;
  }

  List<ExerciseDurationDto> toExerciseDurationDto(WorkoutPhase workoutPhase) {
    final list = <ExerciseDurationDto>[];
    exercisesDuration.forEach((key, value) {
      list.add(ExerciseDurationDto(exerciseName: key.name, exerciseDuration: value, workoutPhase: workoutPhase));
    });
    return list;
  }
}
