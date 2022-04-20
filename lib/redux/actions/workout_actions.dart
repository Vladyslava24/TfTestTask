import 'package:core/core.dart';
import 'package:totalfit/model/loading_state/workout_of_the_day_state.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:totalfit/analytics/analytic_service.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:core/core.dart';
import 'package:totalfit/model/tutorial_page.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/model/workout_page_type.dart';
import 'package:totalfit/model/workout_preview_list_items.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';

class StartWorkoutTimerAction {}

class UpdateWorkoutAfterClearCacheAction {}

class UpdateWorkoutCacheResultAction {
  final List<WorkoutDto> workouts;

  UpdateWorkoutCacheResultAction(this.workouts);
}

class ClearWarmUpCacheAction {}

class QuitWorkoutAction extends TrackableAction {
  /// Nullable, if == null - event is not sent
  WorkoutPhase phase;

  QuitWorkoutAction(this.phase);

  @override
  Event event() => Event.PRESSED_QUIT_WORKOUT;

  @override
  Map<String, String> parameters() => {"workoutPhase": phase.toString()};

  @override
  void logEvent(AnalyticService service) {
    if (phase != null) {
      super.logEvent(service);
    }
  }
}

class NavigateToProgressAction {}

class OnShowTutorialAction extends TrackableAction {
  final TutorialPage page;

  OnShowTutorialAction({@required this.page});

  @override
  Event event() => Event.PRESSED_WATCH_TUTORIAL;

  @override
  Map<String, String> parameters() => {"exercise": page.exercise.name};
}

class OnCloseTutorialAction {}

class OnChangeWODLoadingAction {
  WorkoutOfTheDayState workoutOfTheDayState;

  OnChangeWODLoadingAction(this.workoutOfTheDayState);
}

class OnToggleHabitCompletionAction extends TrackableAction {
  final bool completed;
  final String habitProgressId;
  final String habit;

  OnToggleHabitCompletionAction(
      {@required this.completed,
      @required this.habitProgressId,
      @required this.habit});

  @override
  Event event() => Event.HLH_MARKED;

  @override
  void addParameters(Map<String, dynamic> params) =>
      {"marked": completed, "habit": habit};
}

////////////////// Share Results

class OnShareScreenDataCreatedAction {
  List<dynamic> items;
  ExerciseCategoryItem wodItem;
  WorkoutProgressDto progress;
  int totalExercises;
  int wodResult;
  int workoutDuration;
  int roundCount;
  int points;

  OnShareScreenDataCreatedAction(
      {@required this.items,
      @required this.wodItem,
      @required this.progress,
      @required this.totalExercises,
      @required this.wodResult,
      @required this.workoutDuration,
      @required this.roundCount});
}

class OnShareErrorAction {
  final String errorMessage;

  OnShareErrorAction({@required this.errorMessage});
}

class ClearShareErrorAction {}

class SendDetailWarmUpStatisticsWatchedEventAction extends TrackableAction {
  @override
  Event event() => Event.PRESSED_DETAIL_WARMUP_STATISTICS;
}

class SendPickedImageEventAction extends TrackableAction {
  final ImageSource source;

  SendPickedImageEventAction(this.source);

  @override
  Event event() => Event.PICKED_SHARING_IMAGE;

  @override
  Map<String, String> parameters() => {"imageSource": source.toString()};
}

class OnWarmupCompletedEventAction extends TrackableAction {
  final String theme;
  final String workoutType;

  OnWarmupCompletedEventAction(this.theme, this.workoutType);

  @override
  Event event() => Event.WARMUP_COMPLETED;

  @override
  Map<String, String> parameters() =>
      {"theme": theme, "workoutType": workoutType};
}

class OnSkillCompletedEventAction extends TrackableAction {
  final String theme;
  final String workoutType;

  OnSkillCompletedEventAction(this.theme, this.workoutType);

  @override
  Event event() => Event.SKILL_COMPLETED;

  @override
  Map<String, String> parameters() =>
      {"theme": theme, "workoutType": workoutType};
}

class OnWodCompletedEventAction extends TrackableAction {
  final String theme;
  final String workoutType;

  OnWodCompletedEventAction(this.theme, this.workoutType);

  @override
  Event event() => Event.WOD_COMPLETED;

  @override
  Map<String, String> parameters() =>
      {"theme": theme, "workoutType": workoutType};
}

class OnCooldownCompletedEventAction extends TrackableAction {
  final String theme;
  final String workoutType;

  OnCooldownCompletedEventAction(this.theme, this.workoutType);

  @override
  Event event() => Event.COOLDOWN_COMPLETED;

  @override
  Map<String, String> parameters() =>
      {"theme": theme, "workoutType": workoutType};
}

class OnSharingCompletedEventAction extends TrackableAction {
  final String theme;
  final String wodType;
  final String workoutProgressId;
  final String startedAt;

  OnSharingCompletedEventAction(
      {this.theme, this.wodType, this.workoutProgressId, this.startedAt});

  @override
  Event event() => Event.SHARING_COMPLETED;

  @override
  Map<String, String> parameters() => {"theme": theme, "workoutType": wodType};
}

class SentPressedFilterEventAction extends TrackableAction {
  final String eventName;

  SentPressedFilterEventAction({@required this.eventName});

  @override
  Event event() => Event.SELECTED_FILTER_WORKOUTS;

  @override
  Map<String, String> parameters() => {"filterItem": eventName};
}
