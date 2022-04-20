import 'package:flutter/widgets.dart';
import 'package:core/generated/l10n.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/redux/states/workout_state.dart';

int countTotalExercises(WorkoutState state) {
  int count = 0;
  // count += state.workout.warmUp.length;
  // count += state.workout.wod.length * state.wodState.editedRoundCount;
  // count += state.workout.cooldown.length;
  return count;
}

double getCompletionRate(WorkoutPhase workoutPhase) {
  if (workoutPhase == null) {
    return 0.0;
  } else if (workoutPhase == WorkoutPhase.WARMUP) {
    return 1 / 4;
  } else if (workoutPhase == WorkoutPhase.SKILL) {
    return 2 / 4;
  } else if (workoutPhase == WorkoutPhase.WOD) {
    return 3 / 4;
  } else if (workoutPhase == WorkoutPhase.COOLDOWN) {
    return 4 / 4;
  }
  return 1.0;
}

String getPausePageTitle(WorkoutPhase workoutPhase, BuildContext context) {
  if (workoutPhase == null) {
    return "";
  } else if (workoutPhase == WorkoutPhase.WARMUP) {
    return S.of(context).exercise_category_title_warm_up;
  } else if (workoutPhase == WorkoutPhase.SKILL) {
    return S.of(context).exercise_category_title_skill;
  } else if (workoutPhase == WorkoutPhase.WOD) {
    return S.of(context).exercise_category_title_wod;
  } else if (workoutPhase == WorkoutPhase.COOLDOWN) {
    return S.of(context).exercise_category_title_cooldown;
  }
  return "";
}
