import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/ui/screen/main/progress/progress_view_pager.dart';
import 'package:workout_data/data.dart';

WorkoutProgress selectProgressFromResponse(UpdateProgressNewResponse response, WorkoutDto workout) {
  final progress =
      response.workoutProgress.firstWhere((e) => e.workout != null && e.workout.id == workout.id, orElse: () => null);

  return progress;
}

int selectProgressPageIndex(Store<AppState> store) {
  return PROGRESS_STUB_PAGES_COUNT - 1;
}

WorkoutPhase selectWorkoutStage(Store<AppState> store) {
  final page = store.state.mainPageState.progressPages.last;
  final progress = page.workoutProgressList
      .firstWhere((e) => e.workout.id == store.state.workoutState.workout.id, orElse: () => null);
  final workoutPhase = progress == null ? null : progress.workoutPhase;
  return workoutPhase;
}
