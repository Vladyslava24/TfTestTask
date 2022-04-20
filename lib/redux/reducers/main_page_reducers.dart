import 'package:redux/redux.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/model/loading_state/breathing_page_state.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:totalfit/model/progress_page_model.dart';
import 'package:totalfit/model/purchase_item.dart';
import 'package:totalfit/redux/actions/auth_actions.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/navigation_actions.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/actions/purchase_actions.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/states/main_page_state.dart';
import 'package:totalfit/ui/screen/main/main_screen.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/model/loading_state/environmental_page_state.dart';
import 'package:totalfit/model/loading_state/habit_page_state.dart';
import 'package:totalfit/model/loading_state/habit_completion_state.dart';
import 'package:totalfit/model/loading_state/statement_update_state.dart';
import 'package:totalfit/model/loading_state/statement_page_state.dart';
import 'package:totalfit/model/loading_state/wisdom_page_state.dart';
import 'package:totalfit/ui/screen/main/workout/main/inner_pages/sorted_exercises_page.dart';

final mainPageReducer = combineReducers<MainPageState>([
  TypedReducer<MainPageState, OnWorkoutFetchedAction>(_onWorkoutFetchedAction),
  TypedReducer<MainPageState, UpdateUserStateAction>(_onUpdateUserStateAction),
  TypedReducer<MainPageState, NavigateToExerciseVideoPage>(_onShowExercisePreviewVideoPageAction),
  TypedReducer<MainPageState, RemoveExerciseVideoPageAction>(_onRemoveExerciseVideoPageAction),
  TypedReducer<MainPageState, OnBasicWorkoutLoadedAction>(_onBasicWorkoutLoadedAction),
  TypedReducer<MainPageState, ChangeSelectedVideoStateAction>(onChangeSelectedVideoStateAction),
  TypedReducer<MainPageState, UpdateSelectedTab>(_onUpdateSelectedTab),
  TypedReducer<MainPageState, OnExercisesSortedAction>(_onExercisesSortedAction),
  TypedReducer<MainPageState, OnWorkoutsSortedAction>(_onWorkoutsSortedAction),
  TypedReducer<MainPageState, OnWorkoutItemListBuiltAction>(_onWorkoutItemListBuiltAction),
  TypedReducer<MainPageState, SetCurrentProgressPagesAction>(_onSetCurrentProgressAction),
  TypedReducer<MainPageState, UpdateProgressPageOnSaveStoryAction>(_onUpdateProgressPageOnSaveStoryAction),
  TypedReducer<MainPageState, UpdateProgressPageOnSaveWisdomAction>(_onUpdateProgressPageOnSaveWisdomAction),
  TypedReducer<MainPageState, UpdateProgressPageOnSaveBreathingAction>(_onUpdateProgressPageOnSaveBreathingAction),
  TypedReducer<MainPageState, UpdateProgressPageOnSaveEnvironmentalAction>(
      _updateProgressPageOnSaveEnvironmentalAction),
  TypedReducer<MainPageState, OnUpdateStatementErrorAction>(_onUpdateStatementErrorAction),
  TypedReducer<MainPageState, OnToggleHabitCompletionErrorAction>(_onToggleHabitCompletionErrorAction),
  TypedReducer<MainPageState, OnHabitCompletionToggledAction>(_onHabitCompletionToggledAction),
  TypedReducer<MainPageState, RemoveUpdateStatementErrorAction>(_onRemoveUpdateStatementErrorAction),
  TypedReducer<MainPageState, RemoveHabitCompletionToggleErrorAction>(_onRemoveHabitCompletionToggleErrorAction),
  TypedReducer<MainPageState, RemoveEnvironmentalToggleErrorToggleErrorAction>(
      _onRemoveEnvironmentalToggleErrorToggleErrorAction),
  TypedReducer<MainPageState, UpdateStatementAction>(_onUpdateStatementAction),
  TypedReducer<MainPageState, SaveEnvironmentalResultAction>(_onSaveEnvironmentalAction),
  TypedReducer<MainPageState, SaveStoryResultAction>(_onSaveStoryResultAction),
  TypedReducer<MainPageState, SaveWisdomResultAction>(_onSaveWisdomResultAction),
  TypedReducer<MainPageState, OnSaveStoryErrorAction>(_onSaveStoryErrorAction),
  TypedReducer<MainPageState, OnSaveWisdomErrorAction>(_onSaveWisdomErrorAction),
  TypedReducer<MainPageState, OnSaveBreathingErrorAction>(_onSaveBreathingErrorAction),
  TypedReducer<MainPageState, OnSaveEnvironmentalErrorAction>(_onSaveEnvironmentalErrorAction),
  TypedReducer<MainPageState, UpdateProgressPageOnToggleStatementAction>(_onUpdateProgressPageOnToggleStatementAction),
  TypedReducer<MainPageState, OnToggleHabitCompletionAction>(_onToggleHabitCompletionAction),
  TypedReducer<MainPageState, OnChangeWODLoadingAction>(_onToggleWODLoadingAction),
  TypedReducer<MainPageState, OnHabitListLoadedAction>(_onHabitListLoadedAction),
  TypedReducer<MainPageState, OnHabitListLoadingErrorAction>(_onHabitListLoadingErrorAction),
  TypedReducer<MainPageState, LoadHabitListAction>(_onLoadHabitListAction),
  TypedReducer<MainPageState, NavigateToProgressAction>(_onNavigateToProgress),
  TypedReducer<MainPageState, IncrementProgressPageIndex>(_onIncrementProgressPageIndex),
  TypedReducer<MainPageState, DecrementProgressPageIndex>(_onDecrementProgressPageIndex),
  TypedReducer<MainPageState, LogoutAction>(_onLogoutAction),
  TypedReducer<MainPageState, OnHabitSelectedAction>(_onHabitSelectedAction),
  TypedReducer<MainPageState, OnHabitUnSelectedAction>(_onHabitUnSelectedAction),
  TypedReducer<MainPageState, SelectHabitAction>(_onSelectHabitAction),
  TypedReducer<MainPageState, OnUpdateHabitErrorAction>(_onUpdateHabitErrorAction),
  TypedReducer<MainPageState, NavigateToHabitPageAction>(_onNavigateToHabitPageAction),
  TypedReducer<MainPageState, OnLoadSortedExercisesErrorAction>(_onLoadSortedExercisesErrorAction),
  TypedReducer<MainPageState, LoadExerciseListAction>(_onLoadExerciseListAction),
  TypedReducer<MainPageState, OnExercisesSortedAction>(_onExercisesSortedAction),
  TypedReducer<MainPageState, SwitchProgramTabAction>(_setHasActiveProgramAction),
  TypedReducer<MainPageState, OnProgramFinishedAction>(_onProgramFinishedAction),
  TypedReducer<MainPageState, UpdateWorkoutProgressOnProgramStartAction>(_onUpdateWorkoutProgressOnProgramStartAction),
  TypedReducer<MainPageState, UpdatePurchaserInfoAction>(_updatePurchaserInfo),
  TypedReducer<MainPageState, UpdatePurchaseItemListAction>(_updatePurchaseItemList),
  TypedReducer<MainPageState, SetDiscountProduct>(_setDiscountProduct),
  TypedReducer<MainPageState, OnPurchaseErrorAction>(_onPurchaseError),
  TypedReducer<MainPageState, ClearPurchaseErrorAction>(_onClearPurchaseError),
  TypedReducer<MainPageState, MockChangePremiumStatusAction>(_mockPurchaserInfo),
  TypedReducer<MainPageState, ChangeBreathingPageState>(_changeBreathingPageState),
  TypedReducer<MainPageState, UpdateHexagonAction>(_onUpdateHexagonAction),
  TypedReducer<MainPageState, OnUpdateMoodTracking>(_onUpdateMoodTracking),
  TypedReducer<MainPageState, ShowGlobalProgressLoadingIndicatorAction>(_showLoadingIndicatorAction),
  TypedReducer<MainPageState, OnWorkoutSummaryLoadError>(_onWorkoutSummaryLoadError),
]);

