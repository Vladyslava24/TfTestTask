import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/profile_workout_summary_actions.dart';
import 'package:totalfit/redux/states/profile_workout_summary_state.dart';

final profileWorkoutSummaryStateReducer = combineReducers<ProfileWorkoutSummaryState>([
  TypedReducer<ProfileWorkoutSummaryState, OnProfileWorkoutSummaryErrorAction>(_onWorkoutSummaryErrorAction),
  TypedReducer<ProfileWorkoutSummaryState, SetWorkoutSummaryStateAction>(_setWorkoutSummaryStateAction),
]);

ProfileWorkoutSummaryState _onWorkoutSummaryErrorAction(
    ProfileWorkoutSummaryState state, OnProfileWorkoutSummaryErrorAction action) {
  return state.copyWith(error: action.error);
}

ProfileWorkoutSummaryState _setWorkoutSummaryStateAction(
    ProfileWorkoutSummaryState state, SetWorkoutSummaryStateAction action) {
  return state.copyWith(
    workout: action.workout,
    progress: action.progress,
    listItems: action.listItems,
    isWorkoutCompleted: action.isWorkoutCompleted,
  );
}
