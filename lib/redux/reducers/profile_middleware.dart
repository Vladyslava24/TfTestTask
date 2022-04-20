import 'package:core/src/utils/string_utils.dart';
import 'package:totalfit/data/dto/response/progress_response.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/model/loading_state/workout_of_the_day_state.dart';
import 'package:workout_api/api.dart';
import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/profile/pagination_data.dart';
import 'package:totalfit/model/profile/profile_statistics.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/actions/workout_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/redux/actions/profile_actions.dart';
import 'package:totalfit/model/profile/profile_error_type.dart';
import 'package:totalfit/redux/actions/profile_share_workout_results_actions.dart';
import 'package:totalfit/model/profile_share_workout_results_bundle.dart';
import 'package:totalfit/redux/actions/profile_workout_summary_actions.dart';
import 'package:totalfit/model/progress_list_items.dart';
import 'package:workout_data/data.dart';
import 'package:workout_data_legacy/data.dart' as legacy;
import 'package:workout_use_case/use_case.dart';

import '../../model/profile/list_items.dart';
import '../../data/dto/response/profile_completed_workout_item_response.dart';
import 'package:workout_ui/src/common/time_utils.dart';
const _pageSize = 20;

List<Middleware<AppState>> profileMiddleware(RemoteStorage remoteStorage, WorkoutApi workoutApi, TFLogger logger) {
  return [
    TypedMiddleware<AppState, OnViewProgressAction>(_onViewProgressAction(remoteStorage, workoutApi, logger)),
    TypedMiddleware<AppState, OnShareProgressAction>(_onShareProgressAction(remoteStorage, workoutApi, logger)),
    TypedMiddleware<AppState, OnSharingCompletedEventAction>(_reloadProfileDataAction(logger)),
    TypedMiddleware<AppState, LogoutAction>(_logoutAction(logger)),
    TypedMiddleware<AppState, OnDeleteCompletedWorkoutAction>(_onDeleteCompletedWorkoutAction(remoteStorage, logger)),
    TypedMiddleware<AppState, LoadCompletedWorkoutsHistoryAction>(
        _onLoadCompletedWorkoutsHistoryAction(remoteStorage, logger)),
  ];
}

