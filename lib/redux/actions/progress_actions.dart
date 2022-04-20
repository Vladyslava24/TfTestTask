import 'package:flutter/foundation.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/data/dto/mood_dto.dart';
import 'package:totalfit/data/dto/response/mood_tracking_progress_response.dart';
import 'package:totalfit/model/loading_state/breathing_page_state.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:totalfit/data/dto/request/update_progress_request.dart';
import 'package:totalfit/data/dto/response/progress_response.dart';
import 'package:totalfit/data/hexagon_state.dart';
import 'package:totalfit/model/environment_model.dart';
import 'package:totalfit/model/environmental_result.dart';
import 'package:totalfit/model/progress_page_model.dart';
import 'package:totalfit/model/statement.dart';
import 'package:totalfit/model/story_model.dart';
import 'package:totalfit/model/wisdom_model.dart';

class UpdateProgressWisdomAction {
  WisdomModel wisdomModel;

  UpdateProgressWisdomAction(this.wisdomModel);
}

class UpdateProgressStoryAction {
  StoryModel storyModel;

  UpdateProgressStoryAction(this.storyModel);
}

class UpdateProgressHabitAction {
  List<HabitDto> habits;

  UpdateProgressHabitAction(this.habits);
}

class UpdateProgressEnvironmentAction {
  EnvironmentResult result;

  UpdateProgressEnvironmentAction(this.result);
}

class UpdateStatementListAction {
  List<Statement> statements;

  UpdateStatementListAction({@required this.statements});
}

class UpdateStatementAction extends TrackableAction {
  int progressIndex;
  Statement statement;

  UpdateStatementAction({@required this.progressIndex, @required this.statement});

  @override
  Event event() => Event.STATEMENT_MARKED;

  @override
  Map<String, String> parameters() => {"statement": statement.statement, "completed": statement.completed.toString()};
}

class LoadSelectedProgressAction {
  LoadSelectedProgressAction();
}

class LoadProgressAction {
  final progressTimestamp;

  LoadProgressAction({@required this.progressTimestamp});
}

class InitProgressAction {}

class FetchProgressAction {
  final DateTime date;
  final int index;

  FetchProgressAction(this.date, this.index);
}

class DecrementProgressPageIndex extends TrackableAction {
  final DateTime date;

  DecrementProgressPageIndex(this.date);

  @override
  Event event() => Event.PRESSED_CALENDAR_PREVIOUS_DAY;

  @override
  Map<String, String> parameters() => {'requestedDate': formatDateTime(date)};
}

class IncrementProgressPageIndex extends TrackableAction {
  final DateTime date;

  IncrementProgressPageIndex(this.date);

  @override
  Event event() => Event.PRESSED_CALENDAR_NEXT_DAY;

  @override
  Map<String, String> parameters() => {'requestedDate': formatDateTime(date)};
}

class BuildProgressListAction {
  final ProgressResponse progressResponse;
  final MoodTrackingProgressResponse moodProgressResponse;
  final int progressPageIndex;

  BuildProgressListAction({@required this.progressResponse, @required this.progressPageIndex, this.moodProgressResponse});
}

class OnPreviousProgressSelectedAction {}

class SetCurrentProgressPagesAction {
  final List<ProgressPageModel> progressPages;
  final int progressPageIndex;

  SetCurrentProgressPagesAction({@required this.progressPages, this.progressPageIndex});
}

class RetryLoadingProgressPageAction {
  final DateTime date;
  final int index;

  RetryLoadingProgressPageAction({@required this.date, @required this.index});
}

class SaveStoryResultAction extends TrackableAction {
  final int progressPageIndex;
  final String statement;

  SaveStoryResultAction({this.progressPageIndex, this.statement});

  @override
  Event event() => Event.READ_STORY;
}

class SendStatementSkippedEventAction extends TrackableAction {
  @override
  Event event() => Event.STATEMENT_SKIPPED;
}

class SendStatementAddedEventAction extends TrackableAction {
  final String statement;

  SendStatementAddedEventAction(this.statement);

  @override
  Event event() => Event.STATEMENT_ADDED;

  @override
  Map<String, String> parameters() => {"statement": statement};
}

class SaveWisdomResultAction extends TrackableAction {
  int progressPageIndex;

  SaveWisdomResultAction({this.progressPageIndex});

  @override
  Event event() => Event.READ_WISDOM;

  @override
  Map<String, String> parameters() => {"wisdom_name": 'TODO: add wisdom model'};
}

class SaveBreathingResultAction extends TrackableAction {
  int progressPageIndex;

  SaveBreathingResultAction({this.progressPageIndex});

  @override
  Event event() => Event.BREATHING_CLOSED;

  @override
  Map<String, String> parameters() => {"breathing_name": 'TODO: add breathing model'};
}

class SaveEnvironmentalResultAction {
  int progressIndex;
  int value;

  SaveEnvironmentalResultAction({this.progressIndex, this.value});
}

class DeleteAllProgressAction {}

class UpdateProgressForWarmUpSummaryAction {
  final UpdateProgressRequest request;

  UpdateProgressForWarmUpSummaryAction({@required this.request});
}

class UpdateProgressForSkillSummaryAction {
  final UpdateProgressRequest request;

  UpdateProgressForSkillSummaryAction({@required this.request});
}

class UpdateProgressForWodSummaryAction {
  final UpdateProgressRequest request;

