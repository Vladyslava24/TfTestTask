import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:totalfit/ui/screen/main/main_screen.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/loading_state/breathing_page_state.dart';
import 'package:totalfit/model/progress_page_model.dart';
import 'package:totalfit/model/workout_preview_list_items.dart';
import 'package:totalfit/model/purchase_item.dart';
import 'package:totalfit/model/loading_state/habit_page_state.dart';
import 'package:totalfit/model/loading_state/statement_page_state.dart';
import 'package:totalfit/model/loading_state/wisdom_page_state.dart';
import 'package:totalfit/ui/screen/main/workout/main/inner_pages/sorted_exercises_page.dart';
import 'package:totalfit/ui/utils/utils.dart';
import 'package:totalfit/ui/screen/main/progress/progress_view_pager.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:workout_use_case/use_case.dart';

class MainPageState {
  final String userEmail;
  final List workoutItemList;
  final List<WorkoutDto> workouts;
  final List<WorkoutModel> newWorkouts;
  final BottomTab selectedTab;
  final List<ProgressPageModel> progressPages;
  final List<Habit> habitList;
  final Habit recommendedHabit;
  final Exercise selectedExercise;
  final bool isSelectedExercisePlaying;
  final List<BasicWorkoutListItem> basicWorkoutListItems;
  final Map<String, Set<Exercise>> sortedExercises;
  final List<WorkoutDto> sortedWorkouts;
  final StatementPageState statementPageState;
  final WisdomPageState wisdomPageState;
  final BreathingPageState breathingPageState;
  final HabitPageState habitPageState;
  final SortedExercisePageState sortedExercisePageState;
  final String error;
  final int progressPageIndex;
  final bool hasActiveProgram;
  final PurchaserInfo purchaserInfo;
  final List<PurchaseItem> purchaseItems;
  final TfException purchaseError;
  final PurchaseItem discountProduct;
  final bool showLoadingIndicator;

  MainPageState(this.userEmail,
      {@required this.workoutItemList,
      @required this.workouts,
      @required this.newWorkouts,
      @required this.selectedTab,
      @required this.progressPages,
      @required this.habitList,
      @required this.recommendedHabit,
      @required this.selectedExercise,
      @required this.isSelectedExercisePlaying,
      @required this.sortedExercises,
      @required this.sortedWorkouts,
      @required this.basicWorkoutListItems,
      @required this.statementPageState,
      @required this.wisdomPageState,
      @required this.breathingPageState,
      @required this.habitPageState,
      @required this.sortedExercisePageState,
      @required this.error,
      @required this.progressPageIndex,
      @required this.hasActiveProgram,
      @required this.purchaserInfo,
      @required this.purchaseItems,
      @required this.purchaseError,
      @required this.showLoadingIndicator,
        @required this.discountProduct});

  factory MainPageState.initial() {
    int now = DateTime.now().millisecondsSinceEpoch;
    List<ProgressPageModel> progressPages = List.generate(
        PROGRESS_STUB_PAGES_COUNT,
        (index) =>
            ProgressPageModel.loading(getDayFromMillis(now - (PROGRESS_STUB_PAGES_COUNT - 1 - index) * DAY_IN_MILLIS)));

    return MainPageState(
      null,
      recommendedHabit: null,
      workoutItemList: null,
      workouts: null,
      progressPages: progressPages,
      selectedTab: BottomTab.Progress,
      selectedExercise: null,
      isSelectedExercisePlaying: false,
      basicWorkoutListItems: null,
      sortedExercises: {},
      habitList: [],
      sortedWorkouts: [],
      wisdomPageState: WisdomPageState.INITIAL,
      breathingPageState: BreathingPageState.INITIAL,
      statementPageState: StatementPageState.INITIAL,
      habitPageState: HabitPageState.INITIAL,
      sortedExercisePageState: SortedExercisePageState.INITIAL,
      error: "",
      purchaseError: IdleException(),
      hasActiveProgram: null,
      purchaserInfo: null,
      purchaseItems: [],
      progressPageIndex: PROGRESS_STUB_PAGES_COUNT - 1,
      discountProduct: null,
      showLoadingIndicator: false,
    );
  }