Middleware<AppState> _onViewProgressAction(RemoteStorage remoteStorage, WorkoutApi workoutApi, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {

    store.dispatch(ShowLoadingIndicatorAction(true));

    final data = (action as OnViewProgressAction).item;

    try {
      logger.logInfo("$action _onViewProgressAction");


      final ProgressResponse progressResponse = await remoteStorage.getProgress(formatDateTime(data.originDate));
      final WorkoutProgressDto progress = progressResponse.workoutProgress.firstWhere((p) => p.id == data.workoutProgressId.toString(), orElse: () => null);
      final legacy.WorkoutDto workout = await workoutApi.fetchWorkout(progress.workout.id);

      WorkoutSummaryPayload workoutSummaryPayload = WorkoutSummaryPayload(
          id: workout.id.toString(),
          workoutDuration: progress.workoutDuration,
          moveToProgressOnClose: false,
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

      store.dispatch(ShowLoadingIndicatorAction(false));

      store.dispatch(NavigateToWorkoutFlowScreenWithBundleAction(bundle: workoutSummaryPayload));

      next(action);
    } catch (e) {
      var error = e;
      if (e is! TfException) {
        error = TfException(ErrorCode.ERROR_LOAD_WORKOUT_PROGRESS, e.toString());
      }
      store.dispatch(OnProfileErrorAction(ViewItemError(error: error)));
      logger.logError("$action _onViewProgressAction ${e.toString()}");
      next(ErrorReportAction(where: "profileMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
    store.dispatch(OnChangeWODLoadingAction(WorkoutOfTheDayState.STARTED));
  };
}

Middleware<AppState> _onShareProgressAction(RemoteStorage remoteStorage, WorkoutApi workoutApi, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    final data = (action as OnShareProgressAction).item;

    try {
      logger.logInfo("$action _onShareProgressAction");
      store.dispatch(ShowLoadingIndicatorAction(true));

      final progressResponse = await remoteStorage.getProgress(formatDateTime(data.originDate));
      final progress = progressResponse.workoutProgress
          .firstWhere((p) => p.id == data.workoutProgressId.toString(), orElse: () => null);
      final workout = await workoutApi.fetchWorkout(progress.workout.id);

      var bundle = ProfileShareWorkoutResultsScreenBundle(
        workout: workout,
        progress: progress,
      );

      store.dispatch(ShowLoadingIndicatorAction(false));
      store.dispatch(NavigateToProfileShareScreenAction(bundle: bundle));
      next(action);
    } catch (e) {
      var error = e;
      if (e is! TfException) {
        error = TfException(ErrorCode.ERROR_LOAD_WORKOUT_PROGRESS, e.toString());
      }
      store.dispatch(ShareItemError(error: error));
      logger.logError("$action _onShareProgressAction ${e.toString()}");
      next(ErrorReportAction(where: "profileMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _onDeleteCompletedWorkoutAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    var item = (action as OnDeleteCompletedWorkoutAction).item;
    try {
      store.dispatch(ShowLoadingIndicatorAction(true));

      var response = await remoteStorage.deleteWorkoutProgress(item.workoutProgressId);
      logger.logInfo("$action _onDeleteCompletedWorkoutAction ${response.toString()}");

      var statisticsResponse = await remoteStorage.getProfileStatistics();
      logger.logInfo("$action _onDeleteCompletedWorkoutAction ${statisticsResponse.toString()}");

      final headerItem = ProfileHeaderListItem(
        user: store.state.loginState.user,
        profileStatistics: ProfileStatisticsState(
          totalPoints: statisticsResponse.totalPoints,
          totalTime: formatTotalTime(statisticsResponse.totalTime),
          totalWorkouts: statisticsResponse.totalWorkouts,
        ),
      );

      var result = store.state.profileScreenState.listItems;
      result.removeWhere(
          (element) => element is CompletedWorkoutListItem && element.workoutProgressId == item.workoutProgressId);

      result.removeAt(0);
      result.insert(0, headerItem);

      store.dispatch(SetProfileWorkoutsListAction(listItems: result));
    } catch (e) {
      var error = e;
      if (e is! TfException) {
        error = TfException(ErrorCode.ERROR_DELETE_WORKOUT_PROGRESS, e.toString());
      }
      store.dispatch(OnProfileErrorAction(DeleteItemError(error: error)));
      store.dispatch(ShowLoadingIndicatorAction(false));
      next(ErrorReportAction(where: "profileMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
      logger.logError("$action _onDeleteCompletedWorkoutAction $e");
    }
  };
}

//  Условия и форматы <10 часов — 6h 12m >10 часов — 12h, 12.5h, 13h >100 часов — 123h
String formatTotalTime(int totalExerciseDuration) {
  final Duration duration = Duration(milliseconds: totalExerciseDuration);
  int minutes = duration.inMinutes.remainder(60);
  int hours = duration.inHours;
  if (hours < 10) {
    return "${hours}h ${minutes}m";
  }

  if (hours > 100) {
    return "${hours}h";
  }
  if (hours >= 10) {
    String formattedMinutes;
    String formattedHours = "$hours";
    if (0 <= minutes && minutes < 15) {
      formattedMinutes = "";
    } else if (15 <= minutes && minutes < 30) {
      formattedMinutes = ".5";
    } else if (minutes < 45) {
      formattedMinutes = ".5";
    } else {
      formattedMinutes = "";
      formattedHours = "${hours + 1}";
    }
    return "$formattedHours${formattedMinutes}h";
  }

  throw 'Unhandled Case Error';
}

CompletedWorkoutListItem _mapItem(ProfileCompletedWorkoutItemResponse item) {
  var duration = Duration(milliseconds: item.workoutDuration).inMinutes;

  if (duration == 0) {
    duration = 1;
  }

  return CompletedWorkoutListItem(
    workoutProgressId: item.workoutProgressId,
    originDate: DateTime.parse(item.date),
    dateForUI: DateTime.parse(item.date).day.toString(),
    name: item.name.toLowerCase().capitalize(),
    month: item.month.substring(0, 3).toLowerCase().capitalize(),
    workoutDuration: duration.remainder(60).toString() + ' min',
    roundCount: item.roundCount.toString() + ' rounds',
    wodType: item.wodType,
  );
}

Middleware<AppState> _onLoadCompletedWorkoutsHistoryAction(RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    var data = action as LoadCompletedWorkoutsHistoryAction;

    try {
      final appendItems = <FeedItem>[];
      final listItems = store.state.profileScreenState.listItems;

      var profileStatisticsResponse = await remoteStorage.getProfileStatistics();
      logger.logInfo("$action _onLoadCompletedWorkoutsHistoryAction ${profileStatisticsResponse.toString()}");

      final headerItem = ProfileHeaderListItem(
        user: store.state.loginState.user,
        profileStatistics: ProfileStatisticsState(
          totalPoints: profileStatisticsResponse.totalPoints,
          totalTime: formatTotalTime(profileStatisticsResponse.totalTime),
          totalWorkouts: profileStatisticsResponse.totalWorkouts,
        ),
      );

      var offset = (action as LoadCompletedWorkoutsHistoryAction).pageOffset;

      if (offset == 0) {
        appendItems.add(headerItem);
      }

      var response = await remoteStorage.getProfileCompletedWorkouts(offset, _pageSize);
      logger.logInfo("$action _onLoadCompletedWorkoutsHistoryAction ${response.toString()}");

      response.objects.forEach((item) => {appendItems.add(_mapItem(item))});

      var isLastPage = int.parse(response.totalElements) <= ((offset + 1) * _pageSize);
      var pageOffset = isLastPage ? offset : offset + 1;

      if (isLastPage) {
        appendItems.add(SpaceItem());
      }

      var result = PaginationData(
        appendItems: appendItems,
        isLastPage: isLastPage,
        pageOffset: pageOffset,
      );

      store.dispatch(SetProfileCompletedWorkoutsAction(paginationData: result, listItems: listItems));
    } catch (e) {
      var error = e;
      if (e is! TfException) {
        error = TfException(ErrorCode.ERROR_LOAD_WORKOUT_PROGRESS, e.toString());
      }
      store.dispatch(OnProfileErrorAction(PaginationError(error: error)));
      next(ErrorReportAction(where: "profileMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
      logger.logError("$action _onLoadCompletedWorkoutsHistoryAction $e");
    }
  };
}

Middleware<AppState> _logoutAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      logger.logInfo("$action _logoutAction");
      next(action);
      store.dispatch(SetProfileCompletedWorkoutsAction(paginationData: PaginationData.initial(), listItems: []));
    } catch (e) {
      logger.logError("$action _logoutAction ${e.toString()}");
      next(ErrorReportAction(where: "profileMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}

Middleware<AppState> _reloadProfileDataAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      logger.logInfo("$action _reloadProfileDataAction");
      next(action);
      store.dispatch(ClearPaginationControllerAction(true));
      store.dispatch(LoadCompletedWorkoutsHistoryAction(0));
    } catch (e) {
      logger.logError("$action _reloadProfileDataAction ${e.toString()}");
      next(ErrorReportAction(where: "profileMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}
