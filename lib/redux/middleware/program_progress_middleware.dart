import 'package:core/src/utils/string_utils.dart';
import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/exception/error_codes.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/active_program.dart';
import 'package:totalfit/model/choose_program/program_workout_item.dart';
import 'package:totalfit/model/progress/program_completed_item.dart';
import 'package:totalfit/model/progress/program_full_schedule_item.dart';
import 'package:totalfit/model/progress/program_progress_header_item.dart';
import 'package:totalfit/model/progress/program_progress_workout_item.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/selectors/progress_selectors.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/storage/string_storage.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/model/progress_list_items.dart';

List<Middleware<AppState>> programProgressMiddleware(StringStorage stringStorage, RemoteStorage remoteStorage, TFLogger logger) {
  return [
    TypedMiddleware<AppState, LoadProgramProgressPageAction>(_loadProgramProgressPageAction(stringStorage, logger)),
  ];
}

ProgramProgressHeaderItem _mapProgramHeader(StringStorage stringStorage, ActiveProgram activeProgram) {
  var programProgress = activeProgram.programProgress;
  return ProgramProgressHeaderItem(
    programName: activeProgram.name,
    level: activeProgram.difficultyLevel,
    weeks: activeProgram.numberOfWeeks,
    daysOfWeek: activeProgram.daysAWeek,
    programProgress: programProgress,
    programProgressText:
        "${programProgress.workoutsDone}/${programProgress.workoutsQuantity} ${stringStorage.of().programs_progress__workouts}",
  );
}

List<ScheduledWorkoutItem> _mapThisWeekWorkouts(StringStorage stringStorage, ActiveProgram activeProgram) {
  var result = <ScheduledWorkoutItem>[];
  var thisWeekWorkouts = activeProgram.thisWeekWorkouts;
  thisWeekWorkouts.forEach((item) {
    var workoutProgress = item.workoutProgress;
    var duration = Duration(milliseconds: workoutProgress.workoutDuration).inMinutes;
    if (duration == 0) {
      duration = 1;
    }

    var dateTime = DateTime.parse(item.date);
    result.add(ScheduledWorkoutItem(
      dateTime,
      dayNumber: dateTime.day.toString(),
      day: getWeekDay(stringStorage, dateTime.weekday),
      isToday: isTodayDate(dateTime.millisecondsSinceEpoch),
      inPastDays: !isTodayOrAfter(dateTime),
      workoutDuration: '0',//workoutProgress.workout.getMetricQuantity(),
      workoutProgress: workoutProgress,
    ));
  });

  return result;
}

Middleware<AppState> _loadProgramProgressPageAction(StringStorage stringStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      var listItems = <FeedItem>[];

      var activeProgram = store.state.programProgressState.activeProgram;
      listItems.add(_mapProgramHeader(stringStorage, activeProgram));

      if (activeProgram.allWorkoutsDone ||
          activeProgram.programProgress.workoutsDone == activeProgram.programProgress.workoutsQuantity) {
        listItems.add(ProgramCompletedItem());
      } else if (activeProgram.workoutOfTheDay != null) {
        final workoutProgress = selectProgress(store, activeProgram.workoutOfTheDay);
        listItems.add(ProgramProgressWODItem(workout: activeProgram.workoutOfTheDay, workoutProgress: workoutProgress));
      } else {
        listItems.add(ProgramProgressWODItem());
      }

      listItems.add(FullScheduleItem());
      listItems.addAll(_mapThisWeekWorkouts(stringStorage, activeProgram));
      listItems.add(SpaceItem());

      store.dispatch(SetProgramProgressPageStateAction(listItems: listItems));
    } catch (e) {
      var error = e;
      if (e is! TfException) {
        error = TfException(ErrorCode.ERROR_BUILD_PROGRAM_UI_ITEMS, e.toString());
      }
      store.dispatch(OnErrorProgramProgressAction(error: error));
      next(ErrorReportAction(
          where: "programProgressMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
      logger.logError("$action _loadProgramProgressPageAction $e");
    }
  };
}

String getWeekDay(StringStorage stringStorage, int weekday) {
  if (weekday == DateTime.monday) {
    return stringStorage.of().choose_program_days__monday.substring(0, 3).toLowerCase().capitalize();
  } else if (weekday == DateTime.wednesday) {
    return stringStorage.of().choose_program_days__wednesday.substring(0, 3).toLowerCase().capitalize();
  } else if (weekday == DateTime.tuesday) {
    return stringStorage.of().choose_program_days__tuesday.substring(0, 3).toLowerCase().capitalize();
  } else if (weekday == DateTime.thursday) {
    return stringStorage.of().choose_program_days__thursday.substring(0, 3).toLowerCase().capitalize();
  } else if (weekday == DateTime.friday) {
    return stringStorage.of().choose_program_days__friday.substring(0, 3).toLowerCase().capitalize();
  } else if (weekday == DateTime.saturday) {
    return stringStorage.of().choose_program_days__saturday.substring(0, 3).toLowerCase().capitalize();
  } else if (weekday == DateTime.sunday) {
    return stringStorage.of().choose_program_days__sunday.substring(0, 3).toLowerCase().capitalize();
  } else {
    return "";
  }
}
