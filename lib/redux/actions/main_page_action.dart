import 'package:core/core.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/foundation.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/domain/bloc/workouts_bloc/workout_bloc.dart';
import 'package:totalfit/model/exercise_category.dart';
import 'package:totalfit/model/workout_preview_list_items.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';
import 'package:workout_use_case/use_case.dart';

class ShowSortedWorkoutsAction extends TrackableAction {
  @override
  Event event() => Event.PRESSED_SEE_ALL_WORKOUTS;
}

class ShowFilterWorkoutsAction extends TrackableAction {
  final WorkoutBloc bloc;

  ShowFilterWorkoutsAction(this.bloc);

  @override
  Event event() => Event.PRESSED_FILTER_WORKOUTS;
}

class NavigateToSortedExercisesPageAction extends TrackableAction {
  final ExerciseCategory exerciseCategory;

  NavigateToSortedExercisesPageAction(this.exerciseCategory);

  @override
  Event event() => Event.PRESSED_EXERCISE_CATEGORY;

  @override
  Map<String, String> parameters() => {"category": exerciseCategory.tag};
}

class NavigateToSortedExercisesPageOnSeeAllPressedAction
    extends TrackableAction {
  final ExerciseCategory exerciseCategory;

  NavigateToSortedExercisesPageOnSeeAllPressedAction(this.exerciseCategory);

  @override
  Event event() => Event.PRESSED_SEE_ALL_EXERCISES;
}

class NavigateToExerciseVideoPage {
  final Exercise exercise;

  NavigateToExerciseVideoPage(this.exercise);
}

class RemoveExerciseVideoPageAction {}

class WorkoutLoadingStateAction {
  final bool isLoading;

  WorkoutLoadingStateAction(this.isLoading);
}

class OnFetchWorkoutExceptionAction {
  final ApiException error;

  OnFetchWorkoutExceptionAction(this.error);
}

class OnWorkoutsSortedAction {
  final List<WorkoutDto> workouts;

  OnWorkoutsSortedAction(this.workouts);
}

class OnExercisesSortedAction {
  final Map<String, Set<Exercise>> exercises;

  OnExercisesSortedAction(this.exercises);
}

class OnLoadSortedExercisesErrorAction {
  final String error;

  OnLoadSortedExercisesErrorAction(this.error);
}

class SwitchProgramTabAction {
  final bool showActiveProgram;

  SwitchProgramTabAction({@required this.showActiveProgram});
}

class ShowProgramDescriptionPageAction {}

class OnWorkoutFetchedAction {
  final List<WorkoutDto> workouts;
  final List<WorkoutModel> newWorkouts;

  OnWorkoutFetchedAction(this.workouts, this.newWorkouts);
}

class OnWorkoutItemListBuiltAction {
  final List workoutItemList;

  OnWorkoutItemListBuiltAction(this.workoutItemList);
}

class OnBuildWorkoutItemListAction {
  final List<WorkoutDto> workouts;

  OnBuildWorkoutItemListAction(this.workouts);
}

class OnBasicWorkoutLoadedAction {
  final List<BasicWorkoutListItem> basicWorkoutListItems;

  OnBasicWorkoutLoadedAction(this.basicWorkoutListItems);
}

class RemoveInnerWorkoutPageAction {
  RemoveInnerWorkoutPageAction();
}

class NavigateToWorkoutPreviewPageAction extends TrackableAction {
  final DateTime startDate;
  final WorkoutDto workout;

  NavigateToWorkoutPreviewPageAction(this.workout, {this.startDate});

  /// 'startDate' Not null when triggered from Programs
  @override
  Event event() => startDate == null
      ? Event.PRESSED_WORKOUT
      : Event.PRESSED_WORKOUT_PREVIEW_FROM_PROGRAM;

  @override
  Map<String, String> parameters() =>
      {"workoutId": workout.id.toString(), "workoutName": workout.theme};
}

class SendWorkoutStartedEventAction extends TrackableAction {
  int workoutId;
  String workoutName;
  String workoutType;

  SendWorkoutStartedEventAction(
      this.workoutId, this.workoutName, this.workoutType);

  @override
  Event event() => Event.WORKOUT_STARTED;

  @override
  Map<String, String> parameters() => {
        "workoutId": workoutId.toString(),
        "workoutName": workoutName,
        "workoutType": workoutType
      };
}

class ChangeSelectedVideoStateAction {
  final bool isPlaying;

  ChangeSelectedVideoStateAction({@required this.isPlaying});
}

class RefreshTokenAction {}

class NavigateToWorkoutSelectionAction {}

class NavigateToSingleButtonPageAction {}

class NavigateToStoryPageAction extends TrackableAction {
  final int progressPageIndex;
  final String storyName;

  NavigateToStoryPageAction(
      {@required this.progressPageIndex, @required this.storyName});

  @override
  Event event() => Event.PRESSED_STORY;

  @override
  Map<String, String> parameters() => {"storyName": storyName};
}

class NavigateToHabitPageAction extends TrackableAction {
  final int progressPageIndex;

  NavigateToHabitPageAction({@required this.progressPageIndex});

  @override
  Event event() => Event.PRESSED_HLH;
}

class NavigateToWisdomPageAction extends TrackableAction {
  final int progressPageIndex;
  final String wisdomName;

  NavigateToWisdomPageAction(
      {@required this.progressPageIndex, @required this.wisdomName});

  @override
  Event event() => Event.PRESSED_WISDOM;

  @override
  Map<String, String> parameters() => {"wisdomName": wisdomName};
}

class NavigateToBreathingPageAction extends TrackableAction {
  final int progressPageIndex;
  final String video;

  NavigateToBreathingPageAction(
      {@required this.progressPageIndex, @required this.video});

  @override
  Event event() => Event.BREATHING_STARTED;
}

class OnCompleteReadStoryAction {
  final int progressPageIndex;

  OnCompleteReadStoryAction({@required this.progressPageIndex});
}

class OnHexagonExpansionChangedAction extends TrackableAction {
  final bool isExpanded;

  OnHexagonExpansionChangedAction({@required this.isExpanded});

  @override
  Event event() => Event.PRESSED_HEXAGON_STATISTICS;

  @override
  Map<String, String> parameters() => {"expanded": isExpanded.toString()};
}

class LoadExerciseListAction {}

class OnExerciseLoadedAction {
  final List<Exercise> exercises;

  OnExerciseLoadedAction(this.exercises);
}

class OnExerciseLoadErrorAction {
  final ApiException baseApiException;

  OnExerciseLoadErrorAction(this.baseApiException);
}

class NavigateToEditProgramPageAction extends TrackableAction {
  @override
  Event event() => Event.PRESSED_PROGRAM_EDIT;
}

class ShowGlobalProgressLoadingIndicatorAction {
  bool showLoadingIndicator;

  ShowGlobalProgressLoadingIndicatorAction(this.showLoadingIndicator);
}

class OnWorkoutSummaryLoadError {
  String error;

  OnWorkoutSummaryLoadError(this.error);
}

class OnViewWorkoutSummaryAction extends TrackableAction {
  final CompletedWorkoutListItem item;

  OnViewWorkoutSummaryAction({@required this.item});

  @override
  Event event() => Event.PRESSED_VIEW_WORKOUT_SUMMARY;

  @override
  Map<String, String> parameters() =>
      {"name": item.name, "workoutProgressId": item.workoutProgressId};
}
