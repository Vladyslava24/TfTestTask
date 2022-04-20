import 'package:redux/redux.dart';
import 'package:totalfit/exception/idle_exception.dart';
import 'package:totalfit/redux/actions/main_page_action.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/actions/program_progress_actions.dart';
import 'package:totalfit/redux/actions/program_setup_actions.dart';
import 'package:totalfit/redux/states/program_setup_state.dart';

final programSetupReducer = combineReducers<ProgramSetupState>([
  TypedReducer<ProgramSetupState, SetProgramLevelAction>(_setProgramLevelAction),
  TypedReducer<ProgramSetupState, OnProgramDayClickAction>(_onProgramDayClickAction),
  TypedReducer<ProgramSetupState, UpdateWeeksCountCountAction>(_updateWeeksCountCountAction),
  TypedReducer<ProgramSetupState, OnErrorProgramAction>(_onErrorProgramAction),
  TypedReducer<ProgramSetupState, OnClearProgramsErrorAction>(_onClearProgramsErrorAction),
  TypedReducer<ProgramSetupState, SetInitLevelsPageStateAction>(_setInitLevelsPageStateAction),
  TypedReducer<ProgramSetupState, SetInitDaysPageStateAction>(_setInitDaysPageStateAction),
  TypedReducer<ProgramSetupState, SetProgramAction>(_setProgramAction),
  TypedReducer<ProgramSetupState, SetProgramLoadingAction>(_setProgramLoadingAction),
  TypedReducer<ProgramSetupState, LogoutAction>(_onLogoutAction),
  TypedReducer<ProgramSetupState, ShowProgramDescriptionPageAction>(_onShowProgramDescriptionPageAction),
  TypedReducer<ProgramSetupState, OnProgramFinishedAction>(_onProgramFinishedAction),
]);

ProgramSetupState _onProgramFinishedAction(ProgramSetupState state, OnProgramFinishedAction action) =>
    ProgramSetupState.initial();

ProgramSetupState _onLogoutAction(ProgramSetupState state, LogoutAction action) => ProgramSetupState.initial();

ProgramSetupState _onShowProgramDescriptionPageAction(
        ProgramSetupState state, ShowProgramDescriptionPageAction action) =>
    state.copyWith(selectedDays: []);

ProgramSetupState _setInitLevelsPageStateAction(ProgramSetupState state, SetInitLevelsPageStateAction action) =>
    state.copyWith(selectedProgramLevel: action.selectedProgramLevel);

ProgramSetupState _setInitDaysPageStateAction(ProgramSetupState state, SetInitDaysPageStateAction action) =>
    state.copyWith(days: action.days);

ProgramSetupState _setProgramLevelAction(ProgramSetupState state, SetProgramLevelAction action) =>
    state.copyWith(selectedProgramLevel: action.selectedLevel);

ProgramSetupState _onProgramDayClickAction(ProgramSetupState state, OnProgramDayClickAction action) {
  final toUpdate = List.of(state.selectedDays);
  if (toUpdate.contains(action.day)) {
    toUpdate.remove(action.day);
  } else {
    toUpdate.add(action.day);
  }
  toUpdate.sort((a, b) => a.index() - b.index());
  return state.copyWith(selectedDays: toUpdate);
}

ProgramSetupState _setProgramAction(ProgramSetupState state, SetProgramAction action) =>
    state.copyWith(program: action.program, maxWeekNumber: action.program.maxWeekNumber);

ProgramSetupState _updateWeeksCountCountAction(ProgramSetupState state, UpdateWeeksCountCountAction action) =>
    state.copyWith(selectedNumberOfWeeks: action.weeks);

ProgramSetupState _setProgramLoadingAction(ProgramSetupState state, SetProgramLoadingAction action) =>
    state.copyWith(showLoading: action.isLoading);

ProgramSetupState _onErrorProgramAction(ProgramSetupState state, OnErrorProgramAction action) =>
    state.copyWith(showLoading: false, error: action.error);

ProgramSetupState _onClearProgramsErrorAction(ProgramSetupState state, OnClearProgramsErrorAction action) =>
    state.copyWith(error: IdleException());
