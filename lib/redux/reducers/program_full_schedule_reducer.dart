import 'package:redux/redux.dart';
import 'package:totalfit/redux/actions/user_actions.dart';
import 'package:totalfit/redux/actions/program_full_schedule_actions.dart';
import 'package:totalfit/redux/states/program_full_schedule_state.dart';

import '../actions/program_progress_actions.dart';

final programFullScheduleReducer = combineReducers<ProgramFullScheduleState>([
  TypedReducer<ProgramFullScheduleState, SetProgramFullSchedulePageStateAction>(_setProgramFullSchedulePageStateAction),
  TypedReducer<ProgramFullScheduleState, LogoutAction>(_onLogoutAction),
  TypedReducer<ProgramFullScheduleState, OnProgramFinishedAction>(_onProgramFinishedAction),
]);

ProgramFullScheduleState _onProgramFinishedAction(ProgramFullScheduleState state, OnProgramFinishedAction action) =>
    ProgramFullScheduleState.initial();

ProgramFullScheduleState _onLogoutAction(ProgramFullScheduleState state, LogoutAction action) =>
    ProgramFullScheduleState.initial();

ProgramFullScheduleState _setProgramFullSchedulePageStateAction(
        ProgramFullScheduleState state, SetProgramFullSchedulePageStateAction action) =>
    state.copyWith(listItems: action.listItems);
