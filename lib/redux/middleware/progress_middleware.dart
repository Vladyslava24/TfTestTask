import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/redux/actions/profile_actions.dart';
import 'package:totalfit/redux/actions/profile_workout_summary_actions.dart';
import 'package:workout_api/api.dart';
import 'package:core/core.dart';
import 'package:workout_data/data.dart';
import 'package:workout_data_legacy/data.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/dto/habit_dto.dart';
import 'package:totalfit/data/dto/request/update_breath_practice_request.dart';
import 'package:totalfit/data/dto/request/update_progress_request.dart';
import 'package:totalfit/data/dto/response/habit_response.dart';
import 'package:totalfit/data/dto/response/mood_tracking_progress_response.dart';
import 'package:totalfit/data/dto/response/progress_response.dart';
import 'package:totalfit/model/discount_model.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/data/source/local/local_storage.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/data/workout_phase.dart';
import 'package:totalfit/model/active_program.dart';
import 'package:totalfit/model/breathing_model.dart';
import 'package:totalfit/model/environment_model.dart';
import 'package:totalfit/model/loading_state/breathing_page_state.dart';
import 'package:totalfit/model/progress_page_model.dart';
import 'package:totalfit/model/story_model.dart';
import 'package:totalfit/model/wisdom_model.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/redux/actions/progress_actions.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/middleware/storage_middleware.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/ui/utils/utils.dart';
import 'package:workout_use_case/use_case.dart';
import 'package:workout_data_legacy/data.dart' as legacy;
const String discountShowedValue = 'DISCOUNT_SHOWED';

List<Middleware<AppState>> progressMiddleware(
    LocalStorage localStorage, RemoteStorage remoteStorage, WorkoutApi workoutApi, TFLogger logger) {
  final onSaveStoryResultAction = _onSaveStoryResultAction(remoteStorage, logger);
  final onSaveWisdomResultAction = _onSaveWisdomResultAction(remoteStorage, logger);
  final onToggleHabitSelectionAction = _onToggleHabitCompletionAction(remoteStorage, logger);
  final onFetchProgressAction = _onFetchProgressAction(remoteStorage, logger);
  final onRetryLoadingProgressPageAction = _onRetryLoadingProgressPageAction(remoteStorage, logger);
  final onUpdateStatementAction = _onUpdateStatementAction(remoteStorage, logger);
  final loadHabitListMiddleware = _loadHabitListMiddleware(remoteStorage, logger);
  final initProgressMiddleware = _initProgressMiddleware(remoteStorage, workoutApi, logger);
  final onBuildProgressListMiddleware = _onBuildProgressListMiddleware(logger);
  final onUpdateHabitMiddleware = _updateHabitMiddleware(remoteStorage, logger);
  final onUpdateDiscountMiddleware = _updateDiscountMiddleware(logger);
  final onUpdateMoodMiddleware = _updateMoodMiddleware(logger);
  final onViewSummaryAction = _onViewSummaryAction(remoteStorage, workoutApi, logger);

  return [
    TypedMiddleware<AppState, UpdateMoodTracking>(onUpdateMoodMiddleware),
    TypedMiddleware<AppState, SaveStoryResultAction>(onSaveStoryResultAction),
    TypedMiddleware<AppState, SaveWisdomResultAction>(onSaveWisdomResultAction),
    TypedMiddleware<AppState, SaveEnvironmentalResultAction>(_onSaveEnvironmentalResultAction(remoteStorage, logger)),
    TypedMiddleware<AppState, OnToggleHabitCompletionAction>(onToggleHabitSelectionAction),
    TypedMiddleware<AppState, RetryLoadingProgressPageAction>(onRetryLoadingProgressPageAction),
    TypedMiddleware<AppState, FetchProgressAction>(onFetchProgressAction),
    TypedMiddleware<AppState, UpdateStatementAction>(onUpdateStatementAction),
    TypedMiddleware<AppState, LoadHabitListAction>(loadHabitListMiddleware),
    TypedMiddleware<AppState, InitProgressAction>(initProgressMiddleware),
    TypedMiddleware<AppState, BuildProgressListAction>(onBuildProgressListMiddleware),
    TypedMiddleware<AppState, SelectHabitAction>(onUpdateHabitMiddleware),
    TypedMiddleware<AppState, SaveBreathingResultAction>(_onSaveBreathingResultAction(remoteStorage, logger)),
    TypedMiddleware<AppState, DiscountChangeValueAction>(onUpdateDiscountMiddleware),
    TypedMiddleware<AppState, OnViewWorkoutSummaryAction>(onViewSummaryAction),
  ];
}

