import 'package:flutter/material.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/exception/tf_exception.dart';
import 'package:totalfit/model/choose_program/feed_program_list_item.dart';
import '../../data/dto/response/feed_program_list_item_response.dart';
import '../../model/program_days_of_week.dart';

@immutable
class ProgramSetupState {
  final LevelType selectedProgramLevel;
  final List<DayOfWeek> days;
  final List<DayOfWeek> selectedDays;
  final int maxWeekNumber;
  final int selectedNumberOfWeeks;
  final TfException error;
  final bool showLoading;
  final FeedProgramListItem program;

  ProgramSetupState({
    @required this.selectedProgramLevel,
    @required this.selectedNumberOfWeeks,
    @required this.selectedDays,
    @required this.program,
    @required this.days,
    @required this.error,
    @required this.showLoading,
    @required this.maxWeekNumber,
  });

  factory ProgramSetupState.initial() {
    return ProgramSetupState(
      selectedProgramLevel: null,
      selectedNumberOfWeeks: 3,
      selectedDays: [],
      program: null,
      showLoading: false,
      maxWeekNumber: null,
      error: IdleException(),
      days: [],
    );
  }

  ProgramSetupState copyWith({
    LevelType selectedProgramLevel,
    int selectedNumberOfWeeks,
    List<DayOfWeek> selectedDays,
    List<DayOfWeek> days,
    TfException error,
    bool showLoading,
    int maxWeekNumber,
    FeedProgramListItem program,
  }) {
    return ProgramSetupState(
      selectedProgramLevel: selectedProgramLevel ?? this.selectedProgramLevel,
      selectedDays: selectedDays ?? this.selectedDays,
      selectedNumberOfWeeks: selectedNumberOfWeeks ?? this.selectedNumberOfWeeks,
      program: program ?? this.program,
      days: days ?? this.days,
      error: error ?? this.error,
      maxWeekNumber: maxWeekNumber ?? this.maxWeekNumber,
      showLoading: showLoading ?? this.showLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProgramSetupState &&
          runtimeType == other.runtimeType &&
          selectedProgramLevel == other.selectedProgramLevel &&
          selectedDays == other.selectedDays &&
          program == other.program &&
          days == other.days &&
          error == other.error &&
          maxWeekNumber == other.maxWeekNumber &&
          showLoading == other.showLoading &&
          selectedNumberOfWeeks == other.selectedNumberOfWeeks;

  @override
  int get hashCode =>
      selectedProgramLevel.hashCode ^
      selectedNumberOfWeeks.hashCode ^
      selectedDays.hashCode ^
      program.hashCode ^
      days.hashCode ^
      error.hashCode ^
      maxWeekNumber.hashCode ^
      showLoading.hashCode;
}