  UpdateProgressForWodSummaryAction({@required this.request});
}

class UpdateProgressForWorkoutSummaryAction {
  final UpdateProgressRequest request;

  UpdateProgressForWorkoutSummaryAction({@required this.request});
}

class UpdateProgressForShareResultsAction extends TrackableAction {
  final UpdateProgressRequest request;

  UpdateProgressForShareResultsAction({@required this.request});

  @override
  Event event() => Event.SHARE_SCREEN_COMPLETED;

  @override
  Map<String, String> parameters() => {"hasShared": request.shared.toString()};
}

class UpdateProgressForProfileShareResultsAction {
  final UpdateProgressRequest request;

  UpdateProgressForProfileShareResultsAction({@required this.request});
}

class BuildWarmupSummaryListItemsAction {}

class BuildSkillSummaryListItemsAction {}

class BuildWodSummaryListItemsAction {}

class BuildWorkoutSummaryListItemsAction {}

class ChangeBreathingPageState {
  final BreathingPageState breathingPageState;
  const ChangeBreathingPageState(this.breathingPageState);
}

class UpdateProgressPageOnSaveStoryAction {
  final int index;
  final bool isStoryRead;
  final List<Statement> statements;
  final HexagonState hexagonState;

  UpdateProgressPageOnSaveStoryAction(
      {@required this.index, @required this.isStoryRead, @required this.statements, @required this.hexagonState});
}

class UpdateProgressPageOnSaveWisdomAction {
  final int index;
  final bool isWisdomRead;
  final HexagonState hexagonState;

  UpdateProgressPageOnSaveWisdomAction(
      {@required this.index, @required this.isWisdomRead, @required this.hexagonState});
}

class UpdateProgressPageOnSaveBreathingAction {
  final int index;
  final bool done;
  final HexagonState hexagonState;

  UpdateProgressPageOnSaveBreathingAction({
    @required this.index,
    @required this.done,
    @required this.hexagonState
  });
}

class UpdateProgressPageOnSaveEnvironmentalAction {
  final int index;
  final EnvironmentModel environmental;
  final HexagonState hexagonState;

  UpdateProgressPageOnSaveEnvironmentalAction({
    @required this.index,
    @required this.environmental,
    @required this.hexagonState,
  });
}

class UpdateProgressPageOnToggleStatementAction {
  final int index;
  final String statementId;
  final bool isStatementCompleted;

  UpdateProgressPageOnToggleStatementAction(
      {@required this.index, @required this.statementId, @required this.isStatementCompleted});
}

class OnSaveStoryErrorAction {
  final String error;

  OnSaveStoryErrorAction({@required this.error});
}

class OnSaveWisdomErrorAction {
  final String error;

  OnSaveWisdomErrorAction({@required this.error});
}

class OnSaveBreathingErrorAction {
  final String error;

  OnSaveBreathingErrorAction({@required this.error});
}

class OnSaveEnvironmentalErrorAction {
  final String error;

  OnSaveEnvironmentalErrorAction({@required this.error});
}

class OnUpdateStatementErrorAction {
  final int progressIndex;
  final String error;

  OnUpdateStatementErrorAction({@required this.progressIndex, @required this.error});
}

class OnHabitCompletionToggledAction {
  final bool completed;
  final String habitId;

  OnHabitCompletionToggledAction({@required this.completed, @required this.habitId});
}

class OnToggleHabitCompletionErrorAction {
  final String error;

  OnToggleHabitCompletionErrorAction({@required this.error});
}

class OnUpdateHabitErrorAction {
  final String error;

  OnUpdateHabitErrorAction({@required this.error});
}

class RemoveUpdateStatementErrorAction {
  final int progressIndex;

  RemoveUpdateStatementErrorAction({@required this.progressIndex});
}

class RemoveHabitCompletionToggleErrorAction {}

class RemoveEnvironmentalToggleErrorToggleErrorAction {}

class LoadHabitListAction {}

class SelectHabitAction extends TrackableAction {
  final String habitId;
  final String habitModelId;
  final String date;
  final bool selected;
  final String habit;

  SelectHabitAction(
      {@required this.habitId,
      @required this.habitModelId,
      @required this.date,
      @required this.selected,
      @required this.habit});

  @override
  Event event() => Event.HLH_SELECTED;

  @override
  Map<String, String> parameters() => {"habitId": habitId, "selected": selected.toString(), "habit": habit};
}

class OnHabitListLoadedAction {
  final List<Habit> habitList;
  final Habit recommendedHabit;

  OnHabitListLoadedAction({@required this.habitList, this.recommendedHabit});
}

class OnHabitSelectedAction {
  final HabitDto dto;

  OnHabitSelectedAction({@required this.dto});
}

class OnHabitUnSelectedAction {
  final String habitId;

  OnHabitUnSelectedAction({@required this.habitId});
}

class OnHabitListLoadingErrorAction {
  final String error;

  OnHabitListLoadingErrorAction({@required this.error});
}

class UpdateMoodTracking {
  final MoodDTO model;

  const UpdateMoodTracking({
    @required this.model
  });
}

class OnUpdateMoodTracking {
  final MoodDTO model;

  const OnUpdateMoodTracking({
    @required this.model
  });
}
class DiscountChangeValueAction {
  final bool value;

  DiscountChangeValueAction({ @required this.value });
}