import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:totalfit/analytics/events.dart';
import 'package:totalfit/model/choose_program/feed_program_list_item.dart';
import 'package:totalfit/redux/actions/trackable_action.dart';
import 'package:totalfit/ui/screen/main/programs/setup/summary/program_setup_summary_screen.dart';
import '../../data/dto/response/feed_program_list_item_response.dart';
import '../../model/program_days_of_week.dart';

class LoadInitDaysPageStateAction {}

class SetInitDaysPageStateAction {
  final List<DayOfWeek> days;

  SetInitDaysPageStateAction({@required this.days});
}

class SetInitLevelsPageStateAction {
  final List<LevelType> programLevels;
  final LevelType selectedProgramLevel;

  SetInitLevelsPageStateAction({@required this.programLevels, @required this.selectedProgramLevel});
}

class NavigateToChooseProgramNumberOfWeeksPageAction extends TrackableAction {
  final LevelType selectedLevel;

  NavigateToChooseProgramNumberOfWeeksPageAction(this.selectedLevel);

  @override
  Event event() => Event.PROGRAM_SET_UP_LEVEL_SELECTED;

  @override
  Map<String, String> parameters() => {"level": selectedLevel.uiName};
}

class NavigateToChooseProgramLevelPageAction {}

class NavigateToProgramSetupSummaryPageAction extends TrackableAction {
  final ProgramSummaryMode mode;
  final LevelType level;
  final int numberOfWeeks;
  final String startDate;
  final String targetId;
  final List<int> selectedDays;

  NavigateToProgramSetupSummaryPageAction(
    this.mode, {
    @required this.level,
    @required this.numberOfWeeks,
    @required this.startDate,
    @required this.targetId,
    @required this.selectedDays,
  });

  @override
  Event event() => Event.PROGRAM_SET_UP_DAYS_SELECTED;

  @override
  Map<String, String> parameters() => {"days": json.encode(selectedDays)};
}

class NavigateToChooseDaysOfTheWeekPageAction extends TrackableAction {
  final int selectedNumberOfWeeks;

  NavigateToChooseDaysOfTheWeekPageAction(this.selectedNumberOfWeeks);

  @override
  Event event() => Event.PROGRAM_SET_UP_WEEKS_SELECTED;

  @override
  Map<String, String> parameters() => {"numberOfWeeks": selectedNumberOfWeeks.toString()};
}

class SendStartDateSelectedEventAction extends TrackableAction {
  final String date;

  SendStartDateSelectedEventAction(this.date);

  @override
  Event event() => Event.PROGRAM_SET_START_DATE_SELECTED;

  @override
  Map<String, String> parameters() => {"date": date};
}

class NavigateOnActiveProgramAction {}

class SetProgramAction {
  final FeedProgramListItem program;

  SetProgramAction({@required this.program});
}

class RemoveActiveProgramAction {}

class SetProgramLevelAction {
  final LevelType selectedLevel;

  SetProgramLevelAction({@required this.selectedLevel});
}

class OnProgramDayClickAction {
  final DayOfWeek day;

  OnProgramDayClickAction({@required this.day});
}

class UpdateWeeksCountCountAction {
  final int weeks;

  UpdateWeeksCountCountAction({@required this.weeks});
}

class SetProgramLoadingAction {
  final bool isLoading;

  SetProgramLoadingAction({@required this.isLoading});
}

class OnErrorProgramAction {
  final Exception error;

  OnErrorProgramAction({@required this.error});
}

class OnStopProgramClickAction {}

class OnClearProgramsErrorAction {}