  MainPageState copyWith(
      {String notificationPayload,
      String userEmail,
      List<dynamic> innerPageStack,
      List workoutItemList,
      List<WorkoutDto> workouts,
      List<WorkoutModel> newWorkouts,
      List<ProgressPageModel> progressPages,
      BottomTab selectedTab,
      Exercise selectedExercise,
      bool isSelectedExercisePlaying,
      List<BasicWorkoutListItem> basicWorkoutListItems,
      Map<String, Set<Exercise>> sortedExercises,
      List<WorkoutDto> sortedWorkouts,
      List<Habit> habitList,
      Habit recommendedHabit,
      StatementPageState statementPageState,
      WisdomPageState wisdomPageState,
      BreathingPageState breathingPageState,
      HabitPageState habitPageState,
      SortedExercisePageState sortedExercisePageState,
      String error,
      int progressPageIndex,
      PurchaserInfo purchaserInfo,
      TfException purchaseError,
      List<PurchaseItem> purchaseItems,
      bool hasActiveProgram,
      PurchaseItem discountProduct,
      bool showLoadingIndicator,
      }) {
    return MainPageState(userEmail ?? this.userEmail,
        workoutItemList: workoutItemList ?? this.workoutItemList,
        selectedExercise: selectedExercise ?? this.selectedExercise,
        workouts: workouts ?? this.workouts,
        newWorkouts: newWorkouts ?? this.newWorkouts,
        selectedTab: selectedTab ?? this.selectedTab,
        sortedExercises: sortedExercises ?? this.sortedExercises,
        sortedWorkouts: sortedWorkouts ?? this.sortedWorkouts,
        habitList: habitList ?? this.habitList,
        recommendedHabit: recommendedHabit ?? this.recommendedHabit,
        error: error ?? this.error,
        habitPageState: habitPageState ?? this.habitPageState,
        progressPages: progressPages ?? this.progressPages,
        statementPageState: statementPageState ?? this.statementPageState,
        wisdomPageState: wisdomPageState ?? this.wisdomPageState,
        breathingPageState: breathingPageState ?? this.breathingPageState,
        sortedExercisePageState:
            sortedExercisePageState ?? this.sortedExercisePageState,
        isSelectedExercisePlaying:
            isSelectedExercisePlaying ?? this.isSelectedExercisePlaying,
        basicWorkoutListItems:
            basicWorkoutListItems ?? this.basicWorkoutListItems,
        progressPageIndex: progressPageIndex ?? this.progressPageIndex,
        hasActiveProgram: hasActiveProgram ?? this.hasActiveProgram,
        purchaseError: purchaseError ?? this.purchaseError,
        purchaserInfo: purchaserInfo ?? this.purchaserInfo,
        purchaseItems: purchaseItems ?? this.purchaseItems,
      discountProduct: discountProduct ?? this.discountProduct,
      showLoadingIndicator: showLoadingIndicator ?? this.showLoadingIndicator,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MainPageState &&
          runtimeType == other.runtimeType &&
          selectedExercise == other.selectedExercise &&
          userEmail == other.userEmail &&
          selectedTab == other.selectedTab &&
          isSelectedExercisePlaying == other.isSelectedExercisePlaying &&
          error == other.error &&
          habitPageState == other.habitPageState &&
          statementPageState == other.statementPageState &&
          wisdomPageState == other.wisdomPageState &&
          breathingPageState == other.breathingPageState &&
          sortedExercisePageState == other.sortedExercisePageState &&
          progressPageIndex == other.progressPageIndex &&
          hasActiveProgram == other.hasActiveProgram &&
          recommendedHabit == other.recommendedHabit &&
          purchaserInfo == other.purchaserInfo &&
          purchaseError == other.purchaseError &&
          discountProduct == other.discountProduct &&
          showLoadingIndicator == other.showLoadingIndicator &&
          deepEquals(habitList, other.habitList) &&
          deepEquals(purchaseItems, other.purchaseItems) &&
          deepEquals(basicWorkoutListItems, other.basicWorkoutListItems) &&
          deepEquals(progressPages, other.progressPages) &&
          deepEquals(workouts, other.workouts) &&
          deepEquals(workoutItemList, other.workoutItemList);

  @override
  int get hashCode =>
      userEmail.hashCode ^
      selectedExercise.hashCode ^
      selectedTab.hashCode ^
      isSelectedExercisePlaying.hashCode ^
      statementPageState.hashCode ^
      wisdomPageState.hashCode ^
      breathingPageState.hashCode ^
      error.hashCode ^
      showLoadingIndicator.hashCode ^
      habitPageState.hashCode ^
      sortedExercisePageState.hashCode ^
      purchaseError.hashCode ^
      progressPageIndex.hashCode ^
      recommendedHabit.hashCode ^
      purchaserInfo.hashCode ^
      hasActiveProgram.hashCode ^
      discountProduct.hashCode ^
      deepHash(purchaseItems) ^
      deepHash(habitList) ^
      deepHash(basicWorkoutListItems) ^
      deepHash(progressPages) ^
      deepHash(workouts) ^
      deepHash(workoutItemList);
}
