import 'package:workout_data_legacy/data.dart';
import 'package:redux/redux.dart';
import 'package:totalfit/model/tutorial_page.dart';
import 'package:totalfit/model/workout_page_type.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/states/share_results_state.dart';
import 'package:totalfit/redux/states/workout_state.dart';

final workoutStateReducer = combineReducers<WorkoutState>([
  TypedReducer<WorkoutState, OnShareScreenDataCreatedAction>(_onShareScreenDataCreatedAction),
  TypedReducer<WorkoutState, OnShowTutorialAction>(_onShowTutorialAction),
  TypedReducer<WorkoutState, OnCloseTutorialAction>(_onCloseTutorialAction),
  TypedReducer<WorkoutState, OnShareErrorAction>(_onShareErrorAction),
  TypedReducer<WorkoutState, ClearShareErrorAction>(_onClearShareErrorAction),
]);

WorkoutState _onShareErrorAction(WorkoutState state, OnShareErrorAction action) {
  return state.copyWith(shareResultsState: state.shareResultsState.copyWith(errorMessage: action.errorMessage));
}

WorkoutState _onClearShareErrorAction(WorkoutState state, ClearShareErrorAction action) {
  return state.copyWith(shareResultsState: state.shareResultsState.copyWith(errorMessage: ""));
}

WorkoutState _onShareScreenDataCreatedAction(WorkoutState state, OnShareScreenDataCreatedAction action) {
  String wodType = '';//state.workout.wodType;
  String workoutName = state.workout.theme;
  int workoutDuration = action.workoutDuration;
  int totalExercises = action.totalExercises;
  int wodResult = action.wodResult;
  int roundCount = action.roundCount;
  final shareState = ShareResultsState(
      listItems: action.items,
      wodItem: action.wodItem,
      wodType: wodType,
      workoutName: workoutName,
      totalExercises: totalExercises,
      wodResult: wodResult,
      roundCount: roundCount,
      workoutDuration: workoutDuration,
      errorMessage: "");

  return state.copyWith(currentPageType: WorkoutPageType.FINISHED, shareResultsState: shareState);
}

WorkoutState _onShowTutorialAction(WorkoutState state, OnShowTutorialAction action) {
  return state.copyWith(tutorialPage: action.page, pausedExercise: action.page.exercise);
}

WorkoutState _onCloseTutorialAction(WorkoutState state, OnCloseTutorialAction action) {
  return state.copyWith(
      tutorialPage: TutorialPage.closeTutorialStub(),
      pausedExercise:
          state.tutorialPage.parent != TutorialPageParent.PausePage ? Exercise.clearStateStub() : state.pausedExercise);
}