Middleware<AppState> _updateMoodMiddleware(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_updateMoodMiddleware");
    next(action);
    final moodUpdateAction = action as UpdateMoodTracking;
    next(FetchProgressAction(DateTime.now(), store.state.mainPageState.progressPageIndex));
    await Future.delayed(Duration.zero);
    next(OnUpdateMoodTracking(model: moodUpdateAction.model));
  };
}

Middleware<AppState> _onSaveStoryResultAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onSaveStoryResultAction");
    next(action);
    final updateAction = action as SaveStoryResultAction;
    try {
      final storyModel = store.state.mainPageState.progressPages[updateAction.progressPageIndex].storyModel;
      final request = UpdateProgressRequest(
          workoutProgressId: store.state.workoutState == null ? null : store.state.workoutState.workoutProgressId,
          targetId: storyModel.id,
          dailyProgressStage: 'STORY',
          iWillStatement: updateAction.statement ?? "");
      final response = await remoteStorage.updateProgress(request);

      next(NavigateToProgressAction());
      next(UpdateProgressPageOnSaveStoryAction(
          index: updateAction.progressPageIndex,
          isStoryRead: response.storyDone,
          statements: response.iWillStatements.where((e) => e.statement.isNotEmpty).toList(),
          hexagonState: response.hexagonState));
    } catch (e) {
      next(OnSaveStoryErrorAction(error: 'Failed to update Story state'));
      next(
          ErrorReportAction(where: "_onUpdateProgressAction", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _onToggleHabitCompletionAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onToggleHabitSelectionAction");
    next(action);

    final toggleAction = action as OnToggleHabitCompletionAction;

    try {
      final response =
          await remoteStorage.toggleHabitCompletion(toggleAction.habitProgressId, toggleAction.completed, today());

      if (response.done) {
        next(FetchProgressAction(DateTime.now(), store.state.mainPageState.progressPageIndex));
      }

      next(OnHabitCompletionToggledAction(completed: response.done, habitId: toggleAction.habitProgressId));
    } catch (e) {
      next(OnToggleHabitCompletionErrorAction(error: 'Failed to switch Habit completion'));
      next(ErrorReportAction(
          where: "_onToggleHabitSelectionAction", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _onRetryLoadingProgressPageAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onRetryLoadingProgressPageAction");
    final retryAction = action as RetryLoadingProgressPageAction;

    ///>>>> set loading state for current ProgressPage
    List<ProgressPageModel> prevPages = List.of(store.state.mainPageState.progressPages);
    int index = retryAction.index;
    logger.logInfo("index");
    logger.logInfo(index.toString());
    prevPages.replaceRange(index, index + 1, [ProgressPageModel.loading(prevPages[index].date)]);

    logger.logInfo(prevPages.toString());

    next(SetCurrentProgressPagesAction(progressPages: prevPages));
    if (store.state.mainPageState.workouts == null) {
      next(InitProgressAction());
    } else {
      next(FetchProgressAction(retryAction.date, retryAction.index));
    }
  };
}

Middleware<AppState> _onFetchProgressAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onFetchProgressAction");
    final fetchAction = action as FetchProgressAction;

    try {
      final progressResponse = await remoteStorage.getProgress(formatDateTime(fetchAction.date));
      final moodProgressResponse = await remoteStorage.getMoodTrackingProgress(formatDateTime(fetchAction.date));
      next(BuildProgressListAction(
          progressPageIndex: fetchAction.index,
          progressResponse: progressResponse,
          moodProgressResponse: moodProgressResponse));
    } catch (e) {
      next(ErrorReportAction(where: '_onFetchProgressAction', trigger: action.runtimeType, errorMessage: e.toString()));

      List<ProgressPageModel> pages = List.of(store.state.mainPageState.progressPages);
      int index = fetchAction.index;
      pages.replaceRange(index, index + 1,
          [ProgressPageModel.loadProgressError('Failed to load Progress', formatDateTime(fetchAction.date))]);
      next(SetCurrentProgressPagesAction(progressPages: pages));
    }
  };
}

Middleware<AppState> _initProgressMiddleware(RemoteStorage remoteStorage, WorkoutApi workoutApi, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_initProgressMiddleware");
    final today = formatDateTime(todayDate);
    final pages = store.state.mainPageState.progressPages;
    final todaysProgress = pages.firstWhere((p) => p.date == today, orElse: () => null);
    final index = todaysProgress != null ? pages.indexOf(todaysProgress) : pages.length - 1;
    final workoutListUseCase = DependencyProvider.get<WorkoutListUseCase>();
    Future.wait([
      remoteStorage.getProgress(today),
      workoutApi.fetchWorkouts(),
      _loadProgramProgress(remoteStorage, logger),
      remoteStorage.getMoodTrackingProgress(today),
      workoutListUseCase.getWorkouts(),
    ], eagerError: true)
        .then((resultArray) {
      ProgressResponse progressResponse = resultArray[0];
      final responseWorkouts = List<WorkoutModel>.of(resultArray[4]);
      final workouts = responseWorkouts.map((e) =>
          legacy.WorkoutDto.fromWorkoutV2(e)).toList();
      print('__workouts');
      print(workouts);

      MoodTrackingProgressResponse moodTrackingProgressResponse = resultArray[3];

      final newWorkouts = resultArray[4];

      print('moodTrackingProgressResponse');
      print(moodTrackingProgressResponse);

      progressResponse.moodTrackingData = moodTrackingProgressResponse.objects;

      next(BuildProgressListAction(progressPageIndex: index, progressResponse: progressResponse));
      next(OnWorkoutFetchedAction(workouts, newWorkouts));
      next(OnBuildWorkoutItemListAction(workouts));

      final sortedWorkouts = WorkoutPageHelper.getSortedWorkouts(workouts);
      next(OnWorkoutsSortedAction(sortedWorkouts));

      ///MUST be called after all above actions
      ActiveProgram activeProgram = resultArray[2];
      next(SetActiveProgramAction(program: activeProgram));
      next(SwitchProgramTabAction(showActiveProgram: activeProgram != null));

      ///
    }).catchError((e) {
      logger.logError("$action _initProgressMiddleware ${e.toString()}");
      next(
          ErrorReportAction(where: '_initProgressMiddleware', trigger: action.runtimeType, errorMessage: e.toString()));
      List<ProgressPageModel> pages = List.of(store.state.mainPageState.progressPages);
      pages.replaceRange(index, index + 1, [ProgressPageModel.loadProgressError('Failed to load Progress', today)]);
      next(SetCurrentProgressPagesAction(progressPages: pages));
    });
  };
}

Future<ActiveProgram> _loadProgramProgress(RemoteStorage remoteStorage, TFLogger logger) async {
  final today = formatDateTime(todayDate);
  ActiveProgram activeProgram;
  try {
    var response = await remoteStorage.getCurrentFullProgram(today);

    activeProgram = ActiveProgram(
      allWorkoutsDone: response.allWorkoutsDone,
      daysAWeek: response.daysAWeek,
      difficultyLevel: response.difficultyLevel,
      id: response.id,
      name: response.name,
      schedule: response.schedule,
      numberOfWeeks: response.numberOfWeeks,
      daysOfTheWeek: response.daysOfTheWeek,
      thisWeekWorkouts: response.thisWeekWorkouts,
      maxWeekNumber: response.maxWeekNumber,
      levels: response.levels,
      workoutOfTheDay: response.workoutProgress != null ? response.workoutProgress.workout : null,
      programProgress: response.programProgress,
    );
  } catch (e) {
    logger.logError("_loadProgramProgress in _initProgressMiddleware error : ${e.toString()}");
    if (e is ApiException && e.serverErrorCode != 404) {
      throw e;
    }
  }

  return activeProgram;
}

Middleware<AppState> _onBuildProgressListMiddleware(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onBuildProgressListAction");
    final buildAction = action as BuildProgressListAction;

    final progressResponse = buildAction.progressResponse;

    if (progressResponse.workoutProgress.isEmpty) {
      final workoutProgress = WorkoutProgressDto();
      workoutProgress.workout = progressResponse.recommendedWorkout;
      progressResponse.workoutProgress.add(workoutProgress);
    }

    bool isTodaysProgress = isToday(progressResponse.date);

    if (!isTodaysProgress) {
      progressResponse.workoutProgress =
          progressResponse.workoutProgress.where((p) => p.workoutPhase == WorkoutPhase.FINISHED).toList();
    }

    final storyDto = isTodaysProgress
        ? progressResponse.story
        : progressResponse.storyDone
            ? progressResponse.story
            : null;

    final environmental = EnvironmentModel.fromDto(progressResponse.environmental, isTodaysProgress);
    final storyModel = storyDto != null
        ? StoryModel.fromDto(
            storyDto,
            progressResponse.storyDone,
            !isTodaysProgress
                ? progressResponse.iWillStatements.where((e) => e.completed == true && e.statement.isNotEmpty).toList()
                : progressResponse.iWillStatements.where((e) => e.statement.isNotEmpty).toList())
        : StoryModel.fromDtoNotToday(
            progressResponse.iWillStatements.where((e) => e.completed == true && e.statement.isNotEmpty).toList());
    final wisdomModel = WisdomModel.fromDto(progressResponse.wisdom, progressResponse.wisdomDone);
    BreathingModel breathingModel;
    if (progressResponse.breathPractice != null) {
      breathingModel = BreathingModel.fromDto(progressResponse.breathPractice);
    }
    progressResponse.workoutProgress.sort((a, b) {
      if (a.finished && b.finished) {
        return 0;
      }
      if (a.finished && !b.finished) {
        return -1;
      }
      if (!a.finished && b.finished) {
        return 1;
      }
      return DateTime.parse(a.startedAt).millisecondsSinceEpoch - DateTime.parse(b.startedAt).millisecondsSinceEpoch;
    });

    List<HabitDto> completedHabits;
    if (!isTodaysProgress) {
      completedHabits = progressResponse.habits.where((e) => e.completed).toList();
    }

    final prefs = await SharedPreferences.getInstance();
    final discountEnableValue = prefs.getBool(discountShowedValue) ?? true;

    final progressPageModel = ProgressPageModel(
        workoutProgressList: progressResponse.workoutProgress,
        date: progressResponse.date,
        habitModels: isTodaysProgress
            ? progressResponse.habits
            : completedHabits.isNotEmpty
                ? completedHabits
                : null,
        hexagonState: progressResponse.hexagonState,
        storyModel: isTodaysProgress || storyModel != null ? storyModel : null,
        wisdomModel: isTodaysProgress || wisdomModel.isRead ? wisdomModel : null,
        breathingModel: breathingModel != null
            ? isTodaysProgress || breathingModel.done
                ? breathingModel
                : null
            : null,
        environmentModel: isTodaysProgress || environmental.isDone() ? environmental : null,
        discountModel:
            isTodaysProgress && discountEnableValue != null ? DiscountModel(isShowing: discountEnableValue) : null,
        priority: progressResponse.priority ?? 'Body',
        moodTrackingList: buildAction.moodProgressResponse != null
            ? buildAction.moodProgressResponse.objects
            : progressResponse.moodTrackingData);

    List<ProgressPageModel> pages = List.of(store.state.mainPageState.progressPages);
    int index = buildAction.progressPageIndex;
    if (index == null) {
      pages.removeRange(0, 1);
      pages.add(progressPageModel);
    } else {
      pages.replaceRange(index, index + 1, [progressPageModel]);
    }

    store.dispatch((SetCurrentProgressPagesAction(progressPages: pages, progressPageIndex: action.progressPageIndex)));

    if (store.state.mainPageState.hasActiveProgram != null && store.state.mainPageState.hasActiveProgram) {
      store.dispatch(LoadProgramProgressPageAction());
    }
  };
}

