import 'package:flutter/foundation.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:totalfit/data/dto/mood_dto.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/data/hexagon_state.dart';
import 'package:totalfit/model/discount_model.dart';
import 'package:totalfit/model/loading_state/workout_of_the_day_state.dart';
import 'package:totalfit/model/story_model.dart';
import 'package:totalfit/model/wisdom_model.dart';
import 'package:totalfit/model/loading_state/environmental_page_state.dart';
import 'package:totalfit/model/loading_state/habit_completion_state.dart';
import 'package:totalfit/model/loading_state/statement_update_state.dart';
import 'package:totalfit/ui/utils/utils.dart';

import 'breathing_model.dart';
import 'environment_model.dart';

class ProgressPageModel {
  String date;
  HexagonState hexagonState;
  StoryModel storyModel;
  WisdomModel wisdomModel;
  BreathingModel breathingModel;
  EnvironmentModel environmentModel;
  List<HabitDto> habitModels;
  List<WorkoutProgressDto> workoutProgressList;
  List<MoodDTO> moodTrackingList;
  String loadProgressError;
  WorkoutOfTheDayState workoutOfTheDayState;
  StatementUpdateState statementUpdateState;
  HabitCompletionState habitCompletionState;
  EnvironmentalPageState environmentalPageState;
  String priority;
  DiscountModel discountModel;

  ProgressPageModel({
    @required this.date,
    @required this.habitModels,
    @required this.hexagonState,
    @required this.storyModel,
    @required this.wisdomModel,
    @required this.breathingModel,
    @required this.environmentModel,
    @required this.workoutProgressList,
    @required this.moodTrackingList,
    @required this.discountModel,
    this.loadProgressError,
    this.statementUpdateState = StatementUpdateState.IDLE,
    this.habitCompletionState = HabitCompletionState.IDLE,
    this.environmentalPageState = EnvironmentalPageState.IDLE,
    this.workoutOfTheDayState = WorkoutOfTheDayState.IDLE,
    this.priority
  });

  int get hashCode =>
    date.hashCode ^
    workoutOfTheDayState.hashCode ^
    deepHash(habitModels) ^
    hexagonState.hashCode ^
    storyModel.hashCode ^
    wisdomModel.hashCode ^
    breathingModel.hashCode ^
    environmentModel.hashCode ^
    discountModel.hashCode ^
    habitCompletionState.hashCode ^
    loadProgressError.hashCode ^
    environmentalPageState.hashCode ^
    deepHash(workoutProgressList) ^
    deepHash(moodTrackingList) ^
    priority.hashCode;

  @override
  bool operator ==(Object other) =>
    other is ProgressPageModel &&
    runtimeType == other.runtimeType &&
    date == other.date &&
        workoutOfTheDayState == other.workoutOfTheDayState &&
    deepEquals(habitModels, other.habitModels) &&
    hexagonState == other.hexagonState &&
    storyModel == other.storyModel &&
    habitCompletionState == other.habitCompletionState &&
    wisdomModel == other.wisdomModel &&
    breathingModel == other.breathingModel &&
    environmentModel == other.environmentModel &&
    discountModel == other.discountModel &&
    loadProgressError == other.loadProgressError &&
    environmentalPageState == other.environmentalPageState &&
    deepEquals(workoutProgressList, other.workoutProgressList) &&
    deepEquals(moodTrackingList, other.moodTrackingList) &&
    priority == other.priority;

  ProgressPageModel copyWith({
    String date,
    HexagonState hexagonState,
    StoryModel storyModel,
    WisdomModel wisdomModel,
    BreathingModel breathingModel,
    EnvironmentModel environmentModel,
    DiscountModel discountModel,
    List<HabitDto> habitModels,
    List<WorkoutProgressDto> workoutProgressList,
    List<MoodDTO> moodTrackingList,
    String loadProgressError,
    StatementUpdateState statementUpdateState,
    WorkoutOfTheDayState workoutOfTheDayState,
    HabitCompletionState habitCompletionState,
    EnvironmentalPageState environmentalPageState,
    String priority
  }) {
    return ProgressPageModel(
      date: date ?? this.date,
      hexagonState: hexagonState ?? this.hexagonState,
      storyModel: storyModel ?? this.storyModel,
      wisdomModel: wisdomModel ?? this.wisdomModel,
      breathingModel: breathingModel ?? this.breathingModel,
      environmentModel: environmentModel ?? this.environmentModel,
      habitModels: habitModels ?? this.habitModels,
      discountModel: discountModel ?? this.discountModel,
      workoutProgressList: workoutProgressList ?? this.workoutProgressList,
      moodTrackingList: moodTrackingList ?? this.moodTrackingList,
      loadProgressError: loadProgressError ?? this.loadProgressError,
      statementUpdateState: statementUpdateState ?? this.statementUpdateState,
      habitCompletionState: habitCompletionState ?? this.habitCompletionState,
        workoutOfTheDayState: workoutOfTheDayState ?? this.workoutOfTheDayState,
      environmentalPageState: environmentalPageState ?? this.environmentalPageState,
      priority: priority ?? this.priority
    );
  }

  bool isLoading() => workoutProgressList == null;

  bool isInErrorState() => loadProgressError != null;

  // ignore: non_constant_identifier_names
  factory ProgressPageModel.loading(String date) => ProgressPageModel(
    date: date,
    habitModels: [HabitDto()],
    hexagonState: HexagonState(),
    storyModel: StoryModel(),
    wisdomModel: WisdomModel(),
    environmentModel: EnvironmentModel(),
    breathingModel: BreathingModel(),
    statementUpdateState: StatementUpdateState.IDLE,
    habitCompletionState: HabitCompletionState.IDLE,
    environmentalPageState: EnvironmentalPageState.IDLE,
      workoutOfTheDayState: WorkoutOfTheDayState.IDLE,
    moodTrackingList: [],
    discountModel: DiscountModel()
    // workoutProgressList: []
  );

  factory ProgressPageModel.loadProgressError(String error, String date) => ProgressPageModel(
      loadProgressError: error,
      date: date,
      habitModels: [HabitDto()],
      hexagonState: HexagonState(),
      storyModel: StoryModel(),
      wisdomModel: WisdomModel(),
      environmentModel: EnvironmentModel(),
      breathingModel: BreathingModel(),
      statementUpdateState: StatementUpdateState.IDLE,
      habitCompletionState: HabitCompletionState.IDLE,
      environmentalPageState: EnvironmentalPageState.IDLE,
      workoutOfTheDayState: WorkoutOfTheDayState.IDLE,
      moodTrackingList: [],
      discountModel: DiscountModel()
      //  workoutProgressList: []
    );
}
