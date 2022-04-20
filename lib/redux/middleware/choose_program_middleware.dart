import 'package:core/core.dart';
import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/choose_program/feed_program_header_list_item.dart';
import 'package:totalfit/model/choose_program/feed_program_list_item.dart';
import 'package:totalfit/model/profile/pagination_data.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/storage/string_storage.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/model/progress_list_items.dart';

import '../actions/choose_program_actions.dart';
import '../../data/dto/response/current_program_limited_response.dart';
import '../../data/dto/response/feed_program_list_item_response.dart';

const _pageSize = 20;

List<Middleware<AppState>> chooseProgramMiddleware(
    StringStorage stringStorage, RemoteStorage remoteStorage, TFLogger logger) {
  return [
    TypedMiddleware<AppState, LogoutAction>(_logoutAction(logger)),
    TypedMiddleware<AppState, LoadChooseProgramFeedAction>(
        _onLoadChooseProgramFeedAction(stringStorage, remoteStorage, logger))
  ];
}

//  Условия и форматы <10 часов — 6h 12m >10 часов — 12h, 12.5h, 13h >100 часов — 123h
String formatTotalTime(int totalExerciseDuration) {
  int totalMinutes = Duration(milliseconds: totalExerciseDuration).inMinutes.remainder(60);
  int hours = totalMinutes ~/ 60;
  if (hours < 10) {
    return "${hours}h ${totalMinutes - hours * 60}m";
  }

  if (hours > 100) {
    return "${hours}h";
  }
  if (hours >= 10) {
    String formattedMinutes;
    String formattedHours = "$hours";
    final minutes = totalMinutes - hours * 6;
    if (0 <= minutes && minutes < 15) {
      formattedMinutes = "";
    } else if (15 <= minutes && minutes < 30) {
      formattedMinutes = ".5";
    } else if (40 <= minutes && minutes < 45) {
      formattedMinutes = ".5";
    } else {
      formattedMinutes = "";
      formattedHours = "${hours++}";
    }
    return "$formattedHours${formattedMinutes}h";
  }

  throw 'Unhandled Case Error';
}

FeedProgramListItem _mapCurrentProgram(StringStorage stringStorage, CurrentProgramLimitedResponse item) {
  return FeedProgramListItem(
      isActive: true,
      programProgress: item.programProgress,
      equipment: item.equipment,
      equipmentForFeedUI: item.equipment.join(", "),
      goal: item.goal,
      id: item.id,
      session: "",
      levels: item.levels,
      levelsForFeedUI: _getLevelsForUI(stringStorage, item.levels),
      name: item.name,
      workouts: [],
      image: item.image);
}

FeedProgramListItem mapItem(StringStorage stringStorage, FeedProgramItemResponse item) {
  return FeedProgramListItem(
      isActive: false,
      programProgress: null,
      equipment: item.equipment,
      equipmentForFeedUI: item.equipment.join(", "),
      goal: item.goal,
      id: item.id,
      session: "",
      levels: item.levels,
      levelsForFeedUI: _getLevelsForUI(stringStorage, item.levels),
      name: item.name,
      maxWeekNumber: item.maxWeekNumber,
      workouts: item.workouts,
      image: item.image);
}

String _getLevelsForUI(StringStorage stringStorage, List<LevelType> levels) {
  if (levels.length == 3) {
    return stringStorage.of().programs__all_levels;
  } else if (levels.length == 2) {
    return levels.map((e) => _getLevelName(stringStorage, e)).join(" ${stringStorage.of().programs__and} ");
  } else {
    return _getLevelName(stringStorage, levels.first);
  }
}

String _getLevelName(StringStorage stringStorage, LevelType level) {
  if (level == LevelType.BEGINNER) {
    return stringStorage.of().choose_program_level__beginner;
  } else if (level == LevelType.INTERMEDIATE) {
    return stringStorage.of().choose_program_level__intermediate;
  } else if (level == LevelType.ADVANCED) {
    return stringStorage.of().choose_program_level__intermediate_description;
  } else
    return "";
}

Middleware<AppState> _onLoadChooseProgramFeedAction(
    StringStorage stringStorage, RemoteStorage remoteStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    logger.logInfo("$action _onLoadChooseProgramFeedAction");
    try {
      var appendItems = <FeedItem>[];
      final headerItem = FeedProgramHeaderListItem();
      appendItems.add(headerItem);

      var offset = (action as LoadChooseProgramFeedAction).pageOffset;

      try {
        final currentProgram = await remoteStorage.getCurrentLimitedProgram(formattedDateTime(DateTime.now()));
        appendItems.add(_mapCurrentProgram(stringStorage, currentProgram));
      } catch (e) {
        if (e is ApiException && e.serverErrorCode != 404) {
          throw e;
        }
      }

      var response = await remoteStorage.getFeedPrograms(offset, _pageSize);
      response.objects.forEach((item) => {appendItems.add(mapItem(stringStorage, item))});

      var pageOffset = offset + _pageSize;
      var isLastPage = int.parse(response.totalElements) <= pageOffset;

      if (isLastPage) {
        appendItems.add(SpaceItem());
      }

      var result = PaginationData(
        appendItems: appendItems,
        isLastPage: isLastPage,
        pageOffset: pageOffset,
      );

      store.dispatch(SetChooseProgramsAction(paginationData: result));
    } catch (e) {
      var error = e;
      if (e is! TfException) {
        error = TfException(ErrorCode.ERROR_LOAD_PROGRAM, e.toString());
      }
      store.dispatch(OnChooseProgramErrorAction(error));
      next(
          ErrorReportAction(where: "chooseProgramMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
      logger.logError("$action _onLoadCompletedWorkoutsHistoryAction $e");
    }
  };
}

Middleware<AppState> _logoutAction(TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      logger.logInfo("$action _logoutAction");
      next(action);
      store.dispatch(SetChooseProgramsAction(paginationData: PaginationData.initial()));
    } catch (e) {
      logger.logError("$action _logoutAction ${e.toString()}");
      next(
          ErrorReportAction(where: "chooseProgramMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
    }
  };
}
