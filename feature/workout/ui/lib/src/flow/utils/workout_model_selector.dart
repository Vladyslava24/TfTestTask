import 'package:workout_use_case/use_case.dart';

int? getMaxAmrapDurationInMinutes(WorkoutModel workout, WorkoutStage stage) {
  try {
    final workoutStage =
        workout.stages.firstWhere((element) => element.stageName == stage);
    if (workoutStage.stageOption.metricType != "MIN") {
      throw 'Amrap supports only MIN';
    }
    return workoutStage.stageOption.metricQuantity;
  } catch (e) {
    return null;
  }
}
