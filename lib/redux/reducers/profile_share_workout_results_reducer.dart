import 'package:redux/redux.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/redux/actions/profile_share_workout_results_actions.dart';
import 'package:totalfit/redux/states/profile_share_workout_results_state.dart';

final profileShareScreenReducer = combineReducers<ProfileShareWorkoutResultsScreenState>([
  TypedReducer<ProfileShareWorkoutResultsScreenState, SetShareScreenStateAction>(_setShareScreenStateAction),
  TypedReducer<ProfileShareWorkoutResultsScreenState, OnProfileShareErrorAction>(_onShareErrorAction),
  TypedReducer<ProfileShareWorkoutResultsScreenState, ClearProfileShareErrorAction>(_onClearShareErrorAction),
  TypedReducer<ProfileShareWorkoutResultsScreenState, OnImageItemSelectedAction>(_onImageItemSelectedAction),
]);

ProfileShareWorkoutResultsScreenState _setShareScreenStateAction(
    ProfileShareWorkoutResultsScreenState state, SetShareScreenStateAction action) {
  return state.copyWith(
    isBuildingState: false,
    listItems: action.listItems,
    wodItem: action.wodItem,
    workoutDuration: action.workoutDuration,
    wodType: action.wodType,
    workoutName: action.workoutName,
    totalExercises: action.totalExercises,
    wodResult: action.wodResult,
    roundCount: action.roundCount,
    workoutId: action.workoutId,
  );
}

ProfileShareWorkoutResultsScreenState _onShareErrorAction(
    ProfileShareWorkoutResultsScreenState state, OnProfileShareErrorAction action) {
  return state.copyWith(error: action.error);
}

ProfileShareWorkoutResultsScreenState _onClearShareErrorAction(
    ProfileShareWorkoutResultsScreenState state, ClearProfileShareErrorAction action) {
  return state.copyWith(error: IdleException());
}

ProfileShareWorkoutResultsScreenState _onImageItemSelectedAction(
    ProfileShareWorkoutResultsScreenState state, OnImageItemSelectedAction action) {
  return state.copyWith(selectedImageItem: action.selectedImage);
}