Middleware<AppState> _onSaveEnvironmentalResultAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onSaveEnvironmentalResultAction");
    next(action);
    final updateAction = action as SaveEnvironmentalResultAction;
    try {
      final request = UpdateProgressRequest(
        workoutProgressId: store.state.workoutState == null ? null : store.state.workoutState.workoutProgressId,
        environmentalProgress: updateAction.value,
        dailyProgressStage: 'ENVIRONMENTAL',
      );
      final response = await remoteStorage.updateProgress(request);
      bool isTodaysProgress = isToday(response.date);

      next(UpdateProgressPageOnSaveEnvironmentalAction(
          index: updateAction.progressIndex,
          environmental: EnvironmentModel.fromDto(response.environmental, isTodaysProgress),
          hexagonState: response.hexagonState));
    } catch (e) {
      logger.logError("_onSaveEnvironmentalResultAction in progressMiddleware error : ${e.toString()}");
      next(OnSaveEnvironmentalErrorAction(error: 'Failed to update Environmental state'));
      next(ErrorReportAction(
          where: "_onSaveEnvironmentalResultAction", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _onSaveWisdomResultAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onSaveWisdomResultAction");
    next(action);
    final updateAction = action as SaveWisdomResultAction;
    try {
      final wisdomModel = store.state.mainPageState.progressPages[updateAction.progressPageIndex].wisdomModel;
      final request = UpdateProgressRequest(
          workoutProgressId: store.state.workoutState == null ? null : store.state.workoutState.workoutProgressId,
          targetId: wisdomModel.id,
          dailyProgressStage: 'WISDOM');
      final response = await remoteStorage.updateProgress(request);

      next(NavigateToProgressAction());
      next(UpdateProgressPageOnSaveWisdomAction(
          index: updateAction.progressPageIndex,
          isWisdomRead: response.wisdomDone,
          hexagonState: response.hexagonState));
    } catch (e) {
      logger.logError("_onSaveWisdomResultAction in progressMiddleware error : ${e.toString()}");
      next(OnSaveWisdomErrorAction(error: 'Failed to update Wisdom state'));
      next(
          ErrorReportAction(where: "_onUpdateProgressAction", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _onSaveBreathingResultAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onSaveBreathingResultAction");
    next(action);
    next(ChangeBreathingPageState(BreathingPageState.LOADING));

    final updateAction = action as SaveBreathingResultAction;

    try {
      final breathingModel = store.state.mainPageState.progressPages[updateAction.progressPageIndex].breathingModel;

      if (breathingModel.done) {
        next(ChangeBreathingPageState(BreathingPageState.COMPLETED));
        next(NavigateToProgressAction());
        return;
      }

      final dateTime = DateTime.now();
      final hour = correctDateTimeWithZero(dateTime.hour);
      final minute = correctDateTimeWithZero(dateTime.minute);
      final seconds = correctDateTimeWithZero(dateTime.second);
      final milliseconds = correctMillisecondsWithZero(dateTime.millisecond);
      final createdAt = '$hour:$minute:$seconds.$milliseconds';

      final breathPracticeRequest = UpdateBreathPracticeRequest(
          breathPracticeId: breathingModel.id,
          date: store.state.mainPageState.progressPages[updateAction.progressPageIndex].date,
          createdAt: createdAt);
      final responseBreath = await remoteStorage.updateBreathPractice(breathPracticeRequest);

      if (responseBreath.done) {
        final today = formatDateTime(todayDate);
        final response = await remoteStorage.getProgress(today);

        next(UpdateProgressPageOnSaveBreathingAction(
            index: updateAction.progressPageIndex,
            done: response.breathPractice.done,
            hexagonState: response.hexagonState));

        next(ChangeBreathingPageState(BreathingPageState.COMPLETED));
        next(NavigateToProgressAction());
      } else {
        next(OnSaveBreathingErrorAction(error: 'Failed to update field on Server'));
      }
    } catch (e) {
      next(OnSaveBreathingErrorAction(error: 'Failed to update Breathing state'));
      next(ErrorReportAction(
          where: "_onUpdateProgressAction Breathing Result", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _onUpdateStatementAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onUpdateStatementAction");
    next(action);
    final updateAction = action as UpdateStatementAction;
    try {
      await remoteStorage.updateStatement(updateAction.statement.id, today(), updateAction.statement.completed);
      final progressResponse = await remoteStorage.getProgress(today());
      next(BuildProgressListAction(progressPageIndex: updateAction.progressIndex, progressResponse: progressResponse));
    } catch (e) {
      logger.logInfo('EEE');
      logger.logInfo(e);
      logger.logInfo(e.runtimeType.toString());

      next(
          OnUpdateStatementErrorAction(error: 'Failed to update Statement', progressIndex: updateAction.progressIndex));
      next(
          ErrorReportAction(where: "_onUpdateProgressAction", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _loadHabitListMiddleware(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("loadHabitListMiddleware");
    next(action);

    if (store.state.mainPageState.habitList.isNotEmpty) {
      next(OnHabitListLoadedAction(habitList: List.of(store.state.mainPageState.habitList)));
    } else {
      Future.wait([remoteStorage.getRecommendedHabit(today()), remoteStorage.getHabitList()]).then((resultArray) {
        Habit recommendedHabit = resultArray[0];
        HabitListResponse habitListResponse = resultArray[1];
        next(OnHabitListLoadedAction(habitList: habitListResponse.habitList, recommendedHabit: recommendedHabit));
      }).catchError((e) {
        logger.logError("$action loadHabitListMiddleware ${e.toString()}");
        store.dispatch(OnHabitListLoadingErrorAction(error: 'Failed to load Habit list'));
        next(ErrorReportAction(
            where: 'loadHabitListMiddleware', trigger: action.runtimeType, errorMessage: e.toString()));
      });
    }
  };
}

Middleware<AppState> _updateHabitMiddleware(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_updateHabitMiddleware");
    next(action);
    final selectAction = action as SelectHabitAction;
    try {
      if (selectAction.selected) {
        final habitModel = await remoteStorage.selectHabit(selectAction.habitId, selectAction.date);
        next(OnHabitSelectedAction(dto: habitModel));
      } else {
        await remoteStorage.unSelectHabit(selectAction.habitModelId, selectAction.date);
        next(OnHabitUnSelectedAction(habitId: selectAction.habitId));
      }
    } catch (e) {
      next(OnUpdateHabitErrorAction(error: 'Failed to select Habit'));
      next(ErrorReportAction(where: "_updateHabitMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _updateDiscountMiddleware(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("_onDiscountChangeValueAction");
    next(action);
    final discountChangeAction = action as DiscountChangeValueAction;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(discountShowedValue, discountChangeAction.value);
    } catch (e) {
      next(ErrorReportAction(where: "_updateHabitMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _onViewSummaryAction(RemoteStorage remoteStorage, WorkoutApi workoutApi, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {

    store.dispatch(ShowGlobalProgressLoadingIndicatorAction(true));
    final data = (action as OnViewWorkoutSummaryAction).item;

    try {
      logger.logInfo("$action _onViewProgressAction");

      final ProgressResponse progressResponse = await remoteStorage.getProgress(formatDateTime(data.originDate));
      final WorkoutProgressDto progress = progressResponse.workoutProgress
          .firstWhere((p) => p.id == data.workoutProgressId.toString(), orElse: () => null);
      final legacy.WorkoutDto workout = await workoutApi.fetchWorkout(progress.workout.id);

      WorkoutSummaryPayload workoutSummaryPayload = WorkoutSummaryPayload(
        id: workout.id.toString(),
        moveToProgressOnClose: false,
        workoutDuration: progress.workoutDuration,
        warmupStageDuration: progress.warmupStageDuration,
        wodStageDuration: progress.wodStageDuration,
        cooldownStageDuration: progress.cooldownStageDuration,
        roundCount: progress.roundCount,
        stageProgress: progress.stageProgress,
        workoutModel: WorkoutModel(
          id: workout.id.toString(),
          theme: workout.theme,
          image: workout.image,
          difficultyLevel: workout.difficultyLevel,
          estimatedTime: workout.estimatedTime,
          plan: "",
          badge: "",
          priorityStage: fromStringToWorkoutStageEnum(workout.priorityStage),
          equipment: workout.equipment,
          stages: List<WorkoutStageModel>.from(workout.stages.map((WorkoutStageDto x) => WorkoutStageModel(
                stageName: fromStringToWorkoutStageEnum(x.stageName),
                stageType: fromStringToWorkoutStageTypeEnum(x.stageType),
                exercises: List<ExerciseModel>.from(x.exercises.map((e) => ExerciseModel(
                      type: e.type,
                      video480: e.video480,
                      video720: e.video720,
                      video1080: e.video1080,
                      tag: e.tag,
                      metrics: e.metrics,
                      name: e.name,
                      quantity: e.quantity,
                      image: e.image,
                      videoVertical: e.videoVertical,
                    ))),
                stageOption: StageOption(
                  metricType: x.stageOption.metricType,
                  metricQuantity: x.stageOption.metricQuantity,
                  rests: List<Rest>.from(x.stageOption.rests.map((e) => Rest(order: e.order, quantity: e.quantity))),
                ),
              ))),
        ),
      );

      store.dispatch(ShowGlobalProgressLoadingIndicatorAction(false));

      store.dispatch(NavigateToWorkoutFlowScreenWithBundleAction(bundle: workoutSummaryPayload));

      next(action);
    } catch (e) {
      store.dispatch(ShowGlobalProgressLoadingIndicatorAction(false));
      store.dispatch(OnWorkoutSummaryLoadError(e.toString()));
      logger.logError("$action _onViewProgressAction ${e.toString()}");
      next(ErrorReportAction(where: "profileMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}