MainPageState _onWorkoutSummaryLoadError(MainPageState state, OnWorkoutSummaryLoadError action) =>
    state.copyWith(error: action.error);

MainPageState _showLoadingIndicatorAction(MainPageState state, ShowGlobalProgressLoadingIndicatorAction action) =>
    state.copyWith(showLoadingIndicator: action.showLoadingIndicator);

MainPageState _onUpdateMoodTracking(MainPageState state, OnUpdateMoodTracking action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate[state.progressPageIndex].moodTrackingList.add(action.model);
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _updatePurchaseItemList(MainPageState state, UpdatePurchaseItemListAction action) {
  List<PurchaseItem> sortedItems = List.of(action.items);
  sortedItems.sort((a, b) => b.itemType.index - a.itemType.index);
  return state.copyWith(purchaseItems: sortedItems);
}

MainPageState _setDiscountProduct(MainPageState state, SetDiscountProduct action) {
  return state.copyWith(discountProduct: action.item);
}

MainPageState _updatePurchaserInfo(MainPageState state, UpdatePurchaserInfoAction action) {
  return state.copyWith(purchaserInfo: action.purchaserInfo);
}

MainPageState _mockPurchaserInfo(MainPageState state, MockChangePremiumStatusAction action) {
  return state.copyWith(purchaserInfo: action.purchaserInfo);
}

MainPageState _onPurchaseError(MainPageState state, OnPurchaseErrorAction action) {
  return state.copyWith(purchaseError: action.exception);
}

MainPageState _onClearPurchaseError(MainPageState state, ClearPurchaseErrorAction action) {
  return state.copyWith(purchaseError: IdleException());
}

MainPageState _onLogoutAction(MainPageState state, LogoutAction action) {
  return MainPageState.initial();
}

MainPageState _onIncrementProgressPageIndex(MainPageState state, IncrementProgressPageIndex action) {
  return state.copyWith(progressPageIndex: state.progressPageIndex + 1);
}

MainPageState _setHasActiveProgramAction(MainPageState state, SwitchProgramTabAction action) =>
    state.copyWith(hasActiveProgram: action.showActiveProgram);

MainPageState _onProgramFinishedAction(MainPageState state, OnProgramFinishedAction action) =>
    state.copyWith(hasActiveProgram: false);

MainPageState _onDecrementProgressPageIndex(MainPageState state, DecrementProgressPageIndex action) {
  return state.copyWith(progressPageIndex: state.progressPageIndex - 1);
}

MainPageState _onHabitListLoadingErrorAction(MainPageState state, OnHabitListLoadingErrorAction action) {
  return state.copyWith(habitPageState: HabitPageState.error(action.error));
}

MainPageState _onUpdateHabitErrorAction(MainPageState state, OnUpdateHabitErrorAction action) {
  return state.copyWith(habitPageState: HabitPageState.error(action.error));
}

MainPageState _onLoadHabitListAction(MainPageState state, LoadHabitListAction action) {
  return state.copyWith(habitPageState: HabitPageState.LOADING);
}

MainPageState _onSelectHabitAction(MainPageState state, SelectHabitAction action) {
  return state.copyWith(habitPageState: HabitPageState.LOADING);
}

MainPageState _onHabitListLoadedAction(MainPageState state, OnHabitListLoadedAction action) {
  return state.copyWith(
      habitList: action.habitList, recommendedHabit: action.recommendedHabit, habitPageState: HabitPageState.COMPLETED);
}

MainPageState _onSaveStoryErrorAction(MainPageState state, OnSaveStoryErrorAction action) {
  return state.copyWith(statementPageState: StatementPageState.error(action.error));
}

MainPageState _onSaveWisdomErrorAction(MainPageState state, OnSaveWisdomErrorAction action) {
  return state.copyWith(wisdomPageState: WisdomPageState.error(action.error));
}

MainPageState _onSaveBreathingErrorAction(MainPageState state, OnSaveBreathingErrorAction action) {
  return state.copyWith(breathingPageState: BreathingPageState.error(action.error));
}

MainPageState _onSaveStoryResultAction(MainPageState state, SaveStoryResultAction action) {
  return state.copyWith(statementPageState: StatementPageState.LOADING);
}

MainPageState _onToggleWODLoadingAction(MainPageState state, OnChangeWODLoadingAction action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate.last = listToUpdate.last.copyWith(workoutOfTheDayState: action.workoutOfTheDayState);
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onToggleHabitCompletionAction(MainPageState state, OnToggleHabitCompletionAction action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate.last = listToUpdate.last.copyWith(habitCompletionState: HabitCompletionState.UPDATING);
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onSaveWisdomResultAction(MainPageState state, SaveWisdomResultAction action) {
  return state.copyWith(wisdomPageState: WisdomPageState.LOADING);
}

MainPageState _onUpdateProgressPageOnSaveStoryAction(MainPageState state, UpdateProgressPageOnSaveStoryAction action) {
  final listToUpdate = List.of(state.progressPages);
  final page = listToUpdate[action.index];
  final storyModel = page.storyModel.copyWith(isRead: action.isStoryRead, statements: action.statements);
  listToUpdate[action.index] = page.copyWith(hexagonState: action.hexagonState, storyModel: storyModel);

  return state.copyWith(progressPages: listToUpdate, statementPageState: StatementPageState.COMPLETED);
}

MainPageState _updateProgressPageOnSaveEnvironmentalAction(
    MainPageState state, UpdateProgressPageOnSaveEnvironmentalAction action) {
  final listToUpdate = List.of(state.progressPages);
  ProgressPageModel page = listToUpdate[action.index];
  listToUpdate[action.index] = page.copyWith(
      hexagonState: action.hexagonState,
      environmentModel: action.environmental,
      environmentalPageState: EnvironmentalPageState.IDLE);

  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onUpdateWorkoutProgressOnProgramStartAction(
    MainPageState state, UpdateWorkoutProgressOnProgramStartAction action) {
  final listToUpdate = List.of(state.progressPages);
  ProgressPageModel page = listToUpdate.last;
  final workoutProgressList = List.of(page.workoutProgressList);
  workoutProgressList.add(action.progress);
  listToUpdate.last = page.copyWith(workoutProgressList: workoutProgressList);
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onUpdateProgressPageOnSaveWisdomAction(
    MainPageState state, UpdateProgressPageOnSaveWisdomAction action) {
  final listToUpdate = List.of(state.progressPages);
  ProgressPageModel page = listToUpdate[action.index];
  final wisdomModel = page.wisdomModel.copyWith(isRead: action.isWisdomRead);
  listToUpdate[action.index] = page.copyWith(hexagonState: action.hexagonState, wisdomModel: wisdomModel);

  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onUpdateHexagonAction(MainPageState state, UpdateHexagonAction action) {
  final listToUpdate = List.of(state.progressPages);
  ProgressPageModel page = listToUpdate[action.index];
  final hs = state.progressPages[action.index].hexagonState;
  listToUpdate[action.index] = page.copyWith(hexagonState: hs);
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onUpdateProgressPageOnSaveBreathingAction(
    MainPageState state, UpdateProgressPageOnSaveBreathingAction action) {
  final listToUpdate = List.of(state.progressPages);
  ProgressPageModel page = listToUpdate[action.index];
  final breathingModel = page.breathingModel.copyWith(done: action.done);
  listToUpdate[action.index] = page.copyWith(hexagonState: action.hexagonState, breathingModel: breathingModel);

  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onUpdateProgressPageOnToggleStatementAction(
    MainPageState state, UpdateProgressPageOnToggleStatementAction action) {
  final listToUpdate = List.of(state.progressPages);

  final storyModel = listToUpdate[action.index].storyModel;
  final statementsToUpdate = List.of(storyModel.statements);
  statementsToUpdate.firstWhere((e) => e.id == action.statementId).completed = action.isStatementCompleted;
  final updatedStoryModel = storyModel.copyWith(statements: statementsToUpdate);

  listToUpdate[action.index] = listToUpdate[action.index]
      .copyWith(statementUpdateState: StatementUpdateState.IDLE, storyModel: updatedStoryModel);

  return state.copyWith(progressPages: listToUpdate, statementPageState: StatementPageState.COMPLETED);
}

MainPageState _onHabitCompletionToggledAction(MainPageState state, OnHabitCompletionToggledAction action) {
  final listToUpdate = List.of(state.progressPages);

  final habitModels = List.of(listToUpdate.last.habitModels);
  habitModels.map((e) => e.id == action.habitId ? e.completed = action.completed : e).toList();
  habitModels.sort((a, b) => b.id.compareTo(a.id));
  listToUpdate.last =
      listToUpdate.last.copyWith(habitCompletionState: HabitCompletionState.IDLE, habitModels: habitModels);

  return state.copyWith(
    progressPages: listToUpdate,
  );
}

MainPageState _onSaveEnvironmentalAction(MainPageState state, SaveEnvironmentalResultAction action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate[action.progressIndex] =
      listToUpdate[action.progressIndex].copyWith(environmentalPageState: EnvironmentalPageState.UPDATING);
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onSaveEnvironmentalErrorAction(MainPageState state, OnSaveEnvironmentalErrorAction action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate.last = listToUpdate.last.copyWith(environmentalPageState: EnvironmentalPageState.error(action.error));
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onUpdateStatementErrorAction(MainPageState state, OnUpdateStatementErrorAction action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate[action.progressIndex] =
      listToUpdate[action.progressIndex].copyWith(statementUpdateState: StatementUpdateState.error(action.error));
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onToggleHabitCompletionErrorAction(MainPageState state, OnToggleHabitCompletionErrorAction action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate.last = listToUpdate.last.copyWith(habitCompletionState: HabitCompletionState.error(action.error));
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onUpdateStatementAction(MainPageState state, UpdateStatementAction action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate[action.progressIndex] =
      listToUpdate[action.progressIndex].copyWith(statementUpdateState: StatementUpdateState.UPDATING);
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onHabitSelectedAction(MainPageState state, OnHabitSelectedAction action) {
  final listToUpdate = List.of(state.progressPages);
  final habitModels = List.of(listToUpdate.last.habitModels);

  HabitDto model = habitModels.firstWhere((e) => e.habit.id == action.dto.habit.id, orElse: () => null);
  if (model != null) {
    model.chosen = action.dto.chosen;
  } else {
    habitModels.insert(0, action.dto);
  }

  final pageWithUpdatedHabits = listToUpdate.last.copyWith(habitModels: habitModels);
  listToUpdate.last = pageWithUpdatedHabits;
  return state.copyWith(progressPages: listToUpdate, habitPageState: HabitPageState.COMPLETED);
}

MainPageState _onHabitUnSelectedAction(MainPageState state, OnHabitUnSelectedAction action) {
  final listToUpdate = List.of(state.progressPages);
  final habitModels = List.of(listToUpdate.last.habitModels);

  habitModels.removeWhere((e) => e.habit.id == action.habitId);
  final pageWithUpdatedHabits = listToUpdate.last.copyWith(habitModels: habitModels);
  listToUpdate.last = pageWithUpdatedHabits;
  return state.copyWith(progressPages: listToUpdate, habitPageState: HabitPageState.COMPLETED);
}

MainPageState _onRemoveUpdateStatementErrorAction(MainPageState state, RemoveUpdateStatementErrorAction action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate[action.progressIndex] =
      listToUpdate[action.progressIndex].copyWith(statementUpdateState: StatementUpdateState.IDLE);
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onRemoveHabitCompletionToggleErrorAction(
    MainPageState state, RemoveHabitCompletionToggleErrorAction action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate.last = listToUpdate.last.copyWith(habitCompletionState: HabitCompletionState.IDLE);
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onRemoveEnvironmentalToggleErrorToggleErrorAction(
    MainPageState state, RemoveEnvironmentalToggleErrorToggleErrorAction action) {
  final listToUpdate = List.of(state.progressPages);
  listToUpdate.last = listToUpdate.last.copyWith(environmentalPageState: EnvironmentalPageState.IDLE);
  return state.copyWith(progressPages: listToUpdate);
}

MainPageState _onSetCurrentProgressAction(MainPageState state, SetCurrentProgressPagesAction action) {
  return state.copyWith(progressPages: action.progressPages, progressPageIndex: action.progressPageIndex);
}


MainPageState _onWorkoutsSortedAction(MainPageState state, OnWorkoutsSortedAction action) {
  return state.copyWith(sortedWorkouts: action.workouts);
}

MainPageState _onWorkoutFetchedAction(MainPageState state, OnWorkoutFetchedAction action) =>
    state.copyWith(workouts: action.workouts, newWorkouts: action.newWorkouts);

MainPageState _onWorkoutItemListBuiltAction(MainPageState state, OnWorkoutItemListBuiltAction action) =>
    state.copyWith(workoutItemList: action.workoutItemList);

MainPageState _onUpdateUserStateAction(MainPageState state, UpdateUserStateAction action) {
  if (action.user == null) {
    return state;
  }
  return state.copyWith(userEmail: action.user.email);
}

MainPageState _onUpdateSelectedTab(MainPageState state, UpdateSelectedTab action) =>
  state.copyWith(selectedTab: action.tab);

MainPageState _onShowExercisePreviewVideoPageAction(MainPageState state, NavigateToExerciseVideoPage action) =>
    state.copyWith(selectedExercise: action.exercise);

MainPageState _onRemoveExerciseVideoPageAction(MainPageState state, RemoveExerciseVideoPageAction action) =>
    state.copyWith(selectedExercise: null);

MainPageState _onBasicWorkoutLoadedAction(MainPageState state, OnBasicWorkoutLoadedAction action) =>
    state.copyWith(basicWorkoutListItems: action.basicWorkoutListItems);

MainPageState onChangeSelectedVideoStateAction(MainPageState state, ChangeSelectedVideoStateAction action) =>
    state.copyWith(isSelectedExercisePlaying: action.isPlaying);

MainPageState _onNavigateToProgress(MainPageState state, NavigateToProgressAction action) =>
   state.copyWith(selectedTab: BottomTab.Progress);

MainPageState _onNavigateToHabitPageAction(MainPageState state, NavigateToHabitPageAction action) {
  return state.copyWith(habitPageState: HabitPageState.INITIAL);
}

MainPageState _onLoadSortedExercisesErrorAction(MainPageState state, OnLoadSortedExercisesErrorAction action) {
  return state.copyWith(sortedExercisePageState: SortedExercisePageState.error(action.error));
}

MainPageState _onLoadExerciseListAction(MainPageState state, LoadExerciseListAction action) {
  return state.copyWith(sortedExercisePageState: SortedExercisePageState.LOADING);
}

MainPageState _onExercisesSortedAction(MainPageState state, OnExercisesSortedAction action) {
  return state.copyWith(sortedExercises: action.exercises, sortedExercisePageState: SortedExercisePageState.COMPLETED);
}

MainPageState _changeBreathingPageState(MainPageState state, ChangeBreathingPageState action) {
  return state.copyWith(breathingPageState: action.breathingPageState);
}
