import 'package:redux/redux.dart';
import 'package:core/core.dart';
import 'package:totalfit/data/dto/program_this_week_workout_list_dto.dart';
import 'package:totalfit/data/source/remote/remote_storage.dart';
import 'package:totalfit/model/active_program.dart';
import 'package:totalfit/model/choose_program/program_workout_item.dart';
import 'package:totalfit/model/progress/program_schedule_item.dart';
import 'package:totalfit/redux/actions/analytic_actions.dart';
import 'package:totalfit/redux/states/app_state.dart';
import 'package:totalfit/storage/string_storage.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/redux/actions/program_full_schedule_actions.dart';
import 'package:totalfit/model/progress_list_items.dart';

import 'program_progress_middleware.dart';

List<Middleware<AppState>> programFullScheduleMiddleware(
    StringStorage stringStorage, RemoteStorage remoteStorage, TFLogger logger) {
  return [
    TypedMiddleware<AppState, LoadProgramFullSchedulePageAction>(
        _loadProgramFullSchedulePageAction(stringStorage, logger)),
  ];
}

List<ProgramScheduleItem> _mapScheduleItems(StringStorage stringStorage, ActiveProgram activeProgram) {
  var result = <ProgramScheduleItem>[];
  var schedule = activeProgram.schedule;
  var week = 0;

  schedule.forEach((item) {
    week++;
    final workouts = _mapWorkouts(stringStorage, item.workouts);
    result.add(ProgramScheduleItem(week: week.toString(), dateRange: item.dateRange, workouts: workouts));
  });

  return result;
}

Middleware<AppState> _loadProgramFullSchedulePageAction(StringStorage stringStorage, TFLogger logger) {
  return (Store<AppState> store, action, NextDispatcher next) {
    try {
      var listItems = <FeedItem>[];

      var activeProgram = store.state.programProgressState.activeProgram;
      listItems.addAll(_mapScheduleItems(stringStorage, activeProgram));
      listItems.add(SpaceItem());

      store.dispatch(SetProgramFullSchedulePageStateAction(listItems: listItems));
    } catch (e) {
      next(ErrorReportAction(
          where: "programProgressMiddleware", errorMessage: e.toString(), trigger: action.runtimeType));
      logger.logError("$action _loadProgramProgressPageAction $e");
    }
  };
}

List<ScheduledWorkoutItem> _mapWorkouts(StringStorage stringStorage, List<ProgramThisWeekWorkoutListDto> workouts) {
  var result = <ScheduledWorkoutItem>[];
  workouts.forEach((item) {
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
