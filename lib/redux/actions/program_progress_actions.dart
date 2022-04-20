import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/model/active_program.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';
import 'package:totalfit/data/dto/workout_progress_dto.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/profile/list_items.dart';
import 'package:totalfit/data/dto/response/finish_program_response.dart';

class NavigateToFullSchedulePageAction extends TrackableAction {
  @override
  Event event() => Event.PRESSED_PROGRAM_FULL_SCHEDULE;
}

class LoadProgramProgressPageAction {}

class SetProgramProgressPageStateAction {
  final List<FeedItem> listItems;

  SetProgramProgressPageStateAction({@required this.listItems});
}

class SetActiveProgramAction {
  final ActiveProgram program;

  SetActiveProgramAction({@required this.program});
}

class SendProgramStartedEventAction extends TrackableAction {
  final ActiveProgram program;

  SendProgramStartedEventAction({@required this.program});

  @override
  Event event() => Event.PROGRAM_STARTED;

  @override
  Map<String, String> parameters() => {
        "programId": program.id,
        "name": program.name,
        "numberOfWeeks": program.numberOfWeeks.toString(),
        "wodName": program.workoutOfTheDay?.theme,
        "daysOfTheWeek": json.encode(program.daysOfTheWeek),
        "daysAWeek": program.daysAWeek.toString(),
        "difficultyLevel": program.difficultyLevel
      };
}

class UpdateWorkoutProgressOnProgramStartAction {
  final WorkoutProgressDto progress;

  UpdateWorkoutProgressOnProgramStartAction({@required this.progress});
}

class OnErrorProgramProgressAction {
  final TfException error;

  OnErrorProgramProgressAction({@required this.error});
}

class OnClearProgramsProgressErrorAction {}

class NavigateToProgramSummaryAction {
  final FinishProgramResponse response;

  NavigateToProgramSummaryAction(this.response);
}

class OnProgramFinishedAction extends TrackableAction {
  @override
  Event event() => Event.PRESSED_PROGRAM_SUMMARY_FINISH;
}

class SendPressedProgramQuitEventAction extends TrackableAction {
  @override
  Event event() => Event.PRESSED_PROGRAM_QUIT;
}
